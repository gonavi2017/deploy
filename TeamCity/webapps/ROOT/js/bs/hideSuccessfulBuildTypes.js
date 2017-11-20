/**
 * Support for hiding successful build configurations for a change details.
 *
 * Used on My Changes page and on Change page (both for builds tab)
 *
 * @author kir
 * */
BS.HideSuccessfulSupport = {
  setSuccessfulVisible: function(action_checkbox, modId_personal, buildTypes, skipServerUpdate) {

    if (!buildTypes) buildTypes = BS.buildTypes;
    var hide = action_checkbox.checked;

    var apply_visibility = function() {
      this._applyVisibility2buildTypes(hide, buildTypes, modId_personal);
    }.bind(this);

    if (skipServerUpdate) {
      apply_visibility();
    }
    else {
      BS.User.setBooleanProperty('changePage_hideSuccessful', hide, {
        afterComplete: apply_visibility
      });
    }

    return false;
  },

  storedHiddenSuccessful: function() {
    BS._storedHiddenSuccessful = BS._storedHiddenSuccessful || {};
    return BS._storedHiddenSuccessful;
  },


  _applyVisibility2buildTypes: function(hideNotFailed, buildTypes, modId_personal) {
    // Hide/Show successful build type blocks:
    var shown = 0;
    var hidden = 0;

    this.storedHiddenSuccessful()[modId_personal] = hideNotFailed;
    if (buildTypes) {
      for(var bt_id in buildTypes) {
        var block = $('viewModificationBuildType_' + bt_id + '_' + modId_personal);
        if (block) {
          //noinspection BadExpressionStatementJS
          if (hideNotFailed && !buildTypes[bt_id].failed) {
            BS.Util.hide(block);
            hidden ++;
            this.changeVisibilityForAdditionalRow(jQuery(block), 'hide');
          }
          else {
            BS.Util.show(block);
            shown ++;
            this.changeVisibilityForAdditionalRow(jQuery(block), 'show');
          }
        }
      }
    }
    return {shown: shown, hidden: hidden};
  },

  //we need this to support section1 from viewModificationBuildType.jsp
  changeVisibilityForAdditionalRow: function(tr, display){
    var nosplit = tr.hasClass('nosplit');
    if (nosplit){
      var nextRow = tr.next(".additional");
      if (nextRow!=undefined){
        if (display=='hide') {
          BS.Util.hide($(nextRow));
        }else{
          BS.Util.show($(nextRow));
        }
      }
    }
  }

};
