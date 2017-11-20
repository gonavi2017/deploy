<%@ tag import="jetbrains.buildServer.web.util.WebUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="afn" uri="/WEB-INF/functions/authz"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags/"
%><%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin"
%><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
%><%@ taglib prefix="ext" tagdir="/WEB-INF/tags/ext"
%><%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout"
%><%@attribute name="project" type="jetbrains.buildServer.serverSide.SProject" required="true"
%><%@attribute name="cameFromUrl" type="java.lang.String" required="true"%>
<c:set var="encodedCameFromUrl" value="<%=WebUtil.encode(cameFromUrl)%>"/>
<c:if test="${afn:permissionGrantedForProject(project, 'EDIT_PROJECT')}">
  <c:url value="/admin/createObjectMenu.html?projectId=${project.externalId}&showMode=createBuildTypeMenu&cameFromUrl=${encodedCameFromUrl}" var="createUrl"/>
  <forms:addButton href="${createUrl}">Create build configuration</forms:addButton>
</c:if>
