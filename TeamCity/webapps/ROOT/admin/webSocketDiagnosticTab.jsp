<%@ include file="/include-internal.jsp" %>

<c:url value="/websocketDiagnostic.html" var="separatePageLink"/>
<div style="margin: 0.6em">
  Users without admin permissions can view WebSocket Status <a href="${separatePageLink}">here</a>
</div>
<jsp:include page="webSocketDiagnosticInfo.jsp"/>
