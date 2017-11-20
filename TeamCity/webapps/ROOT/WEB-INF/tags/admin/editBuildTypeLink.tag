<%@ tag import="java.util.Map" %><%@
  tag import="jetbrains.buildServer.controllers.admin.projects.ConfigurationStep" %><%@
  tag import="jetbrains.buildServer.controllers.admin.projects.EditBuildTypeForm" %><%@
  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
  attribute name="buildTypeId" required="true" %><%@
  attribute name="style"%><%@
  attribute name="classes"%><%@
  attribute name="withoutLink"%><%@
  attribute name="onmouseover"%><%@
  attribute name="onmouseout"%><%@
  attribute name="cameFromUrl" type="java.lang.String"%><%@
  attribute name="title"%><%@
  attribute name="step" type="java.lang.String" %><c:set var="step" value="${empty step ? 'general' : step}"/><%
  final Map<String, ConfigurationStep> steps = EditBuildTypeForm.getConfigurationSteps(buildTypeId, cameFromUrl);
  request.setAttribute("steps", steps);
%><c:url var="url" value="${steps[step].url}"/><c:choose><c:when test="${not withoutLink}"><a href="${url}" <c:if test="${not empty onmouseover}">onmouseover="${onmouseover}"</c:if> <c:if test="${not empty onmouseout}">onmouseout="${onmouseout}"</c:if> <c:if test="${not empty title}">title="${title}"</c:if> <c:if test="${not empty classes}">class="${classes}"</c:if> <c:if test="${not empty style}">style="${style}"</c:if>><jsp:doBody/></a></c:when><c:otherwise>${url}</c:otherwise></c:choose>