<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="l" tagdir="/WEB-INF/tags/layout" %><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %><%@
    taglib prefix="afn" uri="/WEB-INF/functions/authz" %><%@
    taglib prefix="intprop" uri="/WEB-INF/functions/intprop" %><%@
    attribute name="project" required="true" type="jetbrains.buildServer.serverSide.SProject"
%><%@ attribute name="caption" required="false" type="java.lang.String"
%><%@ attribute name="autoSetupPopup" required="false" type="java.lang.Boolean"
%><c:if test="${empty autoSetupPopup}"><c:set var="autoSetupPopup" value="${true}"/></c:if>
<c:set var="projectExternalId" value="${project.externalId}"
/><%--@elvariable id="serverSummary" type="jetbrains.buildServer.web.openapi.ServerSummary"--%>
<c:set var="menuItems">
  <c:if test="${!project.rootProject}">
    <authz:authorize allPermissions="EDIT_PROJECT" projectId="${project.projectId}">
      <c:set var="showCopyLink" value="${serverSummary.enterpriseMode or (serverSummary.buildConfigurationsLeft - fn:length(project.buildTypes) + 1) > 0}"/>
      <c:if test="${showCopyLink}">
        <l:li>
          <a href="#" title="Copy project" onclick="return BS.CopyProjectForm.showDialog('${project.externalId}');">Copy project...</a>
        </l:li>
      </c:if>
      <c:if test="${not showCopyLink}">
        <l:li>
          <span class="commentText" title="Cannot copy project due to limit for number of build configurations">Copy project...</span>
        </l:li>
      </c:if>
      <c:if test="${not project.readOnly}">
      <l:li>
        <a href="#" title="Move project" onclick="return BS.MoveProjectForm.showDialog('${projectExternalId}');">Move project...</a>
      </l:li>
      </c:if>
    </authz:authorize>
  </c:if>
  <c:if test="${not project.readOnly and not project.rootProject}">
    <authz:authorize allPermissions="ARCHIVE_PROJECT" projectId="${project.projectId}">
      <c:choose>
        <c:when test="${project.archived}">
          <l:li>
            <a href="#" onclick="<bs:_archiveProjectLinkOnClick project="${project}" archive="false"/>; return false">
              Dearchive project...
            </a>
          </l:li>
        </c:when>
        <c:otherwise>
          <l:li>
            <a href="#" onclick="<bs:_archiveProjectLinkOnClick project="${project}" archive="true"/>; return false">
              Archive project...
            </a>
          </l:li>
        </c:otherwise>
      </c:choose>
    </authz:authorize>
  </c:if>

  <c:if test="${not project.readOnly and afn:permissionGrantedForProject(project, 'EDIT_PROJECT')}">
    <l:li><a href="#" onclick="return BS.AdminActions.regenerateAllIds('${projectExternalId}')">Bulk edit IDs...</a></l:li>
    <l:li><a href="#" onclick="return BS.PauseProjectDialog.showPauseProjectDialog('${projectExternalId}');">Pause/Activate triggers...</a></l:li>
  </c:if>

  <c:if test="${project.readOnly and afn:permissionGrantedForProject(project, 'EDIT_PROJECT') and not project.customSettingsFormatUsed}">
    <l:li><a href="#" onclick="return BS.AdminActions.setProjectEditable('${projectExternalId}', true)">Enable editing</a></l:li>
  </c:if>

  <jsp:include page="/admin/editProjectNavExtensions.html?projectId=${projectExternalId}"/>

  <c:if test="${!project.rootProject and not project.readOnly}">
    <c:if test="${afn:permissionGrantedForProject(project, 'EDIT_PROJECT') or afn:permissionGrantedForProject(project.parentProject, 'DELETE_SUB_PROJECT')}">
      <l:li>
        <a href="#" title="Delete project" onclick="return BS.AdminActions.deleteProject('${projectExternalId}')">Delete project...</a>
      </l:li>
    </c:if>
  </c:if>
</c:set>
<c:if test="${not empty fn:trim(menuItems)}">
  <bs:actionsPopup controlId="prjActions${projectExternalId}" autoSetupPopup="${autoSetupPopup}"
                   popup_options="shift: {x: -150, y: 20}, className: 'quickLinksMenuPopup'">
    <jsp:attribute name="content">
      <div>
        <ul class="menuList">
          ${menuItems}
        </ul>
      </div>
    </jsp:attribute>
    <jsp:body>${not empty caption ? 'Actions' : ''}</jsp:body>
  </bs:actionsPopup>
</c:if>
