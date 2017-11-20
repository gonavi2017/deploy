BS.BaseSaveParameterListener = OO.extend(BS.SaveConfigurationListener, {
  onBeginSave: function(form) {
    form.formElement().parameterName.value = BS.Util.trimSpaces(form.formElement().parameterName.value);
    form.clearErrors();
    form.hideSuccessMessages();
    form.disable();
    form.setSaving(true);
  }
});

BS.EditParameterForm = OO.extend(BS.AbstractWebForm, {
  setSaving: function(saving) {
    if (saving) {
      BS.Util.show('userParamsSaving');
    } else {
      BS.Util.hide('userParamsSaving');
    }
  },

  formElement: function() {
    return $('editParamForm');
  },

  saveParameter: function() {
    this.formElement().submitAction.value = 'updateParameter';
    var that = this;

    BS.FormSaver.save(this, this.formElement().action, OO.extend(BS.BaseSaveParameterListener, {
      onEmptyParameterNameError: function(elem) {
        $("error_parameterName").innerHTML = elem.firstChild.nodeValue.escapeHTML();
        that.highlightErrorField($('parameterName'));
      },

      onParameterSpecError: function(elem) {
        $('error_parameterSpec').innerHTML = elem.firstChild.nodeValue.escapeHTML();
        that.highlightErrorField($('parameterSpec'));
      },

      onParameterValueError: function(elem) {
        $('error_parameterValue').innerHTML = elem.firstChild.nodeValue.escapeHTML();
        that.highlightErrorField($('parameterValue'));
      },

      onCompleteSave: function(form, responseXML, err) {
        BS.ErrorsAwareListener.onCompleteSave(form, responseXML, err);

        form.enable();
        if (!err) {
          that.updateParamLists();
          BS.EditParameterDialog.close();
        }
      }
    }));

    return false;
  },

  doRemoveParameter: function(paramId, paramType) {
    var that = this;

    var url = this.formElement().action + "&submitBuildType=1&submitAction=removeParameter&removedPropertyId=" + paramId + "&paramType=" + paramType;

    BS.ajaxRequest(url, {
      onComplete: function (response) {
        var $errors = $j(response.responseXML).find("error");
        if ($errors.length > 0) {
          $errors.each(function (idx, elt) {
            alert($j(elt).text());
          });
        } else {
          that.updateParamLists();
          BS.EditParameterDialog.close();
        }
      }
    });
  },

  removeParameter: function(paramId, paramType) {
    if (!confirm("Are you sure you want to delete this parameter?")) return;
    this.doRemoveParameter(paramId, paramType);
  },

  resetParameter: function(paramId, paramType) {
    if (!confirm("Are you sure you want to reset the parameter to its template value?")) return;
    this.doRemoveParameter(paramId, paramType);
  },

  updateParamLists: function() {
    BS.reload(true);
  },

  toggleInheritedParams: function(showParams, containerId, userPropName) {
    BS.User.setProperty(userPropName, showParams ? 'show' : 'hide', {
      afterComplete: function() {
        $j('#' + containerId + ' .inheritedParam').each(function() {
          if (showParams) {
            this.show();
          } else {
            this.hide();
          }
        });

        if (showParams) {
          $j('#' + containerId + ' .parametersTable').show();
        } else {
          $j('#' + containerId + ' .parametersTable').each(function() {
            if ($j(this).find('.ownParam').size() == 0) {
              $j(this).hide();
            }
          });
        }

        if (showParams) {
          $j('#' + containerId + ' .showInheritedLink').hide();
          $j('#' + containerId + ' .hideInheritedLink').show();
        } else {
          $j('#' + containerId + ' .showInheritedLink').show();
          $j('#' + containerId + ' .hideInheritedLink').hide();
        }
      }
    });

    return false;
  }
});


