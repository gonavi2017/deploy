<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="changefn" uri="/WEB-INF/functions/change" %><%@
    attribute name="snapDepLink" required="true" type="jetbrains.buildServer.web.functions.change.SnapDepChangeLink"
%><c:set var="snapDepLinkTitle"><c:out value="${snapDepLink.title}"/></c:set
><c:choose>
  <c:when test="${snapDepLink.fromBuild}">
    <span data-build-type-id="${snapDepLink.build.buildPromotion.buildTypeExternalId}"><bs:changesLink build="${snapDepLink.build}" showPopup="false"><bs:snapDepChangeIcon title="${snapDepLinkTitle}"/></bs:changesLink></span>
  </c:when>
  <c:when test="${snapDepLink.fromQueuedBuild}">
    <span data-build-type-id="${snapDepLink.queuedBuild.buildPromotion.buildTypeExternalId}"><bs:changesLink queuedBuild="${snapDepLink.queuedBuild}" showPopup="false"><bs:snapDepChangeIcon title="${snapDepLinkTitle}"/></bs:changesLink></span>
  </c:when>
  <c:when test="${snapDepLink.fromBuildType}">
    <bs:buildTypeLink buildType="${snapDepLink.buildType}" additionalUrlParams="&tab=pendingChangesDiv${snapDepLink.buildTypeBranchParam}"><bs:snapDepChangeIcon title="${snapDepLinkTitle}"/></bs:buildTypeLink>
  </c:when>
  <c:otherwise>
    <bs:snapDepChangeIcon title="${snapDepLinkTitle}"/>
  </c:otherwise>
</c:choose>