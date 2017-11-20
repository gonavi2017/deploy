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

window.name = 'tcMain';

// Additionally define $j in JS to make IDEA happier
window.$j = window.$j || jQuery.noConflict;

$j(function() {
  BS.enableDisabled();
  BS._addCSRFHeader();   // Install header for jquery ajax requests
});

var OO = {
  extend: function(parent, extension) {
    return $j.extend({}, parent, extension);
  },

  bindAll: function(object) {
    var dest = new Object();
    for (var property in object) {
      if (typeof(object[property]) == "function") {
        dest[property] = object[property].bind(dest);
      } else {
        dest[property] = object[property];
      }
    }
    return dest;
  }
};

var BS = {
  Log: {
    log: function(msg, level) {
      var wc = window.console;
      if (wc && wc[level]) {
        wc[level](msg);
        if (msg.stack) {
          wc[level](msg.stack);
        }
      }
    },

    error:  function(msg) { this.log(msg, 'error') },
    warn:   function(msg) { this.log(msg, 'warn') },
    info:   function(msg) { this.log(msg, 'info') },
    debug:  function(msg) { this.log(msg, 'debug') }
  },

  loadingUrl: window['base_uri'] + "/img/spinner.gif",
  loadingIcon: '<i class="icon-refresh icon-spin"></i>',

  _canReload: true,
  _temporaryBlocked: false,
  _tempBlockedTimer: null,

  stopObservingInContainers: function(elements) {
    if (elements.nodeType == 1) {
      elements = [elements];
    }
    var i = elements.length;

    while (i--) {
      var el = elements[i];
      // BS.Log.info("Clean all data under element " + el.id);

      jQuery.cleanData(el.getElementsByTagName('*'));
      jQuery.cleanData([el]);
      Element.purge(el);
    }
  },

  refreshBlocked: function() {
    return !BS._canReload || BS._temporaryBlocked;
  },

  canReload: function() {
    return !BS.Hider.hasVisiblePopups() && !BS.refreshBlocked() &&
           document.readyState != 'loading' && document.readyState != 'uninitialized';
  },

  initReloadBlocker: function() {
    if(BS.Browser.mozilla) {
      $(document.body).on("mousedown", function(event, element) {
        if (typeof BS == 'object') {
          if (element.tagName.toUpperCase() == 'A' && element.href && (element.href.indexOf("#") == -1 || element.href.indexOf("javascript://") == -1)) {
            BS.blockRefreshTemporary(1000);
          }
        }
      });
    }

    $(document.body).on("mousemove", function() {
      if (typeof BS != 'object') return;
      BS.blockRefreshTemporary(100);
    });

    Event.observe(window, "scroll", function() {
      if (typeof BS != 'object') return;
      BS.blockRefreshTemporary(100);
    });
  },

  blockRefreshTemporary: function(milliseconds) {
    // refresh blocked permanently ?
    if (!BS._canReload) return;

    var millis = milliseconds || 10*1000;

    if (BS._tempBlockedTimer) {
      clearTimeout(BS._tempBlockedTimer);
    }

    BS._temporaryBlocked = true;
    BS._tempBlockedTimer = setTimeout(function() {
      BS._temporaryBlocked = false;
    }, millis);
  },

  /**
   * A page might have several reasons for blocking refresh simultaneously. For example, some tests may be
   * selected and some stacktraces may be expanded. So instead of simply blocking/unblocking,
   * we need to take into account those various reasons.
   */
  _blockingActions: {},
  blockRefreshPermanently: function(action) {
    BS._blockingActions[action || 'default'] = true;
    BS._canReload = false;
  },

  unblockRefresh: function(action) {
    delete BS._blockingActions[action || 'default'];

    if (_.isEmpty(BS._blockingActions)) {
      BS._canReload = true;
      if (BS._tempBlockedTimer) {
        clearTimeout(BS._tempBlockedTimer);
      }
      BS._temporaryBlocked = false;
    }
  },

  _reloadTimeout: null,

  /**
   * Calls or queues passed function or `location.reload`
   * @param {Boolean} force
   * @param {Function} [reloadFunc=window.location.reload]
   * @param {Deferred} [deferred]
   */
  reload: function(force, reloadFunc, deferred) {
    if (!deferred) {
      deferred = $j.Deferred();
    }
    if (BS._reloadTimeout) {
      clearTimeout(BS._reloadTimeout);
      BS._reloadTimeout = null;
    }

    if (BS.canReload() || force) {
      deferred.resolve();
      if (reloadFunc) {
        reloadFunc();
      } else {
        window.location.reload(true);
      }
    }
    else {
      BS._reloadTimeout = setTimeout(function() {
        BS.reload(force, reloadFunc, deferred);
      }, 100);
    }
    return deferred;
  },

  /**
   * Trim text in the middle
   *
   * @param text {string} Text to trim
   * @param maxLength max number of visible characters to be shown after trim
   * @returns {string}
   */
  trimText: function(text, maxLength) {
    text = text || "";
    maxLength -= 1;
    if (text.length > maxLength + 3) {
      return text.substr(0, maxLength / 2) + '\u2026' + text.substr(text.length - maxLength / 2, text.length);
    }
    return text;
  },

  /**
   * @param {String} url
   * @param {Object} options
   * @returns {Ajax.Request}
   */
  ajaxRequest: function(url, options) {
    var opts = BS._patchOptions(url, options);

    return new Ajax.Request(url, opts);
  },

  /**
   * @typedef {Object} UpdaterTargetObject
   *
   * @prop {Element} [success]
   * @prop {Element} [failure]
   */
  /**
   * @param {Element|String|UpdaterTargetObject} container
   * @param {String} url
   * @param {Object} options
   * @returns {Ajax.Updater}
   */
  ajaxUpdater: function(container, url, options) {
    if (typeof container === 'string') { container = $(container); }
    if (container == null) return null;

    if (!container.success) container = { success: container };

    var opts = BS._patchOptions(url, options, container);

    return new Ajax.Updater(container, url, opts);
  },

  _getRequestKey: function(url, parameters) {
    if (_.isObject(parameters)) {
      return url + Object.toQueryString(parameters);
    } else if (_.isString(parameters)) {
      return url + parameters;
    } else {
      return url;
    }
  },

  _patchOptions: function(url, options, container) {
    if (options == null) {
      options = {};
    }

    this._addCSRFHeader(options);

    var oldOnComplete = options.onComplete;

    options.onComplete = function(response, json) {
      var respXML = response.responseXML;
      if (respXML) {
        var handled = BS.XMLResponse.processErrors(respXML, {
          onAccessDeniedError: function(elem) {
            BS.XMLResponse.processRedirect(elem.ownerDocument);
          }
        });
        if (handled) return;
      } else {
        if (BS._reloadIfReceivedHTML(response)) return;
      }

      if (oldOnComplete) {
        oldOnComplete.call(options, response, json);
      }

      if (container) {
        if ($(container) instanceof Element) {
          BS.loadRetinaImages(container);
        } else {
          ['success', 'failure'].forEach(function (key) {
            if (container[key]) {
              BS.loadRetinaImages(container[key]);
            }
          });
        }
      }
    };

    return options;
  },

  _addCSRFHeader: function(prototypeJsOptions) {
    var csrfToken = $j('meta[name=tc-csrf-token]').attr('content');
    if (csrfToken) {
      if (prototypeJsOptions) {
        prototypeJsOptions.requestHeaders = prototypeJsOptions.requestHeaders || {};
        prototypeJsOptions.requestHeaders['X-TC-CSRF-Token'] = csrfToken;
      }
      else {
        // Add support for $j.ajax requests:
        $j.ajaxSetup({
                       headers: {
                         "X-TC-CSRF-Token": csrfToken
                       }
                     });
      }
    }
  },

  internalProperty: function(propName, defVal) {
    var intPropVal = window['internalProps'] == undefined ? defVal : window['internalProps'][propName];
    return intPropVal == undefined ? defVal : intPropVal;
  },

  _reloadIfReceivedHTML: function(response) {
    var text = response.responseText;
    // proxies can return HTML with 502 (gateway timeout) status, in this case we should not reload entire page
    if (response.status == 200 && text.match(/^\s*<!DOCTYPE html[^>]*>[\s\S]*<\/html>\s*/i)) { // '.' does not match \n, while [\s\S] does
      BS.reload(true);
      return true;
    }

    return false;
  }
};

BS.Socket = function() {

  var handlers = {};

  var socket;
  var socketOpened = false;
  var onOpenCalled = false;
  var connectTimeouted = false;

  var socketOpenedDeferred;
  var connectTimeout;

  var pushQueue = [];    //list of pending messages that are going to be sent to the server.
  var flushQueueInterval;

  var loggedMessages = [];

  var log = function(message) {
    if (message.length > 100) {
      message = message.substring(0, 100) + "...";
    }
    if (loggedMessages.length > 50) {
      loggedMessages.shift();
    }
    var currentTime = new Date();
    var addLeadingZero = function(number) {
      if (number < 10) return "0" + number;
      else return "" + number;
    };
    var addTwoLeadingZeros = function(number) {
      if (number < 10) return "00" + number;
      if (number < 100) return "0" + number;
      else return "" + number;
    };
    var logMsg = '[' + addLeadingZero(currentTime.getHours()) + ":" + addLeadingZero(currentTime.getMinutes()) + ':' + addLeadingZero(currentTime.getSeconds()) + '.' +
                addTwoLeadingZeros(currentTime.getUTCMilliseconds()) + "]: " + message;
    BS.Log.debug("WebSocket: " + logMsg);
    loggedMessages.push(logMsg);
  };

  var reconnect = function(response) {
    if (socketOpened && response.state != "unsubscribe") { //response.state == "unsubscribe" when socket is closed normally, ex when user leaves page
      socketOpened = false;
      BS.ServerLink.waitUntilServerIsAvailable(openSocket);
    }
  };

  var webSocketFailed = function(reason) {
    log("WebSocket failed: " + reason);
    connectTimeouted = true;
    if (socketOpened) {
      atmosphere.unsubscribe();
    }
    socketOpened = false;
    if (socketOpenedDeferred.state() === 'pending') {
      socketOpenedDeferred.resolve(false);
    }
  };

  var webSocketOpened = function() {
    if (connectTimeouted) {
      atmosphere.unsubscribe();
      return;
    }
    socketOpened = true;
    clearTimeout(connectTimeout);
    log("WebSocket connection is successfully established");

    pushQueue = [];
    for (var topic in handlers) {
      if (handlers.hasOwnProperty(topic)) {
        pushQueue.push(topic);
      }
    }

    if (!flushQueueInterval) {
      flushQueueInterval = setInterval(function() {
        if (pushQueue.length > 0) {
          var message = pushQueue.join(',');
          sendToServer(message);
          pushQueue = [];
        }
      }, 500);
    }

    BS.Socket.subscribe("ping", function() {
      sendToServer("pong");
    });

    if (socketOpenedDeferred.state() === 'pending') {
      socketOpenedDeferred.resolve(true);
    };
  };

  var sendToServer = function(message) {
    log("Sending message '" + message + "'");
    socket.push(message);
  };

  var openSocket = function() {

    onOpenCalled = false;

    var atmosphereRequest = {
      url: window['base_uri'] + '/app/subscriptions',
      shared: false,
      trackMessageLength: true,
      transport: "websocket",
      fallbackTransport: "none",
      maxReconnectOnClose: 0,
      closeAsync: true,
      enableProtocol: false,
      headers: {
        "browserLocationHost" : window['base_uri']
      }
    };

    atmosphereRequest.onMessage = function(response) {
      var responseBody = response.responseBody;
      log("Message received: '" + responseBody + "'");

      //Server sends 'socketWorks' message when it receives 'testSocket' message that client send on socket opening.
      //We consider connection as established only if this round trip is successful.
      if (responseBody == 'socketWorks') {
        webSocketOpened();
        return;
      }

      //all other messages has the format 'topic#message'.
      var delimiterIndex = responseBody.indexOf("#");
      var topicId = responseBody.substring(0, delimiterIndex);
      var message = responseBody.substring(delimiterIndex + 1);

      var handler = handlers[topicId];
      if (handler) {
        handler(message);
      } else {
        log("Message from the unexpected topic '" + topicId + "' was received")
      }
    };

    atmosphereRequest.onTransportFailure = function () {
      if (connectTimeout) {
        clearTimeout(connectTimeout);
      }
      webSocketFailed("Transport failure");
    };

    atmosphereRequest.onClose = function (response) {
      log("WebSocket closed");
      if (response.status) {
        log("Handshake response status: " + response.status + ", " + response.state);
      }
      reconnect(response);
    };

    atmosphereRequest.onClientTimeout = function (response) {
      log("WebSocket client timeout");
      reconnect(response);
    };

    atmosphereRequest.onError = function (response) {
      log("WebSocket error: " + response.error)
    };

    atmosphereRequest.onOpen = function() {
      if (!onOpenCalled) {
        onOpenCalled = true;
        sendToServer("testSocket");
      }
    };

    socket = atmosphere.subscribe(atmosphereRequest);

    /**
     * Currently, Atmosphere's request.connectTimeout doesn't work (see https://github.com/Atmosphere/atmosphere/issues/1844)
     */
    connectTimeout = setTimeout(function () {
      webSocketFailed("Connection timeout")
    }, BS.internalProperty('teamcity.ui.websocket.connectTimeout', 1500));
  };

  return {
    init: function (webSocketEnabled) {
      socketOpenedDeferred = $j.Deferred();

      if (!webSocketEnabled) {
        log("WebSocket are disabled on server side");
        socketOpenedDeferred.resolve(false);
        return;
      }

      openSocket();
    },

    checkSocketAvailable: function(callback) {
      socketOpenedDeferred.done(function(opened) {
        callback(opened);
      })
    },

    subscribe: function(topic, handler) {
      this.checkSocketAvailable(function (socketAvailable) {
        if (!socketAvailable) {
          BS.Log.warn("Attempt to subscribe using socket, that can't be opened")
        } else {
          handlers[topic] = handler;
          pushQueue.push(topic);
        }
      })
    },

    getLog: function() {
      return loggedMessages;
    }
  }
}();

