BS.BuildCommentDialog = OO.extend(BS.AbstractWebForm, OO.extend(BS.AbstractModalDialog, {
  formElement: function() {
    return $('buildCommentForm');
  },

  getContainer: function() {
    return $('buildCommentFormDialog');
  },

  showBuildCommentDialog: function(promotionId, defaultMessage) {
    this.formElement().promotionId.value = promotionId;

    var messageIsValid = defaultMessage != null && defaultMessage.length > 0;
    this.formElement().buildComment.value = messageIsValid ? defaultMessage : this.formElement().buildComment.defaultValue;
    $('buildCommentFormTitle').innerHTML = messageIsValid ? "Change build comment" : "Add build comment";

    this.showAtFixed($(this.getContainer()));

    $(this.formElement().buildComment).activate();

    this.bindCtrlEnterHandler(this.submit.bind(this));
  },

  submit: function() {
    if (this.formElement().buildComment.value == this.formElement().buildComment.defaultValue) {
      this.formElement().buildComment.value = "";
    }

    BS.Util.show("buildCommentProgressIcon");

    BS.FormSaver.save(BS.BuildCommentDialog, BS.BuildCommentDialog.formElement().action, OO.extend(BS.ErrorsAwareListener, {
      
      onCompleteSave: function(form, responseXML, err) {
        BS.Util.hide("buildCommentProgressIcon");

        // todo: shall fix all these reloads to ajax, including pin, and tag!!!
        BS.reload(true);
      },

      onFailure: function() {
        BS.Util.hide("buildCommentProgressIcon");
        alert("Problem accessing server");
      }
    }));

    return false;
  }
}));
