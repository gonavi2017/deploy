BS.AgentPushListener = OO.extend(BS.ErrorsAwareListener, {

    onEmptyHostError: function(elem) {
        $j("#errorHost").text(elem.firstChild.nodeValue);
    },

    onEmptySelectedPresetError: function(elem) {
        $j("#errorSelectedPreset").text(elem.firstChild.nodeValue);
    },

    onNameError: function(elem) {
        $j("#errorPresetName").text(elem.firstChild.nodeValue);
    },

    onEmptyPlatformError: function(elem) {
        $j("#errorPlatform").text(elem.firstChild.nodeValue);
    },

    onEmptyUserError: function(elem) {
        $j("#errorUser").text(elem.firstChild.nodeValue);
    },
    
    onEmptyPasswordError: function(elem) {
        $j("#errorPassword").text(elem.firstChild.nodeValue);
    },

    onEmptyKeyFilePathError: function(elem) {
        $j("#errorKeyFilePath").text(elem.firstChild.nodeValue);
    },

    onCompleteSave: function(form, responseXML, err) {
        BS.ErrorsAwareListener.onCompleteSave(form, responseXML, err);
        if (!err) {
            document.location.reload();
        }
    }
});

BS.AgentPush = {
    _formElement: null,
    _dialogElement: null,
    _refreshScheduled: false,

    createNewPreset: function(e) {
        this._formElement = 'createPresetForm';
        this._dialogElement = 'createPresetFormDialog';

        return this._showDialog(e, $("createPresetFormMainRefresh"),
                "/agentpushPreset.html", "action=new", 'presetName');
    },

    updatePreset: function(e, presetName) {
        this._formElement = 'createPresetForm';
        this._dialogElement = 'createPresetFormDialog';

        return this._showDialog(e, $("createPresetFormMainRefresh"),
                "/agentpushPreset.html", "action=edit&presetId=" + presetName, 'presetName');
    },

    installPreset: function(e) {
        this._formElement = 'installPresetForm';
        this._dialogElement = 'installPresetFormDialog';

        return this._showDialog(e, $("installPresetFormMainRefresh"),
                "/agentpushInstall.html", "action=install", 'host');
    },

    restart: function (e, host, presetId) {
        this._formElement = 'installPresetForm';
        this._dialogElement = 'installPresetFormDialog';

        return this._showDialog(e, $("installPresetFormMainRefresh"),
            "/agentpushInstall.html", "action=install&presetId=" + presetId + "&host=" + host, 'host');
    },

    _showDialog: function(e, container, url, params, focus) {
        BS.AgentPush.CreatePresetDialog.showProgress(e);

        BS.ajaxUpdater(container, base_uri + url + "?" + params,
        {
            method : "get",
            evalScripts : true,
            onComplete: function() {
                BS.AgentPush.CreatePresetDialog.hideProgress();

                BS.AgentPush.CreatePresetDialog.baseParams = function() {
                    return params;
                };

                ((function() {
                    var dialog = $(this.getContainer());
                    var pos = BS.Util.computeCenter(dialog);
                    this.showAt(pos[0], 100);
                }).bind(BS.AgentPush.CreatePresetDialog))();
                $(focus).focus();
            }
        });

        return false;
    },

    CreatePresetForm : OO.extend(BS.AbstractWebForm, {
        formElement: function() {
            return $(BS.AgentPush._formElement);
        },

        getDialog: function() {
            return BS.AgentPush.CreatePresetDialog;
        },

        beforeShow: function() {
            this.clearErrors();
            BS.Util.reenableForm(this.formElement());
        },

        saveForm: function() {
            $('encryptedPassword').value = BS.Encrypt.encryptData($('password').value, $('publicKey').value);
            $('encryptedPassphrase').value = BS.Encrypt.encryptData($('passphrase').value, $('publicKey').value);
            $('encryptedRuntimePassword').value = BS.Encrypt.encryptData($('runtimePassword').value, $('publicKey').value);            
            $('password').value = "";
            $('runtimePassword').value = "";
            $('passphrase').value = "";

            var that = this;
            var url = this.formElement().getAttribute('action');
            BS.PasswordFormSaver.save(this, url, OO.extend(BS.AgentPushListener, {
                getForm: function() {
                    return that;
                },

                onCompleteSave: function(form, responseXML, err) {
                    BS.AgentPushListener.onCompleteSave(form, responseXML, err);

                    if (err) {
                        BS.Util.reenableForm(that.formElement());
                        return;
                    }

                    that.getDialog().close();
                }
            }));
            return false;
        }
    }),

    CreatePresetDialog : OO.extend(BS.DialogWithProgress, {
        getContainer: function() {
            return $(BS.AgentPush._dialogElement);
        },

        getForm: function() {
            return BS.AgentPush.CreatePresetForm;
        },

        beforeShow: function() {
            this.getForm().beforeShow();
        },

        submit: function() {
            this.getForm().saveForm();

            return false;
        },

        close: function() {
            this.doClose();
            var toRemove = $(BS.AgentPush._formElement + 'MainRefresh');

            toRemove.descendants().each(function(elem) {
                Event.stopObserving(elem);
            });
            toRemove.update();

            var children = toRemove.childNodes;
            for (var i = 0; i < children.length; ++i) {
                toRemove.removeChild(children[i]);
            }
        }
    }),

    DeletePresetDialog : OO.extend(BS.AbstractModalDialog, {
        getContainer: function() {
            return $('deletePresetFormDialog');
        },

        showDialog: function(presetId, presetName) {
            $('presetId').value = presetId;
            $j('#presetName').text(presetName);
            this.showCentered();
        },
        
        submit: function() {
            var that = this;
            BS.ajaxRequest(base_uri + "/agentpushPreset.html?action=delete&presetId=" + $('presetId').value, {
                method : 'post',
                onComplete: function(transport) {
                    document.location.reload();
                    that.close();
                }
            });
            return false;
        }
    }),

    CancelInstallDialog : OO.extend(BS.AbstractModalDialog, {
        getContainer: function() {
            return $('cancelInstallFormDialog');
        },

        showDialog: function(host) {
            $j('#host').text(host);
            this.showCentered();
        },

        submit: function() {
            var that = this;
            BS.ajaxRequest(base_uri + "/agentpushPreset.html?action=cancelInstallation", {
                method : 'post',
                onComplete: function(transport) {
                    that.close();
                }
            });
            return false;
        }
    }),

    scheduleRefresh: function(scheduleRefresh) {
        if (scheduleRefresh) {
            this._refreshScheduled = true;
            window.setTimeout(function() {
                $('agentpushProgress').refresh()
            }, 200);
        } else if (this._refreshScheduled) {
            this._refreshScheduled = false;
            $('agentpushProgress').refresh();
        }
    }
};


