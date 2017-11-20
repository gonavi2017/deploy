<%@ include file="include-internal.jsp" %>
<%@ taglib prefix="agent" tagdir="/WEB-INF/tags/agent" %>
<jsp:useBean id="serverSummary" type="jetbrains.buildServer.web.openapi.ServerSummary" scope="request"/>
<jsp:useBean id="compatibilityModel" scope="request" type="jetbrains.buildServer.controllers.compatibility.CompatibilityModel"/>

<bs:linkCSS dynamic="${true}">
  /css/agentBlocks.css
</bs:linkCSS>
<bs:linkScript>
  /js/bs/agentBlocks.js
</bs:linkScript>
<script type="text/javascript">
  BS.AgentBlocks.mustPersistState = false;
</script>

<c:if test="${compatibilityModel.hasSeveralPools}">
  <div class="agentsToolbar">
    <bs:collapseExpand collapseAction="BS.AgentBlocks.collapseAll(); return false" expandAction="BS.AgentBlocks.expandAll(); return false"/>
    <span style="margin-left: 1em">
      <profile:booleanPropertyCheckbox propertyKey="teamcity.compatibility.showAllPools" labelText="Show all agent pools" progress="showAllPoolsProgress" afterComplete="$('otherPoolsAgents').refresh('showAllPoolsProgress')"/>
      <forms:saving id="showAllPoolsProgress" className="progressRingInline"/>
    </span>
  </div>
</c:if>

<bs:_compatibilityTable tableModel="${compatibilityModel.activeTable}" active="${true}"  />

<bs:refreshable containerId="otherPoolsAgents" pageUrl="${pageUrl}">
<c:if test="${compatibilityModel.inactiveTable.notEmpty}">
  <p style="margin-top: 2em;">
    <i class="icon icon16 yellowTriangle"></i> Following agents belong to the agent pools which are not associated with <strong><c:out value="${compatibilityModel.projectFullName}"/></strong> project
  </p>
  <bs:_compatibilityTable tableModel="${compatibilityModel.inactiveTable}" active="${false}" />
</c:if>
</bs:refreshable>