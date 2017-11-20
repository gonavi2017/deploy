/**
 * Created by Evgeniy.Koshkin on 26.11.2015
 */

if (!BS) BS = {};

if (!BS.Tools) BS.Tools = {

  installUrl : '',
  removeUrl : '',
  setDefaultUrl : '',
  showUsagesUrl : '',

  refreshToolsList : function(toolType) {
    if(toolType && $(toolType + '-container')){
      $(toolType + '-container').refresh(null, "toolType=" + encodeURIComponent(toolType), null);
      return false;
    }
    if($('all-types-container')) $('all-types-container').refresh(null, null, null);
    return false;
  },

  removeTool : function(toolId, toolDisplayName, showDialog){
    if(showDialog)
      BS.Tools.RemoveDialog.show(toolId, toolDisplayName);
    else{
      BS.ajaxRequest(BS.Tools.installUrl, {
        parameters: {
          actionName: "remove",
          toolId: toolId
        },
        onComplete: function () {
          BS.Tools.refreshToolsList(null);
        }
      });
    }
  },

  setDefault : function(newDefaultToolId, toolTypeId, toolTypeDisplayName, showDialog){
    if(showDialog)
      BS.Tools.SetDefaultDialog.show(newDefaultToolId, toolTypeId, toolTypeDisplayName);
    else{
      BS.ajaxRequest(BS.Tools.installUrl, {
        parameters: {
          actionName: "default",
          toolId: newDefaultToolId
        },
        onComplete: function () {
          BS.Tools.refreshToolsList(that.toolTypeId);
        }
      });
    }
  }
};

if (!BS.Tools.InstallDialog) {
  BS.Tools.InstallDialog = OO.extend(BS.PluginPropertiesForm, OO.extend(BS.AbstractModalDialog, {
    getContainer: function () {
      return $('InstallDialogFormDialog');
    },

    formElement: function () {
      return $('InstallDialogForm');
    },

    save : function() {
      BS.Util.show(this.savingIndicator());

      var listener = OO.extend(BS.ErrorsAwareListener, {
        onCompleteSave: function(form, responseXML, err) {
          var wereErrors = BS.XMLResponse.processErrors(responseXML, {
            tool_upload: function (elem) { // see TW-46159
              BS.PluginPropertiesForm.showError('tool_upload', elem.textContent);
            }
          }, form.propertiesErrorsHandler);
          BS.ErrorsAwareListener.onCompleteSave(form, responseXML, err);

          BS.Util.reenableForm(form.formElement());
          BS.Util.hide(form.savingIndicator());
          if (!wereErrors) {
            BS.Tools.refreshToolsList(null);
            form.close();
          }
        }});

      if($j('#actionName').val() == 'install'){
        BS.FormSaver.save(this, BS.Tools.installUrl, listener);
      } else { //upload
        BS.MultipartFormSaver.save(this, BS.Tools.installUrl, listener);
      }
      return false;
    },

    savingIndicator: function () {
      return $('installProgress');
    },

    show: function (){
      BS.Util.reenableForm(this.formElement());
      $("InstallDialogFormTitle").innerHTML = "Install Tool";
      var installFormRefreshContainer = $("installFormRefresh");
      var loadingIndicator = $("installFormLoading");
      BS.Util.hide(installFormRefreshContainer);
      BS.Util.show(loadingIndicator);
      var that = this;
      BS.ajaxUpdater(installFormRefreshContainer, BS.Tools.installUrl, {
        method: 'get',
        evalScripts: true,
        onComplete: function() {
          BS.Util.show($("toolTypeSelectorContainer"));
          BS.Util.hide(loadingIndicator);
          BS.Util.show(installFormRefreshContainer);
          that.showCentered();
        }
      });

      return false;
    },

    showUploadForToolType : function (toolTypeId, toolTypeName) {
      return this.showForToolType(toolTypeId, "Upload " + toolTypeName);
    },

    showInstallForToolType : function (toolTypeId, toolTypeName) {
      return this.showForToolType(toolTypeId, "Install " + toolTypeName);
    },

    showForToolType: function (toolTypeId, title) {
      BS.Util.reenableForm(this.formElement());
      $("InstallDialogFormTitle").innerHTML = title;
      this.showCentered();

      var that = this;
      var installFormRefreshContainer = $("installFormRefresh");
      var loadingIndicator = $("installFormLoading");
      BS.Util.hide(installFormRefreshContainer);
      BS.Util.show(loadingIndicator);

      var refreshParams = "toolType=" + toolTypeId;
      BS.ajaxUpdater(installFormRefreshContainer, BS.Tools.installUrl, {
        method: 'get',
        parameters: refreshParams,
        evalScripts: true,
        onComplete: function() {
          BS.Util.hide($("toolTypeSelectorContainer"));
          BS.Util.hide(loadingIndicator);
          BS.Util.show(installFormRefreshContainer);
          that.showCentered();
          $j('#selectedToolType').val(toolTypeId);
        }
      });

      return false;
    },

    selectToolType: function () {
      var selector = $('toolType');
      var selectedIndex = selector.selectedIndex;
      if (selectedIndex <= 0) {
        return;
      }
      var toolTypeId = selector.options[selectedIndex].value;
      var toolTypeName = selector.options[selectedIndex].innerHTML;
      this.showInstallForToolType(toolTypeId, toolTypeName);
    },

    switchInstallMode: function(newMode){
      if(newMode.toLowerCase() == 'install'){
        BS.Util.hide('uploadSettingsContainer');
        BS.Util.show('downloadSettingsContainer');
      } else{
        BS.Util.show('uploadSettingsContainer');
        BS.Util.hide('downloadSettingsContainer');
      }
      $j('#actionName').val(newMode);
      return false;
    },

    selectToolVersion: function(){
      var selector = $('toolVersion');
      var selectedIndex = selector.selectedIndex;
      if (selectedIndex <= 0) {
        return;
      }
      $j('#selectedToolId').val(selector.options[selectedIndex].value);
      $j('#selectedToolVersion').val(selector.options[selectedIndex].text);
    }
  }));
}

