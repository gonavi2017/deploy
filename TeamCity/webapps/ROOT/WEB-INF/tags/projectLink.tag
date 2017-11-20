<%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    attribute name="project" rtexprvalue="true" type="jetbrains.buildServer.BuildProject" required="true" %><%@
    attribute name="style" required="false" type="java.lang.String" %><%@
    attribute name="classes" required="false" type="java.lang.String" %><%@
    attribute name="target" required="false" type="java.lang.String" %><%@
    attribute name="title" required="false" type="java.lang.String" %><%@
    attribute name="tab" required="false" type="java.lang.String" %><%@
    attribute name="additionalUrlParams" required="false" type="java.lang.String"

%><c:set var="text"><jsp:doBody/></c:set
><a href="${serverPath}<bs:projectUrl projectId="${project.externalId}" tab="${tab}"/>${not empty additionalUrlParams ? additionalUrlParams : ''}"
    class="buildTypeName ${not empty classes ? classes : ''}"
    <c:if test="${not empty title}">title="${title}" </c:if
    ><c:if test="${not empty style}">style="${style}" </c:if
    ><c:if test="${not empty target}">target="${target}"</c:if>
  ><c:choose><c:when test="${not empty text}">${text}</c:when><c:otherwise><c:out value="${project.name}"/></c:otherwise></c:choose></a>