BS.MetaRunners = {
  showDialog: function (host, settingsId) {
    $j("#metaRunnersExportButtons").hide();
    BS.MetaRunners.Dialog.settingsId = settingsId;
    BS.MetaRunners.Dialog.show();
    return false;
  },

  Dialog: OO.extend(BS.PluginPropertiesForm, OO.extend(BS.AbstractModalDialog, {
    settingsId: '', // will be updated
    show: function () {
      var that = this;
      that.showCentered();
      that.refreshContent({metainit: 1}, function () {
        that.showCentered();
        $j("#metaRunnersExportButtons").show();
        that.bindCtrlEnterHandler(that.saveNamesPage.bind(that));

        BS.AdminActions.prepareCustomIdGenerator("meta-runner",
                                                 $j("#metaRunnerExportId").get(0),        //id input
                                                 $j("#metaRunnerExportName").get(0),      //name
                                                 $j("#metaRunnerExportProjectId").get(0), //project
                                                 false);
      });
    },

    getBaseParameters: function (params) {
      params = OO.extend(
          {
            id: this.settingsId
          },
          params || {}
      );
      return Object.toQueryString(params);
    },

    refreshContent: function (params, onComplete) {
      var oldOnComplete = onComplete;
      var that = this;
      var newOnComplete = function () {
        if (oldOnComplete) oldOnComplete.apply(this, arguments);
        BS.VisibilityHandlers.updateVisibility()
      };

      $('metaRunnersRefresh').innerHTML = '<i class="icon-refresh icon-spin"></i> Loading...';

      var url = $('metaRunnersRefresh').getAttribute('data-url');
      BS.ajaxUpdater($('metaRunnersRefresh'), url, {
        method: 'get',
        evalScripts: true,
        parameters: that.getBaseParameters(params),
        onComplete: newOnComplete
      });
    },

    save: function () {
      return false;
    },

    saveNamesPage: function () {
      var that = this;

      BS.FormSaver.save(this, this.formElement().action + "?" + this.getBaseParameters(), OO.extend(BS.ErrorsAwareListener, {
        onBeginSave: function (form) {
          BS.Util.show('metaRunnersSaving');
          that.clearErrors();
        },
        onCompleteSave: function (form, responseXML, err) {
          BS.Util.hide('metaRunnersSaving');

          var wereErrors = BS.XMLResponse.processErrors(
              responseXML, {
                onGenerationError: function (elem) {
                  $('error_export').innerHTML = elem.firstChild.nodeValue;
                },
                onIdClashError: function (elem) {
                  err = true;
                  var x = confirm("Replace existing meta-runner with newly created one?");
                  if (x) {
                    $j("#metaRunnerConfirmReplace").val("true");
                    setTimeout(function () {
                      that.saveNamesPage();
                    }, 10);
                  }
                }
              },
              that.propertiesErrorsHandler) || err;
          BS.ErrorsAwareListener.onCompleteSave(form, responseXML, wereErrors);

          if (wereErrors) {
            BS.Util.reenableForm(form.formElement());
            return;
          }

          var nextPages = responseXML.getElementsByTagName("jredirect");
          if (!!nextPages && nextPages.length > 0) {
            that.refreshContent(
                {
                  metaStep: nextPages[0].getAttribute('metaStep')
                },
                function () {
                  that.clearErrors();
                  BS.Util.reenableForm(that.formElement());
                }
            );

            return;
          }

          var completes = responseXML.getElementsByTagName("jcomplete");
          if (!!completes && completes.length > 0) {
            setTimeout(function () {
              document.location.href = base_uri + completes[0].getAttribute('redirectUrl');
            }, 10);
          }
        }
      }));

      return false;
    },

    close: function () {
      //cleanup
      this.settingsId = '';
      (BS.AbstractModalDialog.close.bind(this))();
    },

    getContainer: function () {
      return $('metaRunnersExportDialog');
    },

    formElement: function () {
      return $('metaRunnersExport');
    }

  }))

};