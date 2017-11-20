BS.LoginListener.superOnCompleteSave = BS.LoginListener.onCompleteSave;

BS.LoginListener = OO.extend(Win32.Extension, OO.extend(BS.LoginListener, {
  onCompleteSave: function(form, responseXML, errors) {
    if (errors) {
      this.superOnCompleteSave(form, responseXML, errors);
      return;
    }

    var userElems = responseXML.getElementsByTagName("user");
    if (userElems != null && userElems.length > 0) {
      var userElem = userElems.item(0);
      var userId = userElem.getAttribute("id");
      if (userId != null) {
        this.setAuthorizedUser(userId);
      }
    }
  }
}));

