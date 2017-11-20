BS.IssueDetails = function(elementId, issueId, providerId, projectExternalId) {
  BS.Popup.call(this, elementId, {
    issueId: issueId,
    providerId: providerId,
    projectExternalId: projectExternalId,

    shift: {x : -80},
    zIndex: 200,

    textProvider: function(popup) {
      if (!$('issueDetailsTemplate')) return "";
      var text = $('issueDetailsTemplate').innerHTML;
      text = text.replace(/##ISSUE_ID##/g, popup.options.issueId);
      text = text.replace(/##PROJECT_ID##/g, popup.options.projectExternalId);
      setTimeout(function() { this.showDetailedInfo(); }.bind(popup), 50);
      return text;
    }
  });
};

_.extend(BS.IssueDetails.prototype, BS.Popup.prototype);

BS.IssueDetails.prototype.showDetailedInfo = function() {
  this._loaded = false;
  var issueId = this.options.issueId;
  var providerId = this.options.providerId;
  var projectId = this.options.projectExternalId;
  var url = window['base_uri'] + "/issueDetailsPopup.html";

  BS.ajaxUpdater($('detailedSummary:' + issueId + "_" + projectId), url, {
    evalScripts: true,
    method: 'GET',
    parameters: {
      issueId: issueId,
      providerId: providerId,
      projectId: projectId
    },
    onComplete: function() {
      this.updatePopup();
      this._loaded = true;
    }.bind(this)
  });
};