BS.AgentPush.PresetForm = {
    onPlatformChanged:function () {
        var sel = $('platform');
        var platform = sel[sel.selectedIndex].value;
        isDefaultPath = function (path) {
            return path == '%SystemDrive%\\\\BuildAgent' || path == '$HOME/BuildAgent' || path == '';
        };
        var $installLocation = $('installLocation');
        if ('' == platform) {
            BS.Util.hide($('installLocationContainer'));
            BS.Util.hide($('ap_gt_1'));
            BS.Util.hide($('portContainer'));
            BS.Util.hide($('authenticationSchemeContainer'));
            BS.Util.hide($('userContainer'));
            BS.Util.hide($('passwordWarningContainer'));
            BS.Util.hide($('passwordContainer'));
            BS.Util.hide($('keyFilePathContainer'));
            BS.Util.hide($('passphraseContainer'));
            BS.Util.hide($('ap_gt_2'));
            BS.Util.hide($('runtimeUserContainer'));
            BS.Util.hide($('runtimePasswordContainer'));

            if (isDefaultPath($installLocation.value)) {
                $installLocation.value = '';
            }
        } else if ('Unix' == platform) {
            BS.Util.show($('installLocationContainer'));
            BS.Util.show($('ap_gt_1'));
            BS.Util.show($('portContainer'));
            BS.Util.show($('authenticationSchemeContainer'));
            BS.Util.show($('userContainer'));
            BS.Util.show($('passwordWarningContainer'));
            BS.Util.hide($('passwordContainer'));
            BS.Util.hide($('keyFilePathContainer'));
            BS.Util.hide($('passphraseContainer'));
            BS.Util.show($('ap_gt_2'));
            BS.Util.show($('runtimeUserContainer'));
            BS.Util.show($('runtimePasswordContainer'));

            $('runtimeGroupingTitle').update("Run agent under");
            BS.Util.hide($('runtimeUserNoteWindows'));
            BS.Util.show($('runtimeUserNoteUnix'));

            if (isDefaultPath($installLocation.value)) {
                $installLocation.value = '$HOME/BuildAgent';
            }
            this.onAuthSchemeChanged();
        } else if ('Windows' == platform) {
            BS.Util.show($('installLocationContainer'));
            BS.Util.show($('ap_gt_1'));
            BS.Util.hide($('portContainer'));
            BS.Util.hide($('authenticationSchemeContainer'));
            BS.Util.show($('userContainer'));
            BS.Util.hide($('passwordWarningContainer'));
            BS.Util.show($('passwordContainer'));
            BS.Util.hide($('keyFilePathContainer'));
            BS.Util.hide($('passphraseContainer'));
            BS.Util.show($('ap_gt_2'));
            BS.Util.show($('runtimeUserContainer'));
            BS.Util.show($('runtimePasswordContainer'));

            $('runtimeGroupingTitle').update("Run agent service under");
            BS.Util.show($('runtimeUserNoteWindows'));
            BS.Util.hide($('runtimeUserNoteUnix'));

            if (isDefaultPath($installLocation.value)) {
                $installLocation.value = '%SystemDrive%\\\\BuildAgent';
            }
        }
    },
    onAuthSchemeChanged:function () {
        var sel = $('platform');
        var platform = sel[sel.selectedIndex].value;
        if ('Unix' != platform) {
            return;
        }
        if ($('userAndPassword').checked) {
            BS.Util.show($('passwordContainer'));
            BS.Util.show($('passwordWarningContainer'));

            BS.Util.hide($('keyFilePathContainer'));
            BS.Util.hide($('passphraseContainer'));
        } else {
            BS.Util.hide($('passwordContainer'));
            BS.Util.hide($('passwordWarningContainer'));

            BS.Util.show($('keyFilePathContainer'));
            BS.Util.show($('passphraseContainer'));
        }
    }
};

