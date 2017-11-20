<%@ tag import="jetbrains.buildServer.web.util.SessionUser" %>
<%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags"%><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    attribute name="changeStatus" required="true" type="jetbrains.buildServer.vcs.ChangeStatus"
    %><c:set var="myBuild" value="<%=changeStatus.getChange().isPersonal() && changeStatus.getChange().getCommitters().contains(SessionUser.getUser(request))%>"
    /><c:set var="my" value="${changeStatus.change.personal && myBuild ? 'my' : 'personal'}"/><c:choose
><c:when test="${changeStatus.change.personal}"
><c:choose
><c:when test="${changeStatus.canceledPersonal}"
><c:set var="iconClass" value="build-status-icon_${my}-cancelled"></c:set><c:set var="iconTitle" value="Personal build canceled"></c:set>
  </c:when
><c:when test="${changeStatus.failedCount > 0 && changeStatus.runningBuildsNumber == 0}"
><c:set var="iconClass" value="build-status-icon_${my}-finished-failed"></c:set><c:set var="iconTitle" value="Personal build failed"></c:set></c:when
><c:when test="${changeStatus.failedCount > 0 && changeStatus.runningBuildsNumber > 0}"
><c:set var="iconClass" value="build-status-icon_${my}-running-failing"></c:set><c:set var="iconTitle" value="Personal build is failing"></c:set></c:when
><c:when test="${changeStatus.successful && changeStatus.runningBuildsNumber == 0}"
><c:set var="iconClass" value="build-status-icon_${my}-finished"></c:set><c:set var="iconTitle" value="Personal build successful"></c:set></c:when
><c:when test="${changeStatus.runningBuildsNumber > 0}"
><c:set var="iconClass" value="build-status-icon_${my}-running"></c:set><c:set var="iconTitle" value="Personal build is running"></c:set></c:when
><c:otherwise
><c:set var="iconClass" value="build-status-icon_${my}-pending"></c:set><c:set var="iconTitle" value="Personal build is waiting in the queue"></c:set></c:otherwise
></c:choose
></c:when
><c:otherwise
><c:choose
><c:when test="${changeStatus.failedCount > 0 && changeStatus.runningBuildsNumber == 0}"
><c:set var="iconClass" value="build-status-icon_failed_small"></c:set><c:set var="iconTitle" value="Build with this change failed"></c:set></c:when
><c:when test="${changeStatus.failedCount > 0 && changeStatus.runningBuildsNumber > 0}"
><c:set var="iconClass" value="build-status-icon_running-red-transparent"></c:set><c:set var="iconTitle" value="Build with this change is failing"></c:set></c:when
><c:when test="${changeStatus.successful && changeStatus.runningBuildsNumber == 0}"
><c:set var="iconClass" value="build-status-icon_successful_small"></c:set><c:set var="iconTitle" value="All builds are successful"></c:set></c:when
><c:when test="${changeStatus.failedCount == 0 && changeStatus.runningBuildsNumber > 0}"
><c:set var="iconClass" value="build-status-icon_running-green-transparent"></c:set><c:set var="iconTitle" value="Build with this change is running"></c:set></c:when
><c:when test="${changeStatus.pendingBuildsTypesNumber > 0}"
><c:set var="iconClass" value="build-status-icon_pending"></c:set><c:set var="iconTitle" value="Waiting in the queue"></c:set></c:when
></c:choose
></c:otherwise
></c:choose>
<span class="build-status-icon ${iconClass}" title="${iconTitle}"></span>