<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<%@attribute name="mode" type="java.lang.String" required="true" %>
<%@attribute name="ownerBuild" type="jetbrains.buildServer.Build" required="true" %> <%--Build provided artifacts or build downloaded artifacts--%>
<%@attribute name="targetBuild" type="jetbrains.buildServer.Build" required="true" %> <%--Build from which owner build downloaded artifacts or to which artifacts were delivered--%>
<c:set var="numFiles">
  <c:choose>
    <c:when test="${mode == 'downloadedFrom'}">${fn:length(ownerBuild.downloadedArtifacts.artifacts[targetBuild])}</c:when>
    <c:when test="${mode == 'providedTo'}">${fn:length(ownerBuild.providedArtifacts.artifacts[targetBuild])}</c:when>
  </c:choose>
</c:set>
<bs:popupControl showPopupCommand="BS.DependentArtifactsPopup.showPopup(this, ${ownerBuild.buildId}, ${targetBuild.buildId}, '${mode}')"
                 hidePopupCommand="BS.DependentArtifactsPopup.hidePopup()"
                 stopHidingPopupCommand="BS.DependentArtifactsPopup.stopHidingPopup()"
                 controlId="artifacts:${targetBuild.buildId}"><c:choose><c:when test="${mode == 'downloadedFrom'}">Downloaded</c:when><c:otherwise>Delivered</c:otherwise></c:choose> artifacts (${numFiles})</bs:popupControl>
