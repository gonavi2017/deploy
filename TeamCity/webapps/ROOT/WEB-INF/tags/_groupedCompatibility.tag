<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    attribute name="tableColumn" required="true" type="jetbrains.buildServer.controllers.compatibility.CompatibilityTableColumn" %><%@
    attribute name="active" required="true" type="java.lang.Boolean" %>
<c:set var="agentRowVisibility"><c:if test="${not active}">display: none;</c:if></c:set>

<c:forEach items="${tableColumn.pools}" var="group">
  <c:set var="pool" value="${group.agentPool}"/>

  <div>
    <bs:agentPoolHandle agentPoolId="${pool.agentPoolId}" kind="${group.poolKind}" forceState="${true}" expanded="${active}"/>
    <bs:agentPoolLink agentPoolId="${pool.agentPoolId}" agentPoolName="${pool.name}" groupHeader="${true}" nameSuffix=" (${group.numberByPool})"/>
  </div>

  <c:set var="sectionBlockClass" value="agentRow-${group.poolKind}${pool.agentPoolId}"/>
  <c:forEach items="${group.agents}" var="row">
    <div class="agentDiv <c:if test="${not active}">inactive</c:if> ${sectionBlockClass}" style='${agentRowVisibility}'>
      <bs:agent agent="${row.agent}" doNotShowPoolInfo="${true}" showCommentsAsIcon="true" showRunningStatus="${active and row.compatibility.compatible}"/>
      <c:if test="${not row.canRunOnAgent}">
        <span class="warn">not allowed to run this configuration</span>
      </c:if>
      <c:if test="${not row.compatibility.compatible}">
        <bs:agentCompatibility compatibility="${row.compatibility}"/>
      </c:if>
    </div>
  </c:forEach>
  <c:forEach items="${group.agentTypes}" var="row">
    <div class="agentDiv <c:if test="${not active}">inactive</c:if> ${sectionBlockClass}" style='${agentRowVisibility}'>
      <bs:agentDetailsFullLink agentType="${row.agentType}" showCloudIcon="${true}" cloudStartingInstances="${row.startingInstancesCount}" showCommentsAsIcon="true" doNotShowPoolInfo="true"/>
      <c:if test="${not row.canRunOnAgentType}">
        <span class="warn">not allowed to run this configuration</span>
      </c:if>
      <c:if test="${not row.compatibility.compatible}">
        <bs:agentCompatibility compatibility="${row.compatibility}"/>
      </c:if>
    </div>
  </c:forEach>
</c:forEach>
<c:if test="${tableColumn.numberOfEntries eq 0}">None</c:if>
