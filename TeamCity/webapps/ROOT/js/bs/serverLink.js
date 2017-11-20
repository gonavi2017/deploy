BS.ServerUnavailableModalDialog = OO.extend(BS.AbstractModalDialog, {
  zIndex: 1000,
  _wasClosed: false,

  _getCurrentDate: function() {
    var current = new Date();
    var h = (current.getHours() < 10) ? ("0" + current.getHours()) : current.getHours();
    var m = (current.getMinutes() < 10) ? ("0" + current.getMinutes()) : current.getMinutes();
    return $j.datepicker.formatDate("dd M yy", current) + " " + h + ":" + m;
  },

  getContainer: function() {
    return $('shutdownDialog');
  },

  displayShutdownNote: function() {
    if (this._shutdownNoteIsDisplayed || this._wasClosed) return;

    this._shutdownNoteIsDisplayed = true;
    BS.Util.hide('onCommunicationFailure');
    BS.Util.hide('onAuthFailure');
    BS.Util.show('onServerShutdown');
    $('shutdownDetails').innerHTML = "Server is unavailable since " + this._getCurrentDate();
    this.showCentered();
  },

  displayFailureNote: function() {
    if (this._failureNoteIsDisplayed || this._wasClosed) return;

    this._failureNoteIsDisplayed = true;
    BS.Util.hide('onServerShutdown');
    BS.Util.hide('onAuthFailure');
    BS.Util.show('onCommunicationFailure');
    $('shutdownDetails').innerHTML = "Server is unavailable since " + this._getCurrentDate();
    this.showCentered();
  },

  displayAuthFailureNote: function() {
    if (this._authFailureNoteIsDisplayed || this._wasClosed) return;

    this._authFailureNoteIsDisplayed = true;
    BS.Util.hide('onServerShutdown');
    BS.Util.hide('onCommunicationFailure');
    BS.Util.show('onAuthFailure');
    $('shutdownDetails').innerHTML = "You are logged out since " + this._getCurrentDate();
    this.showCentered();
  },

  afterClose: function() {
    //we are using afterClose instead of overriding close() function because close() is not invoked when dialog is closed by ESC keypress.
    this._wasClosed = true;
  },

  reset: function() {
    this._wasClosed = false;
    this._shutdownNoteIsDisplayed = false;
    this._failureNoteIsDisplayed = false;
    this._authFailureNoteIsDisplayed = false;
  }
});

BS.ServerLink = OO.extend(BS.AbstractModalDialog, {
  _shutdown: false,
  _failuresNum: 0,
  _authFailureNums: 0,

  /**
   * We don't want to reload all pages at the same time and immediately after server start,
   * because it just increases server load without any effect - pages will not be returned until jsp are compiled.
   */
  _scheduleReloadAfterUpgrade: function (oldVersion, newVersion) {
    if (!this._reloadTimeout)  {

      //reload after 30-60 seconds
      var reloadTimeoutInSeconds = Math.floor((Math.random() * 30) + 30);
      BS.Log.info("Server was upgraded (" + oldVersion + " -> " + newVersion + "), page will be reloaded in " + reloadTimeoutInSeconds + " seconds.");

      this._reloadTimeout = setTimeout(function() {
        BS.reload(true);
      }, reloadTimeoutInSeconds * 1000)
    }
  },

  _onFailure: function() {
    if (++this._failuresNum > 1) { //don't show it immediately, only after second failure
      if (this._shutdown) {
        BS.ServerUnavailableModalDialog.displayShutdownNote();
      } else {
        BS.ServerUnavailableModalDialog.displayFailureNote();
      }
    }
  },

  _onAuthFailure: function() {
    if (++this._authFailureNums > 3) {
      BS.ServerUnavailableModalDialog.displayAuthFailureNote();
    }

    // In case of hub plugin we can try to authenticate by navigating user to the some page in a hidden iframe:
    // user will be redirected to hub and then back to teamcity if authenticated.
    // After it user session will become authenticated and the following ajax request will be successful.
    if (!this._tryToAuthenticateIframe) {
      this._tryToAuthenticateIframe = document.createElement("iframe");
      this._tryToAuthenticateIframe.setAttribute("src", window['base_uri'] + "/authenticationTest.html");
      this._tryToAuthenticateIframe.setAttribute("style", "width:0;height:0;border:0; border:none; visibility:hidden; position:absolute");
      document.body.appendChild(this._tryToAuthenticateIframe);
    }
  },

  _onSuccess: function() {
    this._shutdown = false;
    this._failuresNum = 0;
    this._authFailureNums = 0;

    if (this._tryToAuthenticateIframe) {
      document.body.removeChild(this._tryToAuthenticateIframe);
      this._tryToAuthenticateIframe = null;
    }

    BS.ServerUnavailableModalDialog.close();
    BS.ServerUnavailableModalDialog.reset();
  },

  onShutdown: function() {
    this._shutdown = true;
  },

  isConnectionAvailable: function() {
    return this._failuresNum == 0
  },

  subscribeOnServerRestart: function (onRestart) {
    this._onRestart = onRestart;
  },

  waitUntilServerIsAvailable: function (callback) {

    var that = this;

    var poller = BS.periodicalExecutor(function () {
      var deferred = $j.Deferred();
      that.getServerInfo(function(response) {
        if (response.status == 200) {

          var serverElement = response.responseXML.documentElement;

          if (!serverElement) {
            BS.Log.error("Successful connection from the server with unknown version");
            deferred.resolve();
            return;
          }

          var buildNumber = serverElement.getAttribute("buildNumber");
          var startTime = serverElement.getAttribute("startTime");

          if (buildNumber != that._buildNumber) {
            that._scheduleReloadAfterUpgrade(that._buildNumber, buildNumber);
            poller.stop();
            return;
          }

          if (startTime != that._serverStartTime) {
            BS.Log.info("Server was restarted (" + that._serverStartTime + " -> " + startTime + ")");
            if (that._onRestart) {
              that._onRestart();
            }
          }

          that._onSuccess();

          poller.stop();
          callback();

        } else {
          if (response.status == 401) {
            that._onAuthFailure();
          } else {
            that._onFailure();
          }

          deferred.resolve();
        }
      });
      return deferred;
    }, BS.internalProperty('teamcity.ui.serverAvailability.pollInterval') * 1000);

    setTimeout(poller.start.bind(poller), BS.internalProperty('teamcity.ui.serverAvailability.pollInterval') * 1000);
  },

  getServerInfo: function (onComplete) {
    BS.ajaxRequest(window['base_uri'] + '/app/rest/server?fields=startTime,buildNumber', {
      method: 'GET',
      onComplete: onComplete
    });
  },

  init: function () {
    var that = this;
    this.getServerInfo(function (response) {
      if (response.status == 200 && response.responseXML) {
        var serverElement = response.responseXML.documentElement;
        that._buildNumber = serverElement.getAttribute("buildNumber");
        that._serverStartTime = serverElement.getAttribute("startTime");
        BS.Log.info("Server version: " + response.responseText)
      }
    });
  }
});
