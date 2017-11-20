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

BS.AbstractModalDialog = {
  _attachedToRoot: false,
  hideOnMouseClickOutside: false,

  /** should return $('element id') for modal dialog element **/
  getContainer: function() {},

  beforeShow: function() {},

  afterClose: function() {},

  getDragHandle: function() {
    return $(this.getContainer()).getElementsBySelector('.dialogHandle')[0];
  },

  bindCtrlEnterHandler: function(handler) {
    var f = function() {
      this._ctrlEnterHandler = function(event) {
        if (event.ctrlKey && event.keyCode == Event.KEY_RETURN) {
          handler && handler();
        }
      }.bindAsEventListener(this);

      // Ctrl-Enter in a modal dialog takes over the one from the underlying page
      $j(document).off("keydown.formCtrlEnter keydown.dialogCtrlEnter").on("keydown.dialogCtrlEnter", this._ctrlEnterHandler);
    }.bind(this);

    f.defer();
  },

  bindEnterHandler: function(handler) {
    var f = function() {
      this._enterHandler = function(event) {
        if (event.keyCode == Event.KEY_RETURN) {
          handler && handler();
        }
      }.bindAsEventListener(this);

      $j(document).on("keydown.dialogEnter", this._enterHandler);
    }.bind(this);

    f.defer();
  },

  unbindCtrlEnterHandler: function() {
    if (!this._ctrlEnterHandler) return;
    $j(document).off("keydown.dialogCtrlEnter");
    this._ctrlEnterHandler = null;
  },

  _getDialogForm: function(dialog) {
    return dialog.parentNode.tagName.toLowerCase() == 'form' && dialog.parentNode.getAttribute('id') + 'Dialog' == dialog.getAttribute('id')
        ? dialog.parentNode
        : dialog;
  },

  _removeDuplicateElements: function() {
    var el = $(this.getContainer());
    var origId = el.id;
    el.id = '_' + origId;
    var dialog = $(origId);
    while(dialog) {
      var dialogForm = this._getDialogForm(dialog);
      dialogForm.parentNode.removeChild(dialogForm);
      dialog = $(origId);
    };

    el.id = origId;
  },

  _fixElementPlacement: function() {
    this._removeDuplicateElements();
    if (this._attachedToRoot) return;

    var dialog = $(this.getContainer());
    var dialogForm = this._getDialogForm(dialog);

    var mainContent = $('mainContent');

    if (dialogForm.parentNode != mainContent) {
      mainContent.appendChild(dialogForm);
      this._attachedToRoot = true;
    }
  },

  showAt: function(x, y) {
    this._fixElementPlacement();

    var dialog = $(this.getContainer());
    this.beforeShow();

    BS.Util.place(dialog, x, y);

    this._showDialog(dialog);
  },

  showAtFixed: function(dialog) {
    this._fixElementPlacement();

    this.beforeShow();
    dialog.addClassName('modalDialogFixed');

    this._showDialog(dialog);

    this.positionAtFixed(dialog);
    this.recenterDialog();

    var _scrollTop = $j(document).scrollTop();
    var _scrollLeft = $j(document).scrollLeft();

    $j(window).off('resize.modalDialog scroll.modalDialog').on('resize.modalDialog scroll.modalDialog', function() {
      this.positionAtFixed(dialog, $j(document).scrollTop() - _scrollTop, $j(document).scrollLeft() - _scrollLeft);
      _scrollTop = $j(document).scrollTop();
      _scrollLeft = $j(document).scrollLeft();
    }.bind(this));
  },

  positionAtFixed: function(dialog, scrollTopDelta, scrollLeftDelta) {
    if (!dialog) return;

    var $dialog = $j(dialog);

    function pos() {
      $dialog.position({
        my: "center",
        at: "center",
        of: window,
        using: function(position) {
          var _adjustOffset = function (horiz, scrollDelta) {
              var scroll = $j(document)['scroll' + (horiz ? 'Left' : 'Top')](),
                  dialogSize = $dialog[horiz ? 'width' : 'height'](),
                  dialogStart = $dialog.position()[horiz ? 'left' : 'top'],
                  dialogEnd = horiz ? ($dialog.position().left + $dialog.width()) : ($dialog.position().top + $dialog.height()),
                  viewportSize = horiz ? (window.innerWidth || document.documentElement.clientWidth) : (window.innerHeight || document.documentElement.clientHeight),
                  newViewportEnd = scroll + viewportSize,
                  result,
                  isPinched = horiz ? (window.innerWidth && window.innerWidth < document.documentElement.clientWidth) : (window.innerHeight && window.innerHeight < document.documentElement.clientHeight);

              if (dialogSize > viewportSize) { // dialog is taller/wider than viewport
                if (typeof scrollDelta === 'undefined') {
                  result = scroll;
                } else if (scrollDelta > 0) { // scrolling down/right
                  if (newViewportEnd <= dialogEnd) { // new viewport bottom/right-end is above/lefter or at dialog bottom/right-end
                    result = dialogStart;
                  } else {
                    result = newViewportEnd - dialogSize;
                  }
                } else {
                  if (scroll >= dialogStart) {
                    result = dialogStart;
                  } else {
                    result = scroll < 0 ? 0 : scroll;
                  }
                }
              } else if (isPinched) { // page is zoomed in
                result = scroll + (viewportSize - dialogSize)/2;
              } else {
                result = position[horiz ? 'left' : 'top'];
              }

              return result;
            };

          $dialog.css({
            top: parseInt(_adjustOffset(false, scrollTopDelta)),
            left: parseInt(_adjustOffset(true, scrollLeftDelta)),
            visibility: 'visible'
          });
        }
      });
    }

    if (BS.Browser.opera) {
      $dialog.css('visibility', 'hidden');
      setTimeout(pos, 0);
    } else {
      pos();
    }
  },

  _showDialog: function(dialog) {
    var afterHide = function() {
      this.removeOverlappingDiv();
      this.resetPosition(dialog);
      this.afterClose();
      this.unbindCtrlEnterHandler();
      this._attachedToRoot = false;
    }.bind(this);

    BS.Hider.showDivWithTimeout(dialog.id, {
      hideOnMouseOut: false,
      hideOnMouseClickOutside: this.hideOnMouseClickOutside,
      afterHideFunc: afterHide,
      draggable: true,
      dragHandle: this.getDragHandle(),
      zIndex: this.zIndex
    });

    dialog.setAttribute('data-modal', true);
    this.showOverlappingDiv(dialog);
  },

  isVisible: function() {
    return BS.Util.visible(this.getContainer());
  },

  showCentered: function() {
    var dialog = $(this.getContainer());
    this.showAtFixed(dialog);
  },

  recenterDialog: function() {
    this._fixElementPlacement();

    var dialog = $(this.getContainer());
    var dimensions = dialog.getDimensions();
    if (dimensions.height > dialog.getAttribute('data-height') || 0) {
      this.positionAtFixed(dialog);
      this.updateDialog();
    }
  },

  close: function() {
    this.doClose();
  },

  doClose: function() {
    if (this.getContainer()) {
      BS.Hider.hideDiv(this.getContainer().id);
    }
  },

  _overlappingDivId: function() {
    return 'overlappingDiv';
  },

  getOverlappingDiv: function() {
    var id = this._overlappingDivId();
    var overlappingDiv = $(id);
    if (overlappingDiv) {
      return overlappingDiv;
    }

    var newOverlappingDiv =
      $j("<div/>").attr("id", id)
                  .hide()
                  .appendTo($j("#mainContent"));

    var div = newOverlappingDiv.get(0);
    $j(div).width($j(document).width());
    $j(div).height($j(document).height());
    return div;
  },

  showOverlappingDiv: function(dialog) {
    var overlappingDiv = this.getOverlappingDiv();
    var dialogZindex = dialog.style.zIndex;

    overlappingDiv.style.zIndex = "" + (parseInt(dialogZindex, 10) - 1);

    if (!BS.Util.visible(overlappingDiv)) {
      BS.Util.show(overlappingDiv);
    }
  },

  removeOverlappingDiv: function() {
    var overlappingDiv = $(this._overlappingDivId());
    var keepOverlappingDiv = false;
    var previousDialog;

    for (var i in BS.Hider.allDivs) {
      previousDialog = $(BS.Hider.allDivs[i]);
      if (previousDialog && previousDialog.getAttribute('data-modal')) {
        keepOverlappingDiv = true;
      }
    }

    if (overlappingDiv) {
      if (!keepOverlappingDiv) {
        $('mainContent').removeChild(overlappingDiv);
      } else {
        if (previousDialog) {
          overlappingDiv.style.zIndex = "" + (parseInt(previousDialog.style.zIndex, 10) - 1);
        }
      }
    }
  },

  resetPosition: function(dialog) {
    $j(window).off('resize.modalDialog scroll.modalDialog');
    dialog.style.cssText = "";
  },

  // updates dialog iframe if needed
  updateDialog: function() {
    BS.Util.moveDialogIFrame(this.getContainer());
  }
};

