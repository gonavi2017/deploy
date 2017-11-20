jQuery(function($) {
  var editor = BS.internalProperty('teamcity.ui.codeMirrorEditor.enabled', true) ? BS.CodeMirror.fromTextArea(document.getElementById("metaRunnerContent"), {
    mode: 'xml',
    viewportMargin: Infinity
  }) : null;

  var navigateToMetaRunners = function() {
    var location = " " + document.location.href;
    document.location.href = location.replace(/&editRunnerId=[^&]*/, "");
    return false;
  };

  var submitFrom = function() {
    var controllerUrl = $("div.metaRunnerEditSettings").data("controller");
    var projectId = $("div.metaRunnerEditSettings").data("project-id");
    var metaRunnerId = $("div.metaRunnerEditSettings").data("meta-runner-id");
    var content = BS.internalProperty('teamcity.ui.codeMirrorEditor.enabled', true) ? editor.getValue() : $("#metaRunnerContent").val();

    $("#error_metaRunnerContent").hide();
    $("#metaRunnerEditSaving").show();

    BS.ajaxRequest(controllerUrl, {
                     method: "post",
                     parameters: Object.toQueryString(
                         {
                           projectId: projectId,
                           editRunnerId: metaRunnerId,
                           metaRunnerContent: content
                         }),

                     onComplete: function (transport) {
                       var setErrorText = function (text) {
                         if (!!text) {
                           $("#error_metaRunnerContent").show();
                         } else {
                           $("#error_metaRunnerContent").hide();
                         }
                         $("#error_metaRunnerContent").text(text);
                       };
                       $("#metaRunnerEditSaving").hide();

                       var json = transport.responseJSON;
                       if (!json) {
                         setErrorText("Unknown response from server.");
                         return;
                       }

                       if (json.specError) {
                         setErrorText(json.specError);
                         return;
                       }

                       if (json.succeeded) {
                         setTimeout(navigateToMetaRunners, 10);
                       }
                     }
                   }
    );
    return false;
  };

  $("div.metaRunnerEditSettings form").submit(submitFrom);
  $("div.metaRunnerEditSettings form input[type='submit']").click(submitFrom);
  $("div.metaRunnerEditSettings form input[type='button'].btn.cancel").click(navigateToMetaRunners);
});
