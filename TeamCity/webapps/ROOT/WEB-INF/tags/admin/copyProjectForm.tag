<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %><%@
    taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="l" tagdir="/WEB-INF/tags/layout" %><%@
    attribute name="project" type="jetbrains.buildServer.serverSide.SProject" required="true"%><%@
    attribute name="beans" type="java.util.List" required="true"%><%@
    attribute name="parents" type="java.util.List" required="true"
%><c:url value='/admin/copyProject.html' var="copyAction"

/><bs:modalDialog formId="copyProjectForm"
                  title="Copy Project"
                  action="${copyAction}"
                  dialogClass="${not empty beans ? 'wide' : ''}"
                  closeCommand="BS.CopyProjectForm.cancelDialog()"
                  saveCommand="BS.CopyProjectForm.submitCopy()">
  <table class="copyProject">
    <tr>
      <th><label for="newParent" class="tableLabel">Copy to project: <l:star/></label></th>
      <td>
        <bs:projectsFilter name="newParent" style="width: ${not empty beans ? '44em' : '32em'};"
                           defaultOption="true"
                           selectedProjectExternalId="${project.parentProjectExternalId}"
                           projectBeans="${parents}"/>
        <span class="error" id="error_newParent"></span>
      </td>
    </tr>
    <tr>
      <th><label for="newProjectName" class="tableLabel">New name: <l:star/></label></th>
      <td>
        <forms:textField id="newProjectName" name="newName" value="${project.name}"/>
        <span class="error" id="error_newProjectName"></span>
      </td>
    </tr>
    <tr>
      <th class="noBorder"><label for="newProjectExternalId">New ID: <l:star/><bs:help file="Identifier"/></label></th>
      <td class="noBorder">
        <forms:textField id="newProjectExternalId" name="externalId" maxlength="80" value=""/>
        <span class="grayNote">This ID is used in URLs, REST API, HTTP requests to the server, and configuration settings in the TeamCity Data Directory.</span>
        <span class="error" id="error_newProjectExternalId"></span>
      </td>
    </tr>

    <c:if test="${not empty beans}">
      <tr class="subprojects advancedSetting">
        <th class="noBorder" colspan="2">
          <label for="newSubProjects">Projects / build configurations / build templates / VCS roots IDs: <l:star/></label>
        </th>
      </tr>
      <tr class="subprojects advancedSetting">
        <td class="noBorder" colspan="2">
          <c:set var="length" value="${fn:length(beans)}"/>
          <c:set var="classes" value="${length > 5 ? 'gt-5' : ''} ${length > 10 ? 'gt-10' : ''} ${length > 15 ? 'gt-15' : ''}"/>
          <textarea id="copyMapping" class="${classes}" wrap="off"></textarea>
          <span class="error" id="error_newSubProjects"></span>
          <div>
            <a class="regenerate" href="#" title="Regenerate all IDs for all inner projects, build configurations and templates"
               onclick="return BS.AdminActions.regenerateAll('${project.externalId}', 'copyMapping', 'newProjectExternalId');">Regenerate all</a>
            <div style="clear: both"></div>
          </div>
        </td>
      </tr>
    </c:if>
  </table>

  <div style="padding-top: 0.5em;">
    <forms:checkbox name="copyAssociatedSettings" id="projectCopyAssociatedSettings" checked="true"/>
    <label for="projectCopyAssociatedSettings">Copy project-associated user, agent and other settings</label>
  </div>

  <div class="popupSaveButtonsBlock">
    <forms:submit id="copyButton" label="Copy"/>
    <forms:cancel onclick="BS.CopyProjectForm.cancelDialog()"/>
    <forms:saving id="copyProjectProgress"/>
  </div>

  <input type="hidden" name="projectId" value="${project.externalId}"/>

  <script type="text/javascript">
    BS.AdminActions.prepareProjectIdGenerator("newProjectExternalId", "newProjectName", $("newParent"));
    BS.AdminActions.prepareSubstitutor("newProjectExternalId", "${project.externalId}", "copyMapping",
      [<c:forEach var="bean" items="${beans}">['${bean.key}', '${bean.externalId}', ${bean.indent}],</c:forEach>0]
    );
  </script>
</bs:modalDialog>