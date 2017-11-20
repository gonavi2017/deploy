<%@ tag import="static jetbrains.buildServer.controllers.project.schedule.BuildsScheduleForm.PARAMS.PARAM_SHOW_DISABLED" %>
<%@ tag import="static jetbrains.buildServer.controllers.project.schedule.BuildsScheduleForm.PARAMS.PARAM_SHOW_ONLY_UPCOMING" %>
<%@ tag import="static jetbrains.buildServer.controllers.project.schedule.BuildsScheduleForm.PARAMS.PARAM_SCHEDULE_DATE" %>
<%@ tag import="static jetbrains.buildServer.controllers.project.schedule.BuildsScheduleForm.PARAMS.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="util" uri="/WEB-INF/functions/util" %>

<%@ attribute name="showOnlyUpcoming" required="true" type="java.lang.Boolean" %>
<%@ attribute name="showDisabled" required="true" type="java.lang.Boolean" %>
<%@ attribute name="showPaused" required="true" type="java.lang.Boolean" %>
<%@ attribute name="scheduleDate" required="true" type="java.lang.String" %>
<%@ attribute name="projectId" required="true" type="java.lang.String" %>
<%@ attribute name="filterProjectId" required="false" type="java.lang.String" %>
<%@ attribute name="style" required="false" %>
<%@ attribute name="withoutLink" %>


<c:set var="PARAM_scheduleDate" value="<%=PARAM_SCHEDULE_DATE%>"/>
<c:set var="PARAM_showOnlyUpcoming" value="<%=PARAM_SHOW_ONLY_UPCOMING%>"/>
<c:set var="PARAM_showDisabled" value="<%=PARAM_SHOW_DISABLED%>"/>
<c:set var="PARAM_filterProjectId" value="<%=PARAM_FILTER_PROJECT_ID%>"/>
<c:set var="PARAM_showPaused" value="<%=PARAM_SHOW_PAUSED%>"/>

<c:set var="baseUrl" value="/buildSchedule.html"/>
<c:set var="urlString">
  ${baseUrl}${fn:contains(baseUrl,"?") ? "&" : "?" }${PARAM_scheduleDate}=${util:urlEscape(scheduleDate)}&${PARAM_showOnlyUpcoming}=${showOnlyUpcoming}&${PARAM_showDisabled}=${showDisabled}&projectId=${projectId}&${PARAM_filterProjectId}=${filterProjectId}&${PARAM_showPaused}=${showPaused}&isPermalink=true
</c:set>


<c:url var="url" value="${urlString}"/>

<c:choose>
  <c:when test="${not withoutLink}">
    <a href="${url}" style="${style}">
      <jsp:doBody/>
    </a>
  </c:when>
  <c:otherwise>
    ${url}
  </c:otherwise>
</c:choose>
