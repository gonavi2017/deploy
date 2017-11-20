<jsp:useBean id="showMode" type="jetbrains.buildServer.web.openapi.healthStatus.HealthStatusItemDisplayMode" scope="request"/>
<%@ page import="jetbrains.buildServer.web.openapi.healthStatus.HealthStatusItemDisplayMode" %>
<%@ include file="/include-internal.jsp" %>
<c:set var="inplaceMode" value="<%=HealthStatusItemDisplayMode.IN_PLACE%>"/>
<jsp:useBean id="healthStatusItem" type="jetbrains.buildServer.serverSide.healthStatus.HealthStatusItem" scope="request"/>


<c:choose>
  <c:when test="${showMode == inplaceMode}">
    Some users cannot use optimized web UI updates via WebSocket protocol. <admin:healthStatusReportLink selectedCategory="websocket_connection">Details...</admin:healthStatusReportLink>
  </c:when>
  <c:otherwise>
    <div>
      Some users cannot use optimized web UI updates via WebSocket protocol.<br/>
      The following addresses were used by the affected sessions:
      <ul>
        <c:forEach items="${healthStatusItem.additionalData['problematicHosts']}" var="host">
          <li><a href="<c:url value="${host}"/>"><c:out value="${host}"/></a></li>
        </c:forEach>
      </ul>
      Most probably there is not appropriately configured proxy server between the client browsers and the TeamCity server.<bs:help file="Server+Health" anchor="WebSocketconnectionissues"/>
    </div>
  </c:otherwise>
</c:choose>
