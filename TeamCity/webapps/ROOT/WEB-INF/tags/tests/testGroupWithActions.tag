<%@ tag import="java.util.ArrayList"
%><%@ tag import="jetbrains.buildServer.web.util.WebUtil"
%><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
    %><%@ taglib prefix="tt" tagdir="/WEB-INF/tags/tests"
    %><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
    %><%@ taglib prefix="util" uri="/WEB-INF/functions/util"
    %><%@ taglib prefix="intprop" uri="/WEB-INF/functions/intprop"
    %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
    %><%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz"

    %><%@ attribute name="groupedTestsBean" required="true" type="jetbrains.buildServer.web.problems.GroupedTestsBean"
    %><%@ attribute name="withoutActions"
    %><%@ attribute name="groupSelector" required="true"
    %><%@ attribute name="withoutGroupSelector"
    %><%@ attribute name="withoutFixAction"
    %><%@ attribute name="selectorStateKey"

    %><%@ attribute name="ignoreMuteScope" type="java.lang.Boolean" required="false"
    %><%@ attribute name="showMuteFromTestRun" type="java.lang.Boolean" required="false"
    %><%@ attribute name="singleBuildTypeContext" required="false" type="java.lang.Boolean"

    %><%@ attribute name="maxTests" type="java.lang.Integer"
    %><%@ attribute name="defaultOption" required="true"
    %><%@ attribute name="maxTestsPerGroup" type="java.lang.Integer"
    %><%@ attribute name="viewAllUrl" fragment="true" required="false"

    %><%@ attribute name="testMoreData" fragment="true" required="false"
    %><%@ attribute name="testAfterName" fragment="true" required="false"
    %><%@ attribute name="testLinkAttrs" fragment="true" required="false"
    %><%@ attribute name="maxTestNameLength" type="java.lang.Integer" required="false"
    %><%@ attribute name="showFullProjectName" type="java.lang.Boolean" required="false"

    %><%@ attribute name="id" fragment="false" required="false" type="java.lang.String"

    %><%@ attribute name="afterToolbar" fragment="true" required="false"
    %><%@ variable name-given="testBean"

    %><c:set var="maxTestsDefault" value="<%= WebUtil.getMaxUiTestLimit() %>"
/><c:set var="maxTests" value="${empty maxTests ? maxTestsDefault : maxTests}"
/><c:set var="maxTestsPerGroup" value="${empty maxTestsPerGroup ? maxTestsDefault : maxTestsPerGroup}"
/><c:set var="groupId" scope="request"
    ><c:if test="${empty id}">tst_group_<bs:id/></c:if
    ><c:if test="${not empty id}">tst_group_${id}</c:if
></c:set>

<c:if test="${groupedTestsBean.testsNumber < 2}">
  <c:set var="withoutActions" value="true"/>
</c:if>
<c:if test="${not empty withoutActions}">
  <c:set var="groupSelector" value="false"/>
</c:if>

<c:set var="allShownTestBeans" value="<%= new ArrayList()%>" scope="request"/>
<c:set var="projectId" value="${groupedTestsBean.packagesRoot.items[0].projectId}"/>
<c:set var="projectExternalId" value="${groupedTestsBean.rootProjectGroup.project.externalId}"/>

