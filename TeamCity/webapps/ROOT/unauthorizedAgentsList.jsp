<%@ include file="include-internal.jsp" %>
<%@ taglib prefix="agent" tagdir="/WEB-INF/tags/agent"%>
<jsp:useBean id="agentGroups" scope="request" type="java.util.List<jetbrains.buildServer.controllers.agent.AgentGroup>"/>
<jsp:useBean id="agentsForm" scope="request" type="jetbrains.buildServer.controllers.agent.AgentListForm"/>

<c:set var="grouped" value="${agentsForm.actuallyGroupByPools}"/>

<table class="agents dark sortable borderBottom">
  <thead>
    <tr>
      <agent:poolTH/>
      <th class="buildAgentName sortable"><span id="SORT_BY_NAME">Agent</span></th>
      <th>Authorize</th>
      <th class="sortable"><span id="SORT_BY_CONNECTION_STATUS">Is connected</span></th>
      <th class="lastActivity sortable"><span id="SORT_BY_LAST_ACTIVITY_DATE">Last communication date</span></th>
      <th>Inactivity reason</th>
    </tr>
  </thead>

  <c:forEach var="agentGroup" items="${agentGroups}" varStatus="groupIndex">
    <c:if test="${grouped}">
      <tr class="noBorder">
        <td class="noBorder firstCell"><bs:agentPoolHandle agentPoolId="${agentGroup.poolId}"/></td>
        <td colspan="5" class="poolHeader"><bs:agentPoolLink agentPoolId="${agentGroup.poolId}" agentPoolName="${agentGroup.name}" groupHeader="${true}"/></td>
      </tr>
    </c:if>

    <c:forEach var="buildAgent" items="${agentGroup.agents}" varStatus="agentIndex">
      <tr class="agentRow-${agentGroup.poolId} <c:if test="${grouped and agentIndex.last}">noBorder</c:if>" id="agentRow:${buildAgent.id}" style='<bs:agentRowVisibility agentPoolId="${agentGroup.poolId}"/>'>

        <c:if test="${grouped}">
          <td class="emptyCell">&nbsp;</td>
        </c:if>

        <td class="buildAgentName">
          <bs:agentDetailsFullLink agent="${buildAgent}" doNotShowOutdated="${true}" doNotShowPoolInfo="${grouped}" doNotShowUnavailableStatus="${true}"/><br />
          <c:out value="${buildAgent.hostAddress}"/>
        </td>

        <td>
          <jsp:include page="/agentStatus.html?id=${buildAgent.id}&tableMode=2"/>
        </td>

        <td>
          <c:choose>
            <c:when test="${buildAgent.registered}"><span class="registered">Connected</span></c:when>
            <c:when test="${not buildAgent.registered}"><span class="unregistered">Disconnected</span></c:when>
          </c:choose>
        </td>

        <td class="lastActivity">
          <bs:date value="${buildAgent.lastCommunicationTimestamp}"/>
        </td>

        <td>
          <c:out value="${buildAgent.unregistrationComment}"/>&nbsp;
        </td>
      </tr>
    </c:forEach>
  </c:forEach>
</table>

<agent:restoreAgentBlockStates grouped="${grouped}"/>

<bs:changeAgentStatus agentActionCode="changeAuthorizeStatus" agentPoolsList="${agentPoolsList}"/>