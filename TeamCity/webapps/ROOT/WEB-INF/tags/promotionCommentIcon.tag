<%@ tag import="jetbrains.buildServer.serverSide.impl.UserActionsProvider"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ attribute name="promotion" required="true" type="jetbrains.buildServer.serverSide.BuildPromotion"
  %><c:set var="buildCommentToolTipText"><bs:trimWhitespace
  ><jsp:useBean id="serverTC" type="jetbrains.buildServer.serverSide.SBuildServer" scope="request"
  /><c:set var="userActions" value="<%= serverTC.getSingletonService(UserActionsProvider.class).getIconUserActions(promotion)%>"
  /><c:forEach var="userAction" items="${userActions}"
  ><c:set var="comment" value="${userAction.comment}"
  /><p class="userActionBlock">${userAction.actionTextPrefix} <bs:_commentInfo comment="${comment}"/><c:if test="${not empty comment.comment}"><br/>Comment: <bs:out value="${comment.comment}"/></c:if></p></c:forEach
  ></bs:trimWhitespace></c:set><c:if test="${not empty buildCommentToolTipText}"><bs:commentIcon text="${buildCommentToolTipText}" style="cursor:default;"/></c:if>