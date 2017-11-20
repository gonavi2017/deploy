<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ attribute name="buildType" type="jetbrains.buildServer.serverSide.SBuildType" required="true"
%><%@attribute name="contextProject" type="jetbrains.buildServer.serverSide.SProject" required="false"%>
<c:if test="${empty contextProject}"><c:out value="${buildType.fullName}"/></c:if>
<c:if test="${not empty contextProject}"><c:set var="projectPath" value="${buildType.project.projectPath}"/><c:set var="startOutput" value="false"/>
<c:set var="curPath"><c:out value="${contextProject.name}"/></c:set>
<c:forEach var="p" items="${projectPath}" varStatus="pos">
  <c:if test="${not pos.first}">
    <c:if test="${contextProject.projectId ne p.projectId}"><c:set var="curPath"><c:out value="${p.name}"/> :: ${curPath}</c:set></c:if>
    <c:if test="${contextProject.projectId == p.projectId}"><c:set var="startOutput" value="true"/><div class="contextProjectIcon" onmouseover="BS.Tooltip.showMessage(this, {shift:{x:10,y:-30}}, '${curPath}');" onmouseout="BS.Tooltip.hidePopup();">&hellip;</div> </c:if>
    <c:if test="${startOutput and contextProject.projectId ne p.projectId}"><c:out value="${p.name}"/> :: </c:if>
  </c:if>
</c:forEach>
<c:if test="${not startOutput}"><c:out value="${buildType.fullName}"/></c:if>
<c:if test="${startOutput}"><c:out value="${buildType.name}"/></c:if></c:if>