BS.SimpleModalDialog = function(dialogId) {
  return OO.extend(BS.AbstractModalDialog, {
    getContainer: function () {
      return $(dialogId);
    }
  });
};

BS.confirmDialog = OO.extend(BS.AbstractModalDialog, {
  hideOnMouseClickOutside: true,

  getContainer: function () {
    return $('confirmDialog');
  },

  show: function(options) {
    this.options = OO.extend({
       title: '',
       text: 'Are you sure?',
       actionButtonText: 'OK',
       cancelButtonText: 'Cancel',
       action: function() {},
       cancelAction: function() {}
    }, options || {});

    this.setTitle();
    this.setText();
    this.setActionButtonText();
    this.setCancelButtonText();

    this.showCentered();
    this._focusOnActionButton();
  },

  doAction: function () {
    this.options.action();
    this.close();
  },

  doCancelAction: function() {
    this.options.cancelAction();
    this.close();
  },

  close: function() {
    this._resetActions();
    BS.AbstractModalDialog.close.call(this);
  },

  _resetActions: function() {
    this.options.action = function() {};
    this.options.cancelAction = function() {};
  },

  _focusOnActionButton: function () {
    $j(this.getContainer()).find('.submitButton').focus();
  },

  setTitle: function () {
    $j(this.getContainer()).find('.dialogTitle').text(this.options.title);
  },

  setText: function () {
    $j(this.getContainer()).find('.confirmDialog__content').html(this.options.text);
  },

  setActionButtonText: function () {
    $j(this.getContainer()).find('.submitButton').val(this.options.actionButtonText);
  },

  setCancelButtonText: function () {
    $j(this.getContainer()).find('.cancel').text(this.options.cancelButtonText);
  }
});

