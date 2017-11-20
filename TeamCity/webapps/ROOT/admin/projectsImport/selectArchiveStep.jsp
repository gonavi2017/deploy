<%@ include file="/include-internal.jsp" %>
<%--@elvariable id="selectArchiveStep" type="jetbrains.buildServer.controllers.admin.projectsImport.SelectArchiveStepBean"--%>
<c:set value="${fn:length(selectArchiveStep.availableArchives) > 0}" var="archivesExist"/>

<h2>Projects Import: Select Backup File</h2>

<p>On this page you can select a backup file to import projects from. Only backup files created with a TeamCity server of the same version as the current server are supported.
  <bs:helpLink file="Projects+Import"><bs:helpIcon/></bs:helpLink></p>

<form id="selectArchiveForm" onsubmit="return BS.ProjectsImport.SelectArchiveForm.submit()" method="post">
  <table class="runnerFormTable">
    <c:choose>
      <c:when test="${archivesExist}">
        <tr>
          <th><label>Import from:</label></th>
          <td>
            <forms:select id="archiveSelector" name="selectedArchive" enableFilter="true" onchange="BS.ProjectsImport.SelectArchiveForm.archiveSelectorChange();">
              <forms:option value="">-- Please select a backup file --</forms:option>
              <c:forEach var="archive" items="${selectArchiveStep.availableArchives}">
                <forms:option value="${archive.path}" selected="${fn:length(selectArchiveStep.availableArchives) == 1}"><c:out value="${archive.name}"/></forms:option>
              </c:forEach>
            </forms:select>
            <div class="smallNote" style="margin-left: 0;">Directory for files to import: <strong><c:out value="${selectArchiveStep.archivesDirectory}"/></strong></div>
            <span class="error" id="archiveVersionMismatchError"></span>
            <span class="error" id="invalidArchiveError"></span>
            <span class="error" id="projectImportUnexpectedError"></span>

            <div id="uploadArchiveButton">
              <forms:addButton onclick="BS.ProjectsImport.UploadArchiveDialog.show(); return false;">Upload Archive</forms:addButton>
            </div>
          </td>
        </tr>
      </c:when>
      <c:otherwise>
        <tr>
          <td colspan="2">
            There are no backup files in <strong><c:out value="${selectArchiveStep.archivesDirectory}"/></strong>. Upload the file or put it in the directory and refresh this page.
            <div id="uploadArchiveButton">
              <forms:addButton onclick="BS.ProjectsImport.UploadArchiveDialog.show(); return false;">Upload Archive</forms:addButton>
            </div>
          </td>
        </tr>
      </c:otherwise>
    </c:choose>
  </table>

  <c:if test="${fn:length(selectArchiveStep.availableArchives) > 0}">
    <div class="saveButtonsBlock">
      <forms:submit id="submitArchiveButton" label="Configure Import Scope"/>
      <forms:saving id="selectArchiveProgress" savingTitle="Archive is analyzing..."/>
    </div>
  </c:if>
</form>

<c:url var="action" value="/admin/projectsImportUpload.html"/>
<bs:dialog dialogId="uploadImportedArchiveDialog" title="Upload archive" closeCommand="BS.ProjectsImport.UploadArchiveDialog.close()">
  <forms:multipartForm id="uploadImportedArchiveForm" action="${action}" targetIframe="hidden-iframe" onsubmit="return BS.ProjectsImport.UploadArchiveDialog.validate();">
    <table class="runnerFormTable">
      <tr>
        <th>Name</th>
        <td><input type="text" id="fileName" name="fileName" value="" class="mediumField"/></td>
      </tr>
      <tr>
        <th>Imported Archive</th>
        <td>
          <forms:file name="fileToUpload" size="28"/>
          <div id="uploadError" class="error hidden"></div>
        </td>
      </tr>
    </table>
    <div class="popupSaveButtonsBlock">
      <forms:submit id="uploadImportedArchiveDialogSubmit" label="Upload"/>
      <forms:cancel onclick="BS.ProjectsImport.UploadArchiveDialog.close()"/>
      <forms:saving id="uploadingProgress" savingTitle="Uploading..."/>
    </div>
  </forms:multipartForm>
</bs:dialog>


<script type="text/javascript">
  BS.ProjectsImport.SelectArchiveForm.init();
  BS.ProjectsImport.UploadArchiveDialog.prepareFileUpload();
</script>
