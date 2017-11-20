<%@ include file="include-internal.jsp" %>
<%@ taglib prefix="resp" tagdir="/WEB-INF/tags/responsible" %>
<%@ taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %>
<%@ taglib prefix="problems" tagdir="/WEB-INF/tags/problems" %>
<bs:messages key="buildNotFound"/>

<c:if test="${not empty buildResultsSummary}">
<jsp:useBean id="buildResultsSummary" type="jetbrains.buildServer.controllers.viewLog.BuildResultsSummary" scope="request"/>

<c:set var="build" value="${buildResultsSummary.build}"/>
<c:set var="buildStatistics" value="${buildResultsSummary.buildStatistics}"/>
<c:set var="buildProblemsBean" value="${buildResultsSummary.buildProblemsBean}"/>

<table class="buildResultsSummaryTable">
  <td>

    <div class="header">Build shortcuts</div>

      <ul class="bsLinks">
        <li>
          <a href="<c:url value='/viewLog.html?tab=buildLog&buildTypeId=${build.buildTypeExternalId}&buildId=${build.buildId}'/>"
                 title="View log messages">Build log</a>
          <span class="separator">|</span>
          <a href="<c:url value='downloadBuildLog.html?buildId=${build.buildId}&archived=true'/>" target="_blank"
             title="Download archived build log">.zip</a>
        </li>

        <c:forEach items="${buildResultsSummary.extensions}" var="extension">
          <li><bs:_viewLog build="${build}" title="View ${extension.tabTitle}" tab="${extension.tabId}">${extension.tabTitle}</bs:_viewLog></li>
        </c:forEach>
      </ul>

  </td>

  <c:if test="${buildStatistics.failedTestCount > 0 or buildProblemsBean.hasBuildProblems}">
  <td style="padding: 0 0 5px 15px">
    <c:if test="${buildProblemsBean.hasBuildProblems}">
      <div class="header">
        <problems:buildProblemSectionHeader buildProblemsBean="${buildProblemsBean}"/>
      </div>
      <problems:buildProblemList buildProblemsBean="${buildProblemsBean}" showLink="true" showPopup="true" compactMode="true"/>
    </c:if>

    <c:if test="${buildStatistics.failedTestCount > 0}">
      <div class="header">
        ${buildStatistics.failedTestCount} tests failed (<bs:new count="${buildStatistics.newFailedCount}"/>)
      </div>

      <c:set var="linkToTestRequired" value="true" scope="request"/>
      <tt:testGroupWithActions groupedTestsBean="${buildResultsSummary.groupedTests}" defaultOption="package"
                               withoutActions="true" groupSelector="false" singleBuildTypeContext="true"
                               maxTests="12" maxTestsPerGroup="3" maxTestNameLength="120" id="build_summary">
        <jsp:attribute name="viewAllUrl">
            <bs:resultsLink build="${build}" noPopup="true">View all tests &raquo;</bs:resultsLink>
        </jsp:attribute>
      </tt:testGroupWithActions>
    </c:if>
  </td>
  </c:if>

</table>
</c:if>


