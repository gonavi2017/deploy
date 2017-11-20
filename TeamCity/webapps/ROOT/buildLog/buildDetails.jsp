<%@ include file="../include-internal.jsp"
%><jsp:useBean id="build" type="jetbrains.buildServer.serverSide.SBuild" scope="request"
/><bs:buildDataStatus buildData="${build}" showAlsoRunning="false"/>
