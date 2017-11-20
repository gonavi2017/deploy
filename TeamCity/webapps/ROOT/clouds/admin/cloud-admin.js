if (!BS.Clouds) {
  BS.Clouds = {};
}

BS.Clouds.Admin = {
  _runningInstancesCount : 0,

  setRunningInstancesCount: function(c) {
    this._runningInstancesCount = c;
  },

  getRunningInstancesCount: function() {
    return this._runningInstancesCount;
  },

  refresh: function() {
    return $('cloudRefreshable').refresh();
  },

  registerRefresh: function() {
    $j(function() {
      BS.Clouds.registerRefreshable(BS.Clouds.Admin.refresh.bind(BS.Clouds.Admin));
    });
  },

  submitFilter: function(projectId, showSubProjects) {
    BS.ajaxRequest(window["base_uri"] + "/clouds/admin/cloudAdmin.html", {
      method: "post",

      parameters: {projectId: projectId, showSubProjects: showSubProjects},

      onComplete: function(/*transport*/) {
        BS.reload(true);
      }
    });
  },

  updateDependentCheckboxes: function () {
    var enableProj = $j('#enableProject');
    var enableSubprojects = $j('#enableSubprojects');
    if (!enableProj.is(':visible'))
      return;
    if (enableProj.is(':checked')){
      $j('#enableSubprojects').prop('disabled', false);
      $j('#enableSubprojectsCheckbox').removeClass('grayNote');
    } else {
      $j('#enableSubprojects').prop('disabled', true);
      $j('#enableSubprojects').prop('checked', false);
      $j('#enableSubprojectsCheckbox').addClass('grayNote');
    }

    var projectWasDisabled = $j('#initiallyEnabled').val() && !enableProj.is(':checked');
    var subProjectWasDisabled = $j('#initiallySubprojectsEnabled').val() && !enableSubprojects.is(':checked');
    var subp_cnt = subProjectWasDisabled ? $j('#subprojectsInstancesCount').val() : 0;
    var pr_cnt = projectWasDisabled ? $j('#projectInstancesCount').val() : 0;
    var totalCnt = parseInt(subp_cnt) + parseInt(pr_cnt);

    if ((projectWasDisabled || subProjectWasDisabled) && totalCnt > 0) { // was initialized initially
      $j('#terminateInstancesCheckbox').show();
      $j('#confirmShutdown_instanceCount').text(totalCnt);
    } else {
      $j('#terminateInstancesCheckbox').prop('checked', false);
      $j('#confirmShutdown_instanceCount').text('');
      $j('#terminateInstancesCheckbox').hide();
    }

  },

  CreateProfileForm : OO.extend(BS.PluginPropertiesForm, {

    initialData: {},

    formElement: function() {
      return $('newProfileForm');
    },

    savingIndicator: function() {
      return $('newProfileProviderProgress');
    },

    getSelectedType: function() {
      var el = this.formElement().cloudType;
      var idx = el.selectedIndex;
      return el.options[idx].value;
    },

    beforeSaveForm: function() {},

    saveForm: function() {
      this.beforeSaveForm();
      var that = this;
      var url = this.formElement().getAttribute('action');
      BS.PasswordFormSaver.save(that, url, OO.extend(BS.ErrorsAwareListener, {
        onCompleteSave: function(form, responseXML, err) {
          var wereErrors = BS.XMLResponse.processErrors(responseXML, {}, that.propertiesErrorsHandler);

          BS.ErrorsAwareListener.onCompleteSave(form, responseXML, err);

          if (wereErrors) {
            BS.Util.reenableForm(that.formElement());
            return;
          }
          var projectId = encodeURIComponent($j('#projectId').val());

          document.location.href = $j('#cameFromUrl').val() ;// window['base_uri'] + "/admin/editProject.html?projectId="+projectId+"&tab=clouds";
        }
      }));
    },

    recordInitialParams: function(){
      var that = this;
      if ($j('#action').val() == 'edit'){
        $j('input').add($j('select')).each(function(){
          var elem = $j(this);
          if (elem.hasClass('ignoreModified'))
            return;
          if (!elem.attr('name'))
            return;
          if (elem.attr('type') == 'checkbox'){
            that.initialData[elem.attr('name')] = elem.prop('checked');
          } else {
            that.initialData[elem.attr('name')] = elem.val();
          }

          elem.on('change', function(e, data){
            if (arguments.length === 1) {
              that.checkIfModified();
            }
          });
        });
      }
    },

    checkIfModified: function () {
      var modified = false;
      var that = this;
      $j('input').add($j('select')).each(function(){
        var elem = $j(this);
        var attrName = elem.attr('name');
        if (!attrName || (typeof that.initialData[attrName] =='undefined'))
          return;
        if (elem.hasClass('ignoreModified'))
          return;

        var val;
        if (elem.attr('type') == 'checkbox'){
          val = elem.prop('checked');
        } else {
          val = elem.val();
        }

        if (val != that.initialData[attrName]) {
          if (elem.hasClass('jsonParam')){
            var oldVal = JSON.parse(that.initialData[attrName]);
            var newVal = JSON.parse(val);
            if (that._checkJsonDifferent(oldVal, newVal)){
              modified = true;
            }
          } else {
            modified = true;
          }
        }
      });
      if (modified){
        $j('.modifiedMessage').show();
      } else {
        $j('.modifiedMessage').hide();
      }
    },

    _checkJsonDifferent: function(oldVal, newVal){
      var oldKeys = Object.keys(oldVal).sort();
      var newKeys = Object.keys(newVal).sort();
      if (oldKeys.length != newKeys.length)
        return true;
      for(var key in oldVal){
        if (typeof newVal[key] == 'undefined')
          return true;
        if(typeof oldVal[key] == "object" && typeof newVal[key] == "object"){
          if (this._checkJsonDifferent(oldVal[key], newVal[key]))
            return true;
        } else if (!(newVal[key].toString() == oldVal[key].toString())) {
          return true;
        }
      }
      return false;
    },

    baseParams: function() {
      return "";
    },

    beforeShow: function() {
      var providerType = this.getSelectedType();
      if (providerType == '') {
        this.disableButton(['createButton'], true);
      }
    },

    disableButton: function(ids, value) {
      if (value) {
        ids.each(function(item) {
          $(item).disabled = 'disabled';
        });
      } else {
        ids.each(function(item) {
          $(item).disabled = '';
        });
      }
      var that = this;
      return function() {
        that.disableButton(ids, !value);
      };
    },

    refreshSelectedCloudType: function() {
      var enable;
      var providerType = this.getSelectedType();
      if (providerType != '') {
        enable = this.disableButton(["createButton", "cloudType"], true);
      } else {
        this.disableButton(["createButton"], true);
        enable = null;
      }
      var url = 'cloudType=' + providerType + "&" + this.baseParams();
      $('newProfilesContainer').refresh('newProviderSaving',  url, enable);
    },

    submit: function() {
       var providerType = this.formElement();
       if (providerType == '') {
         alert('Please select Cloud Type');
         return false;
       }
       this.saveForm();
       return false;
     }
  }),

  enabledClouds: function(b, uri) {
    var btn = $(b);
    btn.disable();

    $('enable_integration_loader').show();
    BS.ajaxRequest(uri, {
      parameters : {
        action :  'enable'
      },
      method: 'post',
      onComplete: function() {
        BS.reload(true);
      }
    });
  },

  ConfirmDialog : OO.extend(BS.AbstractModalDialog, {
    aThis : null,

    getContainer: function() {
      return $('confirmShutdownDialog');
    },

    showDialog: function(caption, submitCaption, runningCount) {
      BS.Clouds.Admin.ConfirmDialog.aThis = this;
      $j('#confirmShutdown_action').text(caption);
      $('confirmShutdown_submit').value = submitCaption;
      $j('#confirmShutdown_instanceCount').text(runningCount);
      if (runningCount > 0) {
        $j('#terminateInstancesCheckbox').show();
      } else {
        $j('#terminateInstancesCheckbox').hide();
      }
      this.showCentered();
      this.bindCtrlEnterHandler(this.submit.bind(this));
    },

    shouldKillInstances: function() {
      return $('terminateInstances').checked ? 'true' : 'false';
    },

    enableProject: function(){
      return $j('#enableProject').is(':checked');
    },

    enableSubprojects: function(){
      return $j('#enableSubprojects').is(':checked');
    },

    allowOverride: function(){
      return $j('#allowSubprojectsOverwrite').is(':checked');
    },

    //Override this function to handle confirm
    onConfirm: function() {
    },

    submit: function() {
      $('confirmShutdown').disable();
      $('confirmShutdownDialog_loader').show();

      (this.aThis||this).onConfirm();

      return false;
    },

    postSubmit: function() {
      $('confirmShutdownDialog_loader').hide();
      $('confirmShutdown').enable();
      this.close();
    },

    processKillError: function(transport) {
      return BS.XMLResponse.processErrors(transport.responseXML, {
        onKillFailedError: function(elem) {
          alert(elem.firstChild.nodeValue + "\nAction is canceled due to the error");
        }
      }, function(id, elem) {
        alert(elem.firstChild.nodeValue);
      });
    }
  })
};

