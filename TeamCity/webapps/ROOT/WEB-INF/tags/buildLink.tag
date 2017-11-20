<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="util" uri="/WEB-INF/functions/util" %><%@
    attribute name="build" type="jetbrains.buildServer.serverSide.SBuild" required="false" %><%@
    attribute name="buildTypeId" type="java.lang.String" required="false" %><%@
    attribute name="buildNumber" type="java.lang.String" required="false" %><%@
    attribute name="buildTag" type="java.lang.String" required="false" %><%@
    attribute name="buildId" type="java.lang.String" required="false" %><%@
    attribute name="title" type="java.lang.String" required="false" %><%@
    attribute name="buildBranch" type="java.lang.String" required="false"

%><c:set var="branchParam"><c:if test="${not empty buildBranch}">&buildBranch=${util:urlEscape(buildBranch)}</c:if></c:set
><c:set var="buildUrl"
><c:choose
    ><c:when test="${build != null}"><c:url value="/viewLog.html?buildId=${build.buildId}"/></c:when
    ><c:when test="${buildId != null}"><c:url value="/viewLog.html?buildTypeId=${buildTypeId}&buildId=${buildId}${branchParam}"/></c:when
    ><c:when test="${buildNumber != null}"><c:url value="/viewLog.html?buildTypeId=${buildTypeId}&buildNumber=${buildNumber}"/></c:when
    ><c:when test="${buildTag != null}"><c:url value="/viewLog.html?buildTypeId=${buildTypeId}&buildTag=${buildTag}${branchParam}"/></c:when
    ><c:otherwise><c:url value="/viewLog.html?buildTypeId=${buildTypeId}"/></c:otherwise
></c:choose></c:set
><a href="<c:out value="${buildUrl}" />"<c:if test="${title != null}">title="${title}"</c:if>><jsp:doBody/></a>