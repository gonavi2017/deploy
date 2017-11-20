<%@ tag import="jetbrains.buildServer.web.openapi.PlaceId" %><%@
    tag import="jetbrains.buildServer.web.impl.TeamCityInternalKeys" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="ext" tagdir="/WEB-INF/tags/ext"%><%@
    attribute name="placeId" type="jetbrains.buildServer.web.openapi.PlaceId" required="true" %><%@
    attribute name="beforeExtensionContent" fragment="true" required="false"%><%@
    attribute name="afterExtensionContent" fragment="true" required="false"%><%@
    attribute name="separator" fragment="true" required="false"

%><c:set var="extensionsWrapperParam" value="<%=TeamCityInternalKeys.PAGE_EXTENSIONS_COLLECTION%>"
/><c:set var="pageExtensions" value="${requestScope[extensionsWrapperParam]}"
/><c:set var="inHead" value="<%=placeId == PlaceId.ALL_PAGES_HEADER%>"
/><c:set var="pExtensions" value="${pageExtensions.extensions[placeId]}"
/><c:forEach items="${pExtensions}" var="ext"
    ><ext:includeExtension extension="${ext}" isInHead="${inHead}" includeCSS="${true}" includeJS="${false}" includeContent="${false}"
/></c:forEach
><c:forEach items="${pExtensions}" var="ext"
    ><ext:includeExtension extension="${ext}" isInHead="${inHead}" includeCSS="${false}" includeJS="${true}" includeContent="${false}"
/></c:forEach
><c:forEach items="${pExtensions}" var="ext" varStatus="index"
    ><c:if test="${not empty separator && not index.first}"><jsp:invoke fragment="separator"/></c:if
    ><c:if test="${not empty beforeExtensionContent}"><jsp:invoke fragment="beforeExtensionContent"/></c:if
    ><ext:includeExtension extension="${ext}" isInHead="${inHead}" includeCSS="${false}" includeJS="${false}" includeContent="${true}"
    /><c:if test="${not empty afterExtensionContent}"><jsp:invoke fragment="afterExtensionContent"/></c:if
></c:forEach>