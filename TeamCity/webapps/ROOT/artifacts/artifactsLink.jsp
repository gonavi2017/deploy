<%@ include file="../include-internal.jsp" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<jsp:useBean id="build" scope="request" type="jetbrains.buildServer.serverSide.SBuild"/>
<jsp:useBean id="showCompactArtifacts" scope="request" type="java.lang.Boolean"/>
<bs:buildRowArtifactsLink build="${build}" showCompactArtifacts="${showCompactArtifacts}" lazy="${false}"/>