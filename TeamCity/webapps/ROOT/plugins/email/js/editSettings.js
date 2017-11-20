
Email = {};

Email.SettingsForm = OO.extend(BS.AbstractPasswordForm, {
  setupEventHandlers: function() {
    var that = this;
    $('testConnection').on('click', this.testConnection.bindAsEventListener(this));

    this.setUpdateStateHandlers({
      updateState: function() {
        that.storeInSession();
      },
      saveState: function() {
        that.submitSettings();
      }
    });
  },

  storeInSession: function() {
    var that = this;
    $("submitSettings").value = 'storeInSession';

    BS.PasswordFormSaver.save(this, this.formElement().action, BS.StoreInSessionListener);
  },

  submitSettings: function() {
    var that = this;
    $("submitSettings").value = 'store';

    this.removeUpdateStateHandlers();

    BS.PasswordFormSaver.save(this, this.formElement().action, OO.extend(BS.ErrorsAwareListener, this.createErrorListener()));

    return false;
  },

  createErrorListener: function() {
    var that = this;
    return {
      onEmptyHostnameError: function(elem) {
        $("errorHostname").innerHTML = elem.firstChild.nodeValue;
        that.highlightErrorField($("hostname"));
      },

      onEmptyPortError: function(elem) {
        $("errorPort").innerHTML = elem.firstChild.nodeValue;
        that.highlightErrorField($("port"));
      },

      onInvalidPortError: function(elem) {
        this.onEmptyPortError(elem);
      },

      onEmptyEmailFromError: function(elem) {
        $("errorEmailFrom").innerHTML = elem.firstChild.nodeValue;
        that.highlightErrorField($("emailFrom"));
      },

      onCompleteSave: function(form, responseXML, err) {
        BS.ErrorsAwareListener.onCompleteSave(form, responseXML, err);
        if (!err) {
          BS.XMLResponse.processRedirect(responseXML);
        } else {
          that.setupEventHandlers();
        }
      }
    };
  },


  testConnection: function () {
    var to = prompt("Send test Email message to:", $("testAddress").value || "");
    if(to) {
      $("submitSettings").value = 'testConnection';
      $("testAddress").value = to;

      var listener = OO.extend(BS.ErrorsAwareListener, this.createErrorListener());
      var oldOnCompleteSave = listener['onCompleteSave'];
      listener.onCompleteSave = function(form, responseXML, err) {
        oldOnCompleteSave(form, responseXML, err);
        if (!err) {
          form.enable();
          if (responseXML) {
            var res = responseXML.getElementsByTagName("testConnectionResult");
            if (res.length > 0) {   // trouble
              BS.TestConnectionDialog.show(false, res[0].firstChild.nodeValue, $('testConnection'));
            } else {
              BS.TestConnectionDialog.show(true, "", $('testConnection'));
            }
          }
        }
      };

      BS.PasswordFormSaver.save(this, this.formElement().action, listener);
    }
  }
});
