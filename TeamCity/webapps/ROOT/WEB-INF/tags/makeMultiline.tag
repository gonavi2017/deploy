<%@ tag import="jetbrains.buildServer.web.util.HTMLFormatter" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    attribute name="value" type="java.lang.String"

%><c:set var="content"><jsp:doBody/></c:set
><c:if test="${empty content}"><c:set var="content" value="${value}"/></c:if
><%= HTMLFormatter.formatMultiLine((String)jspContext.getAttribute("content"), false) %>