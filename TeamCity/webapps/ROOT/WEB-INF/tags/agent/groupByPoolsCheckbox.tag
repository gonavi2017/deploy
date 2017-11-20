<%@ tag import="jetbrains.buildServer.controllers.agent.AgentListForm" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"%>
<jsp:useBean id="agentsForm" scope="request" type="jetbrains.buildServer.controllers.agent.AgentListForm"/>
<c:if test="${agentsForm.hasSeveralPools}">
  <c:set var="key" value="<%=AgentListForm.DO_NOT_GROUP_BY_POOL_PROPERTY_KEY.getKey()%>"/>
  <div class="agentsToolbar">
    <forms:checkbox name="" id="groupByPoolsCheckbox" checked="${agentsForm.groupByPools}" onclick="BS.AgentsList.groupByPools('${key}');" style="margin-left: 0;"/>
    <label for="groupByPoolsCheckbox">Group by agent pools</label>
    <forms:saving id="groupByPoolsProgress" className="progressRingInline"/>
  </div>
</c:if>