BS.AgentPush.Info = {
    isServerWindows: false,
    isPsExecPathRequired: false,
    isEulaAcceptRequired: false,
    PresetsPlatforms: {}
};

BS.AgentPush.InstallDialog = {
    onPlatformChanged: function (select) {
        if (BS.AgentPush.Info.isServerWindows) {
            var platformEl = $('platform');
            var platformValue = platformEl.options[platformEl.selectedIndex].value;

            if (platformValue == 'Windows') {
                if (BS.AgentPush.Info.isPsExecPathRequired) BS.Util.show($('psexecPathNoteContainer'));
                if (BS.AgentPush.Info.isEulaAcceptRequired) BS.Util.show($('licenceAcceptingNoteContainer'));
            } else {
                BS.Util.hide($('psexecPathNoteContainer'));
                BS.Util.hide($('licenceAcceptingNoteContainer'));
            }
        }
    },
    onPresetChanged: function (select) {
        var selectedValue = select.options[select.selectedIndex].value;
        if (selectedValue == 'CUSTOM') {
            BS.Util.show($('customSettings'));
        } else {
            BS.Util.hide($('customSettings'));
        }
        if (BS.AgentPush.Info.isServerWindows) {
            if (selectedValue == 'CUSTOM') {
                this.onPlatformChanged()
            } else if (selectedValue == '') {
                BS.Util.hide($('psexecPathNoteContainer'));
                BS.Util.hide($('licenceAcceptingNoteContainer'));
            } else {
                var platform = BS.AgentPush.Info.PresetsPlatforms[selectedValue];
                if (platform != undefined && platform.indexOf('Windows') != -1) {
                    if (BS.AgentPush.Info.isPsExecPathRequired) BS.Util.show($('psexecPathNoteContainer'));
                    if (BS.AgentPush.Info.isEulaAcceptRequired) BS.Util.show($('licenceAcceptingNoteContainer'));
                } else {
                    BS.Util.hide($('psexecPathNoteContainer'));
                    BS.Util.hide($('licenceAcceptingNoteContainer'));
                }
            }
        }
    }
};