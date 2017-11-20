<%@ page import="jetbrains.buildServer.web.openapi.PlaceId" %>
<%@ include file="/include-internal.jsp" %>
<jsp:useBean id="agentDetails" scope="request" type="jetbrains.buildServer.controllers.agent.AgentTypeDetailsForm"/>
<c:set var="agentType" value="${agentDetails.agentType}"/>

<div id="agentTypeSummary" class="divsWithHeaders">
  <div id="first">
    <h2>Details</h2>
    <div class="details">
      <ul class="agentSummary">
        <li>Operating system: <strong>${agentType.operatingSystemName}</strong></li>
        <li>CPU rank: <strong><c:choose><c:when test="${agentType.cpuBenchmarkIndex > 0}">${agentType.cpuBenchmarkIndex}</c:when><c:otherwise>unknown</c:otherwise></c:choose></strong></li>
        <c:set var="pool" value="${agentType.agentPool}"/>
        <li>Pool: <strong><bs:agentPoolLink agentPoolId="${pool.agentPoolId}" agentPoolName="${pool.name}" hidePoolWord="${true}"/></strong></li>
      </ul>
    </div>
  </div>

  <ext:extensionsAvailable placeId="<%=PlaceId.AGENT_SUMMARY%>">
    <div>
      <h2>Miscellaneous</h2>
      <div class="details">
        <ext:includeExtensions placeId="<%=PlaceId.AGENT_SUMMARY%>"/>
      </div>
    </div>
  </ext:extensionsAvailable>
</div>

<script type="text/javascript">
  jQuery("#agentTypeSummary > div:last-child").addClass("last");
</script>
