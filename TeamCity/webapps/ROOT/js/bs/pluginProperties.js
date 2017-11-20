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

BS.PluginPropertiesForm = OO.extend(BS.AbstractWebForm, {

  serializeParameters: function() {
    var params = BS.Util.serializeForm(this.formElement());

    var passwordFields = Form.getInputs(this.formElement(), "password");
    if (!passwordFields) return params;

    for (var i=0; i<passwordFields.length; i++) {
      var name = passwordFields[i].name;
      if (name.indexOf("prop:") != 0) continue;
      var encryptedName = "prop:encrypted:" + passwordFields[i].id;

      params += "&" + encryptedName + "=";
      var encryptedValue = $(encryptedName).value;
      if (encryptedValue == "" || passwordFields[i].value != passwordFields[i].defaultValue) {
        encryptedValue = BS.Encrypt.encryptData(passwordFields[i].value, this.formElement().publicKey.value);
      }

      params += encryptedValue;
    }

    return params;
  },

  propertiesErrorsHandler: function(id, elem) {
    BS.PluginPropertiesForm.showError(id, elem.firstChild.nodeValue);
  },

  showError: function(id, message) {
    var input = $(id),
        error = $('error_' + id);

    if (error) {
      error.innerHTML = message.escapeHTML();
    }
    if (input && input.type && (input.type == 'text' || input.type == 'password')) {
      input.addClassName('errorField');
    }
  }
});

// contains names of all multiline properties on the page
BS.MultilineProperties = {
  init: function(name) {
    BS.MultilineProperties.addProperty(name, function() {
      var textarea = $(name),
          container = $(name + '_Container'),
          dragCorner = $(name + '_DragCorner');

      dragCorner.draw = function(container) {
        this.style.left = (container.offsetWidth - this.width - 4) + 'px';
        this.style.top = (container.offsetHeight - this.height - 4) + 'px';
      };

      container.recalculateOffset = function() {
        this._offset = $(this).positionedOffset();
      };

      container.getOffset = function() {
        return this._offset;
      };

      $j(textarea).off('keypress paste').on('keypress paste', function() {
        BS.MultilineProperties.sanitize(this);
      });

      new Draggable(dragCorner, {
        change: function(draggable) {
          var textarea = $(name),
              container = $(name + '_Container'),
              dragCorner = $(name + '_DragCorner');

          var textareaOffset = textarea.cumulativeOffset();
          var cornerImgOffset = dragCorner.cumulativeOffset();

          var newWidth = (cornerImgOffset[0] - textareaOffset[0]);
          var newHeight = (cornerImgOffset[1] - textareaOffset[1]);
          if (newWidth >= 150 && newHeight >= 40) {
            container.style.width = (newWidth + 4) + 'px';
            container.style.height = (newHeight + 6) + 'px';
            textarea.style.width = newWidth + 'px';
            textarea.style.height = (newHeight - dragCorner.height - 1) + 'px';

            container.recalculateOffset();
          }

          dragCorner.draw(container);
          BS.MultilineProperties.updateVisible();
        }
      });
    });
  },

  _init: function() {
    if (!this._properties) {
      this._properties = [];
    }
  },

  _findProperty: function(name) {
    for (var i=0; i<this._properties.length; i++) {
      var prop = this._properties[i];
      if (prop.name == name) {
        return prop;
      }
    }

    return null;
  },

  clearProperties: function() {
    this._properties = null;
  },

  addProperty: function(name, initFunc) {
    this._init();

    var found = this._findProperty(name);

    if (found) {
      found.visible = false;
      found.initFunc = initFunc;
    } else {
      var prop = {};
      this._properties.push(prop);
      prop.visible = false;
      prop.name = name;
      prop.initFunc = initFunc;
    }
  },

  setVisible: function(name, visible) {
    var found = this._findProperty(name);
    if (found) {
      found.visible = visible;
    }
  },

  isVisible: function(name) {
    var found = this._findProperty(name);
    if (found) {
      return found.visible;
    }

    return false;
  },

  updateVisible: function() {
    var that = this;

    if (this._properties) {
      this._properties.forEach(function (prop) {
        prop.visible && that.doShow(prop.name, false);
      });
    }

    BS.VisibilityHandlers.updateVisibility('mainContent');
  },

  show: function(name, focus) {
    this.doShow(name, focus);
    BS.MultilineProperties.setVisible(name, true);
    BS.MultilineProperties.updateVisible();
  },

  doShow: function(name, focus) {
    var found = this._findProperty(name);
    if (!found) return;

    var container = $(name + '_Container');
    if (!container) return; // todo: remove property from collection

    if (found.initFunc) {
      found.initFunc();
    }

    var linkContainer = $(name + '_LinkContainer');
    if (linkContainer) {
      BS.Util.hide(linkContainer);
    }
    var noteContainer = $(name + '_NoteContainer');
    if (noteContainer) {
      BS.Util.show(noteContainer);
    }

    var textarea = $(name);
    var corner = $(name + '_DragCorner');

    if (!container) return;

    BS.Util.show(container);
    BS.Util.show(corner);

    var note = $('note_' + name);
    if (note && note.hasClassName('smallNote_hidden')) {
      note.removeClassName('smallNote_hidden');
    }

    container.style.width = textarea.offsetWidth + 'px';
    container.style.height = textarea.offsetHeight + 'px';

    container.recalculateOffset();
    corner.draw(container);

    if (focus && !textarea.disabled) {
      textarea.focus();
    }
  },

  sanitize: function(el) {
    // u00A0 is &nbsp;
    // When changing the value, cursor will jump to the end in IE and Opera which is OK since
    // this character can only appear through paste
    if (el.value.match(/\u00A0/)) {
      el.value = el.value.replace(/\u00A0/g, ' ');
    }
  }
};

Event.observe(window, "resize", function() {
  BS.MultilineProperties.updateVisible();
});