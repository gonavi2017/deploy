<%@include file="/include-internal.jsp" %>
<jsp:useBean id="cloudImageWarnings" scope="request" type="java.util.Set<jetbrains.buildServer.clouds.server.serverHealth.CloudImageWarnings.CloudImageWarningTypes>"/>

<div>
  <c:forEach var="warning" items="${cloudImageWarnings}">

    <div>
      <span class="icon icon16 yellowTriangle agentVersion" <bs:tooltipAttrs text="${warning.description}"/> ></span>
      <c:out value="${warning.description}"/>
    </div>
  </c:forEach>
</div>