BS.EditParameterDialog = OO.extend(BS.AbstractModalDialog, {
  getContainer: function() {
    return $('editParamFormDialog');
  },

  showSpecEditFields : function(shown, updateVisibility) {
    if (shown) {
      BS.Util.hide('parameterSpecHolderExpand');
      BS.Util.show('parameterSpecHolderEdit');
    } else {
      BS.Util.show('parameterSpecHolderExpand');
      BS.Util.hide('parameterSpecHolderEdit');
    }
    if (updateVisibility) {
      this.updateVisibilityHandlers();
    }
  },

  showDialog: function(nameEl, valueEl, paramType, inherited, readOnly, undefinedParam, specEl, redefined, localReadOnly) {
    BS.EditParameterForm.clearErrors();
    if (readOnly) {
      BS.EditParameterForm.disable();
    } else {
      BS.EditParameterForm.enable();
    }

    var name = nameEl.firstChild ? nameEl.textContent : '';
    var value = valueEl.firstChild ? valueEl.textContent : '';
    var spec = specEl.firstChild ? specEl.textContent : '';
    var addNew = name.length == 0;

    var replaceNewLines = function(x) {
      x = x.replace(/##10##/g, "\n");
      x = x.replace(/##13##/g, "\r");
      return x;
    };

    value = replaceNewLines(value);
    spec = replaceNewLines(spec);

    $('currentName').value = name;
    $('parameterName').value = name;
    $('currentNameWithPrefix').value = name;
    $j('#paramType').val(paramType).ufd('changeOptions');
    $('parameterSpec').value = spec;

    $('editParamFormTitle').innerHTML = addNew ? "Add New Parameter" : (readOnly || inherited ? "View Parameter" : "Edit Parameter");
    if (redefined) {
      $j('#editParamForm .submitButton').val("Save");
    } else if (inherited && !localReadOnly) {
      $j('#editParamForm .submitButton').val("Override");
    } else if (localReadOnly) {
      $j('#editParamForm .submitButton').val("Copy");
    } else {
      $j('#editParamForm .submitButton').val("Save");
    }

    this.showSpecEditFields(spec.length > 0);
    this.showCentered();

    $('parameterValue').value = value;

    this.bindCtrlEnterHandler(function() {
      BS.EditParameterForm.saveParameter();
    });

    if (readOnly) return;

    Form.Element.enable($('parameterValue'));
    if (inherited) {
      Form.Element.disable($('parameterName'));
      Form.Element.disable($('parameterSpec'));
      Form.Element.disable($('editParameterSpec'));
      $('inheritedParamName').show();
      if ($('parameterSpec').value.indexOf("readOnly='true'") >= 0) {
        Form.Element.disable($('parameterValue'));
      } else {
        $('parameterValue').focus();
      }
    } else if (undefinedParam) {
      Form.Element.disable($('parameterName'));
      Form.Element.enable($('parameterSpec'));
      Form.Element.enable($('editParameterSpec'));
      $('parameterValue').focus();
    } else if (!addNew) {
      Form.Element.enable($('parameterName'));
      Form.Element.enable($('parameterSpec'));
      Form.Element.enable($('editParameterSpec'));
      $('parameterValue').focus();
    } else {
      Form.Element.enable($('parameterName'));
      Form.Element.enable($('parameterSpec'));
      Form.Element.enable($('editParameterSpec'));
      $('inheritedParamName').hide();
      $('parameterName').focus();
    }

    this.updateVisibilityHandlers();
  },

  updateVisibilityHandlers : function() {
    BS.VisibilityHandlers.updateVisibility(this.getContainer());
  },

  cancelDialog: function() {
    this.close();
  },

  completionItemSelected: function(event, ui) {
    var sliced = $j(this).data("sliced_text");
    var position = sliced.before_length + ui.item.value.length + 1;
    this.value = sliced.before + ui.item.value + '%' + sliced.after;
    if (!BS.Browser.msie) {
      $j("#parameterValue").attr({selectionStart: position,
                                  selectionEnd:   position});
    }
    return false;
  },

  removeSystemPrefix: function(str) {
    return str.replace(/^system\./, '');
  },

  removeEnvPrefix: function(str) {
    return str.replace(/^env\./, '');
  },

  /**
   * @param {String} str
   * @returns {String}
   */
  removeSystemAndEnvPrefixes: function(str) {
    return str.replace(/^((system|env)\.)*/, '');
  },

  /**
   * @param type
   * @param str
   * @returns {String}
   */
  removePrefixes: function(type, str) {
    if (type === 'system') {
      return BS.EditParameterDialog.removeEnvPrefix(str);
    } else if (type === 'env') {
      return BS.EditParameterDialog.removeSystemPrefix(str);
    } else {
      return BS.EditParameterDialog.removeSystemAndEnvPrefixes(str);
    }
  },

  /**
   * @param {jQuery()} paramTypeEl
   * @param {jQuery()} paramNameEl
   * @returns {Function}
   */
  createParamTypeChangeHandler: function(paramTypeEl, paramNameEl) {
    return function() {
      var type = paramTypeEl.val(),
          name = paramNameEl.val(),
          _name = name,
          position = BS.AvailableParams.getCursorPosition(paramNameEl.attr('id'));
      name = this.removePrefixes(type, name);
      name = this.addTypePrefixMaybe(type, name);
      if (_name !== name) {
        $j(paramNameEl).val(name);
        BS.AvailableParams.setCursorPosition(paramNameEl.get(0), position);
      }
    }.bind(BS.EditParameterDialog);
  },

  /**
   * @param {jQuery()} parameterNameEl
   * @param {jQuery()} paramTypeEl
   * @returns {Function}
   */
  createParamNameChangeHandler: function(parameterNameEl, paramTypeEl) {
    return function() {
      var text = parameterNameEl.val();

      paramTypeEl.val(/^env\./.test(text) ? "env" : /^system\./.test(text) ? "system" : "conf").trigger("change");
    };
  },

  splitAt: function(str, index) {
    return {
      prefix: str.slice(0, index),
      suffix: str.slice(index + 1, str.length)
    };
  },

  addTypePrefixMaybe: function(type, name) {
    if (this.hasTypePrefix(type, name)) {
      return name;
    } else {
      return type + '.' + name;
    }
  },

  hasTypePrefix: function(type, str) {
    return type === 'conf'
        || str.substring(0, type.length + 1) === type + '.';
  },

  /**
   * @param event
   * @returns {boolean}
   */
  canChangeSelectValue: function(event) {
    return event.keyCode === $j.ui.keyCode.UP
        || event.keyCode === $j.ui.keyCode.DOWN
        || event.keyCode === $j.ui.keyCode.PAGE_UP
        || event.keyCode === $j.ui.keyCode.PAGE_DOWN
        || event.keyCode === $j.ui.keyCode.HOME
        || event.keyCode === $j.ui.keyCode.END
        || event.keyCode === 67 //c
        || event.keyCode === 69 //e
        || event.keyCode === 83;//s
  }
});

BS.EditParametersSpecDialog = OO.extend(BS.AbstractWebForm, OO.extend(BS.AbstractModalDialog, {
  formElement: function() {
    return $("parameterSpecEditForm");
  },

  getContainer: function() {
    return $("parameterSpecEditFormDialog");
  },

  showDialog: function(spec) {
    var that = this;
    $('error_parameterSpec').update('');
    BS.Util.show("parameterSpecEditFormContentLoading");
    BS.ajaxUpdater('parameterSpecEditFormContent', this.formElement().action, {
      method: 'get',
      evalScripts : true,
      parameters : {spec : encodeURIComponent(spec), init : 1 },
      onComplete: function(transport) {
        BS.Util.hide("parameterSpecEditFormContentLoading");

        var xml = transport.responseXML;
        if (xml) {
          var error = false;
          var setErrorText = function(text) {
            $('error_parameterSpec').update(text.escapeHTML());
            error = true;
          };

          BS.XMLResponse.processErrors(xml, {
            onSPEC_ERRORError: function() {
              setErrorText('Failed to parse parameter specification');
            },
            onUNKNOWN_TYPEError: function() {
              setErrorText('Unknown parameter type');
            },
            onNO_EDITORError: function() {
              setErrorText('Specified parameter type does not support edit');
            }
          });
          if (error) {
            return;
          }
        }

        that.initializeParameterEdit();
        that.showCentered();
        that.bindCtrlEnterHandler(that.submitDialog.bind(that));
        BS.Util.reenableForm(that.formElement());
        that.updateSelectedType();
        BS.VisibilityHandlers.updateVisibility(that.formElement());
        BS.MultilineProperties.updateVisible();
      }
    });
    return false;
  },

  updateSelectedType: function() {
    var that = this;
    var v = $('specParameterTypeChooser').value;

    if (v == '') {
      v = "--not_selected--";
      var disabled = true;
    }

    var params = "type=" + v;

    $('parameterSpecEditFormSubmit').disabled = disabled;
    $('parameterSpecEditFormSubmit').title = disabled ? 'Select parameter type' : '';
    $('specParameterEditorContainer').refresh(null, params, function(){
      that.showCentered();
      BS.VisibilityHandlers.updateVisibility(that.formElement());
      BS.MultilineProperties.updateVisible();
    });
  },

  initializeParameterEdit: function() {
    jQuery("#specParameterTypeChooser").change(this.updateSelectedType.bind(this));
  },

  closeDialog: function() {
    this.close();
  },

  submitDialog: function() {
    var that = this;

    BS.Util.show('parameterSpecEditFormSaving');
    BS.FormSaver.save(this, this.formElement().action, OO.extend(BS.ErrorsAwareListener, {
      onCompleteSave: function(form, responseXML, err) {
        BS.Util.hide('parameterSpecEditFormSaving');
        var wereErrors = BS.XMLResponse.processErrors(responseXML, {}, BS.PluginPropertiesForm.propertiesErrorsHandler);

        BS.ErrorsAwareListener.onCompleteSave(form, responseXML, err);
        if (wereErrors) {
          BS.Util.reenableForm(that.formElement());
          return;
        }

        var spec = responseXML.getElementsByTagName("paramter-spec")[0].getAttribute('spec');
        if (spec) {
          $('parameterSpec').value = spec;
          BS.EditParameterDialog.showSpecEditFields(true);
          BS.EditParameterDialog.updateVisibilityHandlers();
        }
        form.close();
      }
    }));

    return false;
  }


}));
