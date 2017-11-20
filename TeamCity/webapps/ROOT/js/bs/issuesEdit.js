BS.IssueProviderForm = OO.extend(BS.PluginPropertiesForm, OO.extend(BS.AbstractModalDialog, {
  setSaving: function(saving) {
    if (saving) {
      BS.Util.show('newIssueProviderProgress');
    } else {
      BS.Util.hide('newIssueProviderProgress');
    }
  },

  getContainer: function() {
    return $('newIssueProviderFormDialog');
  },

  formElement: function() {
    return $('newIssueProviderForm');
  },

  afterClose: function () {
    $('providerType').setSelected(0);
  },

  /**
   * Show dialog and optionally pre-select provider
   *
   * @param {string} projectExternalId
   * @param {Object} [options] - initialization options
   */
  showDialog: function(projectExternalId, options) {
    this.projectExternalId = projectExternalId;
    this.initOptions = options;
    BS.Util.reenableForm(this.formElement());
    this.showCentered();
    this.bindCtrlEnterHandler(this.submit.bind(this));
    $("noType").selected = 'selected';

    if (this.providerId) {      // edit
      this.disableButton(false);
    } else {                    // create
      this.disableButton(true);
      BS.Util.hide("newProviderDiv");
      if (options) {
        var issueProviderTypeName = options['addTracker'];
        if (issueProviderTypeName) {
          $('providerType').setSelectValue(issueProviderTypeName);
          $j('#providerType').trigger('change');
        }
      }
    }
  },

  getSelectedType: function() {
    var idx = this.formElement().providerType.selectedIndex;
    return this.formElement().providerType.options[idx].value;  // providerType
  },

  disableButton: function(value) {
    $j("#createButton, #connectionButton").prop("disabled", value);
  },

  submit: function() {
    var providerType = this.getSelectedType();
    if (providerType) {
      this.setSaving(true);
      var url = window['base_uri'] + "/admin/issueTracker/editIssueProvider.html?create=1&type=" + providerType +
                "&projectId=" + this.projectExternalId;
      this.saveForm(url);
    }
    return false;
  },

  saveForm: function(url) {
    var that = this;
    BS.PasswordFormSaver.save(this, url, OO.extend(BS.ErrorsAwareListener, {
      onCompleteSave: function(form, responseXML, err) {
        that.setSaving(false);
        var wereErrors = BS.XMLResponse.processErrors(responseXML, {
          onProviderNotFoundError: function() {
            alert('Provider not found');
          }
        }, that.propertiesErrorsHandler);

        if (wereErrors) {
          BS.Util.reenableForm(that.formElement());
          return;
        }

        that.close();
        BS.ErrorsAwareListener.onCompleteSave(form, responseXML, err);

        if (!err) {
          BS.XMLResponse.processRedirect(responseXML);
        }
        $('providersTable').refresh();
        that.clearContent();
      }
    }));
  },

  clearContent: function() {
    $("newProviderDiv").innerHTML = "";
    $("editProviderDiv").innerHTML = "";
  },

  cancelDialog: function() {
    this.clearContent();
    this.close();
  },

  refreshDialog: function(pageUrl) {
    var that = this;
    var providerType = this.getSelectedType();
    if (providerType != '') {
      $('newProviderSaving').show();
      this.disableButton(true);
      var url = pageUrl + '&selectedType=' + providerType;

      var container = document.getElementById('newIssueProviderContainer');
      container.setAttribute('data-pageurl', url);
      container.refresh(false, false, function() {
        $('newProviderSaving').hide();
        BS.VisibilityHandlers.updateVisibility("newIssueProviderContainer");
        BS.IssueProviderForm.recenterDialog();
        that.disableButton(false);
      });
    } else {
      $("newProviderDiv").innerHTML = "";
      this.disableButton(true);
    }
  },

  testConnection: function() {
    if ($('host') && !$('host').value) {
      alert('Please, set the "host" property (and optionally credentials)');
      return;
    }

    var providerType = this.getSelectedType();
    if (providerType == '') {
      return;
    }
    var url = window['base_uri'] + "/admin/issueTracker/testConnection.html?type=" + providerType +
              "&projectId=" + this.projectExternalId;
    BS.IssueProviderTestConnection.show(this, url);
  }
}));

