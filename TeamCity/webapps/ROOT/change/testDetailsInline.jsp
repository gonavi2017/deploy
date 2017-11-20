<%@ page import="jetbrains.buildServer.web.openapi.PlaceId" %>
<%@ include file="/include-internal.jsp" %>
<%@ taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %>

<jsp:useBean id="test" scope="request" type="jetbrains.buildServer.serverSide.STest"/>
<jsp:useBean id="testRuns" scope="request" type="java.util.List<jetbrains.buildServer.serverSide.STestRun>"/>
<c:set var="testDetailsId">tdi_${util:uniqueId()}</c:set>
<div id="${testDetailsId}" class="testDetailsInline">
  <div class="simpleTabs clearfix"></div>
  <script>
    (function() {

      var testRuns = (function fillTestRunJSONData() {
        var result = [];
        <c:set var="currProject" value="${contextProject}" />
        <c:forEach items="${testRuns}" var="testRun" >

          <c:set var="build" value="${testRun.build}" />
          <c:set var="buildBranch" value="${build.branch}" />
          <c:set var="branchName" value="${not empty buildBranch ? buildBranch.displayName : ''}"/>
          <c:set var="caption"><c:choose>
            <c:when test="${build.buildType.project == currProject}">... ${build.buildType.name}</c:when>
            <c:otherwise>${util:contextConfigurationName(build.buildType, contextProject)}</c:otherwise>
          </c:choose></c:set>

          result.push({
            buildId: ${build.buildId},
            testRunId: ${testRun.testRunId},
            caption: "${util:forJS(caption, true, false)}", <%--Include build number? (<bs:buildNumber buildData="${build}"/>)--%>
            branch: "${util:forJS(branchName, true, true)}",
            status: "${testRun.status.failed ? 'Failed' : testRun.status.successful ? 'Successful' : testRun.status.ignored ? 'Ignored' : testRun.muted ? 'Muted' : 'Unknown'}",
            buildLink: "<c:url value="/viewLog.html?buildId=${build.buildId}"/>",
            fullBuildLink: "<bs:forJs><bs:buildLinkFull build="${build}" contextProject="${contextProject}"/></bs:forJs>"
          });

          <c:set var="currProject" value="${build.buildType.project}" />

          // Show menu item for 'copy stacktrace'
          var copyTR = $('copyInMenuLinkTR_${build.buildId}_${testRun.test.testNameId}');
          if (copyTR) {
            copyTR.style.display = 'table-row';
          }

        </c:forEach>
        return result;
      })();


      var tabs = new TabbedPane();

      (function fillTabsForBuilds(tabs, testRuns) {
        var nonFailedBuilds = [];
        testRuns.forEach(function fillTabsForFailedBuilds(testRun) {

          if (testRun.status != 'Failed') {
            nonFailedBuilds.push(testRun);
            return;
          }

          var tabOptions = {
            caption: testRun.caption,
            onselect: function() {
              $j('#${testDetailsId} div.testBlock').hide();
              BS.Util.runWithElement('${testDetailsId}', function() {
                var myBlock = $('${testDetailsId}').down("[data-buildId=" + testRun.buildId + "][data-testId=" + testRun.testRunId + "]");
                myBlock.show();
                var table = myBlock.down("table.testRelatedBuilds");
                if (table) {
                  BS.TestDetails.loadFFIInformation(testRun.buildId, testRun.testRunId, table);
                }
              }, 200);
            }
          };

          // Update caption to mark configuration name in bold
          var caption = testRun.caption,
              idx = caption.lastIndexOf(" :: "),
              patternLen = " :: ".length;
          if (idx == -1) {
            idx = caption.lastIndexOf("...");
            patternLen = "...".length;
          }
          if (idx >= 0) {
            tabOptions.caption = caption.substr(0, idx + patternLen) + "<b>" + caption.substr(idx + patternLen) + "</b>";
          }

          // Append branch information to the tab:
          var branch = testRun.branch;
          if (branch) {
            if (branch.length > 16) {
              branch = branch.substr(0, 15) + "...";
            }
            tabOptions.captionAddin = "<span class='branch hasBranch'><span class='branchName' title='Build branch: " + branch + "'>" + branch + "</span></span>";
          }

          // Finally, add the tab:
          tabs.addTab('tab_' + testRun.testRunId + '_' + testRun.buildId, tabOptions);
        });

        if (nonFailedBuilds.length > 0) {
          // Create a tab for other, non-failed test runs:

          var buildHtmlFor = function(testRun) {
            var content = testRun.fullBuildLink + " &mdash; <span class='testStatus " + testRun.status.toLowerCase() + "'>" + testRun.status + "</span>";
            if (testRun.invocationCount > 1) {
              content += " (the test was run " + testRun.invocationCount + " times in the build)";
            }
            return "<div class='testRunLine'>" + content + "</div>";
          };
          var buildOtherCaption = function() {
            var partForStatus = function(status, suffix) {
              var count = nonFailedBuilds.reduce(function(prev, testRun) {
                return status == testRun.status ? prev + 1 : prev;
              }, 0);
              return count > 0 ? "" + count + suffix +", " : "";
            };

            var res = "Other: ";
            res += partForStatus("Successful", " successful");
            res += partForStatus("Ignored", " ignored");
            res += partForStatus("Muted", " muted");
            return res.substr(0, res.length - 2); // remove last ", "
          };

          tabs.addTab('otherBuilds', {
            caption: buildOtherCaption(),
            onselect: function() {

              var content = "";
              nonFailedBuilds.forEach(function(testRun) {
                content += buildHtmlFor(testRun);
              });

              var otherBlock = $j('#${testDetailsId} div.testBlock.otherBuilds');
              otherBlock.html(content);

              $j('#${testDetailsId} div.testBlock').hide();
              otherBlock.show();
            }
          });
        }
      })(tabs, testRuns);


      // Show tabs in container
      var tabsContainer = $("${testDetailsId}").down("div.simpleTabs");
      tabs.showIn(tabsContainer);
      tabs.setFirstActive();

      if (tabs.getTabs().length == 1) {
        tabsContainer.hide();
      }
    })();
  </script>

  <c:forEach items="${testRuns}" var="testRun">
    <c:if test="${testRun.status.failed}">

        <c:set var="build" value="${testRun.build}"/>
        <c:set var="testId" value="${testRun.testRunId}"/>

        <div class="testBlock" data-buildId="${build.buildId}" data-testId="${testId}" style="display: none;">

        <span class="testRunsNote">
        <c:if test="${testRun.invocationCount > 1}">
            The test was run <b>${testRun.invocationCount}</b> times in the
            build<c:if test="${testRun.failedInvocationCount > 0}">, <b>${testRun.failedInvocationCount}</b> failure<bs:s val="${testRun.failedInvocationCount}"/></c:if>
        </c:if>
        </span>

          <div class="rightBlock expandedDetails">
            <div class="icon_before icon16 collapser collapser_expanded" onclick="BS.TestDetails.toggleBuildDetails(this);" title="Click to hide the details block"></div>
            <div class="relatedBuildsWrapper">
              <table class="testRelatedBuilds">
                <%@ include file="testRelatedBuilds.jsp" %>
              </table>
              <ext:includeExtensions placeId="<%=PlaceId.TEST_DETAILS_BLOCK%>"/>
            </div>
          </div>
          <div class="rightBlock collapsedDetails" style="display: none;" onclick="BS.TestDetails.toggleBuildDetails(this);">
            <div class="icon_before icon16 collapser collapser_collapsed" title="Click to show the details block"></div>
            <a href="#" onclick="return false;">show details</a>
          </div>
          <pre class="fullStacktrace" id="fullStacktrace_${build.buildId}_${testRun.test.testNameId}"></pre>
          <a href="#" onclick="BS.TestDetails.closeDetails(this); return false;" class="hideStacktrace">&laquo; Hide stacktrace</a>
          <bs:copy2ClipboardLink dataId="fullStacktrace_${build.buildId}_${testRun.test.testNameId}">Copy to clipboard</bs:copy2ClipboardLink>

        </div>

    </c:if>
  </c:forEach>

  <div class="testBlock otherBuilds" style="display: none;">
    <!-- to be filled with JS -->
  </div>
</div>
