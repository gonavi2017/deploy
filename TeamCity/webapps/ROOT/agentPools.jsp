<%@ page import="jetbrains.buildServer.controllers.agent.AgentPoolController" %>
<%@ page import="jetbrains.buildServer.serverSide.agentPools.AgentPoolConstants" %>
<%@ include file="include-internal.jsp"%>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<jsp:useBean id="data" scope="request" type="jetbrains.buildServer.controllers.agent.PoolsData"/>

<!--[if IE 7]>
<style type="text/css">
  div.item-rect {
    display: inline;
    zoom: 1;
  }
</style>
<![endif]-->

<script type="text/javascript">
  <jsp:include page="/js/bs/blocks.js"/>
  <jsp:include page="/js/bs/blocksWithHeader.js"/>
  <jsp:include page="/js/bs/collapseExpand.js"/>
</script>

<c:url var="url" value="agents.html?tab=agentPools" />

<bs:refreshable containerId="pool-boxes-container-refresh" pageUrl="${pageUrl}">

<div class="pool-width">

    <span class="pool-header-element">
      <bs:collapseExpand collapseAction="BS.CollapsableBlocks.collapseAll(true, 'agentPoolsList'); return false"
                         expandAction="BS.CollapsableBlocks.expandAll(true, 'agentPoolsList'); return false">
      </bs:collapseExpand>
    </span>
    <span class="pool-header-element">
       <authz:authorize allPermissions="MANAGE_AGENT_POOLS">
         <div>
           <forms:addButton onclick="BS.AP.confirmCreateNewPool(); return false;">Create new pool</forms:addButton>
         </div>
       </authz:authorize>
    </span>
    <span class="pool-header-element">
      <profile:booleanPropertyCheckbox propertyKey="agentPools.hideArchivedProject" progress="hideArchived_progress"
                                       labelText="Hide archived projects associated with agent pools"
                                       afterComplete="BS.AP.reloadBlocks();"/>
      <forms:saving id="hideArchived_progress" className="progressRingInline" savingTitle="Refreshing list of projects"/>
    </span>
    <span class="pool-header-element" id="actionMessage">
        <bs:messages key="<%=AgentPoolController.AGENT_POOL_ACTION_MESSAGE%>"/>
    </span>

  <div id="pool-boxes-container" class="agentPoolsList">
    <c:forEach items="${data.pools}" var="pool" varStatus="poolStatus">
      <c:set var="poolId" value="${pool.agentPool.agentPoolId}"/>
      <c:set var="blockHeader">
        <bs:agentPoolHeader pool="${pool}"/>
      </c:set>
      <c:set var="visible" value="${util:contains(data.visiblePools, pool.agentPool.agentPoolId)}"/>
      <a name="${poolId}"></a>
      <bs:_collapsibleBlock title="${blockHeader}" id="${poolId}" collapsedByDefault="true" tag="div" headerClass="no_title">
        <c:choose>
          <c:when test="${visible}">
            <bs:agentPoolDetails pool="${pool}" includeDialogs="false" includeHeader="false" defaultPoolAdmin="${data.defaultPoolAdmin}"/>
          </c:when>
          <c:otherwise><div class="loading"><i class="icon-refresh icon-spin"></i>&nbsp;Loading...</div></c:otherwise>
        </c:choose>
      </bs:_collapsibleBlock>
      <script type="text/javascript">
        BS.AP.updateBlock('${poolId}');
      </script>
    </c:forEach>
  </div>
</div>
</bs:refreshable>
<bs:agentPoolDialogs/>
<script>
  BS.AP.selectPoolOnPageLoad(window.location.hash);
</script>

