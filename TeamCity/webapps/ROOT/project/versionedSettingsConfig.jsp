<%@include file="/include-internal.jsp" %>
<jsp:useBean id="currentProject" type="jetbrains.buildServer.serverSide.SProject" scope="request"/>
<jsp:useBean id="settingsBean" type="jetbrains.buildServer.controllers.project.VersionedSettingsBean" scope="request"/>
<c:set var="configuredVcsRoot" value="${settingsBean.configuredVcsRoot}"/>
<c:set var="enabled" value="${settingsBean.enabledGlobally and not settingsBean.containsConvertedFiles}"/>
<c:set var="syncMode" value="${settingsBean.synchronizationMode}"/>
<c:set var="useCredentialsStorage" value="${settingsBean.useCredentialsStorage}"/>
<bs:linkScript>
  /js/bs/versionedSettings.js
</bs:linkScript>
<style type="text/css">
  ul#dirNameList {
    list-style-type: none;
  }

  div#nonEmptyDirConfirmDialog {
    width: 45em;
  }

  div.commitProjectSettingsWrapper {
    margin-top: 1em;
    margin-left: 0.5em;
  }

  span#error_settingsVcsRootId {
    margin-left: 0px;
  }

  .selectRootLabel {
    vertical-align: top;
  }

  a#downloadSample {
    margin-left: 1em;
  }

  ul#dirNameList {
    max-height: 30em;
    overflow-y: auto;
  }

  div#loadSettingsConfirmDialog {
    width: 45em;
  }

  ul#projectList {
    max-height: 30em;
    overflow-y: auto;
    max-width: 40em;
    white-space: nowrap;
  }

  div.disabledSettingsNote {
    margin-top: 1em;
  }
</style>

