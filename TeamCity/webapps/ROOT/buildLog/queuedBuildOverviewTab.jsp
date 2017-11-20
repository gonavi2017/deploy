<%@include file="../include-internal.jsp"%>
<%@taglib prefix="tt" tagdir="/WEB-INF/tags/tests"%>
<%@taglib prefix="tags" tagdir="/WEB-INF/tags/tags"%>
<%@ taglib prefix="problems" tagdir="/WEB-INF/tags/problems"%>
<jsp:useBean id="queuedBuild" type="jetbrains.buildServer.serverSide.SQueuedBuild" scope="request"/>
<jsp:useBean id="dependenciesBean" type="jetbrains.buildServer.controllers.viewLog.DependenciesInfo" scope="request"/>
<jsp:useBean id="chainEstimates" type="jetbrains.buildServer.controllers.viewLog.ChainEstimatesBean" scope="request"/>
<jsp:useBean id="buildProblemsBean" type="jetbrains.buildServer.web.problems.BuildProblemsBean" scope="request"/>

<%--@elvariable id="currentUser" type="jetbrains.buildServer.users.SUser"--%>
<c:set var="buildEstimates" value="${queuedBuild.buildEstimates}"/>
<script type="text/javascript">enablePeriodicalRefresh();</script>
<div>

  <c:set var="hasNote" value="${not empty buildEstimates and not empty buildEstimates.waitReason}"/>
  <c:set var="comment" value="${queuedBuild.buildPromotion.buildComment}"/>
  <div class="queuedStatusBlock statusBlock">
    <table class="statusTable">
      <tr>
        <td class="st labels">Queue position:</td>
        <c:set var="orderNumber" value="${queuedBuild.orderNumber}"/>
        <c:set var="itemId" value="${queuedBuild.itemId}"/>
        <td class="st"><a href="<c:url value='/queue.html?itemId=${itemId}#itemId${itemId}'/>" title="Click to see the Build Queue">#<c:out
            value="${orderNumber > 0 ? orderNumber : 'not in queue'}"/></a> (queued <bs:date value="${queuedBuild.whenQueued}"/>)
        </td>
        <td class="st labels">Can run on:</td>
        <td class="st fixed"><queue:queuedBuildAgent queuedBuild="${queuedBuild}"/></td>
      </tr>
      <tr>
        <td class="st labels">Time to start:</td>
        <td class="st fixed"><span id="estimate"/></td>
        <td class="st labels">Triggered by:</td>
        <td class="st fixed"><queue:triggeredBy queuedBuild="${queuedBuild}" currentUser="${currentUser}" contextProject="${contextProject}"/></td>
      </tr>
      <c:set var="branch" value="${queuedBuild.buildPromotion.branch}"/>
      <c:if test="${not empty branch}">
        <tr>
          <td class="st labels">Branch:</td>
          <td colspan="3" class="st">
            <span class="branch hasBranch ${branch.defaultBranch ? 'default' : ''}"><bs:branchLink branch="${branch}" buildPromotion="${queuedBuild.buildPromotion}"
                                                                                                   noLink="${false}"><c:out value="${branch.displayName}"/></bs:branchLink></span>
          </td>
        </tr>
      </c:if>
    </table>
  </div>

  <bs:userBuildDetails promotion="${queuedBuild.buildPromotion}"/>
  <bs:buildCommentDialog />

  <c:if test="${buildProblemsBean.hasBuildProblems}">
    <problems:buildProblemStylesAndScripts/>

    <c:set var="sectionTitle">
      <problems:buildProblemSectionHeader buildProblemsBean="${buildProblemsBean}"/>
    </c:set>

    <bs:_collapsibleBlock title="${sectionTitle}" id="buildProblems" collapsedByDefault="false">
      <problems:buildProblemList buildProblemsBean="${buildProblemsBean}"
                                 compactMode="false" showLink="false" showPopup="true" showExpandCollapseActions="true">
        <problems:additonalInfo compactMode="false" inlineMuteInfo="true" inlineResponsibilty="false" buildProblem="${buildProblem}"/>
      </problems:buildProblemList>
    </bs:_collapsibleBlock>
  </c:if>

  <c:if test="${dependenciesBean.groupedFailedTests.testsNumber > 0}">
  <c:set var="title2"> <span class="icon icon16 build-status-icon build-status-icon_error"></span> Failed tests from dependent builds: ${dependenciesBean.groupedFailedTests.testsNumber}</c:set>
  <bs:_collapsibleBlock title="${title2}" id="failedDepsTest">
    <tt:testGroupWithActions groupedTestsBean="${dependenciesBean.groupedFailedTests}" defaultOption="bt" groupSelector="true"
                             id="build_dep"  maxTestsPerGroup="200" maxTests="1000"/>
  </bs:_collapsibleBlock>
  </c:if>

  <c:set var="blockTitle">
    <div style="overflow: hidden">
      <div style="float: left">${dependenciesBean.title}</div>
      <c:if test="${dependenciesBean.finished ne fn:length(dependenciesBean.allDependencies)}">
        <div style="float: left; margin-left: 2em; width: 50%"><bs:chainProgress chainEstimates="${chainEstimates}"/></div>
      </c:if>
      <c:url value='/viewChain.html?chainId=${dependenciesBean.chainId}&selectedBuildTypeId=${queuedBuild.buildPromotion.parentBuildTypeId}' var="viewChainUrl"/>
      <div style="float: right">
        <a href="${viewChainUrl}" target="_blank" onclick="BS.stopPropagation(event);" style="text-decoration: none" title="Open build chain in a new window"><i class="tc-icon icon16 tc-icon_build-chain"></i></a>
      </div>
    </div>
  </c:set>
  <c:if test="${fn:length(dependenciesBean.allDependencies) > 0}">
    <bs:_collapsiblePromotions title="${blockTitle}" id="dependencies" promotions="${dependenciesBean.allDependencies}"/>
  </c:if>

  <queue:queueEstimates queuedBuild="${queuedBuild}"/>
  <script type="text/javascript">
    (function() {
      var estimate = BS.QueueEstimates.getEstimate('${queuedBuild.itemId}');
      var timeToStartStr = estimate != null ? estimate.getEstimate() : 'N/A';
      var timeFrameStr = "";
      var noteStr = "";

      if (estimate) {
        if (estimate.secondsToStart == null) {
          noteStr = "Cannot estimate this build<br/>";
        } else if (estimate.secondsToStart > 0) {
          var duration = estimate.durationAsString;
          if (duration == "???") {
            duration = "";
          }
          timeFrameStr = "(expected to run " + estimate.timeFrame + ", duration " + duration + ")<br/>";
        } else if (estimate.secondsToStart == 0) {
          noteStr = "The build should start shortly.<br/>";
        }

        if (estimate.isDelayed) {
          var buildLink = estimate._buildLink;
          var agentLink = estimate._agentLink;
          if (buildLink != '' && agentLink != '') {
            noteStr += "Delayed by " + buildLink + " on " + agentLink + ",<br/>";
            noteStr += "expected build duration is " + estimate.durationAsString + "<br/>"
          }
        }

        if (estimate.waitReason) {
          noteStr += estimate.waitReason;
        }
      }

      var resultStr;
      if (noteStr.length > 0) {
        resultStr = noteStr;
      } else {
        resultStr = timeToStartStr;
        if (timeFrameStr.length > 0) {
          resultStr += " " + timeFrameStr;
        }
      }

      $j("#estimate").html(resultStr);
    })();
  </script>
</div>