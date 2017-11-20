<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="queue" tagdir="/WEB-INF/tags/queue" %><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz"%><%@
    attribute name="theRunningBuilds" fragment="false" required="true" type="java.util.Collection" %><%@
    attribute name="queuedBuilds" required="true" type="java.util.Collection" %><%@
    attribute name="buildType" fragment="false" required="true" type="jetbrains.buildServer.serverSide.SBuildType" %><%@
    attribute name="branch" required="false" type="jetbrains.buildServer.serverSide.Branch" %><%@
    attribute name="noPopupForRunning" required="false" type="java.lang.Boolean"

%><jsp:useBean id="currentUser" type="jetbrains.buildServer.users.User" scope="request"
/><c:if test=""></c:if><c:set var="numberQueued" value="${fn:length(queuedBuilds)}"
/><c:set var="inQueueText">${numberQueued}</c:set
><span class="runningStatus"><c:choose
  ><c:when test="${empty theRunningBuilds}"
    ><c:choose
      ><c:when test="${numberQueued > 0 and buildType.paused}"></c:when
      ><c:when test="${numberQueued > 0 and not buildType.paused}"></c:when
      ><c:when test="${buildType.paused}"></c:when
      ><c:otherwise>Idle</c:otherwise
    ></c:choose
  ></c:when
  ><c:otherwise
    >${fn:length(theRunningBuilds)} <bs:runningBuildsPopup buildType="${buildType}"
                                                                              noPopup="${noPopupForRunning}">running</bs:runningBuildsPopup
    ><c:if test="${numberQueued > 0}"> and </c:if
  ></c:otherwise
></c:choose></span><c:if test="${numberQueued == 1}"
  >${inQueueText} <queue:queueLink queuedBuild="${queuedBuilds[0]}" branch="${branch}">queued</queue:queueLink
></c:if><c:if test="${numberQueued > 1}"
  >${inQueueText} <queue:queueLink buildTypeId="${buildType.externalId}" branch="${branch}">queued</queue:queueLink
></c:if>