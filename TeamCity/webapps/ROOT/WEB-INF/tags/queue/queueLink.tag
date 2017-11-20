<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags"%><%@
    taglib prefix="queue" tagdir="/WEB-INF/tags/queue"%><%@
    attribute name="buildTypeId" type="java.lang.String" %><%@
    attribute name="queuedBuild" type="jetbrains.buildServer.serverSide.SQueuedBuild" description="When queuedBuild is provided only this build data will be shown in popup" %><%@
    attribute name="branch" type="jetbrains.buildServer.serverSide.Branch" %><%@
    attribute name="noPopup" type="java.lang.Boolean"
%><c:set var="btId" value="${queuedBuild != null ? queuedBuild.buildType.externalId : buildTypeId}"/><c:set var="link"
><c:choose
><c:when test="${empty queuedBuild}"><a href="<c:url value='/queue.html?buildTypeId=${buildTypeId}#ref${buildTypeId}'/>" title="Click to see the Build Queue"><jsp:doBody/></a></c:when
><c:otherwise><bs:_viewQueued queuedBuild="${queuedBuild}"><jsp:doBody/></bs:_viewQueued></c:otherwise
></c:choose></c:set>
<c:set var="branchName"
    ><c:if test="${not empty branch}">'<bs:escapeForJs text="${branch.name}" forHTMLAttribute="true"/>'</c:if
    ><c:if test="${empty branch}">null</c:if></c:set
><c:choose
  ><c:when test="${not noPopup}"
    ><bs:popupControl showPopupCommand="BS.QueuedBuildsPopup.showQueuedBuilds(this, '${btId}', ${branchName}, '${not empty queuedBuild ? queuedBuild.itemId : ''}')"
                      hidePopupCommand="BS.QueuedBuildsPopup.hidePopup()"
                      stopHidingPopupCommand="BS.QueuedBuildsPopup.stopHidingPopup()"
                      controlId="queuedBuilds:${btId}"
      >${link}</bs:popupControl
  ></c:when
  ><c:otherwise>${link}</c:otherwise
></c:choose>