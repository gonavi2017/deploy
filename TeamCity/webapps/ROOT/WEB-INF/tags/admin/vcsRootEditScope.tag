<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="admfn" uri="/WEB-INF/functions/admin" %>
<%@ attribute name="buildForm" required="true" type="jetbrains.buildServer.controllers.admin.projects.BuildTypeForm"%>
<%@ attribute name="vcsRootsBean" required="true" type="jetbrains.buildServer.controllers.admin.projects.VcsSettingsBean"%>
<%@ attribute name="vcsRoot" required="true" type="jetbrains.buildServer.vcs.VcsRoot"%>
<%@ variable name-given="editingScope" scope="AT_END" %>
<c:choose>
  <c:when test="${buildForm.template or not buildForm.templateBased or empty vcsRoot or vcsRootsBean.detacheableVcsRoots[vcsRoot.id]}">
    <c:set var="editingScope" value="${buildForm.settingsId}"/>
  </c:when>
  <c:when test="${buildForm.templateBased and not vcsRootsBean.detacheableVcsRoots[vcsRoot.id]}">
    <c:set var="editingScope" value="${admfn:getTemplateSettingsId(buildForm.settings.template)}"/>
  </c:when>
</c:choose>
