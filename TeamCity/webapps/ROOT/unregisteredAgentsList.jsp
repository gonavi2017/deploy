<%@ include file="include-internal.jsp" %>
<%@ taglib prefix="agent" tagdir="/WEB-INF/tags/agent"%>
<jsp:useBean id="agentGroups" scope="request" type="java.util.List<jetbrains.buildServer.controllers.agent.AgentGroup>"/>
<jsp:useBean id="agentsForm" scope="request" type="jetbrains.buildServer.controllers.agent.AgentListForm"/>

<c:set var="grouped" value="${agentsForm.actuallyGroupByPools}"/>

<table class="agents dark sortable borderBottom">
  <thead>
    <tr>
      <agent:poolTH/>
      <th class="buildAgentName sortable">
        <div class="right">
          <span id="SORT_BY_STATUS">Status</span>
        </div>
        <div class="left">
          <span id="SORT_BY_NAME">Agent</span>
        </div>
      </th>
      <th style="width: 1em;"></th>
      <th class="lastActivity sortable"><span id="SORT_BY_LAST_ACTIVITY_DATE">Last communication</span></th>
      <th class="inactivityReason sortable"><span id="SORT_BY_INACTIVITY_REASON">Inactivity reason</span></th>
      <th class="lastCell sortable" colspan="4"><span id="SORT_BY_RUNNING_BUILD">Running build</span></th>
    </tr>
  </thead>

  <c:forEach var="agentGroup" items="${agentGroups}" varStatus="groupIndex">
    <c:if test="${grouped}">
      <tr class="noBorder">
        <td class="noBorder firstCell"><bs:agentPoolHandle agentPoolId="${agentGroup.poolId}"/></td>
        <td colspan="6" class="poolHeader"><bs:agentPoolLink agentPoolId="${agentGroup.poolId}" agentPoolName="${agentGroup.name}" groupHeader="${true}"/></td>
      </tr>
    </c:if>

    <c:forEach var="buildAgent" items="${agentGroup.agents}" varStatus="agentIndex">
      <c:set var="rowClass" value=""/>
      <c:if test="${not buildAgent.enabled}">
        <c:set var="rowClass" value="disabledAgent"/>
      </c:if>
      <tr class="${rowClass} agentRow-${agentGroup.poolId} <c:if test="${grouped and agentIndex.last}">noBorder</c:if>" id="agentRow:${buildAgent.id}" style='vertical-align: top; <bs:agentRowVisibility agentPoolId="${agentGroup.poolId}"/>'>

        <c:if test="${grouped}">
          <td class="emptyCell">&nbsp;</td>
        </c:if>

        <td class="buildAgentName">
          <bs:agentDetailsFullLink agent="${buildAgent}" showSlider="true" doNotShowOutdated="${true}" doNotShowPoolInfo="${grouped}" doNotShowUnavailableStatus="${true}"/>
        </td>

        <td style="width: 1em;"></td>

        <td class="lastActivity">
          <bs:date value="${buildAgent.lastCommunicationTimestamp}"/>
        </td>

        <td class="inactivityReason">
          <c:out value="${buildAgent.unregistrationComment}"/>
        </td>
        <c:set var="runningBuild" value="${buildAgent.runningBuild}"/>
        <c:if test="${empty runningBuild}">
          <td colspan="4">&nbsp;</td>
        </c:if>
        <c:if test="${not empty runningBuild}">
          <authz:authorize allPermissions="VIEW_PROJECT" projectId="${runningBuild.projectId}">
            <jsp:attribute name="ifAccessGranted">
              <bs:buildRow build="${runningBuild}" rowClass="${rowClass}"
                           showBuildTypeName="true"
                           showBuildNumber="true"
                           showStatus="true"
                           showStop="true"/>
            </jsp:attribute>
            <jsp:attribute name="ifAccessDenied">
              <td colspan="4"><span class="icon icon16 build-status-icon build-status-icon_running-green-transparent"></span> Running a build. You do not have permissions to see the build details.</td>
            </jsp:attribute>
          </authz:authorize>
        </c:if>
      </tr>
    </c:forEach>
  </c:forEach>
</table>

<agent:restoreAgentBlockStates grouped="${grouped}"/>

<bs:changeAgentStatus agentActionCode="changeAgentStatus"/>