<script type="text/javascript">
  BS.NonEmptyDirConfirm = OO.extend(BS.AbstractWebForm, OO.extend(BS.AbstractModalDialog, {
    formElement: function() {
      return $('nonEmptyDirConfirm');
    },

    getContainer: function() {
      return $('nonEmptyDirConfirmDialog');
    },

    show: function(dirNames) {
      $j('#dirNameList').empty();
      for (var i = 0; i < dirNames.length; i++) {
        $j('#dirNameList').append('<li>' + dirNames[i] + '</li>');
      }
      this.showCentered();
    },

    submit: function(confirmDecision) {
      $j('#confirmation').val(confirmDecision);
      BS.VersionedSettingsForm.applySettings(true);
      this.doClose();
    },

    close: function() {
      $j('#versionedSettingsTabs').get(0).refresh();
      this.doClose();
    }
  }));


  BS.LoadSettingsConfirm = OO.extend(BS.AbstractWebForm, OO.extend(BS.AbstractModalDialog, {
    formElement: function() {
      return $('loadSettingsConfirm');
    },

    getContainer: function() {
      return $('loadSettingsConfirmDialog');
    },

    show: function() {
      this.showCentered();
    },

    submit: function() {
      BS.Util.disableFormTemp(this.formElement());
      BS.VersionedSettingsForm.disableAll();
      $j('#loadSaving').show();
      BS.ajaxRequest('<c:url value="/admin/versionedSettingsActions.html"/>', {
        parameters: Object.toQueryString({action: 'loadProjectSettings', projectId: '${currentProject.externalId}'}),
        onComplete: function(transport) {
          BS.LoadSettingsConfirm.close();
          $j('#versionedSettingsTabs').get(0).refresh();
        }
      });
    }
  }));

  BS.VersionedSettingsForm = OO.extend(BS.AbstractWebForm, {
    formElement: function() {
      return $('versionedSettingsConfigForm');
    },

    applySettings: function (confirmed) {
      var msg = this.getConfirmation();
      if (confirmed || !msg || confirm(msg)) {
        $j('#versionedSettingSavings').show();
        BS.FormSaver.save(this, this.formElement().action, OO.extend(BS.ErrorsAwareListener, {
          vcsRootNotSpecified: function(elem) {
            $j('#versionedSettingSavings').hide();
            $('error_settingsVcsRootId').innerHTML = elem.firstChild.nodeValue;
          },
          versionedSettingsGloballyDisabled: function (elem) {
            $j('#versionedSettingSavings').hide();
            alert(elem.firstChild.nodeValue);
          },
          onSuccessfulSave: function (responseXML) {
            $j('#versionedSettingSavings').hide();
            var confirmation = responseXML.getElementsByTagName('confirmOverrideVcs')[0];
            if (confirmation) {
              var dirs = confirmation.getElementsByTagName('dir');
              var dirNames = [];
              for (var i = 0; i < dirs.length; i ++) {
                dirNames.push(dirs[i].getAttribute('project'));
              }
              BS.NonEmptyDirConfirm.show(dirNames);
            } else {
              $j('#versionedSettingsTabs').get(0).refresh();
            }
          }
        }));
      }

      return false;
    },

    getConfirmation: function() {
      //don't show confirmation if:
      //- VCS root is not selected: server will not allow to save such settings
      //- syncMode is not 'enabled': no confirm required for 'disabled' and
      //- syncMode was already 'enabled'
      //  disabling editing via UI when 'same as parent' is selected most likely won't surprise
      var root = $j("#settingsVcsRootId").val();
      var syncMode = $j("[name=synchronizationMode]:checked").val();
      var useCreStorage = $j("[name=useCredentialsStorage]:checked").val();
      var format = $j("#settingsFormat").val();//undefined if no custom formats found
      if (root == '' || syncMode != 'enabled' || ('enabled' == '${syncMode}' && useCreStorage == ${useCredentialsStorage}) || ${not settingsBean.enabledGlobally}) {
        return null;
      }

      var result = !useCreStorage ? 'Passwords from VCS roots, build configurations, templates, and projects will be scrambled and committed to VCS. ' : '';
      if (format && format != 'xml') {
        result += 'The selected settings format disables editing via UI. ';
      }

      if (result) {
        result += 'Do you want to continue?';
      }
      return result;
    },

    hideCommitAndLoadProjectSettings: function() {
      $j('#commitProjectSettings').hide();
      $j('#loadProjectSettings').hide();
    },

    disableAll: function() {
      this.disable();
      $j('#commitProjectSettings').attr("disabled", "disabled");
      $j('#loadProjectSettings').attr("disabled", "disabled");
    },

    commitProjectSettings: function(element) {
      if ($j(element).attr("disabled") == "disabled") {
        return false;
      }
      if (confirm("Commit current settings of this project and all sub projects with the same versioned settings configuration in VCS?")) {
        this.disableAll();
        $j('#commitSaving').show();
        BS.ajaxRequest('<c:url value="/admin/versionedSettingsActions.html"/>', {
          parameters: Object.toQueryString({action: 'commitProjectSettings', projectId: '${currentProject.externalId}'}),
          onComplete: function(transport) {
            $j('#versionedSettingsTabs').get(0).refresh();
          }
        });
      }
      return false;
    },

    loadProjectSettings: function(element) {
      if ($j(element).attr("disabled") == "disabled") {
        return false;
      }
      BS.LoadSettingsConfirm.show();
      return false;
    },

    changeSynchMode: function(syncMode) {
      if (syncMode == 'default') {
        $j('#versionedSettingsEnabledSection').hide();
        $j('#editSettingsRoot').hide();
        this.hideCommitAndLoadProjectSettings();
      } else if (syncMode == 'disabled') {
        $j('#versionedSettingsEnabledSection').hide();
        $j('#editSettingsRoot').hide();
        this.hideCommitAndLoadProjectSettings();
      } else if (syncMode == 'enabled') {
        $j('#versionedSettingsEnabledSection').show();
        this.hideCommitAndLoadProjectSettings();
      } else {
        console.error('Unknown sync mode', syncMode);
      }
    },

    partiallyDisable: function() {
      //disable all fields except the option disabling versioned settings,
      //so they can always be disabled and a 'secure storage' option to allow
      //changing it before enabling the versioned settings globally
      $j('#useParentSettings').prop('disabled', 'disabled');
      $j('#enabled').prop('disabled', 'disabled');
      $j('#settingsVcsRootId').prop('disabled', 'disabled');
      $j('#buildSettingsModeAlwaysCurrent').prop('disabled', 'disabled');
      $j('#buildSettingsModePreferCurrent').prop('disabled', 'disabled');
      $j('#buildSettingsModePreferVcs').prop('disabled', 'disabled');
      $j('#showSettingsChanges').prop('disabled', 'disabled');
      $j('#settingsFormat').prop('disabled', 'disabled');
    },

    versionedSettingsRootChanged: function() {
      <c:if test="${not empty configuredVcsRoot}">
      this.hideCommitAndLoadProjectSettings();
      if ('${configuredVcsRoot.externalId}' == $j('#settingsVcsRootId').val()) {
        $j('#editSettingsRoot').show();
      } else {
        $j('#editSettingsRoot').hide();
      }
      </c:if>
    }
  });

  <c:choose>
    <c:when test="${not afn:permissionGrantedForProject(currentProject, 'EDIT_PROJECT')}">
      $j(document).ready(function() {
        BS.VersionedSettingsForm.disable();
      });
    </c:when>
    <c:when test="${not enabled and syncMode != 'enabled'}">
      <%-- versioned settings are not enabled in the project - don't allow to change anything --%>
      $j(document).ready(function() {
        BS.VersionedSettingsForm.disable();
      });
    </c:when>
    <c:when test="${not enabled and syncMode == 'enabled'}">
      $j(document).ready(function() {
        BS.VersionedSettingsForm.partiallyDisable();
      });
    </c:when>
  </c:choose>
