BS.RebootAgentDialog = OO.extend(BS.AbstractModalDialog, {
  getContainer: function() {
    return $('rebootAgent')
  },

  sendReboot: function(agentId) {
    $('rebootAgentLoader').show();

    var rebootAfterBuildVal = $('rebootAfterBuild').checked;
    var that = this;
    BS.ajaxRequest('remoteAccess/reboot.html?agent=' + agentId + '&rebootAfterBuild=' + rebootAfterBuildVal,
                   {
                     onComplete: function(transport) {
                       var xml = transport.responseXML;
                       var text;
                       if (xml.getElementById("rebootError")) {
                         text = xml.getElementById("rebootError").textContent;
                       } else {
                         text = xml.getElementById("rebootMessage").textContent;
                         var rebootState = xml.getElementById("rebootState").textContent;
                         BS.Util.toggleDependentElements(rebootState, 'rebootControl');
                       }
                       $('rebootAgentLoader').hide();
                       that.close();
                       alert(text);
                     }
                   });
  }
});