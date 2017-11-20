<%@ include file="include-internal.jsp" %>
<%@ taglib prefix="agent" tagdir="/WEB-INF/tags/agent" %>
<jsp:useBean id="agentGroups" scope="request" type="java.util.List<jetbrains.buildServer.controllers.agent.AgentGroup>"/>
<jsp:useBean id="agentsForm" scope="request" type="jetbrains.buildServer.controllers.agent.AgentListForm"/>
<c:set var="grouped" value="${agentsForm.actuallyGroupByPools}"/>
<c:set var="tableClass">dark agents sortable borderBottom</c:set>
<c:if test="${grouped}"><c:set var="tableClass">dark agents agents-grouped sortable borderBottom</c:set></c:if>

<table class="${tableClass}">
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
    <th colspan="2" class="buildTypeName sortable"><span id="SORT_BY_RUNNING_BUILD">Running build</span></th>
    <th class="buildNumber"></th>
    <th class="status"></th>
    <th class="changeLink"></th>
    <th class="duration"></th>
    <th class="stopBuild"></th>
  </tr>
  </thead>
  <c:forEach var="agentGroup" items="${agentGroups}" varStatus="groupIndex">
    <c:set var="poolId" value="${agentGroup.poolId}"/>
    <c:if test="${grouped}">
      <tr>
        <td class="noBorder firstCell"><bs:agentPoolHandle agentPoolId="${poolId}"/></td>
        <td class="poolHeader"><bs:agentPoolLink agentPoolId="${poolId}"
                                                 agentPoolName="${agentGroup.name}"
                                                 groupHeader="${true}"/></td>
        <c:set var="totalAgentCount" value="${agentGroup.totalCount}"/>
        <c:set var="buildCount" value="${agentGroup.buildCount}"/>
        <c:set var="idleAgentCount" value="${totalAgentCount - buildCount}"/>
        <td style="width: 1em;"></td>
        <td colspan="7">
          <span>
            <agent:agentGroupMug idleAgentCount="${idleAgentCount}"
                                 totalAgentCount="${totalAgentCount}"/><span class="commentText">
            <c:choose>
              <c:when test="${buildCount == 0}">All agents are idle</c:when>
              <c:when test="${buildCount == totalAgentCount}">All agents are busy</c:when>
              <c:otherwise>
                ${buildCount} build<bs:s val="${buildCount}"/> <bs:are_is val="${buildCount}"/> running,
                ${idleAgentCount} agent<bs:s val="${idleAgentCount}"/> <bs:are_is val="${idleAgentCount}"/> idle
              </c:otherwise>
            </c:choose></span>
          </span>
        </td>
      </tr>
    </c:if>

    <c:forEach var="buildAgent" items="${agentGroup.agents}" varStatus="agentIndex">
      <c:set var="rowClass" value=""/>
      <tr class="${rowClass} agentRow-${poolId} <c:if test="${grouped and agentIndex.last}">noBorder</c:if>"
          id="agentRow:${buildAgent.id}" style='vertical-align: top; <bs:agentRowVisibility agentPoolId="${poolId}"/>'>
        <c:if test="${grouped}">
          <td class="emptyCell"></td>
        </c:if>
        <td class="buildAgentName" style="vertical-align: top;">
          <bs:agentDetailsFullLink agent="${buildAgent}"
                                   showSlider="true"
                                   doNotShowPoolInfo="${grouped}"
                                   doNotShowUnavailableStatus="${true}"/>
        </td>
        <td style="width: 1em;"></td>
        <c:set var="agentBuild" value="${buildAgent.runningBuild}"/>
        <c:if test="${empty agentBuild}">
          <td colspan="2" class="idle" style="text-align: left; vertical-align: top;">Idle</td>
          <td class="buildNumber"></td>
          <td class="status"></td>
          <td class="changeLink"></td>
          <td class="duration"></td>
          <td class="stopBuild"></td>
        </c:if>
        <c:if test="${not empty agentBuild}">
          <authz:authorize allPermissions="VIEW_PROJECT" projectId="${agentBuild.projectId}">
            <jsp:attribute name="ifAccessGranted">
              <bs:buildRow build="${agentBuild}" rowClass="${rowClass}"
                           showBranchName="true"
                           showBuildTypeName="true"
                           showBuildNumber="true"
                           showStatus="true"
                           showArtifacts="false"
                           showCompactArtifacts="false"
                           showChanges="true"
                           showProgress="true"
                           showStop="true"/>
            </jsp:attribute>
            <jsp:attribute name="ifAccessDenied">
              <td colspan="7">
                <span class="icon icon16 build-status-icon build-status-icon_running-green-transparent"></span>
                Running a build. You do not have permissions to see the build details.
              </td>
            </jsp:attribute>
          </authz:authorize>
        </c:if>
      </tr>
    </c:forEach>
  </c:forEach>
</table>

<agent:restoreAgentBlockStates grouped="${grouped}"/>
<bs:changeAgentStatus agentActionCode="changeAgentStatus"/>
