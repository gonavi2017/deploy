<%-- Referenced from jetbrains.buildServer.serverSide.flaky.web.TestDetailsExtension --%>
<%@ include file="/include.jsp"%>

<style type="text/css">
  <%--@elvariable id="teamcityPluginResourcesPath" type="java.lang.String"--%>
  @import "${teamcityPluginResourcesPath}testDetailsExtension.css";
</style>


<%--@elvariable id="statistics" type="jetbrains.buildServer.serverSide.flakyTestDetector.Statistics"--%>
<%--@elvariable id="flakyTest" type="jetbrains.buildServer.serverSide.flakyTestDetector.opendata.TestInfo"--%>

<c:if test="${statistics.monitoringEnabled and not empty flakyTest and flakyTest.flaky}">
  <div class="flaky-analysis-result">
    <div><strong>This test looks flaky:</strong><bs:help file="Viewing+Tests+and+Configuration+Problems" anchor="FlakyTests"/></div>
    <%--

    Despite "testRuns" are already defined
    (1 for the "Projects" -> "Overview" tab (/viewLog.html),
    1+ for the "Changes" -> "Problems & Tests" tab (/viewModification.html)),
    normally none of them is suitable: we need a test invocation from a specific
    build from the flaky reason, *not* the current build.

    --%>
    <%@ include file="flakyReasonsShort.jspf" %>

    <%-- Guaranteed by PlaceId#TEST_DETAILS_BLOCK, see TestDetailsController --%>
    <%--@elvariable id="test" type="jetbrains.buildServer.serverSide.STest"--%>

    <%-- See jetbrains.buildServer.util.ContextProjectInfo --%>
    <%--@elvariable id="contextProject" type="jetbrains.buildServer.serverSide.SProject"--%>
    <c:if test="${not empty test and not empty contextProject}">
      <c:url var="url" value="/project.html?projectId=${contextProject.externalId}&tab=testDetails&testNameId=${test.testNameId}#analysis"/>
      <div><a href="${url}">View test history &raquo;</a></div>
    </c:if>
  </div>
</c:if>
