<%@ include file="/include-internal.jsp" %>
<jsp:useBean id="cns" class="jetbrains.buildServer.runners.metaRunner.ui.export.ExportContrants"/>
<jsp:useBean id="form" scope="request" type="jetbrains.buildServer.runners.metaRunner.ui.export.beans.ExportBean"/>

<div id="metaRunnersRefreshInner">
  <props:hiddenProperty name="${cns.stepNameKey}" value="${cns.stepNameIds}"/>
  <props:hiddenProperty id="metaRunnerConfirmReplace" name="${cns.metaRunnerReplaceAction}"/>
  <table class="runnerFormTable featureDetails">
    <tbody>
    <tr>
      <th><label for="${cns.metaRunnerExportTargetProjectId}">Project</label>:</th>
      <td>
        <c:set var="selectId" value="metaRunnerExportProjectId"/>
        <bs:projectsFilter
            id="${selectId}"
            name="${cns.metaRunnerExportTargetProjectId}"
            className="longField"
            defaultOption="true"
            disableRoot="${false}"
            selectedProjectExternalId="${form.projectExternalIdToExport}"
            projectBeans="${form.projectsToExport}"/>
        <script>BS.jQueryDropdown('#${selectId}', {listWidthFixed: true});</script>
        <span class="smallNote">The project to extract the meta-runner to</span>
        <span class="error" id="error_${cns.metaRunnerExportTargetProjectId}"></span>
      </td>
    </tr>
    <tr>
      <th><label for="${cns.metaRunnerNameKey}">Name: <l:star/></label></th>
      <td>
        <props:textProperty id="metaRunnerExportName" name="${cns.metaRunnerNameKey}" expandable="${false}" maxlength="255" className="longField"/>
        <span class="smallNote">The name to show in the build runners selector on build step settings page</span>
        <span class="error" id="error_${cns.metaRunnerNameKey}"></span>
      </td>
    </tr>
    <tr>
      <th><label for="${cns.metaRunnerIdKey}">ID: <l:star/></label></th>
      <td>
        <props:textProperty id="metaRunnerExportId" name="${cns.metaRunnerIdKey}" expandable="${false}" maxlength="80" className="longField"/>
        <span class="smallNote">The unique runner identifier to be used in build configuration settings to reference this meta-runner</span>
        <span class="error" id="error_${cns.metaRunnerIdKey}"></span>
      </td>
    </tr>
    <tr>
      <th><label for="${cns.metaRunnerDescriptionKey}">Description: <l:star/></label></th>
      <td>
        <props:textProperty name="${cns.metaRunnerDescriptionKey}" expandable="${true}" className="longField"/>
        <span class="smallNote">Description to show on build step settings page</span>
        <span class="error" id="error_${cns.metaRunnerDescriptionKey}"></span>
      </td>
    </tr>
    <tr>
      <td colspan="2" class="noBorder">
        <span class="error" id="error_export" style="margin-left: 0;"></span>
      </td>
    </tr>
    </tbody>
  </table>
</div>
