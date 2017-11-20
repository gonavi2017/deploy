BS.CleanupDisableForm = OO.extend(BS.AbstractWebForm, {
  formElement: function() {
    return $('cleanupDisableForm');
  },

  setSaving: function(saving) {
    if (saving) {
      BS.Util.show('savingSettings');
    } else {
      BS.Util.hide('savingSettings');
    }
  },

  submit: function() {
    BS.FormSaver.save(this, this.formElement().action, OO.extend(BS.ErrorsAwareListener, {
      onCompleteSave: function(form, responseXML, err) {
        if (err) {
          form.enable();
          form.setSaving(false);
        }

        if (!err) {
          BS.reload(true);
        }
      }
    }));
    return false;
  }
});

BS.CleanupPoliciesForm = OO.extend(BS.AbstractWebForm, {
  formElement: function() {
    return $('cleanupTimeForm');
  },

  setSaving: function(saving) {
    if (saving) {
      BS.Util.show('savingSettings');
    } else {
      BS.Util.hide('savingSettings');
    }
  },

  startingCleanup: function(starting) {
    if (starting) {
      BS.Util.show('startingCleanup');
    } else {
      BS.Util.hide('startingCleanup');
    }
  },

  submitCleanupStartTime: function() {
    var that = this;
    $('cleanupPageAction0').value = 'storeSettings';

    BS.FormSaver.save(this, this.formElement().action, OO.extend(BS.ErrorsAwareListener, {
      onSaveServerConfigError: function(elem) {
        alert(elem.firstChild.nodeValue);
      },

      onSaveCleanupTimeError: function(elem) {
        $('error_cleanupTime').innerHTML = elem.firstChild.nodeValue;
        that.highlightErrorField('hour');
        that.highlightErrorField('minute');
      },

      onCompleteSave: function(form, responseXML, err) {
        if (err) {
          form.enable();
          form.setSaving(false);
        }

        if (!err) {
          BS.reload(true);
        }
      }
    }));
    return false;
  },

  submitStartCleanup: function() {
    if (!confirm("This operation may require significant time, and the server will be less performant during the clean-up.\n" +
      "Are you sure you want to start clean-up process now?")) return false;

    $('cleanupPageAction0').value = 'startCleanup';

    BS.FormSaver.save(this, this.formElement().action, OO.extend(BS.SimpleListener, {
      onCannotStartCleanupError: function(elem) {
        alert(elem.firstChild.nodeValue);
      },

      onBeginSave: function(form) {
        form.startingCleanup(true);
        form.disable();
      },

      onCompleteSave: function() {
        setTimeout(function() {
          BS.reload(true);
        }, 1500);
      }
    }));

    return false;
  },

  submitStopCleanup: function() {
    if (!confirm("Are you sure you want to stop clean-up process now?")) return false;

    this.formElement()['cleanupPageAction'].value = 'stopCleanup';
    BS.FormSaver.save(this, this.formElement().action, OO.extend(BS.SimpleListener, {
      onBeginSave: function(form) {
        form.disable();
      },

      onCompleteSave: function() {
        BS.reload(true);
      }
    }));

    return false;
  }
});

