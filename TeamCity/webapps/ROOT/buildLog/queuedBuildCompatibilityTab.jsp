<%@include file="../include-internal.jsp"%>
<jsp:useBean id="queuedBuild" type="jetbrains.buildServer.serverSide.SQueuedBuild" scope="request"/>
<c:set var="buildType" value="${queuedBuild.buildType}"/>
<c:if test="${not empty displayCompatibilityNote and displayCompatibilityNote}">
<p>
  This page shows compatible agents for queued build.  If queued build has custom parameters this set of compatible agents can differ from <bs:buildTypeTabLink buildType="${buildType}" title="Click to view compatible agents of build configuration" tab="compatibilityList">compatible agents</bs:buildTypeTabLink> of <bs:buildTypeLinkFull buildType="${buildType}"/>.
</p>
</c:if>
<bs:buildTypeCompatibility compatibleAgents="${queuedBuild}" project="${buildType.project}" />