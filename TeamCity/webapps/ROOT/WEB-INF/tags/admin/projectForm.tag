<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %><%@
    taglib prefix="afn" uri="/WEB-INF/functions/authz" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %><%@
    taglib prefix="l" tagdir="/WEB-INF/tags/layout" %><%@
    attribute name="projectForm" required="true" rtexprvalue="true" type="jetbrains.buildServer.controllers.admin.projects.BaseProjectForm" %><bs:messages key="projectUpdated"
/>
<c:set var="createMode" value="${projectForm.originalProject == null}"/>
<c:set var="readOnly" value="${projectForm.originalProject.readOnly}"/>
<c:set var="canEdit" value="${projectForm.originalProject == null or (not projectForm.rootProject and afn:permissionGrantedForProject(projectForm.originalProject, 'EDIT_PROJECT'))}"/>
<table class="runnerFormTable">
  <c:if test="${not canEdit}">
    <tr>
      <th>Name:</th>
      <td>
        <c:out value="${projectForm.name}"/>
      </td>
    </tr>
    <tr>
      <th class="noBorder">Project ID: <bs:help file="Identifier"/></th>
      <td class="noBorder">
        <c:out value="${projectForm.externalId}"/>
      </td>
    </tr>
    <tr>
      <th class="noBorder">Description:</th>
      <td class="noBorder">
        <c:out value="${projectForm.description}"/>
      </td>
    </tr>
  </c:if>
  <c:if test="${canEdit}">
  <c:if test="${createMode}">
    <tr>
      <th><label for="parentId">Parent project: <l:star/></label></th>
      <td>
        <bs:projectsFilter name="parentId" id="parentId" style="width: 30.8em"
                           projectBeans="${projectForm.availableParents}"
                           selectedProjectExternalId="${projectForm.parentId}"/>
        <span class="error" id="errorParent"></span>
      </td>
    </tr>
  </c:if>
  <tr>
    <th><label for="name">Name: <l:star/></label></th>
    <td>
      <forms:textField name="name" className="longField" maxlength="80" value="${projectForm.name}"/>
      <span class="error" id="errorName"></span>
    </td>
  </tr>
  <tr>
    <th class="noBorder"><label for="externalId">Project ID: <l:star/><bs:help file="Identifier"/></label></th>
    <td class="noBorder">
      <forms:textField name="externalId" className="longField" maxlength="80" value="${projectForm.externalId}"/>
      <bs:smallNote>This ID is used in URLs, REST API, HTTP requests to the server, and configuration settings in the TeamCity Data Directory.</bs:smallNote>
      <span class="error" id="errorExternalId"></span>
    </td>
  </tr>
  <tr>
    <th class="noBorder"><label for="description">Description:</label></th>
    <td class="noBorder"><forms:textField name="description" className="longField" maxlength="256"
                                          value="${projectForm.description}"/></td>
  </tr>
  </c:if>
</table>
<input type="hidden" id="submitProject" name="submitProject" value="store"/>
<div class="icon_before icon16 attentionComment" id="changeExternalIdWarning" style="display: none; margin-top: 1em">
  Important: Modifying the ID will change all the URLs related to the project.
  It is highly recommended to update the ID in any of the URLs bookmarked or hard-coded in the scripts.
  The corresponding configuration and artifacts directory names on the disk will change too and it can take time.
</div>
<c:if test="${not createMode}">
  <input type="hidden" id="parentId" value="${projectForm.originalProject.parentProjectExternalId}"/>
</c:if>
<c:if test="${not readOnly}">
<script type="text/javascript">
  BS.AdminActions.prepareProjectIdGenerator("externalId", "name", $("parentId"), ${not createMode});
</script>
</c:if>