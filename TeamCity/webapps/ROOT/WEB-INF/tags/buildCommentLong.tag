<%@ tag import="jetbrains.buildServer.serverSide.impl.UserActionsProvider" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz"%>
<%@ attribute name="promotion" required="true" type="jetbrains.buildServer.serverSide.BuildPromotion"%>
<c:set var="comment" value="${promotion.buildComment}"/>

<jsp:useBean id="serverTC" type="jetbrains.buildServer.serverSide.SBuildServer" scope="request"/>
<c:set var="userActions" value="<%= serverTC.getSingletonService(UserActionsProvider.class).getIconUserActions(promotion)%>"/>

<c:if test="${not empty userActions}">
<bs:refreshable containerId="buildComment" pageUrl="${pageUrl}">
  <c:forEach var="userAction" items="${userActions}">
  <c:set var="comment" value="${userAction.comment}"/>
  <div>
    <c:set var="afterTextControl"></c:set>
    <c:choose>
      <c:when test="${userAction.actionTypeCode == 'BUILD_COMMENT'}">
        <span class="icon icon16 commentIcon"></span>
        <c:set var="afterTextControl">
          <authz:authorize projectId="${promotion.projectId}" allPermissions="COMMENT_BUILD">
            <bs:buildCommentLink promotionId="${promotion.id}" oldComment="${comment.comment}" className="btn btn_mini">Edit</bs:buildCommentLink>
          </authz:authorize>
        </c:set>
      </c:when>
      <c:when test="${userAction.actionTypeCode == 'BUILD_MARKED_AS_SUCCESSFUL' || userAction.actionTypeCode == 'BUILD_MARKED_AS_FAILED'}">
        <span class="icon icon16 bp test new"></span>
        <c:set var="afterTextControl">
          <c:if test="${empty promotion.associatedBuild || empty promotion.associatedBuild.finishDate || userAction.action.timestamp.time < promotion.associatedBuild.finishDate.time}">
            <em style="padding-left: 0.3em;">&mdash; The change was made while build was running</em>
          </c:if>
        </c:set>
      </c:when>
    </c:choose>

    ${userAction.actionTextPrefix} <bs:_commentInfo comment="${comment}"/>: <bs:out value="${comment.comment}"/>
    ${afterTextControl}
  </div>
</c:forEach>
</bs:refreshable>
</c:if>