/**
 * Executes the given task with the specified interval.
 * Uses greater interval when current page is not visible (in 5 times greater).
 *
 * @param task function returning jQuery Deferred. Deferred should be resolved/failed when the current task call is finished.
 * @param {integer} [interval=5000] in milliseconds
 */
BS.periodicalExecutor = function(task, interval) {

  var taskTimeoutId;
  var visibilityListenerId;
  var lastStartedTask = null;

  if (!interval) interval = 5000;

  var executeTask = function() {
    lastStartedTask = $j.Deferred();
    task().always(function() {
      taskTimeoutId = setTimeout(executeTask, BS.Util.isPageVisible() ? interval : interval * 5);
      lastStartedTask.resolve();
    });
  };

  return {
    start: function() {
      executeTask();

      var that = this;
      visibilityListenerId = BS.PageVisibilityListeners.subscribe({
        onPageBecameVisible: function() {
          that.unscheduledExecution();
        }
      });
    },

    unscheduledExecution: function() {
      lastStartedTask.done(function() {
        clearTimeout(taskTimeoutId);
        executeTask();
      });
    },

    stop: function() {
      clearTimeout(taskTimeoutId);
      BS.PageVisibilityListeners.unsubscribe(visibilityListenerId);
    }
  };
};

/**
 * Allows to subscribe to updates in some interesting topic.
 *
 * If Socket is available then it's used, otherwise default polling is started automatically.
 *
 * If you want to perform custom polling - please use BS.Socket directly.
 */
BS.SubscriptionManager = function() {

  var topicIds = [];
  var topicHandlers = {};
  var poller = null;

  return {

    subscribe: function (topicId, onMessage) {
      BS.Socket.checkSocketAvailable(function (socketAvailable) {
        if (socketAvailable) {
          BS.Socket.subscribe(topicId, onMessage);
        } else {
          if (topicIds.include(topicId)) {
            //already subscribed
            return;
          }
          topicHandlers[topicId] = onMessage;
          topicIds.push(topicId);
        }
      });
    },

    unsubscribe: function (topicId) {
      var i = topicIds.indexOf(topicId);
      if(i != -1) {
        topicIds.splice(i, 1);
      }
    },

    /**
     * Send unscheduled polling request.
     */
    checkNow: function () {
      if (poller) {
        poller.unscheduledExecution();
      };
    },

    start: function() {
      var that = this;

      BS.Socket.checkSocketAvailable(function (socketAvailable) {
        if (!socketAvailable) {
          poller = BS.periodicalExecutor(function () {
            var result = $j.Deferred();

            BS.ajaxRequest(window['base_uri'] + '/subscriptions.html', {
              method: 'post',
              parameters: "topics=" + topicIds.join(','),
              onComplete: function (response) {
                if (response && response.status != 200) {
                  BS.ServerLink.waitUntilServerIsAvailable(that.start.bind(that));
                  poller.stop();
                  poller = null;
                  return;
                }

                var messages = response.responseText.trim();
                //contains messages from different topics in format: 'topic1|message1Length|message1topic2|message2Length|message2'

                while (messages.length !== 0) {
                  var topicDelimiterPos = messages.indexOf('|');
                  var topic = messages.substring(0, topicDelimiterPos);
                  messages = messages.substring(topicDelimiterPos + 1);

                  var lengthDelimiterPos = messages.indexOf("|");
                  var length = messages.substring(0, lengthDelimiterPos);
                  messages = messages.substring(lengthDelimiterPos + 1);

                  topicHandlers[topic](messages.substring(0, length));
                  messages = messages.substring(length);
                }

                result.resolve();
              }
            });
            return result.promise();
          }, BS.internalProperty('teamcity.ui.pollInterval') * 1000);
          poller.start();
        }
      });
    },

    dispose: function() {
      if (poller) {
        poller.stop();
      }
      topicIds = [];
      topicHandlers = {};
    }
  }
}();

Ajax.PeriodicalUpdater.addMethods({
  updateNow: function () {
    clearTimeout(this.timer);
    this.onTimerEvent();
  }
});

BS.PeriodicalUpdater = Class.create(Ajax.PeriodicalUpdater, {
  initialize: function($super, container, url, options) {
    this.initialFrequency = options.frequency || 2;
    this.initialOnSuccess = options.onSuccess || Prototype.emptyFunction();
    this.initialOnFailure = options.onFailure || Prototype.emptyFunction();
    options.onSuccess = this.onSuccess.bind(this);
    options.onFailure = this.onFailure.bind(this);
    options.onException = this.onException.bind(this);
    options.onComplete = this.onComplete.bind(this);
    BS._addCSRFHeader(options);
    this.visibilityListenerId = this.setupVisibilityHandler();
    if (container && !container.success) container = { success: container };
    $super(container || {update:function() {}}, url, options);
  },

  onComplete: function(){
    this.stopVisibilityHandler();
  },

  onSuccess: function(response, json) {
    if (response && response.status == 0) {
      // workaround, see http://dev.rubyonrails.org/ticket/11508
      this.onFailure(response, json);
      return;
    }

    if (BS.Util.isPageVisible()) {
      this.frequency = this.initialFrequency; // reset frequency
    }
    this.failureState = false;

    if (this.initialOnSuccess) {
      if (BS._reloadIfReceivedHTML(response)) return;
      this.initialOnSuccess.call(this.options, response, json);
    }
  },

  onFailure: function(response, json) {
    this.frequency = this.initialFrequency * 5; // reduce frequency
    this.failureState = true;
    if (this.initialOnFailure) {
      this.initialOnFailure.call(this.options, response, json);
    }
  },

  onException: function() {
    this.frequency = this.initialFrequency * 5; // reduce frequency
    this.failureState = true;
  },

  setupVisibilityHandler: function() {
    var that = this;
    return BS.PageVisibilityListeners.subscribe({
      onPageBecameVisible : function() {
        if (that.failureState === false) {
          that.frequency = that.initialFrequency;
        }
        that.updateNow();
      },

      onPageBecameHidden: function() {
        that.frequency = that.initialFrequency * 5;
      }
    });
  },

  stopVisibilityHandler: function() {
    if (this.visibilityListenerId !== undefined) {
      BS.PageVisibilityListeners.unsubscribe(this.visibilityListenerId);
    }
  }
});

/**
 * https://developer.mozilla.org/en/DOM/Using_the_Page_Visibility_API
 */
BS.PageVisibility = {
  detect: function() {
    var hiddenProperty, visibilityChangeEvent;
    if (typeof document.hidden !== "undefined") {
      hiddenProperty = "hidden";
      visibilityChangeEvent = "visibilitychange";
    } else if (typeof document.mozHidden !== "undefined") {
      hiddenProperty = "mozHidden";
      visibilityChangeEvent = "mozvisibilitychange";
    } else if (typeof document.msHidden !== "undefined") {
      hiddenProperty = "msHidden";
      visibilityChangeEvent = "msvisibilitychange";
    } else if (typeof document.webkitHidden !== "undefined") {
      hiddenProperty = "webkitHidden";
      visibilityChangeEvent = "webkitvisibilitychange";
    }

    var pageVisibilitySupported = typeof document.addEventListener !== "undefined" && typeof hiddenProperty !== "undefined";

    return {
      supported: pageVisibilitySupported,
      hiddenProperty: hiddenProperty,
      visibilityChangeEvent: visibilityChangeEvent
    };
  }
};

BS.PageVisibilityListeners = function() {
  var pageVisibility = BS.PageVisibility.detect();
  var registeredListeners = [];

  if (pageVisibility.supported) {
    document.addEventListener(pageVisibility.visibilityChangeEvent, function() {
      if (document[pageVisibility.hiddenProperty]) {
        for (var i = 0; i < registeredListeners.length; i++) {
          if (registeredListeners[i]) {
            if (registeredListeners[i].onPageBecameHidden) {
              registeredListeners[i].onPageBecameHidden();
            }
          }
        }
      } else {
        for (var j = 0; j < registeredListeners.length; j++) {
          if (registeredListeners[j]) {
            if (registeredListeners[j].onPageBecameVisible) {
              registeredListeners[j].onPageBecameVisible();
            }
          }
        }
      }
    }, false);
  }

  return {
    /**
     * @param listener - object containing two optional callbacks:
     * onPageBecameHidden
     * onPageBecameVisible
     *
     * Note that in some browsers we can't detect page visibility, so callbacks will not be called.
     * It seems to be fine - for such browsers all pages are assumed to be visible always.
     */
    subscribe: function(listener) {
      if (!pageVisibility.supported || (BS.Cookie && BS.Cookie.get('disable-visibility-api') == 1)) {
        return -1;
      }

      return registeredListeners.push(listener) - 1;
    },

    unsubscribe: function(listenerId) {
      registeredListeners[listenerId] = undefined;
    }
  }
}();

BS.EventTracker = {
  _subscriptions: {},

  _toBeInvokedListeners : [],

  subscribeOnEvent: function(eventName, currentValue, listener) {
    this._subscribeOnEvent(eventName, currentValue, "", listener)
  },

  subscribeOnProjectEvent: function(eventName, currentValue, projectId, listener) {
    this._subscribeOnEvent(eventName, currentValue, "p:" + projectId, listener)
  },

  subscribeOnBuildTypeEvent: function(eventName, currentValue, buildTypeId, listener) {
    this._subscribeOnEvent(eventName, currentValue, "b:" + buildTypeId, listener)
  },

  subscribeOnUserEvent: function(eventName, currentValue, userId, listener) {
    this._subscribeOnEvent(eventName, currentValue, "u:" + userId, listener)
  },

  _subscribeOnEvent: function(eventName, currentValue, parameters, listener) {
    var subscr = {
      currentValue: currentValue,
      listeners: [listener],
      id: eventName + ";" + parameters
    };
    this._addSubscription(subscr);
  },

  unsubscribeBuildTypeEventSubscription: function(eventName, buildTypeId) {
    this._removeSubscription(eventName, "b:" + buildTypeId);
  },

  _removeSubscription: function(eventName, parameters) {
    var id = (eventName + ";" + parameters);
    var subscription = this._subscriptions[id];
    if (subscription) {
      subscription.listeners = [];
      delete subscription[id];
    }
    BS.SubscriptionManager.unsubscribe("events/" + id)
  },

  _addSubscription: function(subscr) {
    var curSubscr = this._subscriptions[subscr.id];
    if (curSubscr != null) {
      for (var i=0; i<curSubscr.listeners.length; i++) {
        if (curSubscr.listeners[i].toString().strip() == subscr.listeners[0].toString().strip()) return;
      };

      curSubscr.listeners.push(subscr.listeners[0]);
    } else {
      this._subscriptions[subscr.id] = subscr;
    }

    BS.SubscriptionManager.subscribe("events/" + subscr.id, function(counter) {
      if (subscr.currentValue != counter) {
        subscr.currentValue = counter;
        for (var j=0; j< subscr.listeners.length; j++) {
          BS.EventTracker._addPendingListener(subscr.listeners[j])
        }
      }
    });
  },

  _callPendingListeners: function() {
    for (var k=0; k < this._toBeInvokedListeners.length; k++) {
      try {
        this._toBeInvokedListeners[k]();
      } catch (e) {
        BS.Log.error(e);
      }
    }
    this._toBeInvokedListeners = [];
  },

  _addPendingListener: function(lr) {
    if (!this._toBeInvokedListeners.include(lr)) {
      this._toBeInvokedListeners.push(lr);
    }
  },

  startTracking: function() {
    (function _callListeners() {
      setTimeout(function () {
        BS.EventTracker._callPendingListeners();
        _callListeners();
      }, BS.internalProperty('teamcity.ui.events.pollInterval') * 1000);
    })();

    var that = this;
    BS.ServerLink.subscribeOnServerRestart(function(){
      BS.Log.info("Server restarted - reset Event Tracker counters");
      for (var k=0; k < that._subscriptions.length; k++) {
        that._subscriptions[k].currentValue = 0;
      };
    })
  },

  checkEvents: function() {
    BS.SubscriptionManager.checkNow();
  }
};