if(!BS.Tools.RemoveDialog){
  BS.Tools.RemoveDialog = OO.extend(OO.extend(BS.AbstractModalDialog, {
    toolId : null,

    getContainer: function () {
      return $('RemoveDialogFormDialog');
    },

    formElement: function () {
      return $('RemoveDialogForm');
    },

    savingIndicator: function () {
      return $('removeProgress');
    },

    show : function(toolId, toolDisplayName){
      BS.Util.reenableForm(this.formElement());
      $("RemoveDialogFormTitle").innerHTML = "Remove Tool " + toolDisplayName;
      var removeFormRefreshContainer = $("removeFormRefresh");
      var loadingIndicator = $("removeFormLoading");
      BS.Util.hide(removeFormRefreshContainer);
      BS.Util.show(loadingIndicator);

      var that = this;
      BS.ajaxUpdater(removeFormRefreshContainer, BS.Tools.removeUrl, {
        method: 'get',
        evalScripts: true,
        parameters : {
          toolId : toolId
        },
        onComplete: function() {
          BS.Util.hide(loadingIndicator);
          BS.Util.show(removeFormRefreshContainer);
          that.toolId = toolId;
          that.showCentered();
        }
      });
      return false;
    },

    save: function(){
      BS.Util.show(this.savingIndicator());
      var that = this;
      BS.ajaxRequest(BS.Tools.installUrl, {
        parameters: {
          actionName: "remove",
          toolId: that.toolId
        },

        onComplete: function () {
          BS.Util.hide(that.savingIndicator());
          that.close();
          that.toolId = null;
          BS.Tools.refreshToolsList(null);
        }
      });
      return false;
    }
  }));
}

if(!BS.Tools.SetDefaultDialog){
  BS.Tools.SetDefaultDialog = OO.extend(OO.extend(BS.AbstractModalDialog, {
    toolId : null,
    toolTypeId : null,

    getContainer: function () {
      return $('SetDefaultDialogFormDialog');
    },

    formElement: function () {
      return $('SetDefaultDialogForm');
    },

    savingIndicator: function () {
      return $('setDefaultProgress');
    },

    show: function(newDefaultToolId, toolTypeId, toolTypeDisplayName){
      BS.Util.reenableForm(this.formElement());
      $("SetDefaultDialogFormTitle").innerHTML = "Set Default Version of " + toolTypeDisplayName;
      var setDefaultFormRefreshContainer = $("setDefaultFormRefresh");
      var loadingIndicator = $("setDefaultFormLoading");
      BS.Util.hide(setDefaultFormRefreshContainer);
      BS.Util.show(loadingIndicator);

      var that = this;
      BS.ajaxUpdater(setDefaultFormRefreshContainer, BS.Tools.setDefaultUrl, {
        method: 'get',
        evalScripts: true,
        parameters : {
          toolId : newDefaultToolId
        },
        onComplete: function() {
          BS.Util.hide(loadingIndicator);
          BS.Util.show(setDefaultFormRefreshContainer);
          that.toolId = newDefaultToolId;
          that.toolTypeId = toolTypeId;
          that.showCentered();
        }
      });
      return false;
    },

    save: function(){
      BS.Util.show(this.savingIndicator());
      var that = this;
      BS.ajaxRequest(BS.Tools.installUrl, {
        parameters: {
          actionName: "default",
          toolId: that.toolId
        },

        onComplete: function () {
          BS.Util.hide(that.savingIndicator());
          that.close();
          BS.Tools.refreshToolsList(that.toolTypeId);
          that.toolId = null;
        }
      });
      return false;
    }
  }));
}

if(!BS.Tools.ShowUsagesDialog){
  BS.Tools.ShowUsagesDialog = OO.extend(OO.extend(BS.AbstractModalDialog, {
    getContainer: function () {
      return $('ShowUsagesDialogFormDialog');
    },

    formElement: function () {
      return $('ShowUsagesDialogForm');
    },

    show: function(toolId, toolVersionDisplayName){
      BS.Util.reenableForm(this.formElement());
      $("ShowUsagesDialogFormTitle").innerHTML = "Usages of " + toolVersionDisplayName;
      var showUsagesFormRefreshContainer = $("showUsagesFormRefresh");
      var loadingIndicator = $("showUsagesFormLoading");
      BS.Util.hide(showUsagesFormRefreshContainer);
      BS.Util.show(loadingIndicator);

      var that = this;
      BS.ajaxUpdater(showUsagesFormRefreshContainer, BS.Tools.showUsagesUrl, {
        method: 'get',
        evalScripts: true,
        parameters : {
          toolId : toolId
        },
        onComplete: function() {
          BS.Util.hide(loadingIndicator);
          BS.Util.show(showUsagesFormRefreshContainer);
          that.showCentered();
        }
      });
      return false;
    }
  }));
}