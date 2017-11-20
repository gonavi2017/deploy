<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib prefix="afn" uri="/WEB-INF/functions/authz" %>
<%@ attribute name="buildType" required="true" type="jetbrains.buildServer.serverSide.SBuildType"
%><%@ attribute name="cameFromUrl" type="java.lang.String"
%><%@ attribute name="step" type="java.lang.String"
%><%@ attribute name="viewAdditionalParams" type="java.lang.String"
%><c:set var="adminArea" value="${fn:contains(pageUrl, '/admin/')}"
/><c:choose><c:when test="${adminArea && afn:permissionGrantedForBuildType(buildType, 'EDIT_PROJECT')}"><admin:editBuildTypeLinkFull buildType="${buildType}" cameFromUrl="${cameFromUrl}" step="${step}"
/></c:when><c:otherwise><bs:buildTypeLinkFull buildType="${buildType}" additionalUrlParams="${viewAdditionalParams}"/></c:otherwise></c:choose>
