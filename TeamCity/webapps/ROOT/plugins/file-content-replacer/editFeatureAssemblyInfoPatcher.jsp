<%@ include file="/include-internal.jsp" %>
<jsp:useBean id = "keys" class = "jetbrains.buildServer.fileContentReplacer.server.Keys"/>
<style>
  .longField.longField_extraLong {
    width: 100%;
  }
</style>
<tr class="noBorder">
  <th><label for="${keys.assemblyVersionFormat}">Assembly version format:</label></th>
  <td>
    <props:textProperty name="${keys.assemblyVersionFormat}" className="longField textProperty_max-width js_max-width"/>
    <span class="error" id="error_${keys.assemblyVersionFormat}"/>
    <span class="smallNote">Specify assembly version format to update AssemblyVersion attribute</span>
  </td>
</tr>

<tr class="noBorder">
  <th><label for="${keys.assemblyFileVersionFormat}">Assembly file version format:</label></th>
  <td>
    <props:textProperty name="${keys.assemblyFileVersionFormat}" className="longField textProperty_max-width js_max-width"/>
    <span class="error" id="error_${keys.assemblyFileVersionFormat}"/>
    <span class="smallNote">Specify assembly file version format to update AssemblyFileVersion attribute. Leave blank to use same version as specified in assembly version</span>
  </td>
</tr>

<tr class="noBorder">
  <th><label for="${keys.assemblyInformationalVersionFormat}">Assembly informational version format:</label></th>
  <td>
    <props:textProperty name="${keys.assemblyInformationalVersionFormat}" className="longField textProperty_max-width js_max-width"/>
    <span class="error" id="error_${keys.assemblyInformationalVersionFormat}"/>
    <span class="smallNote">Specify assembly informational version format to update AssemblyInformationalVersion attribute. Leave blank to leave attribute unchanged</span>
  </td>
</tr>

<tr class="noborder">
  <th><label for="${keys.patchGlobalAssemblyInfo}">Patch GlobalAssemblyInfo:</label></th>
  <td>
    <props:checkboxProperty name="${keys.patchGlobalAssemblyInfo}"/>
    <span class="smallNote">When checked, AssemblyInfoPatcher will attempt to patch GlobalAssemblyInfo files</span>
  </td>
</tr>

<tr class="noBorder">
  <td colspan="2">
    Updates the AssemblyVersion, AssemblyFileVersion and AssemblyInformationalVersion attributes in AssemblyInfo files under Properties folders.
    No additional attributes will be added, make sure you have all necessary attributes in the source code.
    Changed source files are reverted at the end of a build. <bs:help file="AssemblyInfo+Patcher"/>
  </td>
</tr>
