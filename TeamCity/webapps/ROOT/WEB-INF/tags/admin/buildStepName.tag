<%@ tag import="jetbrains.buildServer.web.util.WebUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="afn" uri="/WEB-INF/functions/authz"
%><%@ attribute name="buildStep" required="true" type="jetbrains.buildServer.serverSide.SBuildRunnerDescriptor"
%><%@ attribute name="buildType" required="true" type="jetbrains.buildServer.serverSide.SBuildType"
%><%@ attribute name="cameFromUrl" required="true" type="java.lang.String"
%><%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin"
%><c:set var="stepName"
><c:choose
><c:when test="${not empty buildStep.name}"
><em>(<c:out value="${buildStep.runType.displayName}"/>)</em> <c:out value="${buildStep.name}"
/></c:when
><c:otherwise
><c:out value="${buildStep.runType.displayName}"
/></c:otherwise
></c:choose
></c:set
><c:set var="escapedCameFrom" value='<%=WebUtil.encode(cameFromUrl)%>'/><c:url value='/admin/editRunType.html?init=1&id=buildType:${buildType.externalId}&runnerId=${buildStep.id}&cameFromUrl=${escapedCameFrom}' var="stepUrl"
/><a href="${stepUrl}">${stepName}</a>