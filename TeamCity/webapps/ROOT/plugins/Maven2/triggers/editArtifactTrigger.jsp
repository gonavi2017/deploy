<%@ include file="/include.jsp" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ include file="../mavenConsts.jsp"%>
<jsp:useBean id="propertiesBean" type="jetbrains.buildServer.controllers.BasePropertiesBean" scope="request"/>

<tr>
  <td colspan="2">
    <em>Maven Artifact Dependency Trigger will add a build to the queue when the content of the specified Maven artifact changes.</em><bs:help file="Configuring+Maven+Triggers" anchor="MavenArtifactDependencyTrigger"/>
  </td>
</tr>
<tr>
  <td><label for="groupId">Group ID: <l:star/></label></td>
  <td>
    <props:textProperty name="groupId" style="width:20em;"/>
    <span class="error" id="error_groupId"></span>
  </td>
</tr>
<tr>
  <td>
    <label for="artifactId">Artifact ID: <l:star/></label>
  </td>
  <td>
    <props:textProperty name="artifactId" style="width:20em;"/>
    <span class="error" id="error_artifactId"></span>
  </td>
</tr>
<tr>
  <td><label for="version">Version or version range: <l:star/></label></td>
  <td>
    <props:textProperty name="version" style="width:20em;"/>
    <span class="error" id="error_version"></span>
  </td>
</tr>
<tr>
  <td><label for="type">Type: <l:star/></label></td>
  <td>
    <props:textProperty name="type" style="width:10em;"/>
    <span class="error" id="error_type"></span>
  </td>
</tr>
<tr>
  <td><label for="classifier">Classifier: </label></td>
  <td><props:textProperty name="classifier" style="width:10em;"/></td>
</tr>
<tr>
  <td><label for="repoUrl">Maven repository URL:</label></td>
  <td><props:textProperty name="repoUrl" style="width:20em;"/>
    <span class="error" id="error_repoUrl"></span>

    <props:hiddenProperty name="artifactSignature"/>
  </td>
</tr>
<tr class="advancedSetting">
  <td><label for="repoUrl">Maven repository ID:</label></td>
  <td><props:textProperty name="repoId" style="width:20em;"/>
    <span class="error" id="error_repoId"></span>
  </td>
</tr>
<tr class="advancedSetting">
  <td><label for="${USER_SETTINGS_SELECTION}">User settings selection:</label></td>
  <td>
    <props:selectProperty name="${USER_SETTINGS_SELECTION}" onchange="toggleUserSettingsPath(); return true;" enableFilter="true" style="width: 20em;">
      <c:set var="currentSettingsItem" value="${propertiesBean.properties[USER_SETTINGS_SELECTION]}" scope="request"/>
      <jsp:include page="/plugins/Maven2/settingsList.html"/>
    </props:selectProperty>
    <span class="error" id="error_${USER_SETTINGS_SELECTION}"></span>
    <span class="smallNote" style="width: 20em;">Select one of the predefined settings files or provide a custom path. By default, the standard Maven settings file location is used.</span>
    <span><authz:authorize allPermissions="CHANGE_SERVER_SETTINGS" ><a href="<c:url value='/admin/editProject.html?projectId=${buildForm.project.externalId}&tab=mavenSettings'/>">Manage settings files</a></authz:authorize></span>
  </td>
</tr>
<tr id="${USER_SETTINGS_PATH}_section dependent" class="advancedSetting dependent selectPath">
  <td><label for="${USER_SETTINGS_PATH}">Custom path:</label></td>
  <td>
    <props:textProperty name="${USER_SETTINGS_PATH}" style="width:20em;"/>
    <span class="error" id="error_${USER_SETTINGS_PATH}"></span>
    <span class="smallNote">The path to a user settings file.</span>
  </td>
</tr>
<tr>
  <td colspan="2">
    <props:checkboxProperty name="skipIfRunning"/><label for="skipIfRunning">Do not trigger a build if currently running builds can produce this artifact </label>
  </td>
</tr>
<script type="text/javascript">
  toggleUserSettingsPath = function () {
    var modeClassMap = {};
    modeClassMap["${USER_SETTINGS_SELECTION_BY_PATH}"] = "selectPath";
    modeClassMap["${USER_SETTINGS_SELECTION_DEFAULT}"] = "selectDefault";
    BS.Util.toggleDependentElements($$('select[id="userSettingsSelection"]')[0].value, 'dependent', false, modeClassMap);
    BS.MultilineProperties.updateVisible();
  };
  toggleUserSettingsPath();
</script>
