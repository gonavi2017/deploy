<%@ page import="jetbrains.buildServer.web.util.WebUtil" %>
<%@ include file="../include-internal.jsp" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags/tags" %><%@
    taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %><%@
    taglib prefix="labels" tagdir="/WEB-INF/tags/labels" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags"%><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests"
%>
<%@ taglib prefix="problems" tagdir="/WEB-INF/tags/problems"%>

<jsp:useBean id="buildResultsBean" type="jetbrains.buildServer.controllers.viewLog.BuildResultsBean" scope="request"
/><c:set var="buildStatistics" value="${buildResultsBean.buildStatistics}"
/><c:set var="dependenciesBean" value="${buildResultsBean.dependenciesBean}"
/><c:set var="deploymentsBean" value="${buildResultsBean.deploymentsBean}"
/><jsp:useBean id="buildData" type="jetbrains.buildServer.serverSide.SBuild" scope="request"

/><script type="text/javascript">
  enablePeriodicalRefresh();
  BS.BuildResults._expanded_count = 0;
</script>

<c:if test="${not buildData.finished}">
  <div id="noRefreshWarning" class="icon_before icon16 attentionComment" style="display:none;">
    This page will not refresh until you hide all open stacktraces and build problem details on it.&nbsp;
    <a href="#" class="btn btn_mini" onclick="BS.unblockRefresh('stacktrace'); $('buildResults').refresh(null, 'runningBuildRefresh=1'); return false;">Force Refresh</a>
  </div>
</c:if>

<bs:userBuildDetails promotion="${buildData.buildPromotion}"/>

<bs:buildDataPlugins/>

<c:set var="buildProblemsBean" value="${buildResultsBean.buildProblemsBean}"/>
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

  <c:if test="${dependenciesBean.groupedFailedTests.testsNumber > 0}">
    <c:set var="title2"><span class="icon icon16 build-status-icon build-status-icon_error"></span> Failed tests from dependent builds: ${dependenciesBean.groupedFailedTests.testsNumber}</c:set>
    <bs:_collapsibleBlock title="${title2}" id="failedDepsTest">
      <tt:testGroupWithActions groupedTestsBean="${dependenciesBean.groupedFailedTests}" maxTestNameLength="140" defaultOption="bt" groupSelector="true"
                               id="build_dep" maxTestsPerGroup="200" maxTests="1000"/>
    </bs:_collapsibleBlock>
  </c:if>
</c:if>

<c:set var="failedTestCount" value="${fn:length(buildStatistics.failedTests)}"/>
<c:set var="mutedTestCount" value="${fn:length(buildStatistics.mutedTests)}"/>
<c:set var="ignoredTestCount" value="${fn:length(buildStatistics.ignoredTests)}"/>

<c:set var="maxTests2Show" value="${param['maxFailed']}"/>
<c:if test="${empty maxTests2Show}">
  <c:set var="maxTests2Show" value="1000"/>
</c:if>

<!--Failed tests info-->

<c:if test="${failedTestCount > 0}">

  <c:set var="state" value="expanded"/>
  <c:set var="failedTitle">
      <span class="icon icon16 build-status-icon build-status-icon_error"></span>
      <span class="failCount">${failedTestCount} test<bs:s val="${failedTestCount}"/> failed (<bs:new count="${buildStatistics.newFailedCount}"/>)</span>
  </c:set>

  <bs:_collapsibleBlock title="${failedTitle}" id="idfailed">
      <bs:showAllTests buildData="${buildData}" maxTests2Show="${maxTests2Show}" testCount="${failedTestCount}" testType="failed"/>
      <bs:printTests tests="${buildStatistics.failedTests}" buildData="${buildData}" maxTests2Show="${maxTests2Show}"/>
  </bs:_collapsibleBlock>

</c:if>

<!--Muted tests info-->

<c:if test="${mutedTestCount > 0}">
  <c:set var="state" value="expanded"/>

  <c:set var="mutedTitle">
    <span class="icon icon16 bp muted red"></span> <span class="mutedCount">${mutedTestCount} test failure<bs:s val="${mutedTestCount}"/> muted</span>
  </c:set>

  <bs:_collapsibleBlock title="${mutedTitle}" id="idmuted">
    <bs:showAllTests buildData="${buildData}" maxTests2Show="${maxTests2Show}" testCount="${mutedTestCount}" testType="muted"/>
    <tt:_testGroupForBuild tests="${buildStatistics.mutedTests}" maxTests2Show="${maxTests2Show}"
                           buildData="${buildData}" showMuteFromTestRun="true" id="build_mute"/>
  </bs:_collapsibleBlock>
</c:if>

<!--Tests ignored info-->

