BS.BuildType = {};
BS.BuildType.updateView = function () {
  BS.reload(false, function () {
    var containerId = 'buildConfigurationContainer';
    BS.Util.runWithElement(containerId, function(isElementPresent) {
      if (!isElementPresent) {
        throw new Error(containerId + ' is not found');
      } else {
        $(containerId).refresh(null, 'allTags=' + $j('#all-tags-switch').prop('checked'));
      }
    }, 5000);
  });
};
BS.BuildType.updateStatus = function (failed) {
  jQuery("#mainNavigation").children(".buildType").toggleClass("failed", failed);
  jQuery("#restNavigation").children(".buildType").toggleClass("failed", failed);
};

BS.BuildTypeResetSources = OO.extend(BS.AbstractWebForm, OO.extend(BS.AbstractModalDialog, {
  formElement: function () {
    return $('resetSources');
  },

  getContainer: function () {
    return $('resetSourcesDialog');
  },

  savingIndicator: function () {
    return $('resetSourcesProgress');
  },

  showResetSourcesDialog: function () {
    this.showCentered();
    this.bindCtrlEnterHandler(this.submitResetSources.bind(this));

    $('cleanSourcesDialogContent').refresh('cleanSourcesProgress', 'showCleanSourcesDialog=1', function() {
      BS.BuildTypeResetSources.recenterDialog();
    });
  },

  submitResetSources: function () {
    if (this.formElement().agentId.selectedIndex == -1) {
      alert('Please choose an agent.');
      return false;
    }

    var that = this;
    BS.FormSaver.save(this, this.formElement().action, OO.extend(BS.ErrorsAwareListener, {
      onCompleteSave: function (form, responseXML, err) {
        that.setSaving(false);
        that.enable();
        if (!err) {
          that.close();
          BS.reload(true);
        }
      }
    }));

    return false;
  }
}));

BS.PauseBuildTypeDialog = OO.extend(BS.AbstractWebForm, OO.extend(BS.AbstractModalDialog, {
  formElement: function () {
    return $('pauseBuildTypeForm');
  },

  getContainer: function () {
    return $('pauseBuildTypeFormDialog');
  },

  onText: "Pause",
  offText: "Activate",

  showPauseBuildTypeDialog: function (buildTypeId, pause, defaultMessage) {
    if (BS.bcActions_handle != null) {
      BS.bcActions_handle.hidePopup(0);
    }

    var text = pause ? this.onText : this.offText;

    if (pause) {
      // hide option to remove builds from queue in case of resuming
      BS.Util.show('removeFromQueue');
      BS.Util.show('lbl_removeFromQueue');
    } else {
      BS.Util.hide('removeFromQueue');
      BS.Util.hide('lbl_removeFromQueue');
    }

    this.formElement().pause.value = pause;
    this.formElement().pauseBuildType.value = buildTypeId;
    this.formElement().PauseSubmitButton.value = text;
    $('pauseBuildTypeFormTitle').innerHTML = text + ' build configuration';

    this.formElement().pauseComment.value =
    defaultMessage != null && defaultMessage.length > 0 ? defaultMessage : this.formElement().pauseComment.defaultValue;

    this.showCentered();
    this.formElement().pauseComment.focus();
    this.formElement().pauseComment.select();

    this.bindCtrlEnterHandler(this.submit.bind(this));
  },

  submit: function () {
    if (this.formElement().pauseComment.value == this.formElement().pauseComment.defaultValue) {
      this.formElement().pauseComment.value = "";
    }

    BS.Util.show('pauseProgressIcon');

    BS.FormSaver.save(this, this.formElement().action, OO.extend(BS.ErrorsAwareListener, {
      onCompleteSave: function (form, responseXML, err) {
        BS.Util.hide('pauseProgressIcon');
        BS.reload(true);
      },

      onFailure: function () {
        BS.Util.hide('pauseProgressIcon');
        alert("Problem accessing server");
      }
    }));

    return false;
  }
}));

