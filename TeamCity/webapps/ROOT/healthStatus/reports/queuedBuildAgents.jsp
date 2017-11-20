<%@ include file="/include-internal.jsp"%>
<%@ taglib prefix="q" tagdir="/WEB-INF/tags/queue"%>
<jsp:useBean id="healthStatusItem" type="jetbrains.buildServer.serverSide.healthStatus.HealthStatusItem" scope="request"/>

<c:set var="buildType" value="${healthStatusItem.additionalData['buildType']}"/>
<c:set var="hangingQueuedBuilds" value="${healthStatusItem.additionalData['hangingQueuedBuilds']}"/>
Found <strong>${fn:length(hangingQueuedBuilds)}</strong> queued build<bs:s val="${fn:length(hangingQueuedBuilds)}"/> of <admin:viewOrEditBuildTypeLinkFull buildType="${buildType}"/> waiting in the queue for a long time without compatible agents:
<ul>
  <c:forEach items="${hangingQueuedBuilds}" var="qb">
    <li><q:queueLink queuedBuild="${qb}" noPopup="true">#${qb.orderNumber}, added to queue <strong><bs:elapsedTime time="${qb.whenQueued}"/></strong></q:queueLink></li>
  </c:forEach>
</ul>
