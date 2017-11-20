<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags/tags" %><%@
    attribute name="build" required="true" type="jetbrains.buildServer.serverSide.SFinishedBuild" %><%@
    attribute name="pin" required="true" type="java.lang.Boolean" %><%@
    attribute name="onBuildPage" required="true" type="java.lang.Boolean" %><%@
    attribute name="style" required="false"%><%@
    attribute name="className" required="false"%><%@
    attribute name="doNotAddAvailableTags" required="false" type="java.lang.Boolean" %>
<c:if test="${not doNotAddAvailableTags}">
<div id="availableTags_${build.buildId}_pin" style="display: none;">
  <c:set var="tags" value="${build.buildType.tags}"/>
  <c:if test="${fn:length(tags) gt 0}">
    <div class="tagsContainer">
      <c:forEach var="tagName" items="${tags}">
        <c:set var="escapedTag"><bs:escapeForJs text="${tagName}" forHTMLAttribute="true"/></c:set>
        <tags:printTag tag="${tagName}" markAsPrivate="${false}" onclick="BS.PinBuildDialog.appendTag('${escapedTag}'); return false"/>
      </c:forEach>
    </div>
  </c:if>
</div>
</c:if>
<c:set var="pinComment"
    ><c:if test="${build.pinComment != null}"><bs:escapeForJs forHTMLAttribute="true" text="${build.pinComment.comment}"/></c:if
></c:set
><c:set var="availableTagsContainer"><c:choose
  ><c:when test="${not doNotAddAvailableTags}">availableTags_${build.buildId}_pin</c:when
  ><c:otherwise>buildTypeTags_${build.buildType.externalId}</c:otherwise
></c:choose></c:set
><c:set var="onclick"
    >return BS.PinBuildDialog.showPinBuildDialog(${build.buildId}, ${pin}, ${build.buildPromotion.numberOfDependencies}, '${pinComment}', '${availableTagsContainer}');</c:set
><a href="#" id="pinLink${build.buildId}" class="pinLink ${className}" style="${style}" onclick="${onclick}"><jsp:doBody/></a>
