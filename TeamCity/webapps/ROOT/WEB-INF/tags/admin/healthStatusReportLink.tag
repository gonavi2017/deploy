<%@ tag import="jetbrains.buildServer.controllers.admin.healthStatus.HealthStatusTab" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="project" type="jetbrains.buildServer.serverSide.SProject" required="false" %>
<%@ attribute name="minSeverity" required="false" %>
<%@ attribute name="selectedCategory" required="false" %>
<c:set var="params">#minSeverity=${empty minSeverity ? 'INFO' : minSeverity}&scopeProjectId=<c:choose><c:when test="${not empty project}">${project.externalId}</c:when><c:otherwise>__GLOBAL__</c:otherwise></c:choose><c:if test="${not empty selectedCategory}">&selectedCategoryId=${selectedCategory}</c:if></c:set>
<c:set var="healthStatusReportUrl" value="<%=HealthStatusTab.URL%>"/>
<c:url value="${healthStatusReportUrl}${params}" var="reportUrl" />
<a href="${reportUrl}"><jsp:doBody/></a>