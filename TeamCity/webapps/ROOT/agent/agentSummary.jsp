<%@ page import="jetbrains.buildServer.web.openapi.PlaceId" %>
<%@ include file="/include-internal.jsp" %>
<jsp:useBean id="agentDetails" scope="request" type="jetbrains.buildServer.controllers.agent.AgentDetailsForm"/>
<c:set var="agent" value="${agentDetails.agent}"/>
<c:set var="agentType" value="${agentDetails.agentType}"/>
<c:set var="runningBuild" value="${agent.runningBuild}"/>
<et:_subscribeAgentTab>
  AGENT_REGISTERED
  AGENT_PARAMETERS_UPDATED
  AGENT_UNREGISTERED
  AGENT_REMOVED
  AGENT_STATUS_CHANGED
  BUILD_STARTED
  BUILD_FINISHED
  BUILD_INTERRUPTED
  BUILD_REMOVED
</et:_subscribeAgentTab>

<div id="agentSummary" class="divsWithHeaders">
  <div class="first">
    <h2>Status</h2>
    <div class="details">
      <ul class="agentSummary">
        <li>
          <c:choose>
            <c:when test="${agent.registered}"><span class="registered">Connected</span> since
              <strong><bs:date value="${agent.registrationTimestamp}"/></strong>, last communication date <strong><bs:date value="${agent.lastCommunicationTimestamp}"/></strong></c:when>
            <c:otherwise><span class="red-text">Disconnected</span><c:if test="${not empty agent.unregistrationComment}"> (<c:out value="${agent.unregistrationComment}"/>)</c:if>, last communication date <strong>
              <bs:date value="${agent.lastCommunicationTimestamp}"/>
            </strong>
            <authz:authorize anyPermission="REMOVE_AGENT,REMOVE_AGENT_FOR_PROJECT"
                             projectIds="${agent.agentPool.projectIds}"
                             checkGlobalPermissions="true">
              <jsp:attribute name="ifAccessGranted">
                <c:set var="removeAgentForm">
                  <form id="removeAgentForm" action="<c:url value='/agentDetails.html'/>" style="display:inline; margin-left: 1em;">
                    <input class="btn btn_mini" type="button" value="Remove agent" onclick="BS.RemoveAgent.remove(${not empty runningBuild})"/>
                    <input type="hidden" name="removeAgent" value="true"/>
                    <input type="hidden" name="agentId" value="${agent.id}"/>
                  </form>
                </c:set>
                <c:choose>
                  <c:when test="${not empty runningBuild}">
                    <bs:canStopBuild build="${runningBuild}"><jsp:attribute name="ifAccessGranted">${removeAgentForm}</jsp:attribute></bs:canStopBuild>
                  </c:when>
                  <c:otherwise>${removeAgentForm}</c:otherwise>
                </c:choose>
              </jsp:attribute>
            </authz:authorize>
            </c:otherwise>
          </c:choose>
        </li>
        <li>
          <c:url var="agentStatusUrl" value="/agentStatus.html?id=${agent.id}"/>
          <jsp:include page="/agentStatus.html?id=${agent.id}"/>
        </li>
      </ul>
    </div>
  </div>

  <div>
    <h2>Details</h2>
    <div class="details">
      <ul class="agentSummary">
        <li>Agent name: <strong><c:out value="${agent.name}"/></strong></li>
        <c:set var="agentHost" value="${agent.hostName}"/>
        <authz:authorize allPermissions="VIEW_AGENT_CLOUDS">
          <c:if test="${agentDetails.agentType.details.cloudAgent}">
            <li>Cloud image: <bs:agentDetailsFullLink
                showCloudIcon="true"
                doNotShowPoolInfo="true"
                agentType="${agent.agentType}">${agent.agentType.details.name}</bs:agentDetailsFullLink>
            </li>
          </c:if>
        </authz:authorize>
        <li>Hostname: <strong>${agentHost}</strong></li>
        <c:if test="${agent.hostAddress != agentHost}">
          <li>IP: <strong>${agent.hostAddress}</strong></li>
        </c:if>
        <li>Port: <strong>${agent.port}</strong></li>
        <li>Communication protocol: <strong><c:out value="${agent.communicationProtocolDescription}"/> <bs:help file="Setting+up+and+Running+Additional+Build+Agents" anchor="ServerAgentDataTransfers"/></strong></li>
        <li>Operating system: <bs:osIcon osName="${agent.operatingSystemName}" small="${true}"/>&nbsp;<strong>${agent.operatingSystemName}</strong></li>
        <li>CPU rank: <strong><c:choose><c:when test="${agent.cpuBenchmarkIndex > 0}">${agent.cpuBenchmarkIndex}</c:when><c:otherwise>unknown</c:otherwise></c:choose></strong></li>
        <c:set var="pool" value="${agentType.agentPool}"/>
        <li>Pool: <strong><bs:agentPoolLink agentPoolId="${pool.agentPoolId}" agentPoolName="${pool.name}" hidePoolWord="${true}"/></strong></li>
        <c:if test="${agent.registered}">
          <li>
            <bs:agentOutdated agent="${agent}"/>
            Version: <strong>${agent.version}</strong>
            <c:if test="${serverTC.agentBuildNumber != agent.version}"> (outdated, current version is <strong>${serverTC.agentBuildNumber}</strong>)</c:if>
            <c:if test="${serverTC.currentPluginsSignature != agent.pluginsSignature && serverTC.agentBuildNumber == agent.version}"> (some plugins on the agent are out of date)</c:if>
          </li>
        </c:if>
      </ul>
    </div>
  </div>

  <c:if test="${not empty runningBuild}">
  <div>
    <h2>Running build</h2>
    <div class="details">
      <authz:authorize allPermissions="VIEW_PROJECT" projectId="${runningBuild.projectId}">
        <jsp:attribute name="ifAccessGranted">
          <table class="overviewTypeTable">
          <tr>
            <bs:buildRow build="${runningBuild}"
                         showBranchName="true"
                         showBuildNumber="true"
                         showBuildTypeName="true"
                         showStatus="true"
                         showArtifacts="true"
                         showCompactArtifacts="false"
                         showChanges="true"
                         showProgress="true"
                         showStop="true"/>
          </tr>
          </table>
        </jsp:attribute>
        <jsp:attribute name="ifAccessDenied">
          <span class="icon icon16 build-status-icon build-status-icon_running-green-transparent"></span> Running a build. You do not have permissions to see the build details.
        </jsp:attribute>
      </authz:authorize>
    </div>
  </div>
  </c:if>
  <ext:extensionsAvailable placeId="<%=PlaceId.AGENT_SUMMARY%>">
    <div>
      <h2>Miscellaneous</h2>
      <div class="details">
        <ext:includeExtensions placeId="<%=PlaceId.AGENT_SUMMARY%>"/>
      </div>
    </div>
  </ext:extensionsAvailable>
</div>

<bs:changeAgentStatus agentActionCode="changeAgentStatus"/>
<bs:changeAgentStatus agentActionCode="changeAuthorizeStatus"
                      agentPoolsList="${agentPoolsList}"
                      selectedAgentPool="${selectedAgentPool}"/>

<script type="text/javascript">
  jQuery("#agentSummary > div:last-child").addClass("last");
</script>