BS.Clouds.Admin.DisableEnableProfile = OO.extend(BS.Clouds.Admin.ConfirmDialog, {
  profileId : "",
  projectId : "",

  showDisableProfileDialog: function(projectId, profileId, profileName, runningCount) {
    this.profileId = profileId;
    this.projectId = projectId;
    $j("#confirmShutdownTitle").text("Disable Cloud Profile");
    $j("#enableCheckbox").hide();
    $j("#enableSubprojectsCheckbox").hide();
    $j("#allowSubprojectsOverwriteCheckbox").hide();

    return this.showDialog('Are you sure you want to disable "' + profileName + '"?', 'Disable', runningCount);
  },

  enableProfile: function(projectId, profileId){
    var that = this;
    BS.ajaxRequest(window['base_uri'] + "/clouds/admin/cloudAdminProfile.html", {
      parameters : {
        action : 'enable',
        profileId : profileId,
        projectId: projectId
      },
      method : 'post',
      onComplete: function(transport) {
        var handled = that.processKillError(transport);
        if (!handled) {
          BS.Clouds.Admin.refresh();
        }
        that.postSubmit();
      }
    });
  },

  onConfirm: function() {
    var that = this;
    BS.ajaxRequest(window['base_uri'] + "/clouds/admin/cloudAdminProfile.html", {
      parameters : {
        action : 'disable',
        profileId : that.profileId,
        projectId : that.projectId,
        killInstances : that.shouldKillInstances()
      },
      method : 'post',
      onComplete: function(transport) {
        var handled = that.processKillError(transport);
        if (!handled) {
          BS.Clouds.Admin.refresh();
        }
        that.postSubmit();
      }
    });
  }
});

