
BS.JVMUpdate = {
  Dialog : OO.extend(BS.AbstractModalDialog, {
    getContainer: function() { return $('jvmUpdateDialog'); },

    submitJvmUpdate: function() {
      BS.Util.disableFormTemp($('jvmUpdate'));
      BS.Util.show('jvm-saving');

      BS.ajaxRequest($('jvmUpdate').action, {
        parameters : {
          jvm : $('jvm').value,
          id : $('agentId').value
        },

        onComplete: function() {
          BS.reload(true);
        }
      });

      return false;
    },

    showDialog: function() {
      this.showCentered();
      this.bindCtrlEnterHandler(this.submitJvmUpdate.bind(this));
      return false;
    }
  })
};
