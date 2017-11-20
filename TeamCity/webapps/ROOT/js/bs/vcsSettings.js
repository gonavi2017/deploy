

BS.EditVcsUsername = OO.extend(BS.AbstractModalDialog, {
  getContainer: function() {
    return $('editVcsSettingsDialog');
  },

  showEditDialog: function(key, vcsUsername, title) {
    BS.Util.hide('vcsRootSelector');

    $('editVcsSettingsTitle').innerHTML = title;
    $('vcsUsername').value = vcsUsername;
    $('vcsUsernameKey').value = key;

    this.showCentered();
    this.bindCtrlEnterHandler(this.submitUsername.bind(this));

    $('vcsUsername').focus();
  },

  showAddDialog: function(defaultVcsUsername) {
    BS.Util.show('vcsRootSelector');

    $('editVcsSettingsTitle').innerHTML = "Add VCS username";
    $('vcsUsername').value = defaultVcsUsername;
    $('vcsUsernameKey').value = "";
    $("vcsRoot").onchange();

    this.showCentered();
    this.bindCtrlEnterHandler(this.submitUsername.bind(this));

    $("vcsRoot").focus();
  },

  deleteUsername: function(vcsUsernameKey) {
    if (!confirm("Are you sure you want to delete this username?")) {
      return;
    }

    var form = $('editVcsSettings');
    BS.ajaxRequest(form.action, {
      parameters: "vcsUsernameKey=" + vcsUsernameKey + "&vcsUsername=" + "&userId=" + form.userId.value,
      onComplete: function() {
        $('vcsUsernames').refresh();
      }
    });
  },

  submitUsername: function() {
    var form = $('editVcsSettings');
    BS.Util.show('savingUsername');
    Form.disable(form);
    BS.ajaxRequest(form.action, {
      parameters: BS.Util.serializeForm(form),
      onComplete: function() {
        BS.Util.hide('savingUsername');
        BS.EditVcsUsername.close();
        $('vcsUsernames').refresh();
      }
    });
    return false;
  }
});

BS.VcsUsername = {
  addVcsNameFromModification: function(modId) {
    if (confirm("Add this vcs username to your profile?")) {
      var onSuccess = function() {
        BS.reload(true);
      };
      var onFailure = function(error) {
        alert(error);
      };
      this.addVcsNameByModId(modId, null, onSuccess, onFailure);
    }
  },

  viewModificationAddVcsName: function(modId) {
    if (confirm("Add this vcs username to your profile?")) {
      var beforeRequest = function() {
        $j('#addVcsNameProgress').show();
      };
      var onSuccess = function() {
        BS.reload(true);
      };
      var onFailure = function(error) {
        $j('#addVcsNameProgress').hide();
        alert(error);
      };
      this.addVcsNameByModId(modId, beforeRequest, onSuccess, onFailure);
    }
  },

  addVcsNameByModId: function(modId, beforeRequest, onSuccess, onFailure) {
    if (beforeRequest) {
      beforeRequest();
    }
    BS.ajaxRequest(window['base_uri'] + "/ajax.html", {
      parameters: 'addVcsUsername=' + modId,
      onComplete: function(transport) {
        var errors = BS.XMLResponse.processErrors(transport.responseXML, {}, function(id, error) {
          var msg = error.firstChild.nodeValue;
          if (onFailure) {
            onFailure(msg);
          } else {
            alert(msg);
          }
        });

        if (!errors && onSuccess) {
          onSuccess();
        }
      }
    });
  }
};