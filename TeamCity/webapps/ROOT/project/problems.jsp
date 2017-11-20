<%@ include file="../include-internal.jsp" %><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@
    taglib prefix="l" tagdir="/WEB-INF/tags/layout" %><%@
    taglib prefix="util" uri="/WEB-INF/functions/util" %><%@
    taglib prefix="user" tagdir="/WEB-INF/tags/userProfile" %><%@
    taglib prefix="problems" tagdir="/WEB-INF/tags/problems" %><%@
    taglib prefix="resp" tagdir="/WEB-INF/tags/responsible"

%><jsp:useBean id="project" type="jetbrains.buildServer.serverSide.SProject" scope="request"
/><jsp:useBean id="bean" type="jetbrains.buildServer.web.problems.CurrentProblemsBean" scope="request"

/><c:url var="url" value='/project.html?projectId=${project.externalId}&tab=problems'

/>
<div class="currentProblems">
  <div class="actionBar clearfix">
    <span class="nowrap">
      <label class="firstLabel" for="buildType">Filter by build configuration:</label>
      <bs:buildTypesFilter buildTypes="${bean.allBuildsTypes}" selectedBuildTypeId="${bean.buildTypeId}" url="${url}"
                           className="actionInput"/>
    </span>

    <span class="nowrap">
      <profile:booleanPropertyCheckbox propertyKey="hideAssignedProblems" progress="hideAssigned_progress"
                                       labelText="Hide problems under investigation"
                                       afterComplete="BS.reload(true);"/>
    </span>

    <forms:saving id="hideAssigned_progress" className="progressRingInline" savingTitle="Refreshing list of problems"/>
  </div>

  <c:if test="${not bean.hasCurrentProblems}">
    <div class="noProblems">
      There are no ${bean.ignoreInvestigatedProblems ? 'unassigned' : ''} problems in 
      <b><c:out value="${not empty bean.buildTypeId ? bean.buildType.name : project.name}"/></b>.
    </div>
  </c:if>

  <c:if test="${bean.buildsNumber > 0}">
    <c:set var="title">&nbsp;<span class="build-status-icon build-status-icon_error"></span> Build configuration problems: ${bean.buildsNumber}</c:set>
    <bs:_collapsibleBuilds title="${title}" id="currentFailingBuildTypes" builds="${bean.builds}" project="${project}"/>
  </c:if>

  <c:if test="${bean.failingTestsNumber > 0}">
    <c:set var="title">&nbsp;<span class="build-status-icon build-status-icon_error"></span> ${not empty bean.buildTypeId ? 'Failed' : 'All failed'} tests: ${bean.failingTestsNumber}</c:set>
    <bs:_collapsibleBlock title="${title}" id="projectFailingTests">
      <tt:testGroupWithActions groupedTestsBean="${bean.failingTestsGroup}" maxTestNameLength="140" defaultOption="bt"
                               groupSelector="true" ignoreMuteScope="true" id="cur_fail"/>
    </bs:_collapsibleBlock>
  </c:if>

  <c:if test="${bean.mutedFailedTests.testsNumber > 0}">
    <c:set var="title"><span class="icon icon16 bp muted red"></span> Muted test failures: ${bean.mutedFailedTests.testsNumber}</c:set>
    <bs:_collapsibleBlock title="${title}" id="projectMutedTests" collapsedByDefault="true">
      <tt:testGroupWithActions groupedTestsBean="${bean.mutedFailedTests}" maxTestNameLength="140" defaultOption="bt"
                               groupSelector="true" ignoreMuteScope="true" showMuteFromTestRun="true"
                               id="cur_muted"/>
    </bs:_collapsibleBlock>
  </c:if>

  <c:if test="${bean.buildProblemsNumber > 0}">
    <c:set var="title">&nbsp;<span class="build-status-icon build-status-icon_error"></span> Build problems: ${bean.buildProblemsNumber}</c:set>
    <bs:_collapsibleBlock title="${title}" id="projectBuildProblems">
        <problems:buildProblemExpandCollapse showExpandCollapseActions="true">
          <problems:buildProblemGroupByProject projectBuildProblemsBean="${bean.buildProblemsBean}">
          </problems:buildProblemGroupByProject>
        </problems:buildProblemExpandCollapse>
    </bs:_collapsibleBlock>
  </c:if>
</div>
