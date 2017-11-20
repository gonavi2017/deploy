<%@ tag import="jetbrains.buildServer.web.util.HTMLFormatter" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    attribute name="value" type="java.lang.String" %><%@
    attribute name="multilineOnly" type="java.lang.Boolean" required="false"%><%@
    attribute name="resolverContext" type="java.lang.Object" required="false"
    %><%jspContext.setAttribute("requestContextPath", request.getContextPath());
  jspContext.setAttribute("resolverContext", resolverContext);
%><c:set var="content"><jsp:doBody/></c:set
><c:if test="${empty content}"><c:set var="content" value="${value}"/></c:if
><c:choose
    ><c:when test="${multilineOnly}"
        ><%= HTMLFormatter.formatMultiLine((String)jspContext.getAttribute("content"))
    %></c:when
    ><c:otherwise
        ><%= HTMLFormatter.format((String)jspContext.getAttribute("content"), jspContext)
%></c:otherwise
></c:choose>