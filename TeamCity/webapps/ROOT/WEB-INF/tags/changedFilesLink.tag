<%@ taglib prefix="changefn" uri="/WEB-INF/functions/change"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@attribute name="modification" required="true" type="jetbrains.buildServer.vcs.SVcsModification"%>
<%@attribute name="buildType" required="false" type="jetbrains.buildServer.serverSide.SBuildType"%> <%-- not required if build specified --%>
<%@attribute name="build" required="false" type="jetbrains.buildServer.serverSide.SBuild"%> <%-- not required in case of pending changes --%>
<%@attribute name="disableFilesLink" required="false" type="java.lang.Boolean"%> <%-- optional attribute for the case when we want not to show "N files" hyper-link --%>
<%@attribute name="disableFileFiltering" required="false" type="java.lang.Boolean"%><%-- optional attribute for the case when we do not want to filter changed files list --%>
<%@attribute name="disablePopup" required="false" type="java.lang.Boolean"%> <%-- optional attribute for the case when the files are shown by other means --%>
<%@attribute name="tab" required="false" type="java.lang.String"%>
<%@attribute name="showChain" required="false" type="java.lang.Boolean"%> <%-- optional attribute to filter files on whole build chain--%>
<%@attribute name="checkoutRules" required="false" type="jetbrains.buildServer.vcs.CheckoutRules" %>
<c:if test="${empty tab}"><c:set var="tab" value="vcsModificationFiles"/></c:if>
<c:set var="customBody"><jsp:doBody/></c:set>
<c:choose>
  <c:when test="${not empty build and not disableFileFiltering}">
    <c:set var="filesNum" value="${changefn:getNumberOfIncludedFilesByBuild(modification, build)}"/>
    <c:set var="files">${filesNum} file<bs:s val="${filesNum}"/></c:set>
    <c:choose>
      <c:when test="${not empty customBody}"><c:set var="linkText">${customBody}</c:set></c:when>
      <c:otherwise><c:set var="linkText">${files}</c:set></c:otherwise>
    </c:choose>
    <c:set var="linkText"><bs:modificationLink modification="${modification}" buildTypeId="${build.buildTypeExternalId}" tab="${tab}">${linkText}</bs:modificationLink></c:set>
    <c:choose>
      <c:when test="${disablePopup}">${linkText}</c:when>
      <c:otherwise>
        <bs:popupControl showPopupCommand="BS.FilesPopup.showPopup(event, {parameters: 'modId=${modification.id}&buildTypeId=${build.buildTypeExternalId}&buildId=${build.buildId}&personal=${modification.personal}&chain=${showChain}'});"
                         hidePopupCommand="BS.FilesPopup.hidePopup();"
                         stopHidingPopupCommand="BS.FilesPopup.stopHidingPopup();"
                         controlId="files:${modification.id}"
            >${linkText}</bs:popupControl>
      </c:otherwise>
    </c:choose>
  </c:when>
  <c:when test="${not empty buildType and not disableFileFiltering}">
    <c:set var="filesNum" value="${changefn:getNumberOfIncludedFilesByBuildType(modification, buildType)}"/>
    <c:set var="files">${filesNum} file<bs:s val="${filesNum}"/></c:set>
      <c:choose>
        <c:when test="${disableFilesLink}"><c:set var="linkText">${files}</c:set></c:when>
        <c:when test="${not empty customBody}"><c:set var="linkText"><bs:modificationLink modification="${modification}" buildTypeId="${buildType.externalId}" tab="${tab}">${customBody}</bs:modificationLink></c:set></c:when>
        <c:otherwise><c:set var="linkText"><bs:modificationLink modification="${modification}" buildTypeId="${buildType.externalId}" tab="${tab}">${files}</bs:modificationLink></c:set></c:otherwise>
      </c:choose>
    <c:choose>
      <c:when test="${disablePopup}">${linkText}</c:when>
      <c:otherwise>
        <bs:popupControl
            showPopupCommand="BS.FilesPopup.showPopup(event, {parameters: 'modId=${modification.id}&buildTypeId=${buildType.externalId}&personal=${modification.personal}&chain=${showChain}'});"
            hidePopupCommand="BS.FilesPopup.hidePopup();"
            stopHidingPopupCommand="BS.FilesPopup.stopHidingPopup();"
            controlId="files:${modification.id}">${linkText}</bs:popupControl>
      </c:otherwise>
    </c:choose>
  </c:when>
  <c:when test="${not empty checkoutRules and not disableFileFiltering}">
    <c:set var="filesNum" value="${changefn:getNumberOfIncludedFilesByRules(modification, checkoutRules)}"/>
    <c:set var="files">${filesNum} file<bs:s val="${filesNum}"/></c:set>
    <c:set var="linkText"><bs:modificationLink modification="${modification}" tab="${tab}">${files}</bs:modificationLink></c:set>
    <c:choose>
      <c:when test="${disablePopup}">${linkText}</c:when>
      <c:otherwise>
        <bs:popupControl
            showPopupCommand="BS.FilesPopup.showPopup(event, {parameters: 'modId=${modification.id}&personal=${modification.personal}'});"
            hidePopupCommand="BS.FilesPopup.hidePopup();"
            stopHidingPopupCommand="BS.FilesPopup.stopHidingPopup();"
            controlId="files:${modification.id}">${linkText}</bs:popupControl>
      </c:otherwise>
    </c:choose>
  </c:when>
  <c:otherwise>
    <c:set var="filesNum" value="${modification.changeCount}"/>
    <c:set var="files">${filesNum} file<bs:s val="${filesNum}"/></c:set>
    <c:set var="linkText"><bs:modificationLink modification="${modification}" tab="${tab}">${files}</bs:modificationLink></c:set>
    <c:choose>
      <c:when test="${disablePopup}">${linkText}</c:when>
      <c:otherwise>
        <bs:popupControl
            showPopupCommand="BS.FilesPopup.showPopup(event, {parameters: 'modId=${modification.id}&personal=${modification.personal}'});"
            hidePopupCommand="BS.FilesPopup.hidePopup();"
            stopHidingPopupCommand="BS.FilesPopup.stopHidingPopup();"
            controlId="files:${modification.id}">${linkText}</bs:popupControl>
      </c:otherwise>
    </c:choose>
  </c:otherwise>
</c:choose>
