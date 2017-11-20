<%@ include file="/include-internal.jsp"
%><jsp:useBean id="sourceTemplate" type="jetbrains.buildServer.serverSide.BuildTypeTemplate" scope="request"
/><jsp:useBean id="editableProjectBeans" type="java.util.List" scope="request"
/><c:url value='/admin/copyTemplate.html' var="copyAction"/>

<bs:modalDialog formId="copyTemplateForm"
                title="Copy Template"
                action="${copyAction}"
                closeCommand="BS.CopyTemplateForm.cancelDialog()"
                saveCommand="BS.CopyTemplateForm.submitCopy()">
  <label for="copyTemplateProjectId" class="tableLabel">Copy to project: <l:star/></label>
  <bs:projectsFilter id="copyTemplateProjectId" name="projectId" style="width: 31em;"
                     selectedProjectExternalId="${sourceTemplate.project.externalId}"
                     disableRoot="false"
                     projectBeans="${editableProjectBeans}"/>
  <span class="error" id="error_projectId"></span>
  <script type="text/javascript">
    $('copyTemplateForm').projectId.selectProject = function(projectId) {
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
    <label for="newTemplateName" class="tableLabel">New name: <l:star/></label>
    <forms:textField id="newTemplateName" name="newName" value="${sourceTemplate.name}" style="width: 32.2em;"/>
    <span class="error" id="error_newName" style="margin-left: 8em"></span>
  </p>

  <p>
    <label for="newExternalId" class="tableLabel">New ID: <l:star/><bs:help file="Configuring+General+Settings"
                                                                            anchor="BuildconfigurationID" /></label>
    <forms:textField id="newTemplateExternalId" name="newExternalId" style="width: 32.2em;" maxlength="80" value=""/>
    <span class="error" id="error_newTemplateExternalId" style="margin-left: 8em"></span>
  </p>

  <div class="popupSaveButtonsBlock">
    <forms:submit name="copyTemplate" id="copyTemplateButton" label="Copy"/>
    <forms:cancel onclick="BS.CopyTemplateForm.cancelDialog()" showdiscardchangesmessage="false"/>
    <forms:saving id="copyTemplateProgress"/>
  </div>

  <input type="hidden" name="templateId" id="templateId" value="${sourceTemplate.externalId}"/>
  <input type="hidden" name="sourceProjectId" id="sourceProjectId" value="${sourceTemplate.project.externalId}"/>

  <script type="text/javascript">
    BS.AdminActions.prepareTemplateIdGenerator("newTemplateExternalId", "newTemplateName", $("copyTemplateProjectId"));
  </script>
</bs:modalDialog>
