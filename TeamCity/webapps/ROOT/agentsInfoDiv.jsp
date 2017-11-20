<%@ include file="include-internal.jsp" %>
<jsp:useBean id="queuedBuild" type="jetbrains.buildServer.serverSide.SQueuedBuild" scope="request"/>
<jsp:useBean id="canRunAgents" type="java.util.List" scope="request"/>
<jsp:useBean id="virtualAgents" type="java.util.Map< jetbrains.buildServer.serverSide.agentTypes.SAgentType, java.lang.Integer>" scope="request"/>
<c:set var="numCanRun" value="${fn:length(canRunAgents)}"/>
<c:if test="${numCanRun > 0}">
  <p class="compatible"><strong><c:out value="${queuedBuild.buildType.fullName}"/></strong> can run on:</p>
  <ul class="compatibleList">
    <c:forEach var="agent" items="${canRunAgents}">
      <li><bs:agent agent="${agent}" showRunningStatus="true" showCommentsAsIcon="true"/></li>
    </c:forEach>
  </ul>
</c:if>

<c:set var="virtualAgentsCount" value="${fn:length(virtualAgents)}"/>
<c:if test="${virtualAgentsCount gt 0}">
  <p class="compatible">There <bs:are_is val="${virtualAgentsCount}"/>  <c:out value="${virtualAgentsCount}"/> compatible cloud agent<bs:s val="${virtualAgentsCount}"/>:</p>
  <ul class="compatibleList">
    <c:forEach var="agent" items="${virtualAgents}">
      <li><bs:agentDetailsFullLink agentType="${agent.key}" showCloudIcon="${true}" cloudStartingInstances="${agent.value}"/></li>
    </c:forEach>
  </ul>
</c:if>

<p class="compatible">
  <c:if test="${numCanRun == 0}">
    No compatible agents
  </c:if>
</p>
<bs:compatibleAgentsLink queuedBuild="${queuedBuild}">More details &raquo;</bs:compatibleAgentsLink>