BS.CleanupPolicyDialog = OO.extend(BS.AbstractWebForm, OO.extend(BS.AbstractModalDialog, {

  incorrectInputs : {},

  formElement: function() {
    return $('editPolicy');
  },

  getContainer: function() {
    return $('editPolicyDialog');
  },

  showForProject: function(projectId, title, policies, levels, defPolicies, holdDependencies /*true|false|<empty>*/) {
    $('projectId').value = projectId;
    $('buildTypeId').value = '';
    this.showCleanupDialog(title, policies, levels, defPolicies, holdDependencies, projectId == '_Root');
  },

  showForBuildType: function(buildTypeId, title, policies, levels, defPolicies, holdDependencies /*true|false|<empty>*/) {
    $('buildTypeId').value = buildTypeId;
    $('projectId').value = '';
    this.showCleanupDialog(title, policies, levels, defPolicies, holdDependencies, false);
  },

  showCleanupDialog: function(title, policies, levels, defPolicies, holdDependencies, hide_defaults) {
    this.clearErrors();

    if (hide_defaults) {
      BS.Util.hide('use_default_option');
    } else {
      BS.Util.show('use_default_option');
    }

    $('cleanupPageAction1').value = 'savePolicy';
    $j('#editPolicyTitle').text(title) // forces HTML escaping.
        .attr('title', title);
    $('artifactPatternsDiv').hide();
    $('artifactPatterns').value = '';
    for(var i = 0; i<levels.length; i++ ) {
      var level = levels[i];
      var policy = policies[level];
      var daysCount = 0;
      var buildsCount = 0;
      var hasDefault = defPolicies && defPolicies[level];

      $j('span[id=default'+level+'text]').text(hasDefault ? defPolicies[level] : 'Never'); // should be escaped
      if (!hasDefault) {
        $('defPrefix'+level).hide();
      }
      else {
        $('defPrefix'+level).show();
      }

      $('apply'+level).show();

      if(policy) {
        $('edit'+level).show();
        $('default'+level).hide();
        daysCount = policy['keepDays.count'];
        buildsCount = policy['keepBuilds.count'];
        $('custom_C'+level).checked = true;
        $('custom_D'+level).checked = false;

        if (level == 'ARTIFACTS') {
          $('artifactPatternsDiv').show();
          var p = policy['artifactPatterns'];
          $('artifactPatterns').value = p ? p : '';
        }
      } else {
        $('edit'+level).hide();
        $('default'+level).show();
        $('custom_C'+level).checked = false;
        $('custom_D'+level).checked = true;
      }
      $('daysCount['+level+"]").value = daysCount ? daysCount : '';
      $('buildsCount['+level+"]").value = buildsCount ? buildsCount : '';
    }

    if (holdDependencies == 'true') {
      $('holdDependencies_true').checked = true;
    } else if (holdDependencies == 'false') {
      $('holdDependencies_false').checked = true;
    } else {
      $('holdDependencies_default').checked = true;
    }

    this.showCentered();
    this.recheckIntegerInputs();

    this.bindCtrlEnterHandler(this.submitCleanupPolicy.bind(this));
  },

  cancelDialog: function() {
    this.close();
  },

  submitCleanupPolicy: function() {
    var that = this;
    BS.FormSaver.save(this, this.formElement().action, OO.extend(BS.ErrorsAwareListener, {
      onFieldError: function(elem) {
        $(elem.firstChild.nodeValue).addClassName("errorField");
      },

      onARTIFACTS_invalidRuleError: function(elem) {
        $('ARTIFACTS_invalidRuleError').innerHTML =  elem.firstChild.nodeValue;
      },

      onHISTORY_ENTRY_invalidRuleError: function(elem) {
        $('HISTORY_ENTRY_invalidRuleError').innerHTML =  elem.firstChild.nodeValue;
      },

      onEVERYTHING_invalidRuleError: function(elem) {
        $('EVERYTHING_invalidRuleError').innerHTML =  elem.firstChild.nodeValue;
      },

      onSaveServerConfigError: function(elem) {
        alert(elem.firstChild.nodeValue);
      },

      onBuildTypeNotFoundError: function(elem) {
        alert(elem.firstChild.nodeValue);
      },

      onSaveProjectFailedError: function(elem) {
        alert(elem.firstChild.nodeValue);
      },

      onSuccessfulSave: function() {
        that.enable();
        that.close();
        $('cleanupPoliciesTable').refresh();
      }
    }));

    return false;
  },


  isInputIntegerAndPositive: function (inputId) {
    var v = $(inputId).value;
    v = v.replace(/^\s+|\s+$/g, '');
    return /^[0-9]*$/.test(v) && (v >= 1 || v == "");
  },


  checkIntegerInput: function (inputId, msgId) {
    var inputOk = this.isInputIntegerAndPositive(inputId);

    if (inputOk) {
      BS.Util.hide(msgId);
      delete this.incorrectInputs[inputId];
    }
    else {
      BS.Util.show(msgId);
      this.incorrectInputs[inputId] = msgId;
    }

    this.updateInnerSaveButtonStatus();
  },


  updateInnerSaveButtonStatus: function () {
    var ok = true;                                    // guess the map incorrectInputs is empty
    for (var i in this.incorrectInputs) ok = false;   // if the map is not empty then ok == false

    if (ok) Form.Element.enable($("innerSaveButton"));
    else    Form.Element.disable($("innerSaveButton"));
  },


  recheckIntegerInputs: function () {
    var theIncorrectInputs = this.incorrectInputs; // I will update this.incorrectInputs and wanna get a copy
    for (var i in theIncorrectInputs)
      this.checkIntegerInput(i, theIncorrectInputs[i]);
  }



}));