BS.EditIssueProviderForm = OO.extend(BS.IssueProviderForm, {
  show: function(providerType, providerId, projectExternalId) {
    this.providerType = providerType;
    this.providerId = providerId;
    this.projectExternalId = projectExternalId;

    $("editProviderDiv").innerHTML = BS.loadingIcon + " Loading settings... ";
    this.showDialog(this.projectExternalId);

    var url = this.getUrl();
    BS.ajaxUpdater($("editProviderDiv"), url, {
      method: "get",
      evalScripts: true,
      onComplete: function() {
        BS.VisibilityHandlers.updateVisibility("editProviderDiv");
        BS.EditIssueProviderForm.recenterDialog();
      }
    });
  },

  getUrl: function() {
    return window['base_uri'] + "/admin/issueTracker/editIssueProvider.html?" +
           "type=" + this.providerType +
           "&providerId=" + this.providerId +
           "&projectId=" + this.projectExternalId;
  },

  setSaving: function(saving) {
    if (saving) {
      BS.Util.show('editIssueProviderProgress');
    } else {
      BS.Util.hide('editIssueProviderProgress');
    }
  },

  getContainer: function() {
    return $('editIssueProviderFormDialog');
  },

  formElement: function() {
    return $('editIssueProviderForm');
  },

  submit: function() {
    this.setSaving(true);
    var url = this.getUrl();
    this.saveForm(url);

    return false;
  },

  testConnection: function() {
    if ($('host') && !$('host').value) {
      alert('Please, set the "host" property (and optionally credentials)');
      return;
    }

    var url = window['base_uri'] + "/admin/issueTracker/testConnection.html?type=" + this.providerType + "&projectId=" + this.projectExternalId;
    BS.IssueProviderTestConnection.show(this, url);
  }
});

BS.IssueProviderTestConnection = OO.extend(BS.AbstractWebForm, OO.extend(BS.AbstractModalDialog, {
  getContainer: function() {
    return $('testConnectionDialog');
  },

  formElement: function() {
    return $('testConnection');
  },

  show: function(form, url) {
    this.form = form;
    this.url = url;
    this.clearPreviousResults();
    this.showCentered();
    $("issueId").focus();

    // Set the placeholder to make it clear what input is expected.
    var prefixInput = $j("#idPrefix");
    var placeholder;
    if (prefixInput.length) {
      var value = prefixInput.val();
      if (value) {
        value = value.split(" ")[0];
      } else {
        value = "PROJ";
      }
      placeholder = "E.g. " + value + "-123";
    } else {
      placeholder = "Any valid issue ID";
    }
    $j("#issueId").attr("placeholder", placeholder);
  },

  cancelDialog: function() {
    this.close();
  },

  clearPreviousResults: function() {
    $('issueId').value = "";
    $('issueDetails').innerHTML = "";
  },

  testConnection: function() {
    var issueId = $('issueId').value;
    if (!issueId) {
      alert('Please, set the Issue ID field');
      return;
    }

    this.form.setSaving(true);
    var params = this.form.serializeParameters() + "&issueId=" + encodeURIComponent(issueId);
    var resultElem = $('issueDetails');
    var that = this;
    BS.ajaxRequest(this.url, {
      method: "post",
      parameters: params,
      onComplete: function(transport) {
        that.form.setSaving(false);
        var errors = BS.XMLResponse.processErrors(transport.responseXML, {
          onFailureError: function(elem) {
            var message = elem.firstChild.nodeValue;
            resultElem.innerHTML = "<span class='err'>" + message.escapeHTML() + "</span>";

            // Some fancy UI stuff. TW-23282
            var width = $j(resultElem).children().width();
            if (width > $j(resultElem).width()) {
              $j("#testConnectionDialog").width(Math.min(width + 22, 700));
              that.showCentered();
            }
          },
          onPublicKeyExpiredError: function() {
            resultElem.innerHTML = "<span class='err'>Public key expired. " +
                                   "Please refresh the page.</span>";
          }
        });
        if (!errors) {
          resultElem.innerHTML = "<span style='color: green'>Success!</span>";
          var child = transport.responseXML.firstChild.firstChild;
          while (child) {
            resultElem.innerHTML += "<br><b>" + child.nodeName + "</b>: " + this.getElemContent(child);
            child = child.nextSibling;
          }
        }
      },
      getElemContent: function(elem) {
        return (BS.Browser.msie) ? elem.firstChild.nodeValue.escapeHTML() : elem.textContent.escapeHTML();
      }
    });
  },

  _makeLinks: function(text) {
    var exp = /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig;
    return text.replace(exp, "<a href='$1' target='_blank'>$1</a>");
  }
}));


