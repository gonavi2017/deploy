BS.VersionedSettings = {
  url: window['base_uri'] + "/admin/versionedSettingsActions.html",

  enableProjectVersionedSettings: function(projectExtId, optionalProgressSelector) {
    if (!confirm('With enabled versioned settings TeamCity will apply your DSL to the configs on the server. Continue?'))
      return;
    if (optionalProgressSelector) {
      $j(optionalProgressSelector).show();
    }
    BS.ajaxRequest(BS.VersionedSettings.url, {
      parameters: Object.toQueryString({action: 'enableProjectVersionedSettings', projectId: projectExtId}),
      onComplete: function(transport) {
        BS.reload();
      }
    });
  },


  enableXmlVersionedSetting: function(optionalProgressSelector) {
    if (!confirm('Enabling versioned settings will commit configs to VCS, do you want to continue?'))
      return;
    if (optionalProgressSelector) {
      $j(optionalProgressSelector).show();
    }
    BS.ajaxRequest(BS.VersionedSettings.url, {
      parameters: Object.toQueryString({action: 'enableXmlVersionedSettings'}),
      onComplete: function(transport) {
        BS.reload();
      }
    });
  },


  checkForChanges: function(projectExtId) {
    BS.ajaxRequest(BS.VersionedSettings.url, {
      parameters: Object.toQueryString({action: 'checkForChanges', projectId: projectExtId}),
      onComplete: function(transport) {
        var tabs = $j('#versionedSettingsTabs');
        if (tabs && tabs.get(0)) {
          tabs.get(0).refresh();
        }
      }
    });
  }
};
