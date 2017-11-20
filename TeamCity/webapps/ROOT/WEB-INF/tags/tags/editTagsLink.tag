<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz"
  %><%@ taglib prefix="tags" tagdir="/WEB-INF/tags/tags" %><%@
  attribute name="buildPromotion" required="true" type="jetbrains.buildServer.serverSide.BuildPromotion"%><%@
  attribute name="className" required="false" type="java.lang.String"%><%@
  attribute name="doNotAddAvailableTags" required="false" type="java.lang.Boolean"%>
<authz:authorize allPermissions="TAG_BUILD" projectId="${buildPromotion.buildType.projectId}">
<c:set var="tags"><c:forEach var="tag" items="${buildPromotion.tags}" >${tag} </c:forEach></c:set>
<c:set var="escapedTags"><bs:escapeForJs text="${tags}" forHTMLAttribute="true"/></c:set>

<jsp:useBean id="currentUser" type="jetbrains.buildServer.users.SUser" scope="request"/>
<c:set var="privateTags"><c:forEach var="tag" items="<%=buildPromotion.getPrivateTags(currentUser)%>">${tag} </c:forEach></c:set>
<c:set var="escapedPrivateTags"><bs:escapeForJs text="${privateTags}" forHTMLAttribute="true"/></c:set>
<c:set var="availableTagsContainer"><c:choose
  ><c:when test="${not doNotAddAvailableTags}">availableTags_${buildPromotion.id}</c:when
    ><c:otherwise>buildTypeTags_${buildPromotion.buildType.externalId}</c:otherwise
></c:choose></c:set>
<a href="#" class="${className}" onclick="return BS.Tags.showEditDialog(${buildPromotion.id}, '${escapedTags}', '', ${buildPromotion.numberOfDependencies}, '${availableTagsContainer}');"><jsp:doBody/></a>
<c:if test="${not doNotAddAvailableTags}">
<div id="availableTags_${buildPromotion.id}" style="display: none;">
  <c:set var="tags" value="${buildPromotion.buildType.tags}"/>
  <c:if test="${fn:length(tags) gt 0}">
    <div class="tagsContainer">
      <c:forEach var="tagName" items="${tags}">
        <c:set var="escapedTag"><bs:escapeForJs text="${tagName}" forHTMLAttribute="true"/></c:set>
        <tags:printTag tag="${tagName}" markAsPrivate="${false}" onclick="BS.Tags.appendTag('${escapedTag}'); return false"/>
      </c:forEach>
    </div>
  </c:if>
</div>
</c:if>
</authz:authorize>