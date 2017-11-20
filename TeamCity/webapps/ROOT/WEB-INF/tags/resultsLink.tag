<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    attribute name="build" fragment="false" required="true" type="jetbrains.buildServer.serverSide.SBuild" %><%@
    attribute name="noPopup" fragment="false" required="false" type="java.lang.Boolean" %><%@
    attribute name="noTitle" fragment="false" required="false" type="java.lang.Boolean" %><%@
    attribute name="skipChangesArtifacts" fragment="false" required="false" type="java.lang.Boolean" %><%@
    attribute name="attrs" fragment="false" required="false" %><%@
    attribute name="popupZIndex" required="false" type="java.lang.Integer"

%><c:set var="link"><bs:_viewLog build="${build}" title="${empty noTitle ? 'View build results' : ''}" attrs="${attrs}" tab="buildResultsDiv"><jsp:doBody/></bs:_viewLog></c:set
><c:choose
  ><c:when test="${noPopup}">${link}</c:when
  ><c:otherwise><c:set var="zIndexOption" value=""
/><c:if test="${popupZIndex != null}"
   ><c:set var="zIndexOption">, {zIndex: ${popupZIndex}}</c:set
></c:if
><bs:popupControl
  showPopupCommand="BS.BuildResultsPopupTracker(${build.buildId}).showPopup('${build.buildTypeId}', ${build.finished}, '${skipChangesArtifacts}', this${zIndexOption});"
  hidePopupCommand="BS.BuildResultsPopupTracker(${build.buildId}).hidePopup();"
  stopHidingPopupCommand="BS.BuildResultsPopupTracker(${build.buildId}).stopHidingPopup();"
  controlId="results:${build.buildId}"
  >${link}</bs:popupControl></c:otherwise
  ></c:choose>