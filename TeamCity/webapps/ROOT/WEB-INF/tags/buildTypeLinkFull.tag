<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="afn" uri="/WEB-INF/functions/authz"
  %><%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz"
  %><%@ taglib prefix="util" uri="/WEB-INF/functions/util"
  %><%@ attribute name="buildType" rtexprvalue="true" type="jetbrains.buildServer.serverSide.SBuildType" required="true"
  %><%@ attribute name="fullProjectPath" required="false" type="java.lang.Boolean"
  %><%@ attribute name="popupMode" required="false"
  %><%@ attribute name="popupNoProject" required="false"
  %><%@ attribute name="style" required="false"
  %><%@ attribute name="target" required="false"
  %><%@ attribute name="dontShowProjectName" required="false" type="java.lang.Boolean"
  %><%@ attribute name="contextProject" required="false" type="jetbrains.buildServer.serverSide.SProject"
  %><%@ attribute name="skipContextProject" required="false" type="java.lang.Boolean"
  %><%@ attribute name="projectText" required="false"
  %><%@ attribute name="projectTab" required="false"
  %><%@ attribute name="additionalUrlParams" required="false"

%><c:choose><c:when test="${empty buildType}">Build configuration unavailable</c:when><c:otherwise><c:set var="project" value="${buildType.project}"
/><c:if test="${empty popupMode}"><c:url value="/project.html?projectId=${buildType.projectExternalId}" var="projectUrl"
  /><c:if test="${dontShowProjectName != true}"
    ><c:choose
      ><c:when test="${fullProjectPath == null or fullProjectPath}"
        ><bs:projectLinkFull project="${project}" style="${style}" target="${target}" tab="${projectTab}" contextProject="${contextProject}" skipContextProject="${skipContextProject}" withSeparatorInTheEnd="true"
      /></c:when
      ><c:otherwise
        ><bs:projectLink project="${project}" style="${style}" target="${target}" tab="${projectTab}"><c:out value="${projectText}"></c:out></bs:projectLink> ::
      </c:otherwise
    ></c:choose
  ></c:if
  ><bs:buildTypeLink buildType="${buildType}" style="${style}" target="${target}" additionalUrlParams="${additionalUrlParams}"
/></c:if

><c:if test="${not empty popupMode}"
  ><c:set var="withAdmin" value="false"
    /><authz:editBuildTypeGranted buildType="${buildType}"
      ><c:set var="withAdmin" value="true"
    /></authz:editBuildTypeGranted
  ><c:set var="linkContent"><jsp:doBody/></c:set
  ><c:if test="${empty linkContent}"
    ><c:set var="linkContent"
      ><c:choose
        ><c:when test="${dontShowProjectName}"></c:when
        ><c:when test="${fullProjectPath == null or fullProjectPath}"
          ><bs:projectLinkFull project="${project}" style="${style}" target="${target}" withSeparatorInTheEnd="true" tab="${projectTab}" contextProject="${contextProject}" skipContextProject="${skipContextProject}"
        /></c:when
        ><c:otherwise
          ><bs:projectLink project="${project}" style="${style}" target="${target}" tab="${projectTab}"><c:out value="${projectText}"/></bs:projectLink> ::
        </c:otherwise
      ></c:choose
      ><bs:buildTypeLink buildType="${buildType}" style="${style}" target="${target}" additionalUrlParams="${additionalUrlParams}"
    /></c:set
  ></c:if
  ><c:set var="showResponsibility" value="${afn:permissionGrantedForBuildType(buildType, 'ASSIGN_INVESTIGATION')}"
 /><bs:popupControl
  showPopupCommand="BS.BuildTypeSummary.showSummaryPopup(this, '${buildType.externalId}', '${buildType.projectExternalId}', ${popupMode != 'no_self'}, ${popupNoProject ? 0 : 1}, ${withAdmin}, ${showResponsibility});"
  hidePopupCommand="BS.BuildTypeSummary.hidePopup();"
  stopHidingPopupCommand="BS.BuildTypeSummary.stopHidingPopup();"
  controlId="btpp${buildType.buildTypeId}"
  clazz="btPopup"
  >${linkContent}</bs:popupControl>
</c:if></c:otherwise></c:choose>