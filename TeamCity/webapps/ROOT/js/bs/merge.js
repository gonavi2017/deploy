BS.Merge = OO.extend(BS.AbstractModalDialog, {

  branchesDropDownInitialized: false,

  getContainer: function() {
    return $('mergeSourcesFormDialog');
  },

  showEditDialog: function(buildId, branchName) {
    this._clearErrors();
    this._initBranchesDropDown();
    this.showCentered();
    $('message').value = "Merge branch '" + branchName + "'";
  },

  _initBranchesDropDown: function () {
    if (!this.branchesDropDownInitialized) {
      BS.enableJQueryDropDownFilter('dstBranch', '{}');
      this.branchesDropDownInitialized = true;
    }
  },

  _clearErrors: function() {
    $("error_dstBranch").innerHTML = '';
    $("error_message").innerHTML = '';
  },

  merge: function() {
    var f = $('mergeSourcesForm');
    Form.disable(f);
    BS.Util.show('mergingSources');
    BS.ajaxRequest(f.action, {
      parameters: BS.Util.serializeForm(f),
      onComplete: function(transport) {
        BS.Merge._clearErrors();
        var errors = BS.XMLResponse.processErrors(transport.responseXML, {
          onDstBranchError: function(elem) {
            $("error_dstBranch").innerHTML = elem.firstChild.nodeValue;
            BS.Util.hide('mergingSources');
            Form.enable(f);
          },

          onMessageError: function(elem) {
            $("error_message").innerHTML = elem.firstChild.nodeValue;
            BS.Util.hide('mergingSources');
            Form.enable(f);
          }
        });

        if (!errors) {
          BS.Util.hide('mergingSources');
          Form.enable(f);
          BS.Merge.close();
          if ($('buildLabels')) {
            $('buildLabels').refresh();
          }
        }
      }
    });
    return false;
  }
});