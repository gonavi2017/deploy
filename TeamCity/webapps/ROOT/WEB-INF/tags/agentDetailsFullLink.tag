<%@ tag import="java.util.Map" %>
<%@ tag import="jetbrains.buildServer.serverSide.auth.Permission" %>
<%@ tag import="jetbrains.buildServer.users.SUser" %>
<%@ tag import="jetbrains.buildServer.web.util.SessionUser" %>
<%@ tag import="java.util.HashMap" %>
<%@
  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
  taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%><%@
  taglib prefix="bs" tagdir="/WEB-INF/tags"%><%@
  taglib prefix="authz" tagdir="/WEB-INF/tags/authz"%><%@
  attribute name="agent" required="false" type="jetbrains.buildServer.serverSide.BuildAgentEx"%><%@
  attribute name="agentType" required="false" type="jetbrains.buildServer.serverSide.agentTypes.SAgentType"%><%@
  attribute name="useDisplayName" required="false"%><%@
  attribute name="doNotShowOutdated" required="false" type="java.lang.Boolean"%><%@
  attribute name="doNotShowOSIcon" required="false" type="java.lang.Boolean"%><%@
  attribute name="showSlider" required="false" type="java.lang.Boolean"%><%@
  attribute name="doNotShowPoolInfo" required="false" type="java.lang.Boolean"%><%@
  attribute name="showPoolInfoAsText" required="false" type="java.lang.Boolean"%><%@
  attribute name="showRunningStatus" required="false" type="java.lang.Boolean"%><%@
  attribute name="showCloudIcon" required="false" type="java.lang.Boolean"%><%@
  attribute name="cloudStartingInstances" required="false" type="java.lang.Integer"%><%@
  attribute name="showCommentsAsIcon" required="false" type="java.lang.Boolean"%><%@
  attribute name="doNotShowUnavailableStatus" required="false" type="java.lang.Boolean"%><%@
  attribute name="imageWarningsText" required="false" type="java.lang.String"
  %><jsp:useBean id="serverSummary" type="jetbrains.buildServer.web.openapi.ServerSummary" scope="request"
  /><c:set var="nonEmptyAgentType" value="${empty agentType ? agent.agentType : agentType}"
  /><c:set var="realAgent" value="${empty agent ? nonEmptyAgentType.realAgent : agent}"
  />
<c:if test="${showSlider}">
  <c:set var="sliderContent">
    <c:choose>
      <c:when test="${agent.enabled}">
        <c:set var="status">enabled</c:set>
        <c:set var="action">disable</c:set>
      </c:when>
      <c:otherwise>
        <c:set var="status">disabled</c:set>
        <c:set var="action">enable</c:set>
      </c:otherwise>
    </c:choose>
    <c:set var="title_slider" value="Agent ${status}."/>
    <c:set var="pattern" value="dd MMM yy HH:mm"/>
    <c:set var="sliderCss">icon icon16 tc-icon_switch tc-icon_switch_${status}</c:set>
    <%
      SUser currentUser = SessionUser.getUser(request);
      Map<Integer, Boolean> changeAgentStatusCache = (Map<Integer, Boolean>)request.getAttribute("__change_agent_status_cache");
      if (changeAgentStatusCache == null) {
        changeAgentStatusCache = new HashMap<Integer, Boolean>();
        request.setAttribute("__change_agent_status_cache", changeAgentStatusCache);
      }
      if (!changeAgentStatusCache.containsKey(agent.getAgentPoolId())) {
        boolean canChangeStatus = currentUser.isPermissionGrantedGlobally(Permission.ENABLE_DISABLE_AGENT);
        if (!canChangeStatus) {
          canChangeStatus = currentUser.isPermissionGrantedForAllProjects(agent.getAgentPool().getProjectIds(), Permission.ENABLE_DISABLE_AGENT_FOR_PROJECT);
        }
        changeAgentStatusCache.put(agent.getAgentPoolId(), canChangeStatus);
      }
      jspContext.setAttribute("changeAgentStatusCache", changeAgentStatusCache);
    %>
    <c:if test="${changeAgentStatusCache[agent.agentPoolId]}">
      <c:set var="onClick">BS.Tooltip.hidePopup(); BS.Agent.showChangeStatusDialog(${not agent.enabled}, ${agent.id}, ${agent.registered}, 'changeAgentStatus'); return false;</c:set>
      <c:set var="title_slider">Agent ${status}. Click to ${action}.</c:set>
    </c:if>
    <c:if test="${not empty agent.agentStatusToRestore}">
      <c:set var="status_to_restore"><c:choose><c:when test="${agent.agentStatusToRestore}">enabled</c:when><c:otherwise>disabled</c:otherwise></c:choose></c:set>
      <c:set var="restore_time"><fmt:formatDate value="${agent.agentStatusRestoringTimestamp}" pattern="dd MMM yy HH:mm"/></c:set>
      <c:set var="info">Will be automatically ${status_to_restore} at ${restore_time}</c:set>
      <c:set var="sliderCss">${sliderCss} tc-icon_after commentIcon</c:set>
      <c:set var="title_slider">${title_slider} ${info}</c:set>
    </c:if>
    <c:if test="${not empty agent.statusComment and not empty agent.statusComment.comment}">
      <c:set var="info">Comment: <c:out value="${agent.statusComment.comment}"/></c:set>
      <c:set var="sliderCss">${sliderCss} tc-icon_after commentIcon</c:set>
      <c:set var="title_slider">${title_slider} ${info}</c:set>
    </c:if>
    <c:set var="spanId" value="span_${agent.id}"/>
    <span class="${sliderCss}" id="${spanId}" <c:if test="${not empty onClick}">onclick="${onClick}"</c:if>></span>
    <span id="${spanId}_description"class="hidden">${title_slider}</span>
    <script type="text/javascript">
      var slider = $('${spanId}');
      if (!slider._eventsBound) {
        slider.on("mouseenter", function() {
          BS.Tooltip.showMessageFromContainer($('${spanId}'), {shift:{x:45,y:8}}, $('${spanId}_description'));
        });
        slider.on("mouseleave", function() {
          BS.Tooltip.hidePopup();
        });
        slider._eventsBound = true;
      }
    </script>
  </c:set>