</script>
<c:set var="pageTitle" value="Versioned Settings"/>
<c:set var="suitableVcses" value="${settingsBean.versionedSettingsSuitableVcses}"/>
<c:set var="suitableRoots" value="${settingsBean.versionedSettingsSuitableVcsRoots}"/>
<c:set var="effectiveParentSettings" value="${settingsBean.effectiveParentSettings}"/>
<c:set var="supportedVcses"><c:forEach items="${suitableVcses}" var="vcs" varStatus="pos"><strong><c:out value="${vcs.core.displayName}"/></strong><c:if test="${not pos.last}">, </c:if></c:forEach></c:set>

<div class="grayNote" style="margin-top: 1em;">
  On this page you can enable synchronization of the current project settings with the version control:
  if the project settings are changed, the affected configuration files will be checked in to the version control;
  if the configuration files are changed in the version control, the changes will be applied to the project.
  Note that the passwords which are configured in the project and subprojects (e.g. in project's VCS roots) are stored in the configuration files and can be exposed this way.
  <bs:help file="Storing+Project+Settings+in+Version+Control"/><br/>
  <c:if test="${not empty suitableVcses}">
    Supported version control systems: ${supportedVcses}.
  </c:if>
</div>

<bs:unprocessedMessages/>

<c:set var="canEdit" value="${afn:permissionGrantedForProject(currentProject, 'EDIT_VERSIONED_SETTINGS')}"/>
<c:if test="${not enabled}">
  <div class="disabledSettingsNote">
    <c:choose>
      <c:when test="${not settingsBean.enabledGlobally}">
        <span class="icon icon16 yellowTriangle"></span>Versioned settings are globally disabled on the server, contact your system administrator for details
      </c:when>
      <c:when test="${settingsBean.containsConvertedFiles}">
        <c:set var="inheritedSettings" value="${settingsBean.synchronizationMode == 'default' and not empty effectiveParentSettings}"/>
        <span class="icon icon16 yellowTriangle"></span>Versioned settings are disabled in this project because its settings files were modified during TeamCity upgrade.
        <c:choose>
          <c:when test="${settingsBean.usesDefaultFormat}">
            <c:choose>
              <c:when test="${inheritedSettings}">
                Enable versioned settings in the <admin:projectName project="${effectiveParentSettings.project}" addToUrl="&tab=versionedSettings"/>
                project to commit updated configs to VCS.
              </c:when>
              <c:otherwise>
                Enable versioned settings to commit updated configs to VCS.
              </c:otherwise>
            </c:choose>
          </c:when>
          <c:otherwise>
            <c:choose>
              <c:when test="${inheritedSettings}">
                To avoid <b>possible data loss</b>, update your DSL according to <bs:helpLink file="Upgrading+DSL" anchor="dsl20171">Upgrade Notes</bs:helpLink> and then enable versioned settings in the
                <admin:projectName project="${effectiveParentSettings.project}" addToUrl="&tab=versionedSettings"/> project.
              </c:when>
              <c:otherwise>
                To avoid <b>possible data loss</b>, update your DSL according to <bs:helpLink file="Upgrading+DSL" anchor="dsl20171">Upgrade Notes</bs:helpLink> and then enable versioned settings.
              </c:otherwise>
            </c:choose>
          </c:otherwise>
        </c:choose>
        <c:if test="${canEdit and not inheritedSettings}">
          <input type="button" class="btn btn_mini" value="Enable" title="Enable versioned settings" onclick="BS.VersionedSettings.enableProjectVersionedSettings('${currentProject.externalId}', '#enablingProjectVersionedSettingsInForm')"/>
          <forms:saving id="enablingProjectVersionedSettings" style="float: none; margin-left: 0.5em;"/>
        </c:if>
      </c:when>
    </c:choose>
  </div>
</c:if>

<div class="parentProjectNote">
<c:if test="${settingsBean.synchronizationMode == 'default'}">
  <c:if test="${empty effectiveParentSettings and not currentProject.rootProject}">Synchronization is not enabled in any of the parent projects.</c:if>
  <c:if test="${not empty effectiveParentSettings}">
    Synchronization is enabled in <admin:projectName project="${effectiveParentSettings.project}" addToUrl="&tab=versionedSettings"><c:out value="${effectiveParentSettings.project.fullName}"/></admin:projectName> project.
    <c:if test="${effectiveParentSettings.showSettingsChanges}">
      Settings changes are shown in builds.
    </c:if>
    <c:if test="${not effectiveParentSettings.showSettingsChanges}">
      Settings changes are not shown in builds.
    </c:if>
  </c:if>
</c:if>
</div>

<c:set var="readOnlyProject" value="${currentProject.readOnly}"/>
<c:set var="formTitle">
  <c:choose>
    <c:when test="${not settingsBean.enabledGlobally}">Versioned settings are globally disabled on the server</c:when>
    <c:when test="${settingsBean.containsConvertedFiles}">Versioned settings are disabled because project configs were converted on the server</c:when>
    <c:otherwise></c:otherwise>
  </c:choose>
</c:set>

<form id="versionedSettingsConfigForm" action="<c:url value='/admin/versionedSettings.html'/>" method="post" onsubmit="return BS.VersionedSettingsForm.applySettings()"
      title="${not settingsBean.enabledGlobally ? 'Versioned settings are globally disabled on the server' : ''}">
  <table class="synchronizationMode">
    <c:if test="${not currentProject.rootProject}">
    <tr>
      <td><forms:radioButton disabled="${not canEdit or (readOnlyProject and syncMode != 'default')}" name="synchronizationMode" id="useParentSettings" value="default" checked="${syncMode == 'default'}" onclick="BS.VersionedSettingsForm.changeSynchMode('default');"/>
        <label for="useParentSettings">Use settings from a parent project</label></td>
    </tr>
    </c:if>
    <tr>
      <td><forms:radioButton disabled="${not canEdit}" name="synchronizationMode" id="disabled" value="disabled" checked="${syncMode == 'disabled'}" onclick="BS.VersionedSettingsForm.changeSynchMode('disabled');"/>
        <label for="disabled">Synchronization disabled</label></td>
    </tr>
    <tr>
      <td>
        <forms:radioButton disabled="${not canEdit or (readOnlyProject and syncMode != 'enabled')}" name="synchronizationMode" id="enabled" value="enabled" checked="${syncMode == 'enabled'}" onclick="BS.VersionedSettingsForm.changeSynchMode('enabled');"/>
        <label for="enabled">Synchronization enabled</label>
      </td>
    </tr>
    <tr id="versionedSettingsEnabledSection" style="display: ${syncMode == 'enabled' ? '' : 'none'};">
      <td>
        <table>
          <tr>
            <td class="selectRootLabel">
              <label for="settingsVcsRootId">Project settings VCS root:</label>
            </td>
            <td>
              <forms:select name="settingsVcsRootId" enableFilter="true" onchange="BS.VersionedSettingsForm.versionedSettingsRootChanged();" disabled="${not canEdit or readOnlyProject}">
                <forms:option value="">-- Choose VCS root (${supportedVcses} only) --</forms:option>
                <c:set var="prevProjId" value=""/>
                <c:forEach items="${suitableRoots}" var="vcsRoot">
                  <c:set var="createGroup">
                    ${vcsRoot.scope.ownerProjectId != prevProjId}
                  </c:set>
                  <c:if test="${createGroup}">
                    <optgroup value="" label="-- <c:out value="${vcsRoot.project.fullName}"/> project VCS roots --">
                    <c:set var="prevProjId" value="${vcsRoot.scope.ownerProjectId}"/>
                  </c:if>
                  <forms:option value="${vcsRoot.externalId}" className="user-depth-2" selected="${not empty configuredVcsRoot and configuredVcsRoot.externalId == vcsRoot.externalId}"><c:out value="${vcsRoot.name}"/></forms:option>
                  <c:if test="${createGroup}">
                    </optgroup>
                  </c:if>
                </c:forEach>
              </forms:select>
              <c:if test="${not empty configuredVcsRoot and afn:canEditVcsRoot(configuredVcsRoot)}">
                <span id="editSettingsRoot" style="margin-left: 1em;">
                  <admin:editVcsRootLink vcsRoot="${configuredVcsRoot}" editingScope="none" cameFromUrl="${pageUrl}">Edit VCS root</admin:editVcsRootLink>
                </span>
              </c:if>
              <span class="error" id="error_settingsVcsRootId"></span>
            </td>
          </tr>

          <tr class="advancedSetting">
            <td colspan="2">
              <label for="buildSettingsMode">When build starts:<bs:help file="Storing+Project+Settings+in+Version+Control" anchor="buildSettingsMode"/></label>
            </td>
          </tr>
          <tr class="advancedSetting">
            <td colspan="2" style="padding-left: 2em; padding-top: 0;">
              <forms:radioButton disabled="${not canEdit or readOnlyProject}" name="buildSettingsMode" id="buildSettingsModeAlwaysCurrent" value="${settingsBean.alwaysUseCurrentModeName}" checked="${settingsBean.buildSettingsMode == settingsBean.alwaysUseCurrentModeName}"/>
              <label for="buildSettingsModeAlwaysCurrent">always use current settings</label>
              <div class="grayNote" style="padding-left: 1.5em;">
                Builds use current project settings from the TeamCity server. Settings changes in branches, history and personal builds are ignored.
              </div>
            </td>
          </tr>
          <tr class="advancedSetting">
            <td colspan="2" style="padding-left: 2em; padding-top: 0;">
              <forms:radioButton disabled="${not canEdit or readOnlyProject}" name="buildSettingsMode" id="buildSettingsModePreferCurrent" value="${settingsBean.preferCurrentModeName}"
                                 checked="${settingsBean.buildSettingsMode == settingsBean.preferCurrentModeName}" className="${settingsBean.preferCurrentModeName ? 'valueChanged' : ''}"/>
              <label for="buildSettingsModePreferCurrent">use current settings by default</label>
              <div class="grayNote" style="padding-left: 1.5em;">
                Builds use current project settings from the TeamCity server. Users can run a build with settings from VCS via the run custom build dialog.
              </div>
            </td>
          </tr>
          <tr class="advancedSetting">
            <td colspan="2" style="padding-left: 2em; padding-top: 0;">
              <forms:radioButton disabled="${not canEdit or readOnlyProject}" name="buildSettingsMode" id="buildSettingsModePreferVcs" value="${settingsBean.preferVcsModeName}"
                                 checked="${settingsBean.buildSettingsMode == settingsBean.preferVcsModeName}" className="${settingsBean.preferVcsModeName ? 'valueChanged' : ''}"/>
              <label for="buildSettingsModePreferVcs">use settings from VCS</label>
              <div class="grayNote" style="padding-left: 1.5em;">
                Builds in branches and history builds use settings from VCS. Note that users can change settings in <b>personal</b> builds from IDE.
              </div>
            </td>
          </tr>

          <tr id="showSettingsChangesRow" class="advancedSetting">
            <td colspan="2">
              <forms:checkbox name="showSettingsChanges" id="showSettingsChanges" value="true" checked="${settingsBean.showSettingsChanges}" disabled="${not canEdit or readOnlyProject}" className="${settingsBean.showSettingsChanges ? 'valueChanged' : ''}"/>
              <label for="showSettingsChanges">Show settings changes in builds</label>
            </td>
          </tr>

          <tr id="credentialsStorageRow" class="advancedSetting">
            <td colspan="2">
              <forms:checkbox name="useCredentialsStorage" id="useCredentialsStorage" value="true" checked="${settingsBean.useCredentialsStorage}" disabled="${not canEdit or readOnlyProject}" className="${settingsBean.useCredentialsStorage ? 'valueChanged' : ''}"/>
              <label for="useCredentialsStorage">Store secure values (like passwords or API tokens) outside of VCS</label>
            </td>
          </tr>

          <c:set var="availableFormats" value="${settingsBean.availableSettingsFormats}"/>
          <c:set var="currentFormat" value="${settingsBean.settingsFormat}"/>
          <c:if test="${fn:length(availableFormats) > 1}">
            <tr class="advancedSetting">
              <td>
                <label for="settingsFormat">Settings format:</label>
              </td>
              <td>
                <forms:select name="settingsFormat" enableFilter="true" disabled="${not canEdit or readOnlyProject}" className="${currentFormat ne 'xml' ? 'valueChanged' : ''}">
                  <c:forEach var="format" items="${availableFormats}">
                    <forms:option value="${format.id}" selected="${format.id == currentFormat}"><c:out value="${format.name}"/></forms:option>
                  </c:forEach>
                </forms:select>
              </td>
            </tr>
          </c:if>
        </table>
      </td>
    </tr>

    <c:if test="${canEdit}">
    <tr id="versionedSettingSaveRow">
      <td>
        <c:if test="${syncMode == 'enabled'}"><admin:showHideAdvancedOpts containerId="versionedSettingsEnabledSection" optsKey="versionedSettings"/></c:if>

        <forms:submit label="Apply"/>
        <forms:saving id="versionedSettingSavings" style="float: none;"/>
        <input type="hidden" name="projectId" value="${currentProject.externalId}"/>
      </td>
    </tr>
    </c:if>
  </table>
  <input type="hidden" id="confirmation" name="confirmation" value=""/>
</form>

<c:import url="/versionedSettingsStatus.html?projectId=${currentProject.externalId}"/>

<c:if test="${canEdit and settingsBean.syncEnabled}">
<div class="commitProjectSettingsWrapper">
  <forms:button id="commitProjectSettings" onclick="return BS.VersionedSettingsForm.commitProjectSettings(this)" disabled="${not enabled}"
                title="${not settingsBean.enabledGlobally ? 'Versioned settings are globally disabled on the server' : 'Commit current TeamCity server settings of this project and all its children which use same versioned settings configuration'}">
    Commit current project settings&hellip;
  </forms:button>
  <forms:button id="loadProjectSettings" onclick="return BS.VersionedSettingsForm.loadProjectSettings(this)" disabled="${not enabled}"
                title="${not settingsBean.enabledGlobally ? 'Versioned settings are globally disabled on the server' : 'Load settings of this project and all its children from VCS'}">
    Load project settings from VCS&hellip;
  </forms:button>
  <forms:saving id="commitSaving" style="float: none;"/>
</div>
</c:if>

<bs:modalDialog formId="nonEmptyDirConfirm" title="Existing Project Settings Detected"
                action="" closeCommand="BS.NonEmptyDirConfirm.close()" saveCommand="BS.NonEmptyDirConfirm.submit();">
  <div id="confirmMessage">
    The settings of the following projects were found in the VCS:
    <ul id="dirNameList">
    </ul>
    How do you want to proceed?
  </div>

  <div style="text-align: center; margin-top: 1em;">
    <forms:submit type="button" label="Overwrite settings in VCS" onclick="BS.NonEmptyDirConfirm.submit('override');"/>
    <forms:submit type="button" label="Import settings from VCS" onclick="BS.NonEmptyDirConfirm.submit('import');"/>
    <forms:cancel onclick="BS.NonEmptyDirConfirm.close();"/>
  </div>
</bs:modalDialog>

<bs:modalDialog formId="loadSettingsConfirm" title="Load settings from VCS"
                action="" closeCommand="BS.LoadSettingsConfirm.close()" saveCommand="BS.LoadSettingsConfirm.submit();">
  <c:set var="projectsInRoot" value="${settingsBean.allProjectsInRoot}"/>
  <c:set var="projectsInRootCount" value="${fn:length(settingsBean.allProjectsInRoot)}"/>
  <div>
    ${projectsInRootCount} <bs:plural txt="project" val="${projectsInRootCount}"/> use this VCS root to store settings:

    <ul id="projectList">
      <c:forEach items="${settingsBean.allProjectsInRoot}" var="p">
        <li><admin:projectName project="${p}" addToUrl="&tab=versionedSettings"><c:out value="${p.fullName}"/></admin:projectName></li>
      </c:forEach>
    </ul>

    Do you want to load ${projectsInRootCount > 1 ? "their" : "its"} settings from VCS?
  </div>

  <div style="text-align: center; margin-top: 1em;">
    <forms:cancel onclick="BS.LoadSettingsConfirm.close();"/>
    <forms:submit type="button" label="Load settings from VCS" onclick="BS.LoadSettingsConfirm.submit();"/>
    <forms:saving id="loadSaving" style="float: none;"/>
  </div>
</bs:modalDialog>