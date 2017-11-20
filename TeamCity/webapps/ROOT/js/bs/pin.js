BS.Pin = {
  noHover: false,
  _onBuildPage: false,

  pin: function(onBuildPage) {
    if (onBuildPage) {
      BS.Pin._onBuildPage = true;
    }
    BS.Pin.togglePin(true, 'Unpin');
  },

  unpin: function(onBuildPage) {
    if (onBuildPage) {
      BS.Pin._onBuildPage = true;
    }
    BS.Pin.togglePin(false, 'Pin');
  },

  togglePin: function(toPin, newLinkText) {
    var buildId = BS.PinBuildDialog.formElement().buildId.value;
    var link = $('pinLink' + buildId);

    BS.Util.show("progressIcon" + buildId);
    BS.Util.hide(link);

    BS.FormSaver.save(BS.PinBuildDialog, BS.PinBuildDialog.formElement().action, OO.extend(BS.ErrorsAwareListener, {

      onCompleteSave: function(form, responseXML, err) {
        $(link.parentNode).cleanWhitespace();

        BS.Util.hide("progressIcon" + buildId);
        BS.Util.show(link);

        BS.reload(true);
      },

      onFailure: function() {
        BS.Util.show(link);
        BS.Util.hide("progressIcon" + buildId);
        alert("Problem accessing server");
      }
    }));
  },

  showSuccessMessage: function(buildId, pinned) {
    var link = $('pinLink' + buildId);
    var tr = link.parentNode.parentNode.parentNode;
    $(tr).cleanWhitespace();
    if (pinned) {
      tr.addClassName('highlight');
      BS.Util.show('successMessage');
      $('successMessage').innerHTML = "Pinned build won't be removed from the history list until you unpin it.";
    }
    else {
      BS.Util.show('successMessage');
      $('successMessage').innerHTML = "The build has been unpinned.";
    }

    BS.Util.hideSuccessMessages();
  },

  installHover: function(td) {
    if (BS.Pin.noHover) return;

    $(td).cleanWhitespace();

    var buildId = td.id.substring("pinTd".length);
    var img = $('pinImg' + buildId);
    var link = $('pinLink' + buildId);
    BS.Util.hide(link);
    link.addClassName("unpinLink");

    td.on("mouseover", function() { BS.Util.show(link); });
    td.on("mouseout", function() { BS.Util.hide(link); });

    BS.Util.show(img);
  },

  uninstallHover: function(td) {
    var buildId = td.id.substring("pinTd".length);
    var img = $('pinImg' + buildId);
    var link = $('pinLink' + buildId);
    if (link.className) {
      link.removeClassName("unpinLink");
    }
    if (img.style) {
      BS.Util.hide(img);
    }
    td.stopObserving();
  }
};

BS.PinBuildDialog = OO.extend(BS.AbstractWebForm, OO.extend(BS.AbstractModalDialog, {
  formId: 'pinBuildForm',
  formElement: function() {
    return $(this.formId);
  },

  getContainer: function() {
    return $('pinBuildFormDialog');
  },

  onText: "Pin",
  offText: "Unpin",

  appendTag: function(tag) {
    BS.Util.addWordToTextArea(this.formElement().buildTagsInfo, tag);
  },

  __parseTags: function(transport) {
    var result = "";
    var root = BS.Util.documentRoot(transport);
    if (root == null) {
      return result;
    }
    var tags = root.childNodes;
    if (tags == null) {
      return result;
    }
    for (var i = 0; i < tags.length; i++) {
      var tag = tags[i].textContent;
      result += tag + " ";
    }
    return result;
  },

  showPinBuildDialog: function(buildId, pin, partOfChain, defaultMessage, availableTagsContainerId) {
    this.formElement().buildId.value = buildId;

    var pinText = pin ? this.onText : this.offText;

    this.formElement().pin.value = pin;
    this.formElement().PinSubmitButton.value = pinText;
    $('pinBuildFormTitle').innerHTML = pinText + ' build' ;

    this.formElement().pinComment.value = defaultMessage != null && defaultMessage.length > 0 ? defaultMessage : this.formElement().pinComment.defaultValue;

    this.showTags(availableTagsContainerId, partOfChain);

    this.showCentered();
    this.formElement().pinComment.focus();
    this.formElement().pinComment.select();

    this.__loadTags(buildId);

    this.bindCtrlEnterHandler(this.submit.bind(this));

    return false;
  },


  __loadTags: function(buildId) {
    var that = this;
    that.formElement().PinSubmitButton.disable();
    var saving = $j('#pinBuildDialogSaving');
    var oldTitle = saving.prop('title');
    saving.prop('title', 'Loading tags...');
    saving.show();
    BS.ajaxRequest(window['base_uri'] + "/ajax.html", {
      parameters: "buildTagsBuildId=" + buildId,
      onComplete: function(transport) {
        if ($j(that.formElement().buildTagsInfo).is(':visible')) {//don't fill tags in closed dialog
          that.formElement().buildTagsInfo.value = that.__parseTags(transport);
        }
        that.formElement().PinSubmitButton.enable();
        saving.prop('title', oldTitle);
        saving.hide();
      }
    });
  },


  submit: function() {
    var onBuildPage = this.formElement().onBuildPage.value == 'true';

    if (this.formElement().pinComment.value == this.formElement().pinComment.defaultValue) {
      this.formElement().pinComment.value = "";
    }

    var pin = this.formElement().pin.value == 'true';

    if (pin) {
      BS.Pin.pin(onBuildPage);
    } else {
      BS.Pin.unpin(onBuildPage);
    }

    this.formElement().buildTagsInfo.value = '';
    return false;
  },

  close: function() {
    this.formElement().buildTagsInfo.value = '';
    this.doClose();
  }
}));
BS.TagsEditingMixin.init(BS.PinBuildDialog);
