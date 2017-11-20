<%@ tag import="jetbrains.buildServer.favoriteBuilds.FavoriteBuildsManager" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ attribute name="tag" required="true"%>
<%@ attribute name="selected" type="java.lang.Boolean"%>
<%@ attribute name="markAsPrivate" type="java.lang.Boolean"%>
<%@ attribute name="onclick"%>
<%@ attribute name="href"%>
<% boolean isFavoriteBuildTag = tag.equals(FavoriteBuildsManager.FAVORITE_BUILD_TAG);
%><c:set var="escapedTag"><c:out value="${tag}"/></c:set
><c:choose>
  <c:when test="<%=!isFavoriteBuildTag%>">
    <c:set var="text"><c:if test="${markAsPrivate}"><i class="icon-lock"></i>&nbsp;</c:if><span class="${markAsPrivate ? 'privateTagText' : 'tagText'}" title="${escapedTag}">${escapedTag}</span></c:set>
  </c:when>
  <c:otherwise>
    <c:set var="text"><span><i class="icon-star"></i></span><span style="visibility: hidden; display: none;" class="${markAsPrivate ? 'privateTagText' : 'tagText'}" title="${escapedTag}">${escapedTag}</span></c:set>
  </c:otherwise>
</c:choose>
<c:if test="${selected}"><span class="selectedTag">${text}</span></c:if>
<c:if test="${not selected}"><a class="unselectedTag" href="${empty href ? '#' : href}" onclick="${onclick}">${text}</a></c:if>
