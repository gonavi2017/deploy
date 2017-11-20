/*
 * Copyright 2000-2017 JetBrains s.r.o.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

if (BS.AbstractModalDialog && BS.AbstractWebForm) {

BS.StopBuildDialog = OO.extend(BS.AbstractWebForm, OO.extend(BS.AbstractModalDialog, {

  operationKind: 0,


  formElement: function() {
    return $('stopBuildForm');
  },

  getContainer: function() {
    return $('stopBuildFormDialog');
  },

  handleBuildNotFound: function() {
    $j('#removeQueuedBuildComment').hide();
    $j('#submitRemoveQueuedBuild').hide();
    this.refreshPageAfterClose = true;
  },

  afterClose: function() {
    if (this.refreshPageAfterClose) {
      this.refreshPageAfterClose = false;
      $j('#removeQueuedBuildComment').show();
      $j('#submitRemoveQueuedBuild').show();
      $j('#moreToStopFragment').hide();
      BS.reload(true);
    }
  },


  /**
   * Shows the dialog to one of the following 3 actions: remove a build from the queue, stop a running build, remove a finished build.
   *
   * @param promoIds        array of promotion identifiers. Mostly one identifier only.
   * @param defaultMessage
   * @param operationKind      See StopBuildAction.KillOperationKind:
   *                           1 - remove a queued build,
   *                           2 - stop a running build,
   *                           3 - remove a finished build.
   * @param reStopMessage
   */
  showStopBuildDialog: function(promoIds, defaultMessage, operationKind, reStopMessage) {
    if (promoIds.length == 0) {
      alert("Please select at least one build.");
      return;
    }

    this.enable();

    this.operationKind = operationKind;
    this.formElement().operationKind.value = operationKind;

    if (!!reStopMessage && $(reStopMessage)) {
      $("moreToStopRetryNotice").innerHTML = $(reStopMessage).innerHTML;
      BS.Util.show($("moreToStopRetryNotice"));
    } else {
      $("moreToStopRetryNotice").innerHTML = '';
      BS.Util.hide($("moreToStopRetryNotice"));
    }

    switch (operationKind) {
      case 1:
        var builds = promoIds.length > 1 ? promoIds.length + ' builds' : 'build';
        $('stopBuildFormTitle').innerHTML = 'Remove ' + builds + ' from the queue';
        this.formElement().submit.value = 'Remove';
        break;
      case 2:
        $('stopBuildFormTitle').innerHTML = 'Stop running build';
        this.formElement().submit.value = 'Stop';
        break;
      case 3:
        $('stopBuildFormTitle').innerHTML = 'Remove this build';
        this.formElement().submit.value = 'Remove';
        break;
    }

    $('moreToStopFragment').innerHTML = '';
    $('moreToStop').style.display = 'none';

    // must be after clearing of moreToStopFragment, otherwise form will have more than one input with name "kill"
    this.formElement().kill.value = promoIds.join(',');

    if (promoIds.length == 1) {
      $('moreToStop').style.display = 'block';
      $('moreToStopLoader').style.display = 'inline';

      this.disable();
      BS.ajaxUpdater('moreToStopFragment', window['base_uri'] + "/promotionGraph.html", {
        parameters: "buildPromotionId=" + new String(promoIds[0]) + "&jsp=moreToStop.jsp" + "&operationKind=" + operationKind,
        evalScripts: true,
        onComplete: function() {
          $('moreToStop').style.display = 'none';
          if (operationKind == 3)
            $j("#reAddSection").hide();
          BS.StopBuildDialog.initSelectAll();
          BS.StopBuildDialog.enable();
        }
      });
    }

    this.formElement().comment.value = defaultMessage != null && defaultMessage.length > 0 ? defaultMessage : this.formElement().comment.defaultValue;
    this.showCentered();
    $(this.formElement().comment).activate();

    this.bindCtrlEnterHandler(this.killBuild.bind(this));
    
    this.setSaving(false);
  },

  savingIndicator: function() {
    return $('stopBuildIndicator');
  },

  killBuild: function(buildPromotionId) {
    if (buildPromotionId) {
      this.formElement().kill.value = buildPromotionId;
    }

    if (this.formElement().comment.value == this.formElement().comment.defaultValue) {
      this.formElement().comment.value = "";
    }

    if (this.isVisible()) {
      this.setSaving(true);
      this.disable();
    }

    var that = this;
    var params = this.serializeParameters();

    BS.ajaxRequest(this.formElement().action, {
      parameters: params,
      onSuccess: function(transport) {
        var doc = BS.Util.documentRoot(transport);

        var onComplete = function() {
          if (that.isVisible()) {
            that.setSaving(false);
            that.enable();
            that.close();
          }

          if (BS.EventTracker) {
            BS.EventTracker.checkEvents();
          }

          if (BS.QueuedBuildsPopup && BS.QueuedBuildsPopup.isShown()) {
            BS.QueuedBuildsPopup.hidePopup();
          }
        };

        switch (that.operationKind) {
          case 1:
            if (BS.Queue) {
              var unqueued = doc.getElementsByTagName("unqueuedBuild");
              if (unqueued && unqueued.length > 0) {
                var ids = [];
                for (var i = 0; i < unqueued.length; i++) {
                  var itemId = unqueued[i].firstChild.nodeValue;
                  ids.push(itemId);
                }
                BS.Queue.removeQueuedBuilds(ids, onComplete);
              } else {
                // seems build was already deleted, refresh container
                BS.Queue.refreshQueuedBuilds(onComplete);
              }
            }
            return;

          case 2:
            var stopped = doc.getElementsByTagName("stoppedBuild");
            if (stopped) {
              for (var i = 0; i < stopped.length; i ++) {
                var promoId = stopped[i].firstChild.nodeValue;
                that.setStopping(promoId);
              }
            }
            onComplete();
            return;

          case 3:
            var btId = doc.getElementsByTagName("bt")[0].firstChild.nodeValue;
            var url = window['base_uri'] + "/viewType.html?buildTypeId=" + btId;
            window.location = url;
            onComplete();
            return;
        }
      },

      onFailure: function() {
        if (that.isVisible()) {
          that.setSaving(false);
          that.enable();
        }
        alert("Sorry, error accessing the server");
      }

    });

    return false;
  },

  setStopping: function(buildPromotionId) {
    var updateLink = function(newText) {
      var link = $('stopBuild:' + buildPromotionId + ':link');
      if (link) {
        link.innerHTML = newText;
        link.addClassName('stopping');
      }
    };

    //TODO: reuse texts generated from HTML
    updateLink('<span class="stopping">Stopping</span>');
    if ($('stopBuild:' + buildPromotionId + ':message')) {
      $('stopBuild:' + buildPromotionId + ':message').innerHTML = "This build has already been stopped by <em>you</em>";
    }

    setTimeout(function() {
      updateLink('<span class="stopping" title="TeamCity cannot stop this build. Please log in to the build agent and resolve the situation manually.">Cannot stop</span>');
    }, 5 * 60* 1000)
  },

  // 'All builds' checkbox
  initSelectAll: function() {
    var otherBuilds = $j("#moreToStopFragment input[name='kill']");
    $j("#killAll").change(function() {
      var checked = this.checked;

      otherBuilds.each(function() {
        this.checked = checked;
      });
    });
  }

}));

}
