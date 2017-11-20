BS.MavenAddSettings = OO.extend(BS.AbstractWebForm, OO.extend(BS.AbstractModalDialog, OO.extend(BS.FileBrowse, {
  getContainer: function() {
    return $('addSettings');
  },

  formElement: function() {
    return $('addSettingsForm');
  },

  refresh: function() {
    BS.reload();
  }
})));

BS.MavenSettings = {
  actionsUrl: window['base_uri'] + "/admin/mavenSettingsActions.html",
  deleteSettings: function(projectExternalId, name, used, backUrl) {
    var params = {action: 'delete', project: projectExternalId, name: name };
    var warningMessage = "Are you sure you want to delete this maven settings file?";
    if (used) {
      warningMessage += " It will result in errors in configurations that use it."
    }
    if (confirm(warningMessage)) {
      BS.ajaxRequest(this.actionsUrl, {
        parameters: params,
        onComplete: function () {
          if (backUrl) {
            window.location.href = backUrl;
          } else {
            window.location.reload();
          }
        }
      });
    }
    return false;
  },

  errorDetailsVisible: false,

  toggleErrorDisplay: function() {
    if (this.errorDetailsVisible) {
      $j("#errorDetailsToggle").html("Show details...");
    } else {
      $j("#errorDetailsToggle").html("Hide");
    }
    this.errorDetailsVisible = !this.errorDetailsVisible;
    BS.Util.toggleVisible("errorDetails")
  }

};
