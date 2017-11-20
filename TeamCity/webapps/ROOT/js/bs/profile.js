BS.UserProfile = {
  makeEditable: function(elementId) {
    BS.Util.hide("editLink_" + elementId);
    BS.Util.hide("text_" + elementId);

    var inputId = "input_" + elementId;
    BS.Util.show(inputId);

    var input = $(inputId);
    if (input) {
      input.focus();
    }
  },

  onUserPropertyError: function(element, form) {
    var separatorIndex = element.firstChild.nodeValue.indexOf(":");
    if (separatorIndex < 0) return;

    var propId = element.firstChild.nodeValue.substr(0, separatorIndex);
    var errorMsg = element.firstChild.nodeValue.substr(separatorIndex + 1);
    var errorSpan = $("error_" + propId);
    if (errorSpan != null) {
      errorSpan.innerHTML = errorMsg;
      var input = $("input_" + propId);
      if (input) {
        form.highlightErrorField(input);
      }
    }
  }
};