/**
 Provides three additional methods for better temporary "loading" dialog experience:
 - `showProgress` - to display temporary dialog (with optional dialog title)
 - `hideProgress` - to hide temporary dialog

 - `showCentered` - hides temporary dialog calling `@hideCentered` and
                  then displays main one calling `BS.AbstractModalDialog.showCentered`
  */
BS.DialogWithProgress = OO.extend(BS.AbstractModalDialog, {
  loaderDisplayTimeout: 300,

  /**
   *
   * @param {String} [dialogTitle]
   */
  showProgress: function(dialogTitle) {
    this._loadingTimeoutId = setTimeout(function () {
      BS.LoadingDialog.setTitle(dialogTitle);
      BS.LoadingDialog.showCentered();
      this._loadingTimeoutId = null;
    }.bind(this), this.loaderDisplayTimeout);
  },

  hideProgress: function() {
    this._loadingTimeoutId ? clearTimeout(this._loadingTimeoutId) : BS.LoadingDialog.close();
    this._loadingTimeoutId = null;
  },

  showCentered: function() {
    this.hideProgress();
    BS.AbstractModalDialog.showCentered.apply(this, arguments);
  }
});

BS.LoadingDialog = OO.extend(BS.AbstractModalDialog, {
  getContainer: function() { return $('abstractLoadingDialog'); },

  /**
   * Sets abstract loading dialog title
   * @param {String} [title='Loading...']
   */
  setTitle: function (title) {
    $('abstractLoadingTitle').textContent = title || 'Loading...';
  },

  showCentered: function () {
    $j('#abstractProgress').show();
    BS.AbstractModalDialog.showCentered.call(this);
  }
});
/**
 * Specify `__baseId` property to generate
 * - `_savingElemId`
 * - `_containerId`
 * - `_formElementId`
 * - `_fetchUrl`
 * - `_copyButtonId`
 * or create any of them directly to avoid generation
 *
 * Properties `inputId` and `copyButtonId` are required for default `_onFetchDialogComplete` method
 */
BS.AbstractCopyMoveDialog = OO.extend(BS.AbstractWebForm, OO.extend(BS.AbstractModalDialog, {
  savingElemId: function() { return this._savingElemId || this.__baseId + 'Progress'; },
  containerId: function () { return this._containerId || this.__baseId + 'FormDialog'; },
  formElementId: function () { return this._formElementId || this.__baseId + 'Form' },
  fetchUrl: function () { return this._fetchUrl || '/admin/%%.html'.replace(/%%/, this.__baseId); },
  copyButtonId: function() { return this._copyButtonId || this.__baseId + 'Button'; },
  loaderDisplayTimeout: 300,
  fetchParamName: null,

  getContainer: function() {
    return $(this.containerId());
  },

  formElement: function() {
    return $(this.formElementId());
  },

  setSaving: function (saving) {
    BS.Util[saving ? 'show' : 'hide'](this.savingElemId());
  },

  showDialog: function(id) {
    var that = this;

    this._loadingTimeoutId = setTimeout(function () {
      BS.LoadingDialog.showCentered();
      this._loadingTimeoutId = null;
    }.bind(this), this.loaderDisplayTimeout);

    // Remove existing if found.
    $j(BS.Util.escapeId(this.formElementId())).remove();

    BS.ajaxRequest(window["base_uri"] + this.fetchUrl(), {
      method: "GET",
      parameters: this._prepareRequestParameters.apply(this, [].slice.apply(arguments)),
      onComplete: function(response) {
        that._loadingTimeoutId ? clearTimeout(that._loadingTimeoutId) : BS.LoadingDialog.close();
        that._loadingTimeoutId = null;

        that._onFetchDialogComplete(response);
      }
    });

    return false;
  },

  _prepareRequestParameters: function (id) {
    var parameters = {};
    parameters[this.fetchParamName] = id;
    return parameters;
  },

  _onFetchDialogComplete: function (response) {
    $j('body').append(response.responseText);
    this.showCentered();
    $j(this.formElement().projectId).trigger('change').focus();
    this.bindCtrlEnterHandler(this.submitMove.bind(this));
  },

  cancelDialog: function() {
    this.close();
  },

  afterClose: function() {
    this.clearErrors();
  }
}));
