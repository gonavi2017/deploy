<%@ tag import="jetbrains.buildServer.favoriteBuilds.FavoriteBuildsManagerImpl" %>
<%@ attribute name="promotion" required="true" type="jetbrains.buildServer.serverSide.BuildPromotion"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags/tags" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<c:set var="userBuildDetailsContent">
  <bs:trimWhitespace>
  <tags:favoriteBuildAuth buildPromotion="${promotion}">
      <jsp:useBean id="currentUser" type="jetbrains.buildServer.users.SUser" scope="request"/>
      <c:set var="favorite" value='<%=FavoriteBuildsManagerImpl.isFavorite(promotion, currentUser)%>'/>
      <c:if test="${favorite}">
      <div><tags:favoriteBuild buildPromotion="${promotion}" showOnlyIfFavorite="true" showDescription="true"/></div>
      </c:if>
  </tags:favoriteBuildAuth>
  <c:if test="${promotion.personal}">
    <div>
      <c:set var="myBuild" value="${currentUser.id == promotion.owner.id}"/>
      <bs:personalChangesIcon myChanges="${myBuild}"/>
      <bs:personalBuildPrefix buildPromotion="${promotion}"/>:
      <bs:out resolverContext="${promotion}"><bs:personalBuildComment buildPromotion="${promotion}"/></bs:out>
    </div>
  </c:if>

  <bs:buildCommentLong promotion="${promotion}"/>
  <c:if test="${not empty promotion.associatedBuild}">
    <c:set var="buildData" value="${promotion.associatedBuild}"/>
    <c:if test="${buildData.pinned}">
      <c:set var="pintext_line1"><bs:_pinTextLine1 build="${buildData}"/></c:set>
      <c:set var="pintext_line2"><bs:_pinTextLine2 build="${buildData}"/></c:set>
      <span class="icon icon16 icon16_pinned_yes"></span>
      ${pintext_line1} ${pintext_line2}
      <authz:authorize projectId="${buildData.projectId}" allPermissions="PIN_UNPIN_BUILD">
        <bs:pinLink className="btn btn_mini" build="${buildData}" pin="false" onBuildPage="true">Unpin</bs:pinLink>
        <forms:saving id="progressIcon${buildData.buildId}" className="progressRingInline"/>
      </authz:authorize>
    </c:if>
  </c:if>

  <tags:showBuildPromotionTags buildPromotion="${promotion}" hidePrivateTags="true">
    <jsp:attribute name="beforeTags"><span class="icon icon16 icon16_tags"></span></jsp:attribute>
    <jsp:attribute name="afterTags"><tags:editTagsLink className="btn btn_mini" buildPromotion="${promotion}">Edit</tags:editTagsLink></jsp:attribute>
  </tags:showBuildPromotionTags>


</bs:trimWhitespace></c:set>
<c:if test="${not empty userBuildDetailsContent}">
  <div id="userBuildDetails">
      ${userBuildDetailsContent}
  </div>
</c:if>
