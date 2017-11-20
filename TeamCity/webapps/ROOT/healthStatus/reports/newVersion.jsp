<%@ include file="/include-internal.jsp"%>
<jsp:useBean id="healthStatusItem" type="jetbrains.buildServer.serverSide.healthStatus.HealthStatusItem" scope="request"/>
<jsp:useBean id="newVersionBean" type="jetbrains.buildServer.controllers.updates.NewVersionBean" scope="request"/>
<c:out value="${newVersionBean.displayName}"/> has been released<c:choose><c:when test="${empty newVersionBean.message}">.</c:when><c:otherwise>:
  <span><c:out value="${newVersionBean.message}"/></span><br>
</c:otherwise></c:choose>
<span>
  <bs:downloadNewVersionLink newVersionBean="${newVersionBean}" linkText="Upgrade!"/>
</span>
