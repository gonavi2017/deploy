<%@ include file="include-internal.jsp" %>
<jsp:useBean id="buildType" type="jetbrains.buildServer.serverSide.BuildTypeEx" scope="request"/>
<jsp:useBean id="serverSummary" type="jetbrains.buildServer.web.openapi.ServerSummary" scope="request"/>
<%@ include file="_subscribeToCommonBuildTypeEvents.jspf"
%><bs:buildTypeCompatibility compatibleAgents="${buildType}" project="${buildType.project}"/>