<bs:refreshable containerId="${groupId}Refresh" pageUrl="${pageUrl}" deferred="true">
<div class="tests-group" id="${groupId}">
  <!-- ACTION BAR for grouped tests -->
  <c:if test="${empty withoutActions}">
    <div class="action-bar">

      <table class="bulk-toolbar">
        <tr>
          <td class="testNamePart">

            <bs:collapseExpand collapseAction="return BS.CollapsableBlocks.collapseAll(true, 'expand_${groupId}')" expandAction="return BS.CollapsableBlocks.expandAll(true, 'expand_${groupId}')"/>

            <c:if test="${groupSelector != 'false'}">
              <!-- Take current selector state from session-->
              <c:if test="${empty selectorStateKey}">
                <c:set var="selectorStateKey" value="tgr_selector_${id}"/>
              </c:if>
              <c:set var="selectorKey" value="tgr_selector_${selectorStateKey}"/>
              <c:if test="${not empty sessionScope[selectorKey]}">
                <c:set var="defaultOption" value="${fn:substringAfter(sessionScope[selectorKey], '-')}"/>
              </c:if>

              <span class="group-by-section">
                Group by:
                <select onchange="return BS.TestGroup.regroup('${groupId}', '${selectorKey}', this);">
                  <c:if test="${groupSelector != 'noBuildType'}">
                    <forms:option selected="${defaultOption == 'bt'}" value=".by-bt">project, build configuration, package/suite</forms:option>
                  </c:if>
                  <forms:option selected="${defaultOption == 'package'}" value=".by-package">package/suite</forms:option>
                  <forms:option selected="${defaultOption == 'nothing'}" value=".by-nothing">do not group</forms:option>
                </select>
                <forms:progressRing id="${groupId}_loading" style="display: none;" className="changeTestsGroupingProgress"/>
              </span>
            </c:if>

          </td>
          <jsp:invoke fragment="afterToolbar"/>
        </tr>
      </table>

    </div>
  </c:if>

  <c:if test="${empty withoutActions and groupedTestsBean.testsNumber > 1}">
    <authz:authorize projectId="${projectId}" anyPermission="ASSIGN_INVESTIGATION,MANAGE_BUILD_PROBLEMS">
      <div class="select-all">
        <forms:checkbox name="" custom="true" onclick="BS.TestGroup.toggleSelectAll('#${groupId}', this);" id="select-${groupId}"/>
        <label for="select-${groupId}">All tests</label>
      </div>
    </authz:authorize>
  </c:if>

  <!-- Grouping by package: -->
  <c:if test="${defaultOption == 'package'}">
    <div class="group-div by-package">
    <tt:testGroupedByPackage groupId="${groupId}" rootGroup="${groupedTestsBean.packagesRoot}"
                             withoutActions="${withoutActions}"
                             maxTests="${maxTests}" maxTestsPerGroup="${maxTestsPerGroup}" singleBuildTypeContext="${singleBuildTypeContext}"
                             ignoreMuteScope="${ignoreMuteScope}" showMuteFromTestRun="${showMuteFromTestRun}" maxTestNameLength="${maxTestNameLength}"
                             >
      <jsp:attribute name="viewAllUrl"><jsp:invoke fragment="viewAllUrl"/></jsp:attribute>
      <jsp:attribute name="testMoreData"><jsp:invoke fragment="testMoreData"/></jsp:attribute>
      <jsp:attribute name="testAfterName"><jsp:invoke fragment="testAfterName"/></jsp:attribute>
      <jsp:attribute name="testLinkAttrs"><jsp:invoke fragment="testLinkAttrs"/></jsp:attribute>
    </tt:testGroupedByPackage>
    </div>
  </c:if>

  <!-- No grouping at all: -->
  <c:if test="${defaultOption == 'nothing'}">
    <div class="group-div by-nothing">

      <table class="testList">
        <c:forEach var="testBean" items="${groupedTestsBean.packagesRoot.items}" varStatus="i"><c:if test="${i.index < maxTests}"
            ><tt:_testWithBuilds groupId="${groupId}" testBean="${testBean}" withoutActions="${withoutActions}"
                                 checkboxRequired="${empty withoutActions}" showPackage="true" singleBuildTypeContext="${singleBuildTypeContext}"
                                 ignoreMuteScope="${ignoreMuteScope}" showMuteFromTestRun="${showMuteFromTestRun}" maxTestNameLength="${maxTestNameLength}"
                                 >
              <jsp:attribute name="testMoreData"><jsp:invoke fragment="testMoreData"/></jsp:attribute>
              <jsp:attribute name="testAfterName"><jsp:invoke fragment="testAfterName"/></jsp:attribute>
            </tt:_testWithBuilds>
            ${util:add(allShownTestBeans, testBean)}
        </c:if></c:forEach>

      </table>
      <c:if test="${fn:length(groupedTestsBean.packagesRoot.items) > maxTests}">
        <div class="viewAllUrl"><jsp:invoke fragment="viewAllUrl"/></div>
      </c:if>
    </div>
  </c:if>

  <!-- Grouping by build configuration only: -->
  <c:if test="${defaultOption == 'bt'}">
    <div class="group-div by-bt">



    <c:if test="${groupedTestsBean.testsWithSeveralBuildTypes.testCount > 0}">
      <c:set var="groupNameId" value="multiple_bt"/>
      <!-- Always expand this block by default until full page reload: -->
      <script>BS.Blocks._saved['multiple_bt']='';</script>
      <%--${util:blockHiddenJs(pageContext.request, groupNameId, true)}--%>
      <div class="group-name" data-blockId="${groupNameId}">
        <c:if test="${empty withoutActions}">
          <forms:checkbox name="" custom="true" className="multi-select"/>
        </c:if>
        <bs:handle/><span class="title">Problems in multiple projects/build configurations</span>
        <span class="testCount" title="Tests with multiple failures">(${groupedTestsBean.testsWithSeveralBuildTypes.testCount})</span>

      </div>
      <div class="subgroups" style="${util:blockHiddenCss(pageContext.request, groupNameId, false)}">
        <tt:testGroupedByPackage rootGroup="${groupedTestsBean.testsWithSeveralBuildTypes}"
                                 withoutActions="${withoutActions}"
                                 maxTests="${maxTests}" maxTestsPerGroup="${maxTestsPerGroup}"
                                 singleBuildTypeContext="${singleBuildTypeContext}"
                                 ignoreMuteScope="${ignoreMuteScope}" showMuteFromTestRun="${showMuteFromTestRun}" maxTestNameLength="${maxTestNameLength}"
                                 >
          <jsp:attribute name="viewAllUrl"><jsp:invoke fragment="viewAllUrl"/></jsp:attribute>
          <jsp:attribute name="testMoreData"><jsp:invoke fragment="testMoreData"/></jsp:attribute>
          <jsp:attribute name="testAfterName"><jsp:invoke fragment="testAfterName"/></jsp:attribute>
        </tt:testGroupedByPackage>
      </div>
    </c:if>




    <c:if test="${groupedTestsBean.testsWithoutBuilds.testCount > 0}">
      <c:set var="groupNameId" value="without_bt"/>
      ${util:blockHiddenJs(pageContext.request, groupNameId, true)}
      <div class="group-name" data-blockId="${groupNameId}">
        <c:if test="${empty withoutActions}">
          <forms:checkbox name="" custom="true" className="multi-select"/>
        </c:if>
        <bs:handle/><span class="title">Problematic tests without associated builds</span>
        <span class="testCount">(${groupedTestsBean.testsWithoutBuilds.testCount})</span>

      </div>
      <div class="subgroups" style="${util:blockHiddenCss(pageContext.request, groupNameId, false)}">
        <tt:testGroupedByPackage rootGroup="${groupedTestsBean.testsWithoutBuilds}"
                                 withoutActions="${withoutActions}"
                                 maxTests="${maxTests}" maxTestsPerGroup="${maxTestsPerGroup}"
                                 singleBuildTypeContext="${singleBuildTypeContext}"
                                 ignoreMuteScope="${ignoreMuteScope}" showMuteFromTestRun="${showMuteFromTestRun}" maxTestNameLength="${maxTestNameLength}"
            >
          <jsp:attribute name="viewAllUrl"><jsp:invoke fragment="viewAllUrl"/></jsp:attribute>
          <jsp:attribute name="testMoreData"><jsp:invoke fragment="testMoreData"/></jsp:attribute>
          <jsp:attribute name="testAfterName"><jsp:invoke fragment="testAfterName"/></jsp:attribute>
        </tt:testGroupedByPackage>
      </div>
    </c:if>

        <!-- Showing the list of projects with related tests -->
        <tt:projectTestGroups projectGroup="${groupedTestsBean.rootProjectGroup}"
                                 withoutActions="${withoutActions}"
                                 maxTests="${maxTests}" maxTestsPerGroup="${maxTestsPerGroup}" showFullProjectName="${showFullProjectName}"
                                 ignoreMuteScope="${ignoreMuteScope}" showMuteFromTestRun="${showMuteFromTestRun}" maxTestNameLength="${maxTestNameLength}"
            >
          <jsp:attribute name="viewAllUrl"><jsp:invoke fragment="viewAllUrl"/></jsp:attribute>
          <jsp:attribute name="testMoreData"><jsp:invoke fragment="testMoreData"/></jsp:attribute>
          <jsp:attribute name="testAfterName"><jsp:invoke fragment="testAfterName"/></jsp:attribute>
          <jsp:attribute name="testLinkAttrs"><jsp:invoke fragment="testLinkAttrs"/></jsp:attribute>
        </tt:projectTestGroups>


  </div>
  </c:if>

  <bs:trimWhitespace>
  <c:set var="jsData" value=""/>
  <c:forEach var="testBean" items="${allShownTestBeans}">
    <c:set var="testRun" value="${testBean.run}"/>
    <%--@elvariable id="testRun" type="jetbrains.buildServer.serverSide.STestRun"--%>
    <c:set var="builds" value="${testBean.relatedBuilds}"/>
    <c:set var="ids" value=""/>
    <c:forEach var="build" items="${builds}">
      <c:set var="ids" value="${build.buildId},${ids}"/>
    </c:forEach>
    <c:set var="jsData" value="['${testRun.test.testNameId}', \"${ids}\"],${jsData}"/>
  </c:forEach>
  </bs:trimWhitespace>
