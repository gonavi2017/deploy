<%@ tag import="jetbrains.buildServer.favoriteBuilds.FavoriteBuildsManagerImpl" %>
<%@ tag import="jetbrains.buildServer.serverSide.TeamCityProperties" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="t" tagdir="/WEB-INF/tags/tags"
%><%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz"
%><%@ attribute name="buildPromotion" required="true" type="jetbrains.buildServer.serverSide.BuildPromotionEx"
%><%@ attribute name="showActionText" required="false" type="java.lang.Boolean"
%><%@ attribute name="showOnlyIfFavorite" required="false" type="java.lang.Boolean"
%><%@ attribute name="showDescription" required="false" type="java.lang.Boolean"
%><%@ attribute name="cssClass" required="false"
%><%@ attribute name="removeCssClass" required="false"
%><%@ taglib prefix="afn" uri="/WEB-INF/functions/authz"
%><%@ taglib prefix="util" uri="/WEB-INF/functions/util"
%><%@ taglib prefix="intprop" uri="/WEB-INF/functions/intprop"
%><c:if test="${afn:permissionGrantedForProjectWithId(buildPromotion.projectId, 'TAG_BUILD') && afn:permissionGrantedGlobally('CHANGE_OWN_PROFILE')}"
><%
  final boolean tagsLoaded = buildPromotion.hasLoadedTags();
  boolean lazy = !tagsLoaded && TeamCityProperties.getBooleanOrTrue("teamcity.favoriteIcon.lazyLoading");
  jspContext.setAttribute("lazy", lazy);
%><c:choose
><c:when test="${lazy}"
 ><c:set var="id" value="lazyfavorite_${buildPromotion.id}_${util:uniqueId()}"
 /><span id="${id}"></span>
  <script type="text/javascript">
    BS.BackgroundLoader.load($j('#${id}'),
                             '<c:url value="/favoriteIcon.html"/>',
                             {promotionId: ${buildPromotion.id},
                              showActionText: ${showActionText ? 'true' : 'false'},
                              showOnlyIfFavorite: ${showOnlyIfFavorite ? 'true' : 'false'},
                              showDescription: ${showDescription ? 'true' : 'false'},
                              cssClass: ${cssClass ? 'true' : 'false'},
                              removeCssClass : ${removeCssClass ? 'true' : 'false'}});
  </script>
</c:when
><c:otherwise
><jsp:useBean id="currentUser" type="jetbrains.buildServer.users.SUser" scope="request"
/><t:favoriteBuildInner buildPromotion="${buildPromotion}"
                        favorite="<%=FavoriteBuildsManagerImpl.isFavorite(buildPromotion, currentUser)%>"
                        showActionText="${showActionText}"
                        showOnlyIfFavorite="${showOnlyIfFavorite}"
                        showDescription="${showDescription}"
                        cssClass="${cssClass}"
                        removeCssClass="${removeCssClass}"/></c:otherwise></c:choose></c:if>