<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    attribute name="buildType" type="jetbrains.buildServer.serverSide.SBuildType" required="true" %><%@
    attribute name="noPopup" type="java.lang.Boolean" required="true"

%><c:if test="${noPopup}"><jsp:doBody/></c:if
><c:if test="${not noPopup}"
    ><bs:popupControl showPopupCommand="BS.RunningBuildsPopup.showBuilds(this, '${buildType.buildTypeId}')"
                      hidePopupCommand="BS.RunningBuildsPopup.hidePopup()"
                      stopHidingPopupCommand="BS.RunningBuildsPopup.stopHidingPopup()"
                      controlId="runningBuilds:${buildType.buildTypeId}"
      ><a href="<c:url value='/viewType.html?buildTypeId=${buildType.externalId}'/>"><jsp:doBody/></a></bs:popupControl
></c:if>