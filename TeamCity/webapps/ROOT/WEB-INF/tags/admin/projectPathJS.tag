<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@attribute name="startProject" type="jetbrains.buildServer.serverSide.SProject" required="true"
%><%@attribute name="startAdministration" required="false" type="java.lang.Boolean"
%><%@attribute name="currentTitle" required="false" type="java.lang.String"
%><%@attribute name="currentLink" required="false" type="java.lang.String" %>
<c:if test="${startAdministration}">BS.Navigation.items = [ {title: "Administration", url: '<c:url value="/admin/admin.html"/>'} ];</c:if>
<c:if test="${not empty startProject}">
<c:forEach var="p" items="${startProject.projectPath}" varStatus="status">
  BS.Navigation.items.push({
    title: "<bs:escapeForJs text="${p.name}" forHTMLAttribute="true"/>",
    url: '<admin:editProjectLink projectId="${p.externalId}" withoutLink="true"/>',
    selected: false,
    itemClass: "project",
    projectId: "${p.externalId}",
    siblingsTree: {
      parentId: "${p.parentProjectExternalId}",
      projectUrlFormat: '<admin:editProjectLink projectId="{id}" withoutLink="true"/>'
    }
  });
</c:forEach>
</c:if>
BS.Navigation.items.push({
title: "${currentTitle}",
url: '${currentLink}',
selected: true
});