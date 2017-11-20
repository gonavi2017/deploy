<%@ tag import="jetbrains.buildServer.web.impl.TeamCityInternalKeys" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="ext" tagdir="/WEB-INF/tags/ext"%><%@
    attribute name="placeId" type="jetbrains.buildServer.web.openapi.PlaceId" required="true"%><%@
    attribute name="otherwise" required="false" fragment="true"
%><c:set var="extensionsWrapperParam" value="<%=TeamCityInternalKeys.PAGE_EXTENSIONS_COLLECTION%>"
/><c:set var="pageExtensions" value="${requestScope[extensionsWrapperParam]}"
/><c:if test="${not empty pageExtensions.extensions[placeId]}"
><jsp:doBody
/></c:if
><c:if test="${empty pageExtensions.extensions[placeId]}"
><c:if test="${not empty otherwise}"><jsp:invoke fragment="otherwise"/></c:if></c:if>

