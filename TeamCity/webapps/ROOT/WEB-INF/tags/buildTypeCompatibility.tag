<%@ tag import="java.util.Set" %>
<%@ tag import="java.util.HashSet" %>
<%@ tag import="jetbrains.buildServer.controllers.compatibility.BuildCompatibilityController" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@attribute name="project" required="true" type="jetbrains.buildServer.serverSide.SProject"%>
<%@attribute name="compatibleAgents" required="true" type="jetbrains.buildServer.serverSide.CompatibleAgents"%>
<%@attribute name="showActiveCompatibleCount" required="false" type="java.lang.Boolean"%>
<c:set var="showActiveCompatibleValue"><%=BuildCompatibilityController.VIEW_MODE_ACTIVE_COMPATIBLE_NUM%></c:set>
<bs:changeRequest key="<%=BuildCompatibilityController.VIEW_MODE%>" value="${not empty showActiveCompatibleCount and showActiveCompatibleCount ? showActiveCompatibleValue : ''}">
<bs:changeRequest key="project" value="${project}">
<bs:changeRequest key="compatibleAgents" value="${compatibleAgents}">
  <jsp:include page="<%=BuildCompatibilityController.PATH%>"/>
</bs:changeRequest>
</bs:changeRequest>
</bs:changeRequest>
