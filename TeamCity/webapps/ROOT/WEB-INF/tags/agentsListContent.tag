<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout"
  %><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
  %><%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz"
  %><%@ taglib prefix="afn" uri="/WEB-INF/functions/authz"
  %><%@ taglib prefix="graph" tagdir="/WEB-INF/tags/graph"
  %><%@taglib prefix="ext" tagdir="/WEB-INF/tags/ext"
  %><%@ taglib prefix="lic" tagdir="/WEB-INF/tags/license"
  %><%@ taglib prefix="et" tagdir="/WEB-INF/tags/eventTracker"
  %><%@ taglib prefix="queue" tagdir="/WEB-INF/tags/queue"
  %><%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin"
  %><%@ taglib prefix="n" tagdir="/WEB-INF/tags/notifications"
  %><%@ taglib prefix="profile" tagdir="/WEB-INF/tags/userProfile"
  %><%@ attribute name="agentsForm" type="jetbrains.buildServer.controllers.agent.AgentListForm" required="true"
  %><%@ attribute name="agentGroups" type="java.util.List" required="true" %>

<bs:linkCSS dynamic="${true}">
  /css/agentBlocks.css
</bs:linkCSS>

<bs:linkScript>
  /js/bs/agentBlocks.js
  /js/bs/agentsList.js
</bs:linkScript>

<div id="buildAgents">
  <bs:messages key="agentNotFound"/>
  <bs:messages key="agentRemoved"/>
  <c:set var="agentsCount" value="${fn:length(agentsForm.agents)}"/>
  <%@ variable name-given="agentsCount" scope="NESTED" %>
  <jsp:doBody/>
</div>

<script type="text/javascript">
  (function() {
    function reSort(event, element) {
      var sortBy = element.id;
      if (!sortBy) {
        element = element.firstElementChild;
        sortBy = element.id;
      }

      var sortAsc = element.className.indexOf('sorted') == -1 || element.className.indexOf('sortedDesc') != -1;
      $('agentsList').refresh(null, "sortBy=" + sortBy + "&sortAsc=" +sortAsc);
    }

    <c:forEach items="${agentsForm.sortOptions}" var="sortOption">
    if ($('${sortOption}')) {
    <c:if test="${agentsForm.sortBy == sortOption}">
      $('${sortOption}').className = $('${sortOption}').className + ' ${agentsForm.sortAsc ? "sortedAsc" : "sortedDesc"}';
    </c:if>
      $($('${sortOption}').parentNode).on("click", reSort);
    }
    </c:forEach>
  })();
</script>

<et:subscribeOnEvents>
  <jsp:attribute name="eventNames">
    AGENT_REGISTERED
    AGENT_PARAMETERS_UPDATED
    AGENT_UNREGISTERED
    AGENT_REMOVED
    AGENT_STATUS_CHANGED
    BUILD_STARTED
    BUILD_FINISHED
    BUILD_INTERRUPTED
  </jsp:attribute>
  <jsp:attribute name="eventHandler">
    BS.Agent.scheduleRefresh();
  </jsp:attribute>
</et:subscribeOnEvents>

