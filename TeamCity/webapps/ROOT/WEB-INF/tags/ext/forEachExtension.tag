<%@ tag import="jetbrains.buildServer.web.impl.PageExtensionsInterceptor" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ attribute name="placeId" type="jetbrains.buildServer.web.openapi.PlaceId" required="true" %>
<%@ variable name-given="extension" scope="NESTED" %>
<c:set var="extensionsWrapperParam" value="<%=PageExtensionsInterceptor.PAGE_EXTENSIONS_PARAM%>"/>
<c:set var="pageExtensions" value="${requestScope[extensionsWrapperParam]}"/>
<c:forEach items="${pageExtensions.extensions[placeId]}" var="extension" >
  <jsp:doBody />
</c:forEach>
