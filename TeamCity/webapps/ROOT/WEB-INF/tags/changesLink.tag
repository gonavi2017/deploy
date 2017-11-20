<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    attribute name="build" fragment="false" required="false" type="jetbrains.buildServer.serverSide.SBuild" %><%@
    attribute name="queuedBuild" fragment="false" required="false" type="jetbrains.buildServer.serverSide.SQueuedBuild" %><%@
    attribute name="highlightIfCommitter" type="java.lang.Boolean" required="false" %><%@
    attribute name="containsUserChanges" type="java.lang.Boolean" required="false" %><%@
    attribute name="showPopup" type="java.lang.Boolean" required="false"
%><c:set var="promotion" value="${build != null ? build.buildPromotion : queuedBuild.buildPromotion}"
/><c:set var="link">
    <c:choose><c:when test="${not empty build}"
    ><c:set var="attrs" value="id='changesLink:${build.buildPromotion.id}'"/><bs:_viewLog build="${build}" title="" attrs="${attrs}" tab="buildChangesDiv"><jsp:doBody/></bs:_viewLog
    ></c:when
    ><c:when test="${not empty queuedBuild}"><bs:_viewQueued queuedBuild="${queuedBuild}" tab="buildChangesDiv"><jsp:doBody/></bs:_viewQueued></c:when
    ></c:choose
></c:set
><c:choose><c:when test="${empty showPopup or showPopup}"
  ><bs:changesPopup buildPromotion="${promotion}" highlightIfCommitter="${highlightIfCommitter}" containsUserChanges="${containsUserChanges}">${link}</bs:changesPopup
></c:when><c:otherwise
  >${link}</c:otherwise
></c:choose>