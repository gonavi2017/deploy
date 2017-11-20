<%@ page import="jetbrains.buildServer.controllers.RunBuildBean" %>
<%@ page import="jetbrains.buildServer.serverSide.BuildTypeOptions" %>
<%@ include file="/include-internal.jsp"%>
<jsp:useBean id="runBuildBean" type="jetbrains.buildServer.controllers.RunBuildBean" scope="request"/>
<jsp:useBean id="serverSummary" type="jetbrains.buildServer.web.openapi.ServerSummary" scope="request"/>
<c:set var="hasSeveralPools" value="${serverSummary.hasSeveralAgentPools}"/>
<c:set value="<%=RunBuildBean.ALL_ENABLED_COMPATIBLE_AGENTS_ID%>" var="allEnabledCompatibleOption"/>
<c:set value="<%=RunBuildBean.POOL_ID_PREFIX%>" var="poolIdPrefix"/>
<c:set value="<%=RunBuildBean.AGENT_TYPE_ID_PREFIX%>" var="agentTypeIdPrefix"/>

<div id="general-tab" class="tabContent">
  <table class="runnerFormTable">
    <tr>
      <th><label for="agentId">Agent: </label></th>
      <td <c:if test="${runBuildBean.hasCustomAgents}">class="modifiedParam"</c:if>>
        <forms:select name="agentId" id="agentId" style="width: 20em" enableFilter="true"
                      onchange="BS.RunBuildDialog.highlightCustomAgent(this);">
          <forms:option value="">&lt;the fastest idle agent&gt;</forms:option>
          <c:set var="agents" value="${runBuildBean.availableAgents}"/>
          <c:set var="groupStarted" value="${false}"/>
          <c:forEach items="${agents}" var="poolAgentsPair">
            <c:if test="${hasSeveralPools}">
              <c:set var="pool" value="${poolAgentsPair.first}"/>
              <c:set var="agentId">${poolIdPrefix}${pool.agentPoolId}</c:set> <!-- to string -->
              <c:set var="poolName"><c:out value="${pool.name}"/></c:set>
              <c:if test="${groupStarted}"></optgroup></c:if>
              <optgroup label="${poolName} Pool">
              <c:set var="groupStarted" value="${true}"/>
              <forms:option value="${agentId}" selected="${runBuildBean.selectedAgentIds[agentId]}">&lt;the fastest idle agent in the ${poolName} pool&gt;</forms:option>
            </c:if>
            <c:forEach items="${poolAgentsPair.second}" var="agentWrapper">
              <c:if test="${agentWrapper.isAgent}">
                <c:set var="agentId">${agentWrapper.buildAgent.id}</c:set> <!-- to string -->
                <forms:option value="${agentId}" selected="${runBuildBean.selectedAgentIds[agentId]}"><c:out value="${agentWrapper.buildAgent.name}"/> <bs:agentShortStatus agent="${agentWrapper.buildAgent}" showRunningStatus="${true}" showUnavailable="${true}"/></forms:option>
              </c:if>
            </c:forEach>
            <c:forEach items="${poolAgentsPair.second}" var="agentWrapper">
              <c:if test="${agentWrapper.isAgentType}">
                <c:set var="agentTypeId">${agentWrapper.agentType.agentTypeId}</c:set> <!-- to string -->
                <forms:option value="${agentTypeIdPrefix}${agentTypeId}" selected="${runBuildBean.selectedAgentIds[agentTypeId]}">[Cloud] <c:out
                    value="${agentWrapper.agentType.details.name}"/><c:if
                    test="${agentWrapper.instancesStarting gt 0}">(<c:out value="${agentWrapper.instancesStarting}"/> <bs:plural txt="instance" val="${agentWrapper.instancesStarting}"/> starting)</c:if></forms:option>
              </c:if>
            </c:forEach>
          </c:forEach>
          <c:if test="${groupStarted}"></optgroup></c:if>
          <c:if test="${not empty agents}">
            <forms:option value="${allEnabledCompatibleOption}">&lt;All enabled compatible agents&gt;</forms:option>
          </c:if>
        </forms:select>
        <c:if test="${not runBuildBean.hasCompatibleAgents}">
          <div class="icon_before icon16 attentionComment">Warning: No enabled compatible agents for this build configuration. Please register a build agent or tweak the build configuration requirements.</div>
        </c:if>
      </td>
    </tr>
    <c:set var="personalBuildsAllowed" value="<%=runBuildBean.getBuildType().getOption(BuildTypeOptions.BT_ALLOW_PERSONAL_BUILD_TRIGGERING)%>"/>
    <c:if test="${personalBuildsAllowed}">
      <tr>
        <th class="noBorder"></th>
        <td class="noBorder">
          <forms:checkbox name="personal"/> <label for="personal" >run as a personal build</label>
        </td>
      </tr>
    </c:if>
    <authz:authorize allPermissions="REORDER_BUILD_QUEUE">
      <tr>
        <th class="noBorder"></th>
        <td class="noBorder">
          <forms:checkbox name="moveToTop"/> <label for="moveToTop">put the build to the queue top</label>
        </td>
      </tr>
    </authz:authorize>
    <tr>
      <th class="noBorder"></th>
      <td class="noBorder">
        <forms:checkbox name="cleanSources" checked="${runBuildBean.cleanSourcesEnabled}"/> <label for="cleanSources" >clean all files in the checkout directory before the build</label>
      </td>
    </tr>
    <c:if test="${runBuildBean.dependencies.hasSnapshotDependencies}">
    <tr>
      <th class="noBorder"></th>
      <td class="noBorder">
        <div style="padding-left: 1.5em; margin-top: -0.3em">
          <forms:checkbox name="applyCleanSourcesToDependencies" onclick="if (this.checked && !$('rebuildDependencies').checked) $('rebuildDependencies').click(); BS.RunBuildDialog.highlightModifiedTabs();"/> <label for="applyCleanSourcesToDependencies" >apply to all snapshot dependencies</label>
        </div>
      </td>
    </tr>
    </c:if>
  </table>
</div>
