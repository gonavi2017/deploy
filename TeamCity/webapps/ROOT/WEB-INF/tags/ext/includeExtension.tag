<%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    attribute name="extension" type="jetbrains.buildServer.web.openapi.PageExtension" %><%@
    attribute name="isInHead" type="java.lang.Boolean" required="false"%><%@
    attribute name="includeCSS" type="java.lang.Boolean" required="false"%><%@
    attribute name="includeJS" type="java.lang.Boolean" required="false"%><%@
    attribute name="includeContent" type="java.lang.Boolean" required="false"

%><c:if test="${not empty extension}"
><c:if test="${( empty includeCSS or includeCSS ) and fn:length(extension.cssPaths) gt 0}">
  <!-- START EXTENSION CSS <c:out value="${extension}"/> name:<c:out value="${extension.pluginName}"/> -->
  <bs:linkCSS dynamic="${empty isInHead or not isInHead}"><c:forEach items="${extension.cssPaths}" var="path">${path};</c:forEach></bs:linkCSS>
  <!-- END EXTENSION CSS <c:out value="${extension}"/> --></c:if

 ><c:if test="${( empty includeJS or includeJS ) and fn:length(extension.jsPaths) gt 0}">
  <!-- START EXTENSION JS <c:out value="${extension}"/> name:<c:out value="${extension.pluginName}"/> -->
  <bs:linkScript><c:forEach items="${extension.jsPaths}" var="path">${path}; </c:forEach></bs:linkScript>
  <!-- END EXTENSION JS <c:out value="${extension}"/> --></c:if

 ><c:if test="${empty includeContent or includeContent}">
  <!-- START EXTENSION CONTENT <c:out value="${extension}:"/> name:<c:out value="${extension.pluginName}"/>: <c:out value="${extension.includeUrl}"/> -->
    <jsp:include page="${extension.includeUrl}"/>
  <!-- END EXTENSION CONTENT <c:out value="${extension}"/> -->
  </c:if
></c:if>