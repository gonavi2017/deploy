<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="t" tagdir="/WEB-INF/tags/tags"
%><%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz"
%><%@ attribute name="buildPromotion" required="true" type="jetbrains.buildServer.serverSide.BuildPromotionEx"
%><%@ attribute name="favorite" required="true" type="java.lang.Boolean"
%><%@ attribute name="showActionText" required="false" type="java.lang.Boolean"
%><%@ attribute name="showOnlyIfFavorite" required="false" type="java.lang.Boolean"
%><%@ attribute name="showDescription" required="false" type="java.lang.Boolean"
%><%@ attribute name="cssClass" required="false"
%><%@ attribute name="removeCssClass" required="false"
%><c:set var="aid" value='fv_${buildPromotion.id}'
/><c:set var="pageReload">${showActionText || showDescription}</c:set
><c:url var="actionUrl" value="/ajax.html"
/><c:url var="favoritePageLink" value="/favoriteBuilds.html"
/><c:choose
    ><c:when test="${favorite}"><a href="javascript:void(0);" id="${aid}" class="<c:if test="${!removeCssClass}">favoriteBuild ${cssClass}</c:if>" title="Remove build from favorites"
         onclick="BS.FavoriteBuilds.tagBuild('${actionUrl}','${buildPromotion.id}','${aid}',${pageReload});"><c:if test="${showActionText}">Remove build from favorites&nbsp;</c:if><i class="icon-star"></i></a>
  <c:if test="${showDescription}">This build is in <a href="${favoritePageLink}">your favorites</a></c:if
    ></c:when
    ><c:when test="${!showOnlyIfFavorite}"><a href="javascript:void(0);" id="${aid}" class="addToFavorite <c:if test="${!removeCssClass}">favoriteBuild ${cssClass}</c:if>" title="Add build to favorites"
         onclick="BS.FavoriteBuilds.tagBuild('${actionUrl}','${buildPromotion.id}','${aid}',${pageReload});"><c:if test="${showActionText}">Add build to favorites&nbsp;</c:if><i class="icon-star-empty"></i></a></c:when
    ></c:choose>