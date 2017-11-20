<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>

<%@ attribute name="buildProblem" type="jetbrains.buildServer.serverSide.problems.BuildProblem" required="true" %>
<%@ attribute name="compactMode" type="java.lang.Boolean" required="false" %>
<%@ attribute name="showPopup" type="java.lang.Boolean" required="false" %>
<%@ attribute name="showExpanded" type="java.lang.Boolean" required="false" %>
<%@ attribute name="buildProblemUID" type="java.lang.String" required="true" %>

<c:set var="buildProblem" value="${buildProblem}" scope="request"/>
<c:set var="compactMode" value="${compactMode}" scope="request"/>
<c:set var="showPopup" value="${showPopup}" scope="request"/>
<c:set var="showExpanded" value="${showExpanded}" scope="request"/>
<c:set var="buildProblemUID" value="${buildProblemUID}" scope="request"/>
<jsp:include page="/problems/buildProblemWithDetails.html"/>