<c:if test="${ignoredTestCount > 0}">
  <c:set var="ignoredTitle">
    <bs:icon icon="ignored.png"/> <span class="failCount">${ignoredTestCount} test<bs:s val="${ignoredTestCount}"/> ignored</span>
  </c:set>

  <bs:_collapsibleBlock title="${ignoredTitle}" id="idignored" collapsedByDefault="true">
    <bs:showAllTests buildData="${buildData}" maxTests2Show="${maxTests2Show}" testCount="${ignoredTestCount}" testType="ignored"/>
    <c:set var="maxTestsDefault" value="<%= WebUtil.getMaxUiTestLimit() %>"/>
    <tt:testGroupWithActions groupedTestsBean="${buildResultsBean.ignoredGroup}"
                             groupSelector="noBuildType" defaultOption="package" singleBuildTypeContext="true"
                             maxTests="${maxTests2Show > 0 ? maxTests2Show : maxTestsDefault}" maxTestNameLength="140"
                             maxTestsPerGroup="${maxTests2Show > 0 ? maxTests2Show/2 : maxTestsDefault}" id="build_ignore"
                             withoutFixAction="${true}">
      <jsp:attribute name="testLinkAttrs">onclick='return false;'</jsp:attribute>
      <jsp:attribute name="testAfterName">
          <c:set var='test' value="${testBean.run}"/>
          <c:if test="${not empty test.ignoreComment}">
            <span class="commentText">&mdash; <bs:out value="${test.ignoreComment}"/></span>
          </c:if>
      </jsp:attribute>
      <jsp:attribute name="viewAllUrl">
      </jsp:attribute>
        </tt:testGroupWithActions>
  </bs:_collapsibleBlock>
</c:if>

<!--Tests passed info-->

<c:if test="${buildStatistics.passedTestCount > 0}">
  <p class="passedTestsBlock">
    <span class="icon icon16 build-status-icon build-status-icon_successful"></span> <span class="passCount">${buildStatistics.passedTestCount} test<bs:s val="${buildStatistics.passedTestCount}"/> passed</span>
  </p>
</c:if>

<c:if test="${fn:length(dependenciesBean.allDependencies) > 0}">
  <c:url value='/viewChain.html?chainId=${dependenciesBean.chainId}&selectedBuildTypeId=${buildData.buildTypeId}' var="viewChainUrl"/>
  <c:set var="title">
    <span>${dependenciesBean.title}</span>
    <span style="float: right">
      <a href="${viewChainUrl}" target="_blank" onclick="BS.stopPropagation(event);" style="text-decoration: none" title="Open build chain in a new window"><i class="tc-icon icon16 tc-icon_build-chain"></i></a>
    </span>
  </c:set>
  <bs:_collapsiblePromotions title="${title}"
                             id="dependencies"
                             promotions="${dependenciesBean.allDependencies}"
                             collapsed="${buildData.finished}"/>
</c:if>

<c:if test="${buildData.finished}">
  <c:set var="lastDeployments" value="${deploymentsBean.lastDeployments}"/>
  <c:if test="${not empty lastDeployments}">
    <bs:_collapsibleBlock title="Environments" id="lastDeployments" collapsedByDefault="${false}" tag="div" headerStyle="margin-top: 13px">
      <table class="modificationBuilds">
        <c:forEach var="promotion" items="${lastDeployments}" varStatus="pos">
          <%--@elvariable id="promotion" type="jetbrains.buildServer.serverSide.BuildPromotion"--%>
          <c:set var="buildType" value="${promotion.buildType}"/>
          <c:set var="build" value="${promotion.associatedBuild}"/>
          <c:set var="queuedBuild" value="${promotion.queuedBuild}"/>
          <c:if test="${not empty buildType}">
            <tr class="buildTypeProblem">
              <td class="buildTypeName">
                <bs:buildTypeLinkFull buildType="${buildType}" fullProjectPath="true" popupMode="no_self"/>
              </td>
              <c:choose>
                <c:when test="${not empty build}">
                  <bs:buildRow build="${build}" showBranchName="true" showBuildNumber="true" showStatus="true" showArtifacts="true" showChanges="true" showStartDate="true"/>
                  <c:if test="${build.finished}"><td class="finishedBuildDuration duration"><bs:printTime time="${build.duration}" showIfNotPositiveTime="&lt; 1s"/></td></c:if>
                  <c:if test="${not build.finished}"><td class="stopBuild"><bs:stopBuild build="${build}" message=""/></td></c:if>
                </c:when>
                <c:when test="${not empty queuedBuild}">
                  <bs:queuedBuild queuedBuild="${queuedBuild}" estimateColspan="5" showNumber="true" showBranches="true"  hideIcon="false"/>
                </c:when>
                <c:otherwise>
                  <td colspan="8"><i>Deleted build</i></td>
                </c:otherwise>
              </c:choose>
            </tr>
          </c:if>
        </c:forEach>
      </table>
    </bs:_collapsibleBlock>
  </c:if>
</c:if>
