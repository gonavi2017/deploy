<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %><%@
    taglib prefix="l" tagdir="/WEB-INF/tags/layout" %><%@
    taglib prefix="afn" uri="/WEB-INF/functions/authz" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %><%@
    attribute name="project" required="true" type="jetbrains.buildServer.serverSide.SProject"

%><c:url value='/admin/action.html' var="actionUrl"/>
<bs:modalDialog formId="extractTemplateForm"
                title="Extract Template"
                action="${actionUrl}"
                closeCommand="BS.ExtractTemplateAction.cancelDialog()"
                saveCommand="BS.ExtractTemplateAction.submit()">
  <span class="error" id="error_extractFailed" style="margin-left: 0;"></span>

  <table class="runnerFormTable">
    <tr>
      <th class="name noBorder"><label for="templateName"><strong>Template name:</strong> <l:star/></label></th>
      <td class="noBorder">
        <forms:textField name="templateName" style="width: 100%"/>
        <span class="error" id="error_templateName" style="margin-left: 0;"></span>

        <bs:smallNote>Note that this build configuration will be attached to the extracted template.</bs:smallNote>
      </td>
    </tr>
    <tr>
      <th class="name noBorder">
        <label for="templateExternalId"><strong>Template ID: <l:star/></strong> <bs:help file="Identifier"/></label>
      </th>
      <td class="noBorder">
        <forms:textField name="templateExternalId" style="width: 100%"/>
        <span class="error" id="error_templateExternalId" style="margin-left: 0;"></span>
      </td>
    </tr>
  </table>

  <div class="popupSaveButtonsBlock">
    <forms:submit name="extractTemplateButton" label="Extract"/>
    <forms:cancel onclick="BS.ExtractTemplateAction.cancelDialog()" showdiscardchangesmessage="false"/>
    <forms:saving id="extractTemplateProgress"/>
  </div>

  <input type="hidden" name="buildTypeId" value=""/>
  <input type="hidden" name="extractTemplate" value="1"/>

  <script type="text/javascript">
    BS.AdminActions.prepareTemplateIdGenerator("templateExternalId", "templateName", "${project.externalId}");
  </script>
</bs:modalDialog>