BS.StatisticsMonitor = function () {

  var processServerStat = function (agentsNum, runningNum, freeAgentsNum, buildQueueSize) {
    if (agentsNum != null) {
      var agentsLoad = 0;
      if (runningNum > 0 || freeAgentsNum > 0) {
        agentsLoad = Math.round(runningNum * 100.0 / (freeAgentsNum + runningNum));
      }
      if (agentsLoad < 0) {
        agentsLoad = 100;
      }
      var idle = freeAgentsNum;
      if (idle < 0) idle = 0;
      var title = '';
      if (agentsNum == 0) {
        title = "There are no agents";
      } else if (idle == 0) {
        title = "All agents are busy";
      } else if (idle == agentsNum) {
        title = "All agents are idle";
      } else {
        title = runningNum + (runningNum > 1 ? " builds are" : " build is") + " running, ";
        title += idle + (idle > 1 ? ' agents are' : ' agent is') + ' idle';
      }

      var content = '<div class="mug" onmouseover="BS.Tooltip.showMessage(this, {shift:{x:10,y:20}}, \'' + title + '\')" onmouseout="BS.Tooltip.hidePopup()">';
      if (agentsLoad > 0) {
        var maxheight = 16; // maximum height of the progress bar (see tabs.css)
        var top = Math.round((100 - agentsLoad) / 100 * maxheight);
        content += '<div class="mugStuff" style="top: ' + top + 'px; height: ' + (maxheight - top) + 'px;"></div>';
      }
      content += "</div>";
      var agentsTab = BS.topNavPane.getTab("agents");
      agentsTab.setPostLinkContent(content);
      agentsTab.setCaption("Agents (" + agentsNum + ")");
    }

    if (buildQueueSize != null && BS.topNavPane.getTab("queue")) {
      BS.topNavPane.getTab("queue").setCaption("Build Queue (" + buildQueueSize + ")");
    }
  };

  return {
    start: function() {
      BS.SubscriptionManager.subscribe('statistics', function(message) {
        var parsedMessage = JSON.parse(message);
        processServerStat(parsedMessage.agentsNum, parsedMessage.runningBuildsNum, parsedMessage.freeAgentsNum, parsedMessage.buildQueueSize);
      });
    }
  }
}();

BS.InvestigationsCounterMonitor = function() {
  var processInvestigations = function (count, hasNew) {
    var node = $j('.investigationsTicker');
    if (node.length > 0) {
      node.removeClass("investigationsNew");
      node.removeClass("investigationsOld");
      if (count == 0) {
        node.html("");
      }
      else {
        var title = hasNew ? "You have some recently updated investigations, click to view" : "Review your active investigations";
        node.html("<a class='investigationsLink' href='" + window['base_uri'] + "/investigations.html' title='" +title+ "'>" + count + "</a>");
        node.addClass(hasNew ? "investigationsNew" : "investigationsOld");
      }
    }
  };

  return {
    start: function(userId) {

      BS.SubscriptionManager.subscribe("investigationsCounter/" + userId, function(message) {
        var doc = $j.parseXML(message).documentElement;
        var investNodes = doc.getElementsByTagName("investigations");
        if (!investNodes || investNodes.length != 1) return;
        var count = investNodes[0].getAttribute("activeCount");
        var hasNew = investNodes[0].getAttribute("hasNew") == "true";
        processInvestigations(count, hasNew);
      });
    }
  }
} ();