</div>
<script type="text/javascript">
  (function($) {

  BS.Util.runWithElement('${groupId}', function() {
    if (BS.Browser.msie) {
      $j('#${groupId} .group-name:eq(0)').css("border", 'none');
    }

    BS.TestGroup.initialize('${groupId}', [${jsData}], '${projectExternalId}');
    <c:set var="expandGroup" value="'expand_${groupId}'"/>

    <c:if test="${not withoutActions}">
    // We need this to remove existing blocks from the collapse all/expand all handler to avoid memory leaks
    // Otherwise Collapse all will be broken in case when we have periodical AJAX page refresh with test list
    BS.CollapsableBlocks.unregisterBlocks(${expandGroup});
    </c:if>

    var expandDeepFunction = function(el, expand) {
      if (expand) {
        var subnodes = $(this.getBlockContentElement()).children(".group-name");

        if (subnodes.length == 1 && subnodes[0]._simple_block) {
          subnodes[0]._simple_block.showBlock();
        }
      }
    };

    $('#${groupId} .group-name').make_collapsable({registerForExpandAll: ${withoutActions ? "false" : expandGroup}, onStateChange: expandDeepFunction});
  });

  })(jQuery);
</script>
</bs:refreshable>
<c:if test="${empty withoutActions}">
  <forms:modified id="${groupId}-actions-docked">
    <jsp:body>
      <div class="bulk-operations-toolbar fixedWidth">
        <span class="bulk-operations">
          <tt:_bulkOperationsLinks groupId="${groupId}" projectId="${projectId}"  noFix="${withoutFixAction}"/>
        </span>
      </div>
      <script type="text/javascript">
        (function($) {
          $('.bulk-operations-toolbar .bulk-operation-link').addClass(function() {
            $(this).addClass('btn');
            if (!$(this).hasClass('bulk-operation-cancel')) {
              $(this).addClass('btn_primary submitButton')
            }
          });
        })(jQuery)
      </script>
    </jsp:body>
  </forms:modified>
</c:if>