BS.Clouds.Admin.ConfirmDeleteProfileDialog = OO.extend(BS.Clouds.Admin.ConfirmDialog, {
  profileId : "",
  projectId : "",

  showDeleteProfileDialog: function(projectId, profileId, profileName, runningCount) {
    this.profileId = profileId;
    this.projectId = projectId;
    $j("#confirmShutdownTitle").text("Remove Cloud Profile");
    $j("#enableCheckbox").hide();
    $j("#enableSubprojectsCheckbox").hide();
    $j("#allowSubprojectsOverwriteCheckbox").hide();

    return this.showDialog('Are you sure you want to remove profile "' + profileName +'"?', 'Remove', runningCount);
  },

  onConfirm: function() {
    var that = this;
    BS.ajaxRequest(window['base_uri'] + "/clouds/admin/cloudAdminProfile.html", {
      parameters : {
        action : 'delete',
        profileId : that.profileId,
        projectId : that.projectId,
        killInstances : that.shouldKillInstances()
      },
      method : 'post',
      onComplete: function(transport) {
        var handled = that.processKillError(transport);
        if (!handled) {
          BS.reload(true);
        }
        that.postSubmit();
      }
    });
  }
});

BS.Clouds.Admin.ConfirmShutdownDialog = OO.extend(BS.Clouds.Admin.ConfirmDialog, {
  showConfirmDisableDialog: function() {
    var running = BS.Clouds.Admin.getRunningInstancesCount();
    $j("#confirmShutdownTitle").text("Change Cloud Integration Status");
    $j("#enableCheckbox").show();
    $j('#enableProject').prop('checked', $j('#initiallyEnabled').val() == 'true');
    $j("#enableSubprojectsCheckbox").show();
    $j("#enableSubprojects").prop('checked', $j('#initiallySubprojectsEnabled').val() == 'true');
    $j("#allowSubprojectsOverwriteCheckbox").show();

    var showDialog = this.showDialog('', 'Update', running);
    BS.Clouds.Admin.updateDependentCheckboxes();
    return showDialog;
  },

  onConfirm: function() {
    var form = 'confirmShutdown';
    var url = $(form).getAttribute('action');

    var that = this;
    BS.ajaxRequest(url, {
      parameters : {
        action : 'update',
        kill : that.shouldKillInstances(),
        enableProject : that.enableProject(),
        enableSubprojects : that.enableSubprojects(),
        allowOverride : that.allowOverride()
      },
      method: 'post',
      onComplete: function(transport) {
        var handled = that.processKillError(transport);
        if (!handled) {
          BS.reload(true);
        }
        that.postSubmit();
      }
    });
  }
});


