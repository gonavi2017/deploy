<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    attribute name="build" fragment="false" required="false" type="jetbrains.buildServer.serverSide.SBuild" %><%@
    attribute name="queuedBuild" fragment="false" required="false" type="jetbrains.buildServer.serverSide.SQueuedBuild" %><%@
    attribute name="buildPromotion" required="true" type="jetbrains.buildServer.serverSide.BuildPromotionEx" %><%@
    attribute name="noPopup" type="java.lang.Boolean" required="false" %><%@
    attribute name="noUsername" type="java.lang.Boolean" required="false" %><%@
    attribute name="noLink" type="java.lang.Boolean" required="false" %><%@
    attribute name="highlight" type="java.lang.Boolean" required="true" %><%@
    attribute name="containsUserChanges" type="java.lang.Boolean" required="true" %><%@
    attribute name="totalNum" type="java.lang.Integer" required="true" %><%@
    attribute name="totalCount" type="java.lang.String" required="true" %><%@
    attribute name="changes" type="java.util.List<jetbrains.buildServer.UserChanges>" required="true"
%><c:if test="${buildPromotion.outOfChangesSequence}"
><c:set var="attrs" value="id='changes:${buildPromotion.id}'"
/><c:set var="sequenceBuild" value="${buildPromotion.sequenceBuild}"
/><c:if test="${not noPopup}"><bs:changesPopup buildPromotion="${buildPromotion}" highlightIfCommitter="false" containsUserChanges="${containsUserChanges}">History</bs:changesPopup
></c:if><c:if test="${noPopup}"><span class="commentText">History</span></c:if></c:if

><c:if test="${not buildPromotion.outOfChangesSequence}"
><c:set var="text"
  ><c:choose
    ><c:when test="${totalNum == 0}">No changes</c:when
    ><c:when test="${noUsername or fn:length(changes) > 1}">Changes (${totalCount})</c:when
    ><c:otherwise><c:set var="username" value="<%=changes.get(0).getCommitters().get(0).getName()%>"/><bs:trim maxlength="14">${username}</bs:trim> (${totalCount})</c:otherwise
  ></c:choose
></c:set
><c:if test="${not empty changes}"
  ><c:choose
    ><c:when test="${noPopup}"
      ><c:choose
        ><c:when test="${build != null}"><bs:_viewLog build="${build}" title="Click to see changes" attrs="${attrs}" tab="buildChangesDiv">${text}</bs:_viewLog></c:when
        ><c:when test="${queuedBuild != null}"><bs:_viewQueued queuedBuild="${queuedBuild}" tab="buildChangesDiv">${text}</bs:_viewQueued></c:when
        ><c:otherwise>${text}</c:otherwise
      ></c:choose
    ></c:when
    ><c:otherwise
      ><c:choose
        ><c:when test="${build != null and not noLink}"><bs:changesLink build="${build}" highlightIfCommitter="${highlight}" containsUserChanges="${containsUserChanges}">${text}</bs:changesLink></c:when
        ><c:when test="${queuedBuild != null and not noLink}"><bs:changesLink queuedBuild="${queuedBuild}" highlightIfCommitter="${highlight}" containsUserChanges="${containsUserChanges}">${text}</bs:changesLink></c:when
        ><c:otherwise
          ><bs:changesPopup buildPromotion="${buildPromotion}" highlightIfCommitter="${highlight}" containsUserChanges="${containsUserChanges}">${text}</bs:changesPopup
        ></c:otherwise
      ></c:choose
    ></c:otherwise
  ></c:choose
></c:if
><c:if test="${empty changes and not noPopup}"
  ><bs:changesPopup buildPromotion="${buildPromotion}" highlightIfCommitter="${highlight}" containsUserChanges="${containsUserChanges}"><span class="commentText">No changes</span></bs:changesPopup
></c:if
><c:if test="${empty changes and noPopup}"><span class="commentText">No changes</span></c:if
></c:if>