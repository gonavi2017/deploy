<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz"%>
<%@include file="mavenConsts.jsp"%>

<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<jsp:useBean id="buildForm" type="jetbrains.buildServer.controllers.admin.projects.EditableBuildTypeSettingsForm" scope="request"/>
<tr>
  <th><label for="goals">Goals:</label></th>
  <td>
    <props:textProperty name="goals" className="longField"/>
    <span class="error" id="error_goals"></span>
    <span class="smallNote">Space-separated goals to execute.</span></td>
</tr>

<tr>
  <th><label for="pomLocation">Path to POM file:</label></th>
  <td>
    <props:textProperty name="pomLocation" className="longField"/>
    <bs:vcsTree fieldId="pomLocation"/>
    <span class="smallNote">The specified path should be relative to the checkout directory.</span>
  </td>
</tr>

<tr class="advancedSetting">
  <th><label for="runnerArgs">Additional Maven command line parameters:</label></th>
  <td><props:textProperty name="runnerArgs" className="longField" expandable="true"/>
</tr>

<props:workingDirectory />

<jsp:include page="/tools/editToolUsage.html?toolType=${TOOL_TYPE_NAME}&versionParameterName=${TOOL_SELECTION_PARAM}&class=longField"/>

<l:settingsGroup title="User Settings" className="advancedSetting">
<tr class="advancedSetting">
  <th><label for="${USER_SETTINGS_SELECTION}">User settings selection:</label></th>
  <td>
    <props:selectProperty name="${USER_SETTINGS_SELECTION}" onchange="syncUserSettingsControlState(); return true;" enableFilter="true" className="mediumField">
      <c:set var="currentSettingsItem" value="${propertiesBean.properties[USER_SETTINGS_SELECTION]}" scope="request"/>
      <jsp:include page="/plugins/Maven2/settingsList.html"/>
    </props:selectProperty>
    <span class="error" id="error_${USER_SETTINGS_SELECTION}"></span>
    <span class="smallNote">Select one of the predefined settings files or provide a custom path. By default, the standard Maven settings file location is used.</span>
    <span><authz:authorize allPermissions="CHANGE_SERVER_SETTINGS" ><a href="<c:url value='/admin/editProject.html?projectId=${buildForm.project.externalId}&tab=mavenSettings'/>">Manage settings files</a></authz:authorize></span>
  </td>
</tr>
<tr id="${USER_SETTINGS_PATH}_section" class="advancedSetting">
  <th><label for="${USER_SETTINGS_PATH}">Custom path:</label></th>
  <td>
    <props:textProperty name="${USER_SETTINGS_PATH}" className="longField"/>
    <span class="error" id="error_${USER_SETTINGS_PATH}"></span>
    <span class="smallNote">The path to a user settings file.</span>
  </td>
</tr>
</l:settingsGroup>

<props:javaSettings/>

<l:settingsGroup title="Local Artifact Repository Settings" className="advancedSetting">
  <tr class="advancedSetting">
    <th><label for="${USE_OWN_LOCAL_REPO}">Use own local artifact repository:</label></th>
    <td>
      <props:checkboxProperty name="${USE_OWN_LOCAL_REPO}"/><label for="${USE_OWN_LOCAL_REPO}">Use own local repository for this build configuration</label>
    </td>
  </tr>
</l:settingsGroup>

<l:settingsGroup title="Incremental Building" className="advancedSetting">
  <tr class="advancedSetting">
    <th><label for="${IS_INCREMENTAL}">Enable incremental building:</label></th>
    <td>
      <props:checkboxProperty name="${IS_INCREMENTAL}"/><label for="${IS_INCREMENTAL}">Build only modules affected by changes</label>
    </td>
  </tr>
</l:settingsGroup>

<script type="text/javascript">
  window.syncUserSettingsControlState = function() {
    if($("${USER_SETTINGS_SELECTION_BY_PATH}").selected) {
      BS.Util.show("${USER_SETTINGS_PATH}_section");
    }
    else {
      BS.Util.hide("${USER_SETTINGS_PATH}_section");
    }

    BS.MultilineProperties.updateVisible();
  };

  window.syncControlState = function() {
    syncUserSettingsControlState();
  };

  window.syncControlState();


  $j("#maven\\.path ~ span.smallNote").append("<br>For Auto, the path is taken from the M2_HOME environment variable, otherwise the default Maven version will be used.");
</script>