BS.Util = {
  // Wraps an element into a position: relative container
  wrapRelative: function(element) {
    return $j(element).wrap('<div class="posRel"/>').parent();
  },

  place: function(element, x, y) {
    $(element).setStyle({left: x + 'px', top: y + 'px'});
  },

  center: function(elementToPlace, container) {
    var pos = BS.Util.computeCenter(elementToPlace, container);
    BS.Util.place(elementToPlace, pos[0], pos[1]);
  },

  // computes x and y so that element is shown centered vertically relative to the window
  // and horizontally relative to the container
  computeCenter: function(elementToPlace, container) {
    if (!container) {
      container = $('mainContent');
    }

    elementToPlace = $(elementToPlace);

    var containerDim = container.getDimensions();
    var containerPos = container.cumulativeOffset();
    var windowSize = BS.Util.windowSize();

    // to obtain element dimensions we have to show it
    var oldVisibility = elementToPlace.style.visibility;
    var oldDisplay = elementToPlace.style.display;
    elementToPlace.setStyle({visibility: 'hidden', display: 'block'});
    var dim = elementToPlace.getDimensions();
    elementToPlace.setStyle({visibility: oldVisibility, display: oldDisplay});
    var x = 0;
    var y = Math.round(this._scrollTop() + (windowSize[1] - dim.height) / 2);

    // check if container is wider than visible area
    if (containerDim.width > windowSize[0]) {
      // position within window instead of container
      x = Math.round(this._scrollLeft() + (windowSize[0] - dim.width) / 2);
    } else {
      x = Math.round(containerPos[0] + (containerDim.width - dim.width) / 2);
    }

    // Make sure dialog fits into screen boundaries
    if (_.isElement(container) && container.id == 'mainContent') {
      y = Math.max(y, 0);
    }

    return [x, y];
  },

  _scrollTop: function() {
    return $j(window).scrollTop();
  },

  _scrollLeft: function() {
    return $j(window).scrollLeft();
  },

  windowSize: function(win) {
    var $window = $j(win || window);

    return [$window.width(), $window.height()];
  },

  placeNearElement: function(elementToPlace, element, shift) {
    if (!shift) {
      shift = {};
      shift.x = 0;
      shift.y = 15;
    }

    element = $(element);

    var pos = element.positionedOffset();
    var x = pos[0] + shift.x;
    var y = pos[1] + shift.y;

    BS.Util.place(elementToPlace, x, y);
  },

  showNearElement: function(near_element, element_to_show, x_shift) {
    var menuDiv = $(element_to_show);
    if (typeof x_shift == 'undefined') {
      x_shift = -180;
    }
    BS.Util.placeNearElement(menuDiv, near_element, {x: x_shift, y: 21});
    BS.Hider.showDivWithTimeout(menuDiv, {hideOnMouseOut: false});
  },

  /**
   * @param {Node|string} element - element or id
   * @returns {boolean}
   */
  visible: function(element) {
    return jQuery($(element)).is(':visible');
  },

  /**
   * @param {Node|string} - element or id
   * ...
   */
  show: function() {
    for (var i = 0; i < arguments.length; i++) {
      if (arguments[i]) {
        jQuery($(arguments[i])).show();
      }
    }
  },

  /**
   * @param {Node|string} - element or id
   * ...
   */
  hide: function() {
    for (var i = 0; i < arguments.length; i++) {
      if (arguments[i]) {
        jQuery($(arguments[i])).hide();
      }
    }
  },

  /**
   * A helper for a case when there is a chooser defining some kind of mode
   * and a page should show different elements depending on which mode was chosen.
   *
   * To use this function add some css class to all the dependent elements
   * and add the class for each visibility mode, e.g. chooser has 2 values
   * mode1 and mode2 and there are 2 elements which depend on selected value.
   * If they have css classes like this:
   *
   * &lt;div class="dependent mode1"/>
   * &lt;div class="dependent mode2"/>
   *
   * then this function will updated their visibility according to selected mode:
   * first div will be visible for mode1, the second - for mode2.
   *
   * @param mode selected mode
   * @param commonClass a common css class for all elements which visibility depends on selected mode
   * @param resetHiddenElements if true all the fields will be reset to their default value (empty
   * string for text, password, file fields and first option for checkboxes).
   * @param modeClassMap a mapping between selected value and a css class, useful when
   * values are long, if not specified assume css class equals mode
   */
  toggleDependentElements: function(mode, commonClass, resetHiddenElements, modeClassMap) {
    var classToShow = modeClassMap && modeClassMap[mode];
    if (!classToShow) {
      classToShow = mode;
    }

    var hideSelector = '.' + commonClass + ':not(.' + classToShow + ')';
    $j(hideSelector).hide();
    if (!!resetHiddenElements) {
      $j(hideSelector + ' input:text').val('');
      $j(hideSelector + ' input:password').val('');
      $j(hideSelector + ' input:file').val('');
      $j(hideSelector + ' select').prop('selectedIndex', 0);
      $j(hideSelector + ' textarea').val('');
    }
    $j('.' + commonClass + '.' + classToShow).show();
  },

  toggleVisible: function() {
    for (var i = 0; i < arguments.length; i++) {
      var element = $(arguments[i]);
      jQuery(element).toggle();
    }
  },

  isParameterIgnored : function(element) {
    return !element || $j(element).parents('.non_serializable_form_elements_container').length != 0
  },

  //neuro: this is basically copy fo prototype.Form.serialize but with 1.5 contract (send disabled and all submits)
  serializeForm: function(form) {
    var elements = Form.getElements(form);
    var jQueryElementPrefix = BS.jQueryDropdown.namePrefix;
    elements = elements.filter(function(element) {
      return element.type!='password'
             && element.name.indexOf('prop:encrypted') == -1
             && !element.name.endsWith(jQueryElementPrefix)
             && !BS.Util.isParameterIgnored(element)
          ;
    });

    var key, value, submitted = false, submit;

    var data = elements.inject({ }, function(result, element) {
      if (element.name) {
        key = element.name; value = $(element).getValue();
        if (value != null && (element.type != 'submit' || (!submitted &&
            submit !== false && (!submit || key == submit) && (submitted = true)))) {
          if (key in result) {
            // a key is already present; construct an array of values
            if (!_.isArray(result[key])) result[key] = [result[key]];
            result[key].push(value);
          }
          else result[key] = value;
        }
      }
      return result;
    });

    return Object.toQueryString(data);
  },

  //neuro: using _wasDisabled to remember state
  disableFormTemp: function(form, elemsFilter) {
    var disabledElems = [];
    for (var i = 0; i < form.elements.length; i++) {
      var element = form.elements[i];
      if (!elemsFilter || elemsFilter(element)) {
        this.disableInputTemp(element);
        disabledElems.push(element);
      }
    }
    BS.VisibilityHandlers.updateVisibility(form);
    return disabledElems;
  },

  isDisabled: function(input) {
    return input.disabled == 'disabled' || input.disabled;
  },

  disableInputTemp: function(input) {
    input.blur();
    if (this.isDisabled(input)) {
      input._wasDisabled = true;
    } else {
      input.disabled = 'disabled';
    }
  },

  reenableInput: function(input) {
    if (typeof input._wasDisabled == 'undefined') {
      input.disabled = '';
    } else {
      input._wasDisabled = undefined;
    }
  },

  //neuro: using _wasDisabled to restore state
  reenableForm: function(form, elemsFilter) {
    for (var i = 0; i < form.elements.length; i++) {
      var element = form.elements[i];
      if (!elemsFilter || elemsFilter(element)) {
        this.reenableInput(element);
      }
    }
    BS.VisibilityHandlers.updateVisibility(form);
  },

  shiftToFitPage: function(el) {
    el = $(el);

    if (!el || el.hasClassName('modalDialogFixed')) return;

    // Fix for TW-10259.
    var overflow = el.style.overflow;
    if (BS.Browser.opera || BS.Browser.msie) { el.style.overflow = 'visible'; }

    var winSize = BS.Util.windowSize();
    var scrollLeft = BS.Util._scrollLeft();
    var pos = el.positionedOffset();
    var dim = el.getDimensions();
    var maxPageX = winSize[0] + scrollLeft;
    var minElemX = pos[0];
    var maxElemX = pos[0] + dim.width;

    if (minElemX < scrollLeft) {
      // if element is hidden by scroller
      el.style.left = (10 + scrollLeft) + 'px';
    } else if (maxElemX > maxPageX && dim.width < maxPageX) {
      // element maximum position by X is outside visible area
      el.style.left = (maxPageX - dim.width - 20) + 'px';
    } else if (dim.width >= maxPageX) {
      // element width is more than visible area
      el.style.left = '10px';
    }

    if (BS.Browser.opera || BS.Browser.msie) { el.style.overflow = overflow; }
  },

  showHelp: function(event, url, options) {
    Event.stop(event);
    var parts = url.split('#');
    if (parts.length == 2) {
      BS.Util.popupWindow(parts[0] + '#' + parts[1].replace(/\+/g, ''), "tcHelp", options);
    }
    else {
      BS.Util.popupWindow(url, "tcHelp", options);
    }
  },

  popupWindow: function(url, target, options) {
    target = target || '_blank';
    options = options || {};

    var width = options.width || 1000;
    var height = options.height || 600;

    var w = window.open(url, target, 'toolbar=no,scrollbars=yes,resizable=yes,width=' + width + ',height=' + height);

    try {
      w.focus();
    } catch(e) {}

    return w;
  },

  hideSuccessMessages: function() {
    if (BS._shownMessages) {
      for (var id in BS._shownMessages) {
        var el = $(id);
        if (el && BS._shownMessages[id] == 'info') {
          el.style.visibility = 'hidden';
        }
      }
      BS._shownMessages = {};
    }
  },

  showIFrameIfNeeded: function(div) {
    div = $(div);

    var iframe = BS.Util.getOrCreateDialogIFrame(div);
    if (iframe == null) return;

    iframe.absolutize();
    iframe.clonePosition(div);
    var zIndex = parseInt(div.style.zIndex, 10);
    iframe.style.zIndex = "" + (zIndex - 1);
    BS.Util.show(iframe);
  },

  hideIFrameIfNeeded: function(div) {
    div = $(div);

    var iframe = BS.Util.getOrCreateDialogIFrame(div);
    if (iframe == null) return;
    BS.Util.hide(iframe);
  },

  moveDialogIFrame: function(div) {
    div = $(div);

    var iframe = BS.Util.getOrCreateDialogIFrame(div);
    if (iframe == null) return;

    iframe.absolutize();
    iframe.clonePosition(div);
  },

  getOrCreateDialogIFrame: function(div) {
    if (!BS.Browser.msie6) return null;
    var iframe = $('iframe_' + div.id);
    if (iframe == null) {
      iframe = document.createElement("iframe");
      iframe.src = 'javascript:false'; // this is required to disable insecure items warning in IE for https protocol
      iframe.id = 'iframe_' + div.id;
      document.body.appendChild(iframe);
    }

    return $(iframe);
  },

  addWordToTextArea: function(textarea, word) {
    var initialValue = textarea.value;
    if (initialValue.length == 0) {
      textarea.value = word;
    } else {
      textarea.value = initialValue + " " + word;
    }
  },

  processError: function(e) {
    if (e.message) {
      alert(e.message);
    } else {
      alert(e.toString());
    }
  },

  changeChildrenColor: function(parent, options) {
    var color = options.color;
    var bgColor = options.backgroundColor;
    var filter = options.filter;

    var childNodes = parent.childNodes;
    for (var i=0; i<childNodes.length; i++) {
      if (filter && !filter(childNodes[i])) continue;
      if (childNodes[i].style) {
        if (color != null) {
          childNodes[i].style.color = color;
        }

        if (bgColor != null) {
          childNodes[i].style.backgroundColor = bgColor;
        }
      }
    }
  },

  documentRoot: function(transport) {
    if (!transport.responseXML) return null;
    return transport.responseXML.documentElement;
  },

  trimSpaces: function(str) {
    return str.replace(/^\s+(.*)/, "$1").replace(/(.*?)\s+$/, "$1");
  },

  makeBreakable: function(text, regex) {
    regex = regex ? new RegExp("(" + regex + ")", "g") : /(.{60})/g;

    return text.replace(regex, "$1<wbr/>");
  },

  /*
  * Formats time in format 23h:33m:21s
  * If includeSeconds == false, seconds are not shown
  * */
  formatSeconds: function(seconds, includeSeconds) {
    if (seconds < 0) return "N/A";
    if (seconds == 0) return "&lt;1s";

    var result = "";
    var t = parseInt(seconds);

    if (t >= 3600) {
      var hours = Math.floor(t / 3600);
      t -= hours*3600;
      result += hours + "h"
    }

    if (t >= 60) {
      var mins = Math.floor(t / 60);
      t -= mins*60;
      if (result != "") {
        result += ":";
      }
      result += mins + "m";
    }

    if (t > 0 && includeSeconds) {
      seconds = t;
      if (result != "") {
        result += ":";
      }
      result += seconds + "s";
    }
    else if (result == "") {
      result = "&lt;1m";
    }
    return result;
  },

  /**
   * Turns ON all checkboxes with specified name in the specified form
   * @param form
   * @param checkboxName
   */
  selectAll: function(form, checkboxName) {
    this._setChecked(form, checkboxName, true);
  },

  /**
   * Turns OFF all checkboxes with specified name in the specified form
   * @param form
   * @param checkboxName
   */
  unselectAll: function(form, checkboxName) {
    this._setChecked(form, checkboxName, false);
  },

  /**
   * Turns array of the selected checkboxes values
   * @param form
   * @param checkboxName
   */
  getSelectedValues: function(form, checkboxName) {
    var result = [];
    var checkboxes = Form.getInputs(form, "checkbox", checkboxName);
    for (var i=0; i<checkboxes.length; i++) {
      if (checkboxes[i].checked) {
        result.push(checkboxes[i].value);
      }
    }
    return result;
  },

  _setChecked: function(form, checkboxName, checked) {
    var checkboxes = Form.getInputs(form, "checkbox", checkboxName);
    for (var i=0; i<checkboxes.length; i++) {
      if (!checkboxes[i].disabled) {
        checkboxes[i].checked = checked;
      }
    }
  },

  descendantOf: function(child, parent) {
    while (child != null) {
      if (child === parent) return true;
      child = child.parentNode;
    }
    return false;
  },

  isDetached: function(elem) {
    if (elem.id) return $(elem.id) !== elem;

    if (elem === document.documentElement || elem === window || elem === document) return false;
    if (elem.parentNode == null) return true;

    return BS.Util.isDetached(elem.parentNode);
  },

  /**
   * Executes `toRun` as soon as node with `element_id` is attached to DOM
   * OR timeout ms elapsed (result of last existence check is passed to the
   * `toRun` as first argument)
   *
   * @param {String} element_id
   * @param {Function} toRun
   * @param {int} [timeout=1000] in ms
   */
  runWithElement: function(element_id, toRun, timeout) {
    if (!timeout) timeout = 1000;

    BS.WaitFor(function() {
      return $(element_id) && !BS.Util.isDetached($(element_id));
    }, toRun, timeout / 1000.0);
  },

  setTitle: function(title) {
    document.title = title ? title + " \u2014 TeamCity" : "TeamCity";
  },

  capitalize: function(s) {
    return s.replace(/\s+(\w)/g, function(match, chr) {
      return ' ' + chr.toUpperCase();
    });
  },

  fadeOutAndDelete: function(jQuerySelector) {
    $j(jQuerySelector).fadeOut("fast", function() {
      $j(this).remove();
    });
  },

  createDelayedInvocator: function(fun, delay) {
    return {
      _timeoutId: null,
      invoke: function() {
        if (this._timeoutId) {
          clearTimeout(this._timeoutId);
        }
        var that = this;
        this._timeoutId = setTimeout(function() {
          that._timeoutId = null;
          fun();
        }, delay);
      }
    };
  },

  // Escapes IDs containing dots and colons to make them usable as jQuery selectors
  escapeId: function(id) {
    if (id.toString().match(/^#/)) return id;

    //TODO: consider all possible variants: !"#$%&'()*+,./:;<=>?@[\]^`{|}~
    return '#' + id.toString().replace(/(:|\.)/g,'\\$1');
  },

  // Returns element's direct children that are text nodes
  getTextChildren: function(elemId) {
    return $j(BS.Util.escapeId(elemId)).contents().filter(function () {
      return this.nodeType == 3;
    });
  },

  // OS-specific line feed
  getLineFeed: function() {
    return navigator.userAgent.toLowerCase().match(/windows/) ? '\r\n' : '\n';
  },

  isModifierKey: function(e) {
    return e && (e.ctrlKey || e.altKey || e.shiftKey || e.metaKey);
  },

  installPlaceHolder: function(inputField, placeHolderText, setPlaceHolderText) {
    inputField = $(inputField);
    placeHolderText = placeHolderText.trim();

    if (setPlaceHolderText) {
      inputField.value = placeHolderText;
    }

    if (inputField.value.trim() == placeHolderText) {
      inputField.style.color = "gray";
    }

    inputField.on('focus', function() {
      if (this.value.trim() == placeHolderText) {
        this.value = "";
        this.style.color = "black";
      }
    });

    inputField.on('blur', function() {
      if (this.value.trim().length == 0) {
        this.value = placeHolderText;
        this.style.color = "gray";
      }
    });
  },

  paramsFromHash: function(separator) {
    var parsed = {};
    var hash = document.location.hash;
    if (hash.length > 1) {
      hash = hash.substring(1);
      var params = hash.split(separator || '&');
      for (var i=0; i<params.length; i++) {
        var eqsgn = params[i].indexOf('=');
        if (eqsgn == -1) continue;

        var name = params[i].substring(0, eqsgn);
        parsed[name] = params[i].substring(eqsgn+1);
      }
    }
    return parsed;
  },

  removeParamFromHash: function(paramName, separator, skipHistory) {
    var parsed = BS.Util.paramsFromHash(separator);
    var newParams = [];

    for (var key in parsed) {
      if (parsed.hasOwnProperty(key) && key !== paramName) {
        newParams.push(key);
        newParams.push(parsed[key]);
      }
    }

    BS.Util.setParamsInHash(newParams, separator, skipHistory)
  },

  setParamsInHash: function(params, separator, skipHistory) {
    var newHash = "";
    for (var i=0; i<params.length; i+=2) {
      newHash += params[i] + "=" + params[i+1] + separator;
    }

    if (newHash.length > 0) {
      newHash = newHash.substring(0, newHash.length - 1); //remove last separator
    }

    if (skipHistory) {
      // will replace location to avoid it appearance in browser history
      var url = document.location.href;
      var hashIdx = url.indexOf('#');
      if (hashIdx != -1) {
        url = url.substring(0, hashIdx);
      }
      url += '#' + newHash;
      document.location.replace(url);
    } else {
      document.location.hash = newHash;
    }
  },

  syncValues: function(sourceElem, targetElem) {
    var srcVal = sourceElem.value;
    var destVal = targetElem.value;
    var generated = targetElem.getAttribute('generated');
    if (destVal.length == 0 || (generated != null && destVal == generated)) {
      targetElem.value = srcVal;
      targetElem.setAttribute('generated', srcVal);
      $j(targetElem).trigger("keyup");
    }
  },

  _visibilityAPI: null,

  isPageVisible: function() {
    if (this._visibilityAPI == null) {
      this._visibilityAPI = BS.PageVisibility.detect();
    }
    return !this._visibilityAPI.supported || !document[this._visibilityAPI.hiddenProperty];
  },

  escapeRegExp: function(str) {
    return str.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&");
  }
};

//==========================================================================
/**
Public API:

BS.Hider.showDivWithTimeout('id');
BS.Hider.startHidingDiv('id', delay = 500);
BS.Hider.stopHidingDiv('id');
BS.Hider.hideDiv('id');


BS.Hider.hideAll('id');

*/

BS.Hider = {
  hidingDivs: {},
  allDivs: {},
  afterHideFuncs: {},

  hasVisiblePopups: function() {
    return !$j.isEmptyObject(this.allDivs);
  },

  _currentZindex: function() {
    if (this._shownStack.length == 0) return 10;
    var id = this._shownStack[this._shownStack.length - 1];
    return parseInt($(id).style.zIndex, 10) + 5;
  },

  addHideFunction: function(id, hideFunction) {
    if (typeof this.afterHideFuncs[id] == 'function') {
      var old = this.afterHideFuncs[id];
      this.afterHideFuncs[id] = function() {
        hideFunction();
        old();
      }
    }
    else {
      this.afterHideFuncs[id] = hideFunction;
    }
  },

  showDivWithTimeout: function(id, options) {
    var element = $(id);
    id = element.id;

    if (!options) {
      options = {};
    }

    if (options.hideOnMouseOut === undefined) {
      options.hideOnMouseOut = true;
    }

    if (options.hideOnMouseClickOutside === undefined) {
      options.hideOnMouseClickOutside = true;
    }

    if (options.draggable === undefined) {
      options.draggable = false;
    }

    if (!_.isElement(options.dragHandle)) {
      options.draggable = false;
    }

    var currentZIndex = this._currentZindex();
    if (options.zIndex === undefined || options.zIndex < currentZIndex) {
      options.zIndex = currentZIndex;
    }

    if (options.afterHideFunc != undefined) {
      this.addHideFunction(id, options.afterHideFunc);
    }

    // Modal dialog's position is defined in CSS
    if (!element.hasClassName('modalDialog')) {
      element.style.position = 'absolute';
    }

    element.style.zIndex = "" + options.zIndex;

    BS.Util.show(id);
    BS.Util.shiftToFitPage(id);
    BS.Util.showIFrameIfNeeded(id);

    this.allDivs[id] = id;

    this.stopHidingDiv(id); // if was started previously

    this._shownStack.indexOf(id) < 0 && this._shownStack.push(id);
    this._setupHandlers(id, options);

    BS.VisibilityHandlers.updateVisibility(id);

    element._hideOnMouseClickOutside = false;
    if (options.hideOnMouseClickOutside) {
      setTimeout(function() {
        element._hideOnMouseClickOutside = true;
      }.bind(this), 10);
    }

    if (options.draggable && !element._draggable) {
      element._draggable = new Draggable(id, {
        starteffect: function() {},
        endeffect: function() {},
        change: function() {
          BS.Util.moveDialogIFrame(id);
          $j(window).off('resize.modalDialog scroll.modalDialog');
        },
        handle: options.dragHandle
      });
    }
  },

  startHidingDiv: function(id, delay) {
    if (delay == undefined) {
      delay = 500;
    }

    id = $(id).id;

    this.stopHidingDiv(id, true);

    var that = this;
    this.hidingDivs[id] = setTimeout(function() {
      if (that.hidingDivs[id]) {

        // Hide popup only if it is not pinned
        var isPinned;
        $j('span.toggle').each(function() {
          if (this.getAttribute('data-popup') == id) {
            isPinned = this.getAttribute('data-pinned') === 'true';
            return false;
          }
        });
        if (!isPinned) {
          that.hideDivSingle(id);
        }

      }
    }, delay);
  },

  /* Hides the whole stack of open popups */
  hideDiv: function(id) {
    var divPos = -1;
    for (var i=0; i<this._shownStack.length; i++) {
      if (this._shownStack[i] == id) {
        divPos = i;
        break;
      }
    }

    if (divPos != -1) {
      var numShown = this._shownStack.length - divPos;
      while (numShown > 0) {
        var topId = this._shownStack.pop();
        this.hideDivSingle(topId);
        numShown--;
      }
    }

    if (this.afterHideFuncs[id]) {
      this.afterHideFuncs[id]();
      delete this.afterHideFuncs[id];
    }
  },

  /* Hides a single popup */
  hideDivSingle: function(id) {
    BS.Util.hideIFrameIfNeeded(id);
    this.stopHidingDiv(id, true);
    delete this.allDivs[id];

    // If there is a relevant toggle control - remove any attributes from it:
    $j('span.toggle').each(function() {
      if (this.getAttribute('data-popup') == id) {
        this.removeAttribute('data-pinned');
        this.removeAttribute('data-popup');
        return false;
      }
    });


    var elem = $(id);

    if (elem && elem._draggable) {
      elem._draggable.destroy();
      elem._draggable = null;
    }
    Event.stopObserving(elem);
    BS.Util.hide(elem);

    this._runAfterHide(id);
  },

  _runAfterHide: function(id) {
    if (this.afterHideFuncs[id]) {
      this.afterHideFuncs[id]();
      delete this.afterHideFuncs[id];
    }
  },

  stopHidingDiv: function(id, thisDivOnly) {
    var idAttr = $(id).id;
    if (this.hidingDivs[idAttr]) {
      if (thisDivOnly) {
        clearTimeout(this.hidingDivs[idAttr]);
      } else {
        for (var i=0; i<this._shownStack.length; i++) {
          clearTimeout(this._shownStack[i]);
          if (this._shownStack[i] == idAttr) {
            break;
          }
        }
      }

      delete this.hidingDivs[idAttr];
    }
  },

  /**
   * Hides all popups or all popups with zIndex greater than zIndex of popup having id provided
   * @param {DOMElement} stopOn - id of popup to break hiding process on
   */
  hideAll: function(stopOn) {
    var divs = [];
    for(var divId in this.allDivs) {
      if (!$(divId)) continue;
      divs.push($(divId));
    }

    // sort divs according to their z-index
    divs.sort(function(div1, div2) {
      var zI1 = parseInt(div1.style.zIndex, 10);
      var zI2 = parseInt(div2.style.zIndex, 10);
      return zI1 - zI2;
    });

    for (var i=divs.length-1; i>=0; i--) {
      var div = divs[i];
      if (div == stopOn) {
        break;
      }
      if (!div._hideOnMouseClickOutside) break;
      this.hideDiv(div.id);
      div._hideOnMouseClickOutside = true;
    }

    // Reset 'pinned' state
    $j('span.toggle').each(function() {
      if (stopOn && this.getAttribute('data-popup') == stopOn.id) return false;

      this.removeAttribute('data-pinned');
      this.removeAttribute('data-popup');
    })
  },

  _shownStack: [],

  _setupHandlers: function(id, options) {
    var el = $(id);

    if (options.hideOnMouseOut) {
      el.on("mouseout", function() {
        // don't hide the popup if a certain element is provided as override (TW-18908)
        if (document.activeElement) {
          if (options.overrideHideIfActive && document.activeElement == $(options.overrideHideIfActive)) {
            return;
          }
        }

        // we should not hide popup on mouse out if there are visible popups shown after this popup
        var top = BS.Hider._shownStack[BS.Hider._shownStack.length - 1];

        if (top != id) {
          return;
        }

        if (typeof options.hideOnMouseOut == 'function') {
          if (!options.hideOnMouseOut())
            return;
        }

        BS.Hider.startHidingDiv(id);
      });
    }

    el.on("mouseover", function() {
      BS.Hider.stopHidingDiv(id);
    });
  },

  _escapeHandler: function(event) {
    if (this._shownStack.length != 0 && event.keyCode == Event.KEY_ESC) {
      var id = this._shownStack[this._shownStack.length - 1];
      BS.Hider.hideDiv(id);
      return false;
    }
  }
};

$j(function() {
  var wrapper = document.getElementById('bodyWrapper') || document.getElementById('mainContent');
  $j(wrapper).on("click", function(e) {
    var t = e.target;
    // Don't hide popups if click occurred inside one of the popups
    var stopOn = null;
    for(var div in BS.Hider.allDivs) {
      var elem = $(div);
      if (!elem) continue;
      if (BS.Util.descendantOf(t, elem)) {
        stopOn = elem;
        break;
      };
    }
    BS.Hider.hideAll(stopOn);
  });

  $j(document).on("keydown", BS.Hider._escapeHandler.bind(BS.Hider));
});


//==========================================================================

BS.Navigation = {
    items: [],

    siblingsNavType: null,

    discoverMode: function(){
      var adminPart = this.items.length > 0 && this.items[0].title == 'Administration';
      var edit = adminPart && (window.location.href.indexOf('admin/edit') > -1 || window.location.href.indexOf('admin/attachBuildTypeVcsRoots'));
      var create = adminPart && window.location.href.indexOf('admin/create') > -1;
      return {adminPart: adminPart, editMode: edit, createMode: create};
    },

    writeLargeNavigation: function () {
      $j('#mainNavigation').html(this.getItemsHtml()).css('visibility', 'visible');
      // Breadcrumbs can be rendered before domReady,
      // but for the siblings navigation we have to wait until the DOM has fully loaded.
      var self = this;
      $j(document).ready(function () {
        if (BS.SiblingsTreePopup != undefined) {
          self._renderSiblingsNav();
        } else if (BS.RestProjectsPopup != undefined) {
          BS.RestProjectsPopup.installBreadcrumbs();
        }
      });
    },

    writeCompactNavigation: function () {
      var mode = BS.Navigation.discoverMode();
      var adminPart = mode.adminPart;
      var edit = mode.editMode;
      var create = mode.createMode;
      $j('#restBreadcrumbs').css('display', 'block');
      if (adminPart && !edit && !create){
        $j('#restPageTitle').html(this.getTitleHtml(this.items[0])).css('display', 'block');
      } else {
        if (this.items.length > 1) {
          $j('#restNavigation').html(this.getCompactItemsHtml()).css('display', 'block');
        }
        if (create || edit || !adminPart) {
          var last = this.items[this.items.length - 1];
          $j('#restPageTitle').html(this.getTitleHtml(last, '', edit)).css('display', 'block');
        }
        if (!adminPart) {
          var descriptionHtml = this.getDescriptionHtml(last);
          if (descriptionHtml != undefined && descriptionHtml > '') {
            $j('#restPageDescription').html(descriptionHtml).css('display', 'block');
          }
        }
      }
    },

    writeBreadcrumbs: function() {
      if (this.items.length == 0) return;

      if ($j('#mainNavigation').length > 0) {
        this.writeLargeNavigation();
      }

      if ($j('#restBreadcrumbs').length > 0) {
        this.writeCompactNavigation();
      }
      this._selectHeaderTabIfNeeded();
      $j(document).trigger("bs.navigationRendered");
    },

    getItemsHtml: function() {
      var result = "";
      for (var i = 0; i < this.items.length - 1; i ++) {
        result += this._writeItem(this.items[i]);
      }
      if (this.items.length > 0) {
        result += this._writeItem(this.items[this.items.length - 1], "last");
      }
      return result;
    },

    getCompactItemsHtml: function (adminPart) {
      var result = "";
      var lastIndex = this.items.length - (adminPart ? 1 : 2);
      if (this.items[lastIndex].title == undefined || this.items[lastIndex].title.trim().length == 0){
        lastIndex--;
      }
      for (var i = 0; i < lastIndex; i++) {
        var item = this.items[i];
        if (item != undefined && item.title != undefined && item.title.length > 0){
          result += this._writeCompactItem(this.items[i]);
        }
      }
      result += this._writeCompactItem(this.items[lastIndex], "last");
      return result;
    },

    getTitleHtml: function (item, li_class, editMode) {
      var content = item.title, idx = content.indexOf("<small>");
      var __ret = this._prepareAttributes(li_class, item);
      var li_classes = __ret.li_classes;
      var li_attributes = __ret.li_attributes;
      var iconClassName = __ret.iconClassName + (item.siblingsTree || item.siblings ? " hasSiblings" : "");

      var titleContent = (idx > -1 ? content.substr(0, idx) : item.title);
      if (item.url) {
        titleContent = "<a href='" + item.url + "'>" + titleContent + "</a>";
      }

      /*var prefix = (editMode ? "Edit Settings:" : undefined);*/
      var prefix = undefined;

      var triangle = "";

      var contentWrapperClass = 'contentWrapper ' + (triangle.length > 0 ? 'triangle' : '');

      return '<div class="' + $j.trim(li_classes) + '"' + li_attributes + '><span class="'+contentWrapperClass+'">' +
             (prefix != undefined ? '<span class="prefix">' + prefix +'</span>' : '') +
             (iconClassName ? '<span class="iWrapper"><i class="tc-icon_before icon16 ' + iconClassName + ' icon_disabled"></i></span>' : '') +
             titleContent + '</span></div>';
    },

    getDescriptionHtml: function (item) {
      var content = item.title, idx = content.indexOf("<small>");
      return (idx > -1 ? content.substr(idx + "<small>".length + 1, content.length - ("</small>".length + 1) - (idx + "<small>".length + 1)) : undefined);
    },

    _writeItem: function(navItem, li_class) {
      function getMaxDescriptionLength() {
        var totalWidth = $j(window).width();
        if (totalWidth > 1600) {
          return 120;
        } else if (totalWidth > 1400) {
          return 100;
        } else if (totalWidth > 1200) {
          return 80;
        } else if (totalWidth > 1000) {
          return 70;
        } else {
          return 50;
        }
      }

      function trimDescription(content, idx) {
        var description = content.substr(idx);
        var text = $j(description).text();
        var maxDescriptionLength = getMaxDescriptionLength();
        if (text.length > maxDescriptionLength) {
          if (description.indexOf("<script") > -1 || description.indexOf("<a") > -1) {
            return description;
          }
          text = BS.trimText(text, maxDescriptionLength);
          description = '<small>' + text + '</small>';
        }
        return description;
      }

      var content = navItem.title, idx = content.indexOf("<small>");
      var li_classes = [], li_attributes = [];

      li_classes.push(li_class);

      if (navItem.selected) {
        li_classes.push("selected");
      }

      if (navItem.itemClass) {
        li_classes.push(navItem.itemClass);
      }

      var iconClasses = ' class="tc-icon_after icon16 tc-icon_breadcrumb" ';
      if (navItem.url) {
        if (idx >= 0) {
          content = '<a href="' + navItem.url + '"' + iconClasses + '>' + $j.trim(navItem.title.substr(0, idx)) + '</a>' + '&nbsp;' + trimDescription(content, idx);
        }
        else {
          content = '<a href="' + navItem.url + '"' + iconClasses + '>' + $j.trim(navItem.title) + '</a>';
        }
      } else {
        if (idx >= 0) {
          content = content.substr(0, idx) + trimDescription(content, idx);
        }
      }

      if (navItem.siblingsTree) {
        this._addSiblingsTreeNav(navItem);
      } else if (navItem.siblings) {
        this._prepareSiblingsNav(navItem);
      }

      if (navItem.projectId) {
        li_attributes.push('data-projectId="' + navItem.projectId + '"');
      }
      if (navItem.buildTypeId) {
        li_attributes.push('data-buildTypeId="' + navItem.buildTypeId + '"');
      }

      if (navItem.siblingsTree && navItem.siblingsTree.parentId) {
        li_attributes.push('data-parentId="' + navItem.siblingsTree.parentId + '"');
      }

      var iconClassName = "";
      if (navItem.projectId) {
        iconClassName = "projectIcon project-icon";
      } else if (navItem.itemClass == "buildTypeTemplate") {
        iconClassName = "buildTypeTemplate-icon";
      } else if (navItem.buildTypeId) {
        iconClassName = "buildTypeIcon buildType-icon";
      }

      li_classes = li_classes.join(" ");
      li_attributes = li_attributes.join(" ");

      return '<li class="' + $j.trim(li_classes) + '"' + li_attributes + '><div class="contentWrapper">' +
             (iconClassName ? '<i class="tc-icon_before icon16 ' + iconClassName + ' icon_disabled"/>' : '') +
             content + '</div></li>';
    },


    _prepareAttributes: function (li_class, navItem) {
      var li_classes = [], li_attributes = [];

      li_classes.push(li_class);

      if (navItem.selected) {
        li_classes.push("selected");
      }

      if (navItem.itemClass) {
        li_classes.push(navItem.itemClass);
      }

      if (navItem.siblingsTree) {
        this._addSiblingsTreeNav(navItem);
      } else if (navItem.siblings) {
        this._prepareSiblingsNav(navItem);
      }

      if (navItem.projectId) {
        li_attributes.push('data-projectId="' + navItem.projectId + '"');
      }
      if (navItem.buildTypeId) {
        li_attributes.push('data-buildTypeId="' + navItem.buildTypeId + '"');
      }

      if (navItem.siblingsTree && navItem.siblingsTree.parentId) {
        li_attributes.push('data-parentId="' + navItem.siblingsTree.parentId + '"');
      }

      var iconClassName = "";
      if (navItem.projectId) {
        iconClassName = "projectIcon project-icon";
      } else if (navItem.itemClass == "buildTypeTemplate") {
        iconClassName = "buildTypeTemplate-icon";
      } else if (navItem.buildTypeId) {
        iconClassName = "buildTypeIcon buildType-icon";
      }

      li_classes = li_classes.join(" ");
      li_attributes = li_attributes.join(" ");
      return {li_classes: li_classes, li_attributes: li_attributes, iconClassName: iconClassName};
    },

    _writeCompactItem: function(navItem, li_class) {

      var content = navItem.title, idx = content.indexOf("<small>");

      var __ret = this._prepareAttributes(li_class, navItem);
      var li_classes = __ret.li_classes;
      var li_attributes = __ret.li_attributes;
      var iconClassName = __ret.iconClassName + (navItem.siblingsTree || navItem.siblings ? " hasSiblings" : "");

      var linkClassName = iconClassName == undefined || iconClassName == ''? 'noIconLink' : '';

      var titleText = (idx > -1 ? navItem.title.substr(0, idx) : navItem.title).trim();

      var triangle = "";

      content = navItem.url ? '<a class="' + linkClassName + '" href="' + navItem.url + '" >' + titleText + '</a>' : titleText;

      var contentWrapperClass = 'contentWrapper ' + (triangle.length > 0 ? 'triangle' : '');

      return '<li class="' + $j.trim(li_classes) + '"' + li_attributes + '><span class="noWrapContent"><span class="'+contentWrapperClass+'">' +
               (iconClassName ? '<span class="iWrapper"><i class="tc-icon_before icon16 ' + iconClassName + ' icon_disabled"></i></span>' : '') +
               content + '</span>' + (li_class == undefined || li_class.indexOf('last') == -1 ? "<span class='tc-icon_breadcrumb_slash'></span>" : '') + '</span></li>';
    },

    _addSiblingsTreeNav: function(navItem) {
      if (!this.siblingsTreeNav) {
        this.siblingsTreeNav = [];
      }
      this.siblingsTreeNav.push(navItem);
    },

    _prepareSiblingsNav: function(navItem) {
      this.siblingsNav = navItem;
    },

    _renderSiblingsNav: function() {
      var container = $j('#mainNavigation'), subContainer = null;

      if (this.siblingsTreeNav) {
        for (var i = 0; i < this.siblingsTreeNav.length; ++i) {
          var nav = this.siblingsTreeNav[i];

          // Find li to attach the icon to its content wrapper.
          var li = null;
          if (nav.projectId) {
            li = container.find("[data-projectId='" + nav.projectId + "'] .contentWrapper");
          } else if (nav.buildTypeId) {
            li = container.find("[data-buildTypeId='" + nav.buildTypeId + "'] .contentWrapper");
          }
          if (!li || !li.length) {
            continue;
          }

          // Attach the icon.
          (function(nav) {

            var icon = li.find('.tc-icon_before').removeClass('icon_disabled');

            if (nav.siblingsTree.parentId) {
              function showPopup() {
                var siblingsTree = nav.siblingsTree;

                BS.SiblingsTreePopup.show(icon, {
                  showArchived: false,
                  markedId: nav.projectId || nav.buildTypeId,
                  projectId: siblingsTree.parentId,
                  projectUrlFormat: siblingsTree.projectUrlFormat,
                  buildTypeUrlFormat: siblingsTree.buildTypeUrlFormat
                });
                return false;
              }

              icon.click(showPopup);
              $j(document).off("keydown.j").on("keydown.j", function(e) {
                if (e.keyCode == 74 && !BS.Util.isModifierKey(e)) {
                  var element = $j(e.target);
                  if (element.is("input") || element.is("textarea") || element.is("select")) {
                    return;
                  }
                  showPopup();
                }
              });
            } else {
              icon.css({
                cursor: "auto"
              });
            }
          })(nav);
        }
      }

      if (this.siblingsNav) {
        if (this.siblingsNav.siblings.type == 'buildType') {
          subContainer = container.find('.buildType');

          // if matching breadcrumb item not found, use the last one
          if (subContainer.length == 0) {
            subContainer = container.find('li').last();
          }

          $j('.siblingBuildTypes').appendTo(subContainer).css('display', '');
          BS.SiblingsPopup.install(this.siblingsNav.siblings);
        }
      }
    },

    _selectHeaderTabIfNeeded: function() {
      var navItem0 = this.items[0],
          navItem1 = this.items[1];
      if (navItem0 && navItem0.url && navItem0.url.endsWith("/admin/admin.html") && navItem1 && navItem1.title === 'Projects') {
        this.selectAdminTab();
      }
    },

    selectProjectsTab: function() {
      jQuery("#overview_Tab").addClass("selected");
    },

    selectAdminTab: function() {
      jQuery("#userPanel .info:nth-child(2)").addClass("selected");
    },

    selectMySettingsTab: function() {
      jQuery("#userPanel .info:nth-child(1)").addClass("selected");
    },

    fromUrl: function(idToFind, idToReplace, suffixIfNotFound, removeTabParam) {
      var url = document.location.href;
      var hashIdx = url.indexOf('#');
      if (hashIdx != -1) {
        url = url.substring(0, hashIdx);
      }
      if (removeTabParam) {
        url = url.replace(/tab=[^&]+&*/, "");
      }
      if (!url.include(idToFind) && url.include(encodeURIComponent(idToFind))) {
        idToFind = encodeURIComponent(idToFind);
      }
      if (url.include("=" + idToFind)) {
        return url.replace("=" + idToFind, "=" + (idToReplace || "{id}"));
      }
      return suffixIfNotFound ? url + suffixIfNotFound : url;
    },

    installHealthItems: function () {
        var healthIndicators = $j('.healthItemIndicatorContainer').detach();
        var container = $j('#mainNavigation');
        var hi = {
          'class': 'breadcrumbHealthIndicators',
          'append': healthIndicators
        };
        if (container.length == 0){
          container = $j('#restPageTitle');
          $j('<div></div>', hi).appendTo(container);
        } else {
          $j('<li></li>', hi).appendTo(container);
        }
        healthIndicators.show();
    }
};

//==========================================================================

BS.Highlight = function(element, options) {
  new Effect.Highlight(element, _.extend(options || {}, {
    startcolor: '#ffffcc',
    duration: 1.0,
    keepBackgroundImage: true
  }));
};


BS.Logout = function(logoutUrl) {
  BS.ajaxRequest(logoutUrl, {
    onComplete: function(transport) {
      BS.XMLResponse.processRedirect(transport.responseXML);
    }
  });
};

BS.XMLResponse = {
  processModified: function(form, responseXML) {
    if (!responseXML) return;

    var rootElement = responseXML.documentElement;
    form.setModified(rootElement.firstChild && rootElement.firstChild.nodeValue == "modified");
  },

  processRedirect: function(responseXML) {
    if (!responseXML) return false;

    var rootElement = responseXML.documentElement;
    var redirect = rootElement.getElementsByTagName("redirect")[0];
    if (redirect && !redirect.firstChild.nodeValue.startsWith("javascript:")) {
      document.location.href = redirect.firstChild.nodeValue;
      return true;
    }
    return false;
  },

  /** Error handlers is an object with error handlers with names like onFieldError,
   * where 'field' is 'id' of the 'error' element in XML response.
   * The handler is called with 'this' == errorHandlers and XML error element goes as the first parameter.
   * To access text of the error node, use syntax 'param.firstChild.nodeValue'
   * */
  processErrors: function(responseXML, errorHandlers, generalErrorHandler) {
    var eNodes = this._getErrorNodes(responseXML);
    if (!eNodes || eNodes.length == 0) return false;

    var handled = false;
    for (var i=0; i<eNodes.length; i++) {
      var elem = eNodes.item(i);
      var id = elem.getAttribute("id");
      var funcName = "on" + id.charAt(0).toUpperCase() + id.substring(1) + "Error";
      var handler = errorHandlers[funcName] || errorHandlers[id];

      if (handler && typeof(handler) == 'function') {
        handler.apply(errorHandlers, [elem]);
        handled = true;
      } else if (generalErrorHandler) {
        generalErrorHandler(id, elem);
        handled = true;
      }
    }

    return handled;
  },

  _xmlErrorsXml: function(responseXml) {
    var errs = responseXml.getElementsByTagName("errors");
    if (!errs || errs.length == 0 || errs[0].getElementsByTagName("error").length == 0) return [];
    var errorElements = errs[0].getElementsByTagName("error");
    var result = [];
    for (var i = 0; i < errorElements.length; i ++) {
      var e = errorElements[i];
      result.push([e.getAttribute("id"), e.firstChild.nodeValue]);
    }
    return result;
  },

  _getErrorNodes: function(responseXML) {
    if (!responseXML) {
      responseXML = $j.parseXML('<response><errors><error id="emptyResponse">Unexpected empty response</error></errors></response>');
    }
    var parentElement = responseXML.documentElement;
    if (parentElement == null) return null;

    var errorsNodes = parentElement.getElementsByTagName("errors");
    if (!errorsNodes || errorsNodes.length == 0) return null;
    var errorsNode = errorsNodes.item(0);
    return errorsNode.getElementsByTagName("error");
  }
};

BS.StopBuild = function(actionUrl, id, form) {
  if (form) {
    Form.disable(form);
  }

  BS.ajaxRequest(actionUrl + "?kill=" + id, {
    onComplete: function() {
      setTimeout(function() {
        BS.reload(true);
      }, 3000);
    }
  });

  return false;
};

/**
 * @deprecated
 */
BS.TableHighlighting = {
  createInitElementFunction: function () {
      var element = this;

      var f = function (element) {
        element = $(element);

        element.on("mouseover", function () {
          if (typeof(BS) == "undefined") return;

          BS.Util.changeChildrenColor(this.parentNode, {
            color: '#254193',
            backgroundColor: '#ffffcc',
            filter: function (elem) {
              return elem.nodeType == 1 && elem.className.indexOf("highlight") >= 0;
            }
          });
        }.bind(element));

        element.on("mouseout", function () {
          if (typeof(BS) == "undefined") return;
          BS.Util.changeChildrenColor(this.parentNode, {
            color: '',
            backgroundColor: '',
            filter: function (elem) {
              return elem.nodeType == 1 && elem.className.indexOf("highlight") >= 0;
            }
          });
        }.bind(element));
      };

      if (!element.nodeType) {
        // Old calling convention (Behaviour.js)
        return f;
      } else {
        // jQuery
        return f(element);
      }
    }
};

BS.Refreshable = {
  /**
   * see more in TW-49330 Workaround for JS error "refresh is not a function"
   *
   * @param {String?} progressId
   * @param {String?} moreParameters
   * @param {Function?} afterComplete
   *
   * @returns {Promise}
   */
  prototypeRefreshable: function(progressId, moreParameters, afterComplete) {

      var deferred = $j.Deferred();
      var container = $(this);

      if (!container) {
        BS.Log.error('prototypeRefreshable called without element');
        deferred.reject();
        return deferred.promise();
      }

      var containerId = $j(container).attr('id');

      var pageUrl = $j(container).attr('data-pageurl');
      if (!pageUrl) {
        // In case url is empty in BS.ajaxRequest the request will be sent to the current URL due to underlying XMLHttpRequest behaviour
        pageUrl = window.location.pathname;
      }

      var passJsp = $j(container).attr('data-passjsp');

      if (BS.ServerLink && !BS.ServerLink.isConnectionAvailable()) {
        BS.Log.info("Connection to server is not available. Refresh is not called.");
        deferred.resolve();
        return deferred.promise();
      }

      if (!moreParameters) {
        moreParameters = "";
      }

      if (progressId && $(progressId)) {
        BS.Util.show(progressId);
      }

      var myParams = passJsp ? "jsp=" + passJsp : "__fragmentId=" + containerId + "Inner";

      BS.ajaxRequest(pageUrl, {
        method: 'get',
        parameters: myParams + (moreParameters ? "&" + moreParameters : ""),
        onFailure: function() {
          BS.Log.warn("Failure while refreshing " + containerId);
          deferred.reject();
        },
        onComplete: function(response) {
          var status = response.request.getStatus();
          var success = !status || (status >= 200 && status < 300);

          // Do nothing if request has failed (server was unavailable)
          if (success) {
            BS.stopObservingInContainers(container);
            BS.Refreshable.destroySortables(container);
            container.update(response.responseText);
            BS.loadRetinaImages(container);
            BS.enableDisabled(container);
            BS.Util.hide(progressId);
            _.isFunction(afterComplete) && afterComplete();
          }

          deferred.resolve();
        }
      });

      return deferred.promise();
  },
  /**
   * @deprecated (see more in TW-49330 Workaround for JS error "refresh is not a function")
   */
  createRefreshFunction: function () {
    return function() {
      BS.Log.error("This function was created by BS.createRefreshFunction which shouldn't be used any more.");
    }
  },

  destroySortables: function(container) {
    if (typeof(Sortable) == "undefined") return;

    if (!_.isEmpty(Sortable.sortables)) {
      Sortable.destroy(container);
      var children = container.getElementsByTagName('*'),
          l = children.length;

      for (var i = 0; i < l; i ++) {
        if (Sortable.sortables[children[i].id]) {
          Sortable.destroy(children[i]);
          BS.Log.debug("Destroying sortable under " + children[i].id);
          if (_.isEmpty(Sortable.sortables)) {
            return;
          }
        }
      }
    }
  }
};

HTMLDivElement.prototype.refresh = BS.Refreshable.prototypeRefreshable;

/**
 * Executes `runWhenDone` as soon as `condition()` returns truthy value
 * OR `waitSeconds` seconds elapses; `condition()` return  value is
 * passed to `runWhenDone` handler
 *
 * @param {Function} condition
 * @param {Function} runWhenDone
 * @param {int} [waitSeconds=10]
 */
BS.WaitFor = function(condition, runWhenDone, waitSeconds) {
  if (!waitSeconds) waitSeconds = 10;
  var maxCount = waitSeconds * 1000 / 50;
  var counter = 0;

  var _waitForHandler = function() {
    var _condition = condition();
    if (!_condition && maxCount > counter++) {
      setTimeout(_waitForHandler, 50);
    }
    else {
      runWhenDone(_condition);
    }
  };
  _waitForHandler();
};

Event.observe(window, "unload", function() {
  BS.PeriodicalRefresh.stop();
});

BS.PeriodicalRefresh = {

  start: function (interval, refreshFunc) {
    if (this.executor) {
      this.executor.stop();
      this.executor = null;
    }

    this.executor = BS.periodicalExecutor(function () {
      return BS.reload(false, function () {
          })
          .then(function () {
            return refreshFunc();
          });
    }, interval * 1000);

    if (interval > 0) {
      this.executor.start();
    }
  },

  stop: function () {
    this.executor && this.executor.stop();
  }
};

(function($) {
  BS.InPlaceFilter = {
    _storedInitializers: {},
    applyFilter: function(containerId, filterField, afterFilterFunc, forceSearch) {
      var container = containerId instanceof $ ? containerId : $(BS.Util.escapeId(containerId));

      var keyword = filterField.value.toUpperCase();
      if (!forceSearch && keyword == this.prevKeyword) return;

      var narrowSearch = this.prevKeyword != null && keyword.indexOf(this.prevKeyword) != -1;
      this.prevKeyword = keyword;

      var elementsToFilter = container.find('.inplaceFiltered');

      var that = this;
      // Search and toggle option visibility
      elementsToFilter.each(function(i) {
        var elem = this;
        if (narrowSearch && !that.isVisible(elem)) return;

        if (!keyword) {
          that.showElement(elem, i);
        } else {
          that.performSearch(elem, keyword, i);
        }
      });

      this.toggleOptgroups(keyword, container, elementsToFilter);

      if (afterFilterFunc) {
        afterFilterFunc.call(this, filterField);
      }
    },

    performSearch: function(elem, keyword, idx) {
      var text = this.getContent(elem);
      var found = text.indexOf(keyword) > -1;
      if (!found) {
        this.hideElement(elem, idx);
      } else {
        this.showElement(elem, idx);
      }
      return found;
    },

    hideElement: function(elem, idx) {
      if (elem.tagName.toUpperCase() == 'OPTION') {
        if (elem.className.indexOf('optgroup') == -1) {
          this.hideOption(elem, idx);
        }
      } else {
        if (elem.tagName.toUpperCase() != 'OPTGROUP') {
          BS.Util.hide(elem);
          $j(elem).data('visibleElem', false);
        }
      }
    },

    showElement: function(elem, idx) {
      if (this.isHiddenOption(elem)) {
        this.showOption(elem, idx);
      } else {
        BS.Util.show(elem);
        $j(elem).data('visibleElem', true);
      }
    },

    isVisible: function(elem) {
      return elem.style.display != 'none';
    },

    /*
     * Retrieves text contents of the element, including child nodes.
     * If a child node contains text that should not be searchable, add a 'noSearch' class to such element.
     */
    getContent: function(elem) {
      var content = elem._cachedContent;
      if (content != null) return content;

      content = "";

      // Take content from data-title, if none is present - search in child nodes,
      // omitting the nodes with noSearch class
      if (elem.getAttribute('data-title')) {
        content = elem.getAttribute('data-title');
      } else {
        for (var i=0; i<elem.childNodes.length; i++) {
          var node = elem.childNodes[i];
          if (node.nodeType == 1 && node.className.indexOf('noSearch') == -1) {
            content += this.getContent(node);
          }
          if (node.nodeType == 3) {
            content += node.nodeValue;
          }
        }
      }

      elem._cachedContent = content.replace(/[\s]+/g, ' ').strip().toUpperCase();
      return elem._cachedContent;
    },

    isHiddenOption: function(elem) {
      return elem.className && elem.className.indexOf('hiddenOption') != -1;
    },

    hideOption: function(elem, idx) {
      var selectElem = elem.parentNode;
      if (!selectElem._hiddenOptions) {
        selectElem._hiddenOptions = {};
      }

      selectElem._hiddenOptions[idx] = elem;

      var newElem = document.createElement("SPAN");
      newElem.className = 'inplaceFiltered hiddenOption';
      newElem._cachedContent = this.getContent(elem);
      if (elem.disabled) {
        newElem.disabled = true;
      }

      if (elem.className.indexOf('optgroup') > -1) {
        newElem.className += ' optgroup';
      }
      newElem.setAttribute("data-filter-data", elem.getAttribute("data-filter-data"));

      selectElem.insertBefore(newElem, elem);
      selectElem.removeChild(elem);
    },

    showOption: function(elem, idx) {
      var selectElem = elem.parentNode;
      if (selectElem && selectElem._hiddenOptions[idx]) {
        selectElem.insertBefore(selectElem._hiddenOptions[idx], elem);
        selectElem.removeChild(elem);

        selectElem._hiddenOptions[idx] = null;
      }
    },

    toggleOptgroups: function(keyword, container, elementsToFilter) {
      if (container.prop('tagName').toUpperCase() == 'SELECT') {
        function shouldHandle(option) {
          var tagName = option.tagName.toUpperCase();
          return tagName == "OPTION" || tagName == "SPAN"
        }

        var that = this;
        elementsToFilter.each(function(index) {
          var thisClassName = this.className;

          // Doesn't do anything with ordinary options.
          if (!thisClassName.include('optgroup') || !shouldHandle(this)) {
            return;
          }

          var hasVisibleChildren = that.getContent(this).include(keyword),
              nextOption = this.nextSibling,
              depth = parseInt(this.getAttribute("data-filter-data") || "0");

          while (nextOption && !hasVisibleChildren) {
            if (nextOption.nodeType == 1 && shouldHandle(nextOption)) {
              // Check if next group is reached.
              var nextData = nextOption.getAttribute("data-filter-data");
              if (nextData) {
                if (depth >= parseInt(nextData)) {
                  break;
                }
              } else {
                if (nextOption.disabled) {
                  break;
                }
              }

              // Stop if there is an element that matches the query.
              hasVisibleChildren = that.isVisible(nextOption) && that.getContent(nextOption).include(keyword);
            }
            nextOption = nextOption.nextSibling;
          }

          if (hasVisibleChildren) {
            thisClassName.include('hiddenOption') && that.showOption(this, index);
          } else {
            !thisClassName.include('hiddenOption') && that.hideOption(this, index);
          }
        });
      }
    },

    prepareFilter: function(containerId) {
      var container = $(BS.Util.escapeId(containerId));

      function getPaddingForElement(element) {
        var attr = (element instanceof $) ? element.attr("data-filter-data") : element.getAttribute("data-filter-data");
        if (!attr) return "";

        var depth = parseInt(attr);
        var spaces = [];
        for (var i = 0; i < 4 * depth; ++i) spaces.push("&nbsp;");
        return spaces.join("");
      }

      if (container.length > 0 && container.prop('tagName').toUpperCase() == 'SELECT') {
        var previousOption = null;
        container.children("option").each(function() {
          var option = this;
          option.innerHTML = getPaddingForElement(option) + option.innerHTML;

          if (previousOption && parseInt(option.getAttribute("data-filter-data") || "0") > parseInt(previousOption.getAttribute("data-filter-data") || "0")) {
            $(previousOption).addClass("optgroup");
          }
          previousOption = option;
        });

        container.children("optgroup").each(function() {
          var optgroup = $(this),
              options = this.getElementsByTagName('option');

          if (options.length == 0) {
            optgroup.remove();
            return;
          }

          for (var i=options.length-1; i>=0; i--) {
            var option = options[i];
            optgroup.after(option);
            option.innerHTML = getPaddingForElement(option) + option.innerHTML;
          }

          option = $('<option class="inplaceFiltered optgroup" disabled="disabled">' + getPaddingForElement(optgroup) + optgroup.attr('label').escapeHTML() + '</option>');
          option.attr("data-filter-data", optgroup.attr("data-filter-data"));
          optgroup.replaceWith(option);
        });
      }
    },
    /**
     * Stores init function with corresponding id to call it manually
     * e.g. right after whatever have been loaded, not on DOM 'ready'
     * @param {String} id
     * @param {Function} func
     */
    storeInitFunction: function (id, func) {
      this._storedInitializers[id] = func;
    },
    /**
     * Returns stored init function by id and changes stored value to null
     * to prevent duplicate inits
     * @param {String} id
     * @returns {Function|null}
     */
    getStoredInitFunction: function (id) {
      var result = this._storedInitializers[id];
      this._storedInitializers[id] = null;
      return result;
    }
  };

  $.fn.inplaceFilter = function(containerId, afterApplyFunc) {
    var input = this;
    var container = $(BS.Util.escapeId(containerId));

    input.on('keyup', _.throttle(function() {
      BS.InPlaceFilter.applyFilter(container, input.get(0), afterApplyFunc);
    }, 100));
  };
})(jQuery);

BS.VisibilityHandlers = {
  _emptyHandler: { updateVisibility: function() {} },
  _handlers: {},

  attachTo: function(control, handler) {
    var controlId = $(control).id;
    var controlHandlers = this._handlers[controlId];
    if (controlHandlers == null) {
      controlHandlers = [];
      this._handlers[controlId] = controlHandlers;
    }
    controlHandlers.push(handler);
  },

  detachFrom: function(elementId) {
    this._handlers[elementId] = null;
  },

  _visibilityHandler: function(element) {
    if (!element || !element.id) return this._emptyHandler;

    var controlHandlers = this._handlers[element.id];
    if (controlHandlers == null) return this._emptyHandler;

    return {
      updateVisibility: function() {
        for (var i=0; i<controlHandlers.length; i++) {
          controlHandlers[i].updateVisibility();
        }
      }
    };
  },

  _collectElements: function(parentEl) {
    var elems = [];
    var id;
    if (parentEl == null) return elems;

    if (parentEl.id) {
      elems.push(parentEl);
    }

    if (parentEl.id == 'mainContent') {
      for (id in this._handlers) {
        if (!this._handlers.hasOwnProperty(id)) continue;
        elems.push($(id));
      }
    } else {
      for (id in this._handlers) {
        if (!this._handlers.hasOwnProperty(id)) continue;
        var elem = $(id);
        if (BS.Util.descendantOf(elem, parentEl)) {
          elems.push(elem);
        }
      }
    }
    return elems;
  },

  updateVisibility: function(el) {
    if (el == null) return;
    var elems = this._collectElements($(el));
    for (var i=0; i<elems.length; i++) {
      this._visibilityHandler(elems[i]).updateVisibility();
    }
  }
};

BS.User = {
  setProperty: function(key, value, options) {
    this._setProperty(key, value, options, "setUserProperty");
  },

  deleteProperty: function(key, options) {
    this._beforeChange(options);

    BS.ajaxRequest(window['base_uri'] + '/ajax.html', {
      parameters: 'deleteUserProperty=' + key,
      onComplete: function() {
        BS.User._afterChange(options);
      }
    })
  },

  setBooleanProperty: function(key, value, options) {
    if (value) {
      this.setProperty(key, value, options);
    } else {
      this.deleteProperty(key, options);
    }
  },

  /**
   * @param key string key property, you can get property value on the server-side using session[key] in JSP
   * @param options have keys 'progress' - ID of progress element; afterComplete - function to call after property is set
   * */
  setSessionProperty: function(key, value, options) {
    this._setProperty(key, value, options, "setSessionProperty");
  },

  _setProperty: function(key, value, options, methodName) {
    if (!options) options = {};
    this._beforeChange(options);

    BS.ajaxRequest(window['base_uri'] + '/ajax.html', {
      parameters: methodName + '=' + key + '&value=' + value,
      onComplete: function() {
        BS.User._afterChange(options);
      }
    })
  },


  _beforeChange: function(options) {
    if (options && options.progress) {
      BS.Util.show(options.progress);
    }
  },

  _afterChange: function(options) {
    options = options || {};
    if (options.afterComplete) {
      options.afterComplete();
    }
    if (options.progress) {
      BS.Util.hide(options.progress);
    }
  }
};

/**-------------------------------------------------------*/
/*-------- Simple delayed action support -----------------*/
/**-------------------------------------------------------*/
BS.DelayedAction = function(action_start, action_stop, delay) {
  if (!delay) delay = 300;
  this.delay = delay;
  this.action = action_start;
  this.stop_action = action_stop;
};

BS.DelayedAction.prototype.start = function() {
  this.timeout = setTimeout(this.action, this.delay);
};

BS.DelayedAction.prototype.stop = function() {
  clearTimeout(this.timeout);
  this.stop_action.call(this);
};

/**
 Usage:
 var progress = new BS.DelayedShow(element_id); // == new BS.DelayedShow(element_id, 300);
 progress.show();

 // some ajax call
 // onComplete: function() { progress.hide();}

 */

BS.DelayedShow = function(element) {
  BS.DelayedAction.call(this, function() {
    if ($(element)) $(element).show();
  }, function() {
    if ($(element)) $(element).hide();
  });
};

BS.DelayedShow.prototype = new BS.DelayedAction();
BS.DelayedShow.prototype.show = BS.DelayedShow.prototype.start;
BS.DelayedShow.prototype.hide = BS.DelayedShow.prototype.stop;

/**-------------------------------------------------------*/


/* Catch Javascript problems in AJAX handlers: */
Ajax.Responders.register({
  onException: function(r, e) {
    BS.Log.error(e);
  }
});

// Depends on jquery UFD plugin.
// See http://code.google.com/p/ufd/
BS.jQueryDropdown = function(selector, options) {
  var dropDown = jQuery(selector);
  var id = dropDown.attr('id');

  // Check if already initialized.
  if ($(BS.jQueryDropdown.namePrefix + id)) {
    try {
      jQuery($(id)).ufd("destroy");
    } catch(e) {
      BS.Log.warn(e);
    }
  }

  var selectElem = dropDown.get(0);
  var name = selectElem.name;
  id = selectElem.id;

  var className = "ufd";
  if (dropDown.attr("class")) {
    className += " " + dropDown.attr("class");
  }

  dropDown.ufd(jQuery.extend(true, options || {}, {
    css: { button: BS.jQueryDropdown.namePrefix + (name ? name : id), wrapper: className },
    calculateZIndex: true,
    zIndexPopup: BS.Hider._currentZindex()
  }));

  return dropDown;
};

/**
 * Inits `jQueryDropdown` and attaches `setSelected` and `setSelectValue` methods on element with id `selectId`
 * @param {String} selectId
 * @param {Object} filterOptions - `jquery.ui.ufd` options
 */
BS.enableJQueryDropDownFilter = function(selectId, filterOptions) {
  BS.jQueryDropdown($(selectId), filterOptions);

  /**
   * @function setSelected
   * Updates  master `select` selectedIndex and
   * - by default rebuilds `jQueryDropdown` - can be VERY slow on long list
   * - with `shallow` parameter just updates `jQueryDropdown` in accordance to the index.
   *
   * @param {Number} idx
   * @param {Boolean} [shallow=false]
   */
  $(selectId).setSelected = function(idx, shallow) {
    $(selectId).selectedIndex = idx;
    shallow ? $j($(selectId)).ufd('setInputFromMaster') : BS.jQueryDropdown($(selectId)).ufd("changeOptions");
  };

  /**
   * @function setSelectValue
   * Looks for the provided value in master `select` options, selects it (or 0),
   * updates corresponding `jQueryDropdown`
   *
   * @param val
   * @param {Boolean} [shallow=false]
   */
  $(selectId).setSelectValue = function(val, shallow) {
    var idx = 0;
    var selector = $(selectId);
    for (var i = 0; i < selector.options.length; i++) {
      if (selector.options[i].value == val) {
        idx = i;
        break;
      }
    }
    selector.setSelected(idx, shallow);
  };
};


// jQuery ufd creates temporary elements with names
// that ends with that prefix. We need to filter those
// fields out when sending parameters to the server.
BS.jQueryDropdown.namePrefix = "-ufd-teamcity-ui-";

BS.jQueryDropdown.setJQueryOptions = function($) {
  if ($.ui && $.ui.ufd) {
    $.ui.ufd.defaults.skin = "default";
    $.ui.ufd.defaults.prefix = BS.jQueryDropdown.namePrefix;
    $.ui.ufd.prototype.options = $.ui.ufd.defaults; // 1.8 default options location
  }
};

BS.jQueryDropdown.setJQueryOptions(jQuery);

// A hack-y way of fixing the restriction of the HTML element `optgroup`:
// In some cases `optgroup` appears to be empty (without nested options), but has to be shown anyway.
// Browsers automatically strip empty groups, and we don't want that.
// So here's a trick: insert a dummy option with a special class "user-delete", and delete them right after init.
// Has been tested in Google Chrome, Firefox and Opera.
// For the case with UFD selectors, CSS is enough.
BS.deleteRedundantOptions = function(selector) {
  $j("option.user-delete", selector || "select").remove();
};

// Please consider NOT using this method if possible. An "A" element with display: block is usually
// a better idea than making a DIV or a TD clickable
BS.openUrl = function(event, url) {
  if (Event.element(event) && Event.element(event).tagName.toUpperCase() == 'A') {
    // Handle links normally
    return true;
  } else {
    if (Event.isLeftClick(event)) {
      // New tab requested
      if (event.ctrlKey || event.metaKey) {
        window.open(url);
      // Plain normal click
      } else {
        document.location.href = url;
      }
    // New tab requested
    } else if (Event.isMiddleClick(event)) {
      window.open(url);
    // If we made it until here, and the following check is false - assume the left button
    // was clicked because we ran out of buttons.
    // Why? Because button detection is unstable for click events (looking at you, IE)
    // http://www.quirksmode.org/js/events_properties.html#button
    } else if (!Event.isRightClick(event)) {
      document.location.href = url;
    }
  }
  return false;
};

// A fix for TW-33812.
BS.goBack = function(event, url) {
  // Cannot use window["base_uri"], because of context duplication.
  var prefixWithoutContext = window.location.protocol + "//" + window.location.host;
  BS.openUrl(event, prefixWithoutContext + url);
  return false;
};

// One more fix for TW-33812.
BS.fixCancel = function() {
  $j(function() {
    var prefixWithoutContext = window.location.protocol + "//" + window.location.host;
    $j(".btn.cancel").each(function() {
      var self = $j(this),
          href = self.attr("href");
      if (href && href != "#" && !href.startsWith(prefixWithoutContext)) {
        href = prefixWithoutContext + href;
        self.attr("href", href);
      }
    });
  });
};

BS.LoadStyleSheetDynamically = function (url, callback) {
  var head = document.getElementsByTagName('head')[0];
  var existingStylesheet = null;
  var stylesheet;

  $j('link[type="text/css"], style').each(function() {
    if (this.tagName.toLowerCase() == 'link' && this.href == url || this.getAttribute('data-href') == url) {
      existingStylesheet = this;
      return false;
    }
  });

  var intervalId;
  var waitForStylesheet = function(stylesheet, callback) {
    if (stylesheet.getAttribute('data-loaded')) {
      clearInterval(intervalId);
      callback();
    }
  };

  if (!callback) {
    if (existingStylesheet) return;
    stylesheet = document.createElement('link');
    stylesheet.type = 'text/css';
    stylesheet.rel = 'stylesheet';
    stylesheet.title = 'dynamicLoadedSheet';
    stylesheet.href = url;
    if (!BS.Browser.msie) {
      head.appendChild(stylesheet);
    } else {
      head.insertBefore(stylesheet, head.firstChild);
    }
  } else {
    if (!existingStylesheet) {
      stylesheet = document.createElement('style');
      stylesheet.type = 'text/css';
      stylesheet.setAttribute('data-href', url);
      if (!BS.Browser.msie) {
        head.appendChild(stylesheet);
      } else {
        head.insertBefore(stylesheet, head.firstChild);
      }
      $j.get(url, function(contents) {
        if (BS.Browser.msie && parseInt(BS.Browser.version, 10) < 9) {
          stylesheet.styleSheet.cssText = contents;
        } else {
          stylesheet.textContent = contents;
        }
        stylesheet.setAttribute('data-loaded', true);
        callback();
      });
    } else {
      if (existingStylesheet.tagName.toLowerCase() == 'style') {
        intervalId = setInterval(function() {
          waitForStylesheet(existingStylesheet, callback);
        }, 50);
      } else {
        callback();
      }
    }
  }
};

/**
 * Replace all `img` elements inside container with double-density ones
 * (for retina displays only)
 * @param {Element} container
 */
BS.loadRetinaImages = function(container) {
  if (Retina.isRetina()) {
    jQuery(container).find('img').each(function() {
      if (!this.hasAttribute('data-no-retina')) {
        if (this.src.indexOf("/empty.png") < 0) {
          new RetinaImage(this);
        }
      }
    });
  }
};

BS.updateRetinaImage = function (image) {
  if (Retina.isRetina() && !image.hasAttribute('data-no-retina')) {
    new RetinaImage(image);
  }
};

(function () {
  var u = navigator.userAgent.toLowerCase(),
      m = /(chrome)[ \/]([\w.]+)/.exec(u)
                || /(webkit)[ \/]([\w.]+)/.exec(u)
                || /(opera)(?:.*version|)[ \/]([\w.]+)/.exec(u)
                || /(msie) ([\w.]+)/.exec(u)
                || u.indexOf("compatible") < 0 && /(mozilla)(?:.*? rv:([\w.]+)|)/.exec(u)
          || [],
      b = m[1] || "",
      v = m[2] || 0,
      ie = b === "msie";

  BS.Browser = {
    version: v,
    msie: ie,
    msie6: ie && v == 6,
    mozilla: b === "mozilla",
    opera: b === "opera",
    webkit: b === "chrome" || b === "webkit",
    windows: navigator.platform.indexOf('Win') != -1
  };
})();

BS.stopPropagation = function(event) {
  if (BS.Browser.msie) {
    event.cancelBubble = true;
  } else {
    event.stopPropagation();
  }
};

(function($) {
  BS.MultiSelect = {
    init: function(selector, onchange) {
      var select = $(selector);
      if (!select.length) return;

      select.find("input").each(function() {
        var self = $(this);

        if (self.hasClass("group")) {
          self.on("change", function(evt) {
            var parent = self.parent().parent(),
                depth = parseInt(parent.attr("data-depth") || "0"),
                checked = this.checked;

            var shouldDisableChildren = parent.attr("data-disable-children");

            parent.nextAll().each(function(idx, elem) {
              elem = $(elem);
              var currentDepth = parseInt(elem.attr("data-depth") || "0");
              if (currentDepth > depth) {
                // $(elem).is(':visible') check is simple fix for TW-40638 w/o regressions,
                // but it is too slow for big trees, so lets still use data('visibleElem')
                // from BS.InPlaceFilter but do not forget to use it in MultiSelect#update
                var dataVisibility = $(elem).data('visibleElem');
                if (typeof dataVisibility === 'undefined' || dataVisibility) {
                  elem.find("input").prop("checked", checked);
                  if (shouldDisableChildren) {
                    elem.find("input").prop("disabled", checked);
                  }
                  //if (checked) elem.hide(); else elem.show();
                }
                return true;
              } else {
                return false;
              }
            });

            onchange && onchange(evt);
          });
        } else {
          self.on("change", function(evt) {
            onchange && onchange(evt);
          });
        }
      });

      var stack = [];
      select.find(".inplaceFiltered").each(function() {
        var self = $(this);
        var depth = parseInt(self.attr("data-depth"));

        if (!stack.length) {
          stack.push(self);
          return;
        }

        while (stack.length) {
          var last = stack[stack.length - 1];
          var lastDepth = parseInt(last.attr("data-depth"));

          if (lastDepth == depth) {
            self.data("parent", last.data("parent"));
            stack[stack.length - 1] = self;
            break;
          } else if (depth > lastDepth) {
            self.data("parent", last);
            stack.push(self);
            break;
          } else {
            stack.pop();
          }
        }
      });
    },

    update: function(selector, filterField) {
      if (!filterField.value) {
        return;
      }

      $(selector).find(".inplaceFiltered:visible").each(function() {
        var self = $(this);
        var depth = parseInt(self.attr("data-depth"));
        var row = self;
        while (depth > 0) {
          depth--;
          var parent = row.data("parent");
          if (!parent) {
            parent = row.prevAll(".user-depth-" + depth + ':first');
            row.data("parent", parent);
          }
          parent.show().data('visibleElem', true);
          row = parent;
        }
      });
    }
  };
})(jQuery);

// See TW-27636, TW-29438
function fixErrorMessage(error) {
  return error.escapeHTML().replace(/(\w{40})/g, "$1<wbr>");
}

BS.ScrollUtil = {
  win: $j(window),
  doc: $j(document),

  body: function() {
    return $j('#bodyWrapper');
  },

  getVerticalScroll: function() {
    return this.win.scrollTop();
  },

  getHorizontalScroll: function() {
    return this.win.scrollLeft();
  },

  getContentHeight: function() {
    return this.body().height();
  },

  getWindowHeight: function() {
    return this.win.height();
  },

  isScrollAtBottom: function(error) {
    var height = this.getContentHeight();
    var scroll = this.getVerticalScroll();
    var innerHeight = this.getWindowHeight();
    if (error == undefined) {
      error = 20;
    }

    return Math.abs(innerHeight + scroll - height) < error;
  },

  scrollToBottom: function() {
    this.win.scrollTop(this.getContentHeight());
  }
};

/**
 * @param {jQuery} $select
 */
BS.expandMultiSelect = function ($select) {
  $select.css('height', '');
  $select.attr('size', $select.children('option').length);

  if ($select.get(0).scrollHeight && $select.get(0).scrollHeight > $select.height()) {
    $select.height($select.get(0).scrollHeight);
  }
};

/**
 * Resets `disabled` property to `false` for every element with class `js_to-enable`
 * inside container (document by default)
 *
 * @param {Element} [container=document]
 */
BS.enableDisabled = function (container) {
  $j(container || document).find('.js_to-enable').prop('disabled', false);
};


/**
 * Displays confirm dialog (browser or BS.confirmDialog depending on 'teamcity.ui.customConfirm' internal property value)
 * and executes `onConfirm` action if user confirms action
 * @param {String} message
 * @param {Function} onConfirm
 * @param {Function} [onCancel]
 */
BS.confirm = function (message, onConfirm, onCancel) {
  if (BS.internalProperty('teamcity.ui.customConfirm', false) && BS.confirmDialog) {
    BS.confirmDialog.show({
      text: message,
      action: onConfirm,
      cancelAction: onCancel
    });
  } else if (confirm(message)) {
    onConfirm();
  } else if (onCancel) {
    onCancel();
  }
};