</c:if>
<c:set var="agentDescription">
  <c:if test="${not empty realAgent and not doNotShowOutdated}"><bs:agentOutdated agent="${realAgent}"/></c:if
      ><authz:authorize allPermissions="VIEW_AGENT_DETAILS"
    ><c:if test="${not doNotShowOSIcon}"
    ><bs:osIcon osName="${nonEmptyAgentType.operatingSystemName}" small="${true}"/></c:if
    ><c:if test="${imageWarningsText != '' and imageWarningsText != null}"
    ><span class="icon icon16 yellowTriangle agentVersion" <bs:tooltipAttrs text="${imageWarningsText}"/>
    ></span></c:if><c:if test="${not empty showCloudIcon and showCloudIcon and nonEmptyAgentType.details.cloudAgent}"
    ><span class="icon icon16 cloudIcon" title="Cloud agent image"></span></c:if></authz:authorize
    ><bs:agentDetailsLink agent="${realAgent}" agentType="${agentType}" useDisplayName="${useDisplayName}"><jsp:doBody/></bs:agentDetailsLink
    ><c:if test="${not doNotShowPoolInfo and serverSummary.hasSeveralAgentPools and nonEmptyAgentType.agentTypeId > 0}">&nbsp;(<bs:agentPoolLink agentPoolId="${nonEmptyAgentType.agentPool.agentPoolId}" agentPoolName="${nonEmptyAgentType.agentPool.name}" noLink="${showPoolInfoAsText}"/>)</c:if
    ><c:if test="${not empty realAgent and realAgent.id > 0 and (showRunningStatus or not doNotShowUnavailableStatus)}"><bs:agentShortStatus agent="${realAgent}" showRunningStatus="${showRunningStatus}" showUnavailable="${not doNotShowUnavailableStatus}" showCommentsAsIcon="${showCommentsAsIcon}"/></c:if
    ><c:if test="${not empty cloudStartingInstances and cloudStartingInstances > 0}"> (${cloudStartingInstances} cloud agent<bs:s val="${cloudStartingInstances}"/> <bs:are_is val="${cloudStartingInstances}"/> starting)</c:if>
</c:set>
<c:choose>
  <c:when test="${showSlider}">
    <div>
      <div class="right">${sliderContent}</div>
      <div class="left">${agentDescription}</div>
    </div>
  </c:when>
  <c:otherwise>${agentDescription}</c:otherwise>
</c:choose>
