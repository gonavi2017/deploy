<%@ include file="/include-internal.jsp" %>
<jsp:useBean id="healthStatusItem" type="jetbrains.buildServer.serverSide.healthStatus.HealthStatusItem" scope="request"/>
<jsp:useBean id="problematicAgents" type="java.util.Map" scope="request"/>
<div>The following agents tried to upgrade several times but failed:</div>
<ul>
  <c:forEach items="${problematicAgents}" var="agentInfo">
    <li><bs:agent agent="${agentInfo.key}"/></li>
  </c:forEach>
</ul>