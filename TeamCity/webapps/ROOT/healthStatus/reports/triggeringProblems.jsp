<%@ page import="jetbrains.buildServer.serverSide.impl.BuildTriggersChecker" %>
<%@include file="/include-internal.jsp"%>
<jsp:useBean id="healthStatusItem" type="jetbrains.buildServer.serverSide.healthStatus.HealthStatusItem" scope="request"/>
<c:set var="reason" value="${healthStatusItem.additionalData['reason']}"/>
<c:set var="TOO_BIG_QUEUE" value="<%=BuildTriggersChecker.TriggeringPausedReason.TOO_BIG_BUILD_QUEUE%>"/>
Automatic build triggering paused for the whole server because of the following reason: <c:out value="${fn:toLowerCase(reason.reasonText)}"/>.
<c:choose>
  <c:when test="${reason == TOO_BIG_QUEUE}">
    Build triggering will be unpaused automatically once the queue size is reduced.
  </c:when>
</c:choose>
