<%@ include file="/include-internal.jsp"%>
<jsp:useBean id="metaDialogPath" scope="request" type="java.lang.String"/>
<jsp:useBean id="buildTypeForm" scope="request" type="jetbrains.buildServer.controllers.admin.projects.EditableBuildTypeSettingsForm"/>
<c:set var="settingsId"><bs:forJs>${buildTypeForm.settingsId}</bs:forJs></c:set>
<a href="#" onclick="BS.MetaRunners.showDialog(this, '${settingsId}')">Extract meta-runner...</a>

<c:url var="metaDialogUrl" value="${metaDialogPath}"/>
<bs:modalDialog formId="metaRunnersExport"
                title="Extract Meta-Runner"
                action="${metaDialogUrl}"
                closeCommand="BS.MetaRunners.Dialog.close();"
                saveCommand="BS.MetaRunners.Dialog.save();">
  <div id="metaRunnersRefresh" data-url="${metaDialogUrl}">
  </div>

  <div id="metaRunnersExportButtons" class="popupSaveButtonsBlock">
    <forms:submit id="metaRunnersExportSubmit" label="Extract" onclick="BS.MetaRunners.Dialog.saveNamesPage();"/>
    <forms:cancel onclick="BS.MetaRunners.Dialog.close();"/>
    <forms:saving id="metaRunnersSaving"/>
  </div>
</bs:modalDialog>
