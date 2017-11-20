<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ attribute name="change" type="jetbrains.buildServer.vcs.SVcsModification" required="true"
%><%@ attribute name="buildTypeId" type="java.lang.String" required="false"
%><%@ attribute name="extension" type="jetbrains.buildServer.web.openapi.CustomTab" required="false"
%><c:set var="query" value="modId=${change.id}&personal=${change.personal}&init=1"
/><c:if test="${not empty buildTypeId}"
    ><c:set var="query" value="${query}&buildTypeId=${buildTypeId}"
/></c:if
><c:if test="${empty extension}"
    ><c:set var="extension" value="${extensionTab}"
/></c:if
><c:set var="query" value="${query}&tab=${extension.tabId}"
/><c:url value="/viewModification.html?${query}"/>