<%@ tag import="jetbrains.buildServer.web.impl.PageExtensionsInterceptor" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ext" tagdir="/WEB-INF/tags/ext"%>
<%@attribute name="placeId" type="jetbrains.buildServer.web.openapi.PlaceId" %>
<c:set var="extensionsWrapperParam" value="<%=PageExtensionsInterceptor.PAGE_EXTENSIONS_PARAM%>"/>
<c:set var="pageExtensions" value="${requestScope[extensionsWrapperParam]}"/>
<c:set var="extensionTab" value="${pageExtensions.selectedTabs[placeId]}" scope="request"/>
<%@ variable name-given="extensionTab" variable-class="jetbrains.buildServer.web.openapi.CustomTab" scope="AT_END" %>
