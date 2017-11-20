<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %><%@
    taglib prefix="afn" uri="/WEB-INF/functions/authz" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %><%@
    taglib prefix="l" tagdir="/WEB-INF/tags/layout" %><%@
    attribute name="sourceBuildType" required="true" type="jetbrains.buildServer.serverSide.SBuildType" %><%@
    attribute name="editableProjectBeans" required="true" type="java.util.List"
%><c:url value='/admin/copyBuildType.html' var="copyAction"/>

<bs:modalDialog formId="copyBuildTypeForm"
                title="Copy Build Configuration"
                action="${copyAction}"
                closeCommand="BS.CopyBuildTypeForm.cancelDialog()"
                saveCommand="BS.CopyBuildTypeForm.submitCopy()">
  <label for="copyBuildTypeProjectId" class="tableLabel">Copy to project: <l:star/></label>
  <bs:projectsFilter id="copyBuildTypeProjectId" name="projectId" style="width: 31em;"
                     selectedProjectExternalId="${sourceBuildType.projectExternalId}"
                     disableRoot="true"
                     projectBeans="${editableProjectBeans}"/>
  <span class="error" id="error_projectId"></span>
  <script type="text/javascript">
    $('copyBuildTypeForm').projectId.selectProject = function(projectId) {
      for (var i = 0; i < this.options.length; i++) {
        if (this.options[i].value == projectId) {
          this.selectedIndex = i;
          break;
        }
      }
      BS.jQueryDropdown('#' + this.id).ufd("changeOptions");
    };
  </script>

  <p>
    <label for="newBuildTypeName" class="tableLabel">New name: <l:star/></label>
    <forms:textField id="newBuildTypeName" name="newName" value="${sourceBuildType.name}" style="width: 32.2em;"/>
    <span class="error" id="error_newName" style="margin-left: 8em"></span>
  </p>

  <p>
    <label for="newExternalId" class="tableLabel">New ID: <l:star/><bs:help file="Identifier"/></label>
    <forms:textField id="newBuildTypeExternalId" name="newExternalId" style="width: 32.2em;" maxlength="80" value=""/>
    <span class="error" id="error_newBuildTypeExternalId" style="margin-left: 8em"></span>
  </p>

  <div style="padding-top: 0.5em;">
    <forms:checkbox name="copyAssociatedSettings" id="btCopyAssociatedSettings" checked="true"/>
    <label for="btCopyAssociatedSettings">Copy build configuration-associated user, agent and other settings</label>
  </div>

  <div class="popupSaveButtonsBlock">
    <forms:submit name="copyBuildType" id="copyBuildTypeButton" label="Copy"/>
    <forms:cancel onclick="BS.CopyBuildTypeForm.cancelDialog()" showdiscardchangesmessage="false"/>
    <forms:saving id="copyBuildTypeProgress"/>
  </div>

  <input type="hidden" name="buildTypeId" id="buildTypeId" value="${sourceBuildType.externalId}"/>
  <input type="hidden" name="sourceProjectId" id="sourceProjectId" value="${sourceBuildType.projectExternalId}"/>

  <script type="text/javascript">
    BS.AdminActions.prepareBuildTypeIdGenerator("newBuildTypeExternalId", "newBuildTypeName", $("copyBuildTypeProjectId"));
  </script>
</bs:modalDialog>