BS.Cleanup = {
  resetPolicies: function(parentProjectId, projectId, buildTypeId) {
    var message = "Do you want to reset cleanup rules?";

    if (confirm(message)) {
      BS.ajaxRequest(window["base_uri"] + "/admin/editCleanupRules.html", {
        method: "post",

        parameters: {parentProjectId: parentProjectId, cleanupPageAction: "resetPolicy", projectId: projectId, buildTypeId: buildTypeId},

        onComplete: function(/*transport*/) {
          $('cleanupPoliciesTable').refresh();
        }
      });
    }
  },

  submitFilter: function(parentProjectId, showSubProjects) {
    BS.ajaxRequest(window["base_uri"] + "/admin/editCleanupRules.html", {
      method: "post",

      parameters: {parentProjectId: parentProjectId, showSubProjects: showSubProjects},

      onComplete: function(/*transport*/) {
        BS.reload(true);
      }
    });
  },

  updateDiskUsage: function(projectId) {
    BS.ajaxRequest(window["base_uri"] + "/diskUsage.html", {
      method: "POST",
      parameters: {
        action: "getData",
        projectId: projectId
      },
      onComplete: function(transport) {
        function getSizeFormatted(tag) {
          if (tag.getAttribute("size") > 1024 * 1024) {
            return tag.getAttribute("sizeFormatted");
          } else {
            return "<1 MB";
          }
        }
        if (transport.responseXML && transport.responseXML.firstChild) {
          var response = transport.responseXML.firstChild;
          var buildTypes = response.getElementsByTagName("buildType");
          var projects = response.getElementsByTagName("project");
          var dataHolder = {buildTypes: {}, projects: {}};
          for (var i = 0; i < buildTypes.length; ++i) {
            dataHolder.buildTypes[buildTypes[i].getAttribute("buildTypeId")] = getSizeFormatted(buildTypes[i]);
          }
          for (i = 0; i < projects.length; ++i) {
            dataHolder.projects[projects[i].getAttribute("projectId")] = getSizeFormatted(projects[i]);
          }

          $j("#cleanupPoliciesTable .diskUsage").each(function (idx, elem) {
            var $elem = $j(elem);
            var projectId = $elem.attr("data-project-id");

            $elem.show();
            $elem.find(".valueHolder").text((projectId ? dataHolder.projects[projectId] : dataHolder.buildTypes[$elem.attr("data-build-type-id")]) || "?");
          });
        }
      }
    });
  },

  updateOverallDiskUsage: function() {
    BS.ajaxRequest(window["base_uri"] + "/diskUsage.html", {
      method: "POST",
      parameters: {
        action: "getOverallData"
      },
      onComplete: function (transport) {
        if (transport.responseXML && transport.responseXML.firstChild) {
          var response = transport.responseXML.firstChild;
          var elements = response.getElementsByTagName("diskUsage");
          if (elements.length > 0) {
            var data = elements[0];
            var artFreeSpace = data.getElementsByTagName("totalArtifactsFreeSpace")[0].firstChild.nodeValue;
            var logsFreeSpace = data.getElementsByTagName("totalLogsFreeSpace")[0].firstChild.nodeValue;
            var artTotalSize = data.getElementsByTagName("totalArtifactsSize")[0].firstChild.nodeValue;
            var isUpdating = data.getElementsByTagName("totalArtifactsSize")[0].attributes["updating"].value === "true";
            var logsTotalSize = data.getElementsByTagName("totalLogsSize")[0].firstChild.nodeValue;

            var text;
            if (artFreeSpace == logsFreeSpace) {
              text = "Free space: <strong>" + artFreeSpace + "</strong>, ";
            } else {
              text = "Free space in artifacts directory: <strong>" + artFreeSpace + "</strong>, Free space in logs directory: <strong>" + logsFreeSpace + "</strong>, ";
            }
            text += "total artifacts" + (isUpdating ? " (updating)" : "") + ": <strong>" + artTotalSize + "</strong>, ";
            text += "total logs" + (isUpdating ? " (updating)" : "") + ": <strong>" + logsTotalSize + "</strong>.";
            $j("#freeSpaceHolder").html(text);
          } else {

          }
        }
      }
    });
  }
};