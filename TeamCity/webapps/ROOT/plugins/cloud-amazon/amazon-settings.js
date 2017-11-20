/**
 * Created by Sergey.Pak on 12/9/2015.
 */

BS = BS || {};
BS.Clouds = BS.Clouds || {};
BS.Clouds.AmazonEC2 = {};

BS.Clouds.AmazonEC2.AbstractRefreshableSelect = {

  //return select element
  getElementName: function () {
    throw "abstract method error";
  },

  //return true if element el is selected. State is the same map as in rememberState
  isSelected: function (item, state) {
    throw "abstract method error";
  },

  // remembers state of current control
  rememberState: function (state) {
    throw "abstract method error";
  },

  clearOptions: function (state) {
    var el = $(this.getElementName());
    var selectedValues = {};
    for (var i=0; i< el.options.length; i++ ) {
      var opt = el.options[i];
      var txt = opt.text || opt.innerHTML;
      if (this.isSelected({name: txt, value: opt.value}, state)) {
        selectedValues[opt.value] = txt;
      }
    }
    $j(el).empty();
    return selectedValues;
  },

  filterListValues: function (valuesMap, values) {
    return values;
  },

  makeSelected: function (item, selectedItems) {
    selectedItems[item.value] = null;
  },

  updateList: function (valuesMap, state, hasDefault) {
    var selectElement = $(this.getElementName());
    var values = this.filterListValues(valuesMap, (valuesMap || {})[this.getElementName()] || []);

    var oldSelected = this.clearOptions(state);

    var idx = 0;
    if (hasDefault) {
      selectElement.options[idx++] = new Option('<Please select>', '', false, true);
    }

// Get the size of an object
    var optGroups = {};
    for (var i = 0; i < values.length; i++) {
      var item = values[i];
      if (item.type){
        if (!optGroups[item.type]){
          optGroups[item.type] = $j('<optgroup label="'+item.type+'s"></optgroup>')
        }
        if (this.getElementName()==='source-id' && item.name.split(/\n/).length > 1){
          optGroups[item.type].append($j('<option>').attr('value', item.value).text(item.name.replace("Name: ", "").replace("Id: ", "").replace(/\n/, ",")));
        } else {
          optGroups[item.type].append($j('<option>').attr('value', item.value).text(item.name || item.value));
        }
      } else {
        selectElement.options[idx++] = new Option(item.name, item.value, false, this.isSelected(item, state));
      }
      this.makeSelected(item, oldSelected);
    }
    if (Object.keys(optGroups).size() > 0){
      for (var groupName in optGroups){
        var group = optGroups[groupName];
        $j(selectElement).append(group);
      }
      var selectedElem = $j('#' + this.getElementName() + ' option[value="' + state[this.getElementName()] + '"]');
      if (selectedElem) {
        selectedElem.prop('selected', true);
      }
    }

    for (var key in oldSelected) {
      var text = oldSelected[key];
      if (text) {
        if (!/^\s*Unknown\s+value.*/i.match(text)) {
          text = "Unknown value: " + (text || key);
        }

        selectElement.options[idx++] = new Option(text, key, false, true);
      }
    }


  },

  forElement: function (name) {
    return OO.extend(this, {
      getElementName: function () {
        return name;
      }
    });
  }
};

BS.Clouds.AmazonEC2.SingleChoiceRefreshableSelect = OO.extend(BS.Clouds.AmazonEC2.AbstractRefreshableSelect, {
  isSelected: function (item, state) {
    return item.value == state[this.getElementName()];
  },

  rememberState: function (state) {
    state[this.getElementName()] = $(this.getElementName()).value;
  }
});

BS.Clouds.AmazonEC2.MultiChoiceRefreshableSelect = OO.extend(BS.Clouds.AmazonEC2.AbstractRefreshableSelect, {
  isSelected: function (item, state) {
    var selected = state[this.getElementName()];
    return this.isSelectedImpl(selected, item);
  },

  isSelectedImpl: function (selected, item) {
    return true === selected[item.value];
  },

  makeSelected: function (item, selectedItems) {
    selectedItems[item.value] = null;
    selectedItems[item.oldValue] = null;
  },

  rememberState: function (state) {
    var selected = {};
    var opts = $(this.getElementName()).options;
    for (var i = 0; i < opts.length; i++) {
      selected[opts[i].value] = opts[i].selected;
    }
    state[this.getElementName()] = selected;
  }
});

BS.Clouds.AmazonEC2 = OO.extend(BS.Clouds.AmazonEC2, {
  updatableSelect: [
    BS.Clouds.AmazonEC2.SingleChoiceRefreshableSelect.forElement('avilability-zone'),
    BS.Clouds.AmazonEC2.SingleChoiceRefreshableSelect.forElement('key-pair-name'),
    BS.Clouds.AmazonEC2.SingleChoiceRefreshableSelect.forElement('iam-instance-profile'),
    BS.Clouds.AmazonEC2.SingleChoiceRefreshableSelect.forElement('subnet-id'),
    BS.Clouds.AmazonEC2.SingleChoiceRefreshableSelect.forElement('source-id'),
    OO.extend(BS.Clouds.AmazonEC2.MultiChoiceRefreshableSelect.forElement('securityGroupsUI'), {
      isSelectedImpl: function (selected, item) {
        return (true === selected[item.value]) || (true === selected[item.oldValue]);
      },

      filterListValues: function (valuesMap, values) {
        var vpc = ((valuesMap || {}).subnet_to_vpc || {})[$('subnet-id').value];
        return $j.grep(values, function (n, i) {
          if (vpc == '' || vpc == null) {
            return (n.vpc == '' || n.vpc == null);
          } else {
            return n.vpc == vpc;
          }
        });
      }
    })
  ],
  selectors: {
    sourcesSelect: '#sourceId',
    rmImageLink: '.removeImageLink',
    editImageLink: '.editImageLink',
    imagesTableRow: '.imagesTableRow'
  },
  _errorIds: ['source-id', 'source-id-custom', 'security-group-ids', 'key-pair-name', 'image-instances-limit', 'spot-instance-price', 'user-script', 'user-tags'],
  _displayedErrors: {},

   /*
   <th class="name">Source</th>
   <th class="name">Instance Type</th>
   <th class="name hidden">VPC</th>
   <th class="name hidden">Key Pair</th>
   <th class="name hidden">Spot instance</th>
   <th class="name maxInstances">Max #</th>
   <th class="name" colspan="2"></th>
  * */
  _imagesTableRowTemplate: $j('<tr class="imagesTableRow">\
<td class="source-id highlight"><div class="sourceIcon sourceIcon_unknown">?</div><span class="sourceId"></span></td>\
<td class="instance-type highlight"></td>\
<td class="subnet-id highlight"></td>\
<td class="key-pair-name highlight "></td>\
<td class="spot-instances highlight "></td>\
<td class="image-instances-limit highlight"></td>\
<td class="edit highlight"><span class="editImageLink_disabled" title="Editing is available after successful retrieval of data">edit</span><a href="#" class="editImageLink hidden">edit</a></td>\
<td class="remove"><a href="#" class="removeImageLink">delete</a></td>\
    </tr>'),

  _refreshUrl : '',

  init: function(prefetchOnLoad, refreshUrl){
    this.$showDialogButton = $j('#amazonShowDialogButton');
    this.$imagesDataElem = $j('#source_images_json');
    this.$imagesTable = $j('#amazonImagesTable');
    this.$imagesTableWrapper = $j('.imagesTableWrapper');
    this.$dialogSubmitButton = $j('#addImageButton');
    this.$sourceIdField = $j('#source-id');
    this.$sourceIdCustomField = $j('#source-id-custom');
    this.$subnetIdField = $j('#subnet-id');
    this.$avilabilityZone = $j('#avilability-zone');
    this.$iamInstanceProfile = $j('#iam-instance-profile');
    this.$keyPairName = $j('#key-pair-name');
    this.$instanceType = $j('#instance-type');
    this.$ebsOptimized = $j('#ebs-optimized');
    this.$useSpotInstances = $j('#use-spot-instances');
    this.$spotInstancePrice = $j('#spot-instance-price');
    this.$maxImageInstances = $j('#image-instances-limit');
    this.$userTags = $j('#user-tags');
    this.$securityGroupIds = $j('#security-group-ids');
    this.$cancelButton = $j('#amazonCancelDialogButton');
    this.$imageNamePrefix = $j('#image-name-prefix');
    this.$confirmRemoveButton = $j("#removeImageConfirmButton");
    this.$cancelRemoveButton = $j("#removeImageCancelButton");
    this.$userScript = $j("#user-script");
    this.$agentPoolId = $j('#agent_pool_id');
    this._bindHandlers();

    this._lastImageId = this._imagesDataLength = 0;

    this._refreshUrl = refreshUrl;
    this._windowsAmisMap = {};

    BS.Clouds.AmazonEC2.disableRefreshableElements();

    $j('#not-checked').addClass('ignoreModified');

    var that = this;
    if (prefetchOnLoad=='true') {
      setTimeout(function () {
        that._initData();
        that.renderImagesTable(true);
        BS.Clouds.AmazonEC2.refreshProfilesOptions(true);
        that.resetDataAndDialog();
      }, 400);
    } else {
      that.renderImagesTable(false);
      that.resetDataAndDialog();
    }
  },

  _bindShowDialogHandler: function(bind){
    if (bind) {
      this.$showDialogButton.on('click', function () {
        this.showAddEditImageDialog();
        return false;
      }.bind(this));
    } else {
      this.$showDialogButton.off('click');
    }
  },

  _bindHandlers: function(){
    var self = this;
    this.$dialogSubmitButton.on('click', this._submitDialogHandler.bind(this));

    this.$sourceIdField.on('change', function(e, data){
      if (arguments.length === 1) {
        if ($j(this).val()=='custom'){
          BS.Util.show('tr_source-id-custom');
          $j('.amiOnly').removeClass('hidden');
          self._imageData[this.getAttribute('id')] = $j('#source-id-custom').val();
        } else {
          BS.Util.hide('tr_source-id-custom');
          if (e.target.value.indexOf('ami-')==0){
            $j('.amiOnly').removeClass('hidden');
          } else {
            $j('.amiOnly').addClass('hidden');
          }
          var map = {};
          Object.keys(self.data).forEach(function (idx) {
            if (idx != self.$dialogSubmitButton.data('imageId')) {
              map[self.data[idx]['source-id']] = '1';
            }
          });
          if (map[e.target.value] == '1'){
            self.addOptionError('not_unique', 'source-id');
          } else {
            self._imageData[this.getAttribute('id')] = e.target.value;
          }
        }
      } else {
        this.value = data;
        // data is not in the list
        if (this.value != data) {
          $j('#source-id-custom').val(data);
          BS.Util.show('tr_source-id-custom');
          $j('.amiOnly').removeClass('hidden');
          self.$sourceIdField.trigger('change', 'custom');
        } else if (data != 'custom') {
          BS.Util.hide('tr_source-id-custom');
          if (e.target.value.indexOf('ami-') == 0){
            $j('.amiOnly').removeClass('hidden');
          } else {
            $j('.amiOnly').addClass('hidden');
          }
        }
      }
    });

    this.$sourceIdCustomField.on('change', function(e, data){
      if (arguments.length === 1) {
        if ($j('#source-id').val()=='custom'){
          self._imageData['source-id'] = $j('#source-id-custom').val();
        }
      } else {
        this.value = data;
      }
    });
    
    this.$avilabilityZone
        .add(this.$securityGroupIds)
        .add(this.$iamInstanceProfile)
        .add(this.$keyPairName)
        .add(this.$subnetIdField)
        .add(this.$agentPoolId)
        .on('change', function(e, data){
          if (arguments.length === 1) {
            self._imageData[this.getAttribute('id')] = e.target.value;
          } else {
            this.value = data;
          }
        });

    this.$instanceType.on('change', function(e, data){
      if (arguments.length === 1) {
        self._imageData[this.getAttribute('id')] = e.target.value;
      } else {
        this.value = data;
      }

      var selectedOption = $j(this).find('option:selected');
      if (selectedOption == undefined)
        return;

      var ebsOptimized = selectedOption.attr('data-ebs-optimized') == 'true';

      if (selectedOption.attr('data-ebs-customizable') == 'true') {
        self.$ebsOptimized.removeAttr('disabled');
      } else {
        self.$ebsOptimized.attr('disabled', 'disabled');
      }
      if (arguments.length == 1 && data == undefined) {

        var currentInstanceType = self._imageData['instance-type'];
        if (currentInstanceType == undefined || selectedOption.value == currentInstanceType)
          return;

        self.$ebsOptimized.prop('checked', ebsOptimized);
        self._imageData['ebs-optimized'] = ebsOptimized;
      }

      if (data != undefined && data != '' && (
          self._imageData['ebs-optimized'] == undefined
          || self._imageData['ebs-optimized'] == '')
      ){
        if (ebsOptimized){
          self._imageData['ebs-optimized'] = true;
          self.$ebsOptimized.prop('checked', ebsOptimized);
        }
      }
    });

    this.$maxImageInstances
        .on('change', function(e, data){
          var val = e.target.value;
          if (arguments.length === 1) {
            if ($j.isNumeric(val)) {
              self._imageData[this.getAttribute('id')] = parseInt(val).toString();
            } else {
              self._imageData[this.getAttribute('id')] = val
            }
          } else {
            this.value = data;
          }
        });
    this.$spotInstancePrice
        .on('change', function(e, data){
          var val = e.target.value;
          if (arguments.length === 1) {
            if ($j.isNumeric(val)) {
              self._imageData[this.getAttribute('id')] = parseFloat(val).toString();
            } else {
              self._imageData[this.getAttribute('id')] = val
            }
          } else {
            this.value = data;
          }
        });

    this.$imageNamePrefix
        .add(this.$userScript)
        .add(this.$userTags)
        .on('change', function(e, data){
          var val = e.target.value;
          if (arguments.length === 1) {
            self._imageData[this.getAttribute('id')] = val;
          } else {
            this.value = data;
          }
        });

    this.$useSpotInstances.on('change', function(e, data){
      if (arguments.length === 1) {
        self._imageData['use-spot-instances'] = self.$useSpotInstances.is(':checked');
      } else {
        this.checked = data;
      }
      if ($j(this).prop('checked')){
        BS.Util.show('spotInstancePriceDiv');
      } else {
        BS.Util.hide('spotInstancePriceDiv');
      }
    });


    this.$ebsOptimized.on('change', function(e, data){
      if (arguments.length === 1) {
        self._imageData['ebs-optimized'] = self.$ebsOptimized.is(':checked');
      } else {
        this.checked = data;
      }
    });


    this.$cancelButton.on('click', function () {
      BS.AmazonImageDialog.close();

      return false;
    }.bind(this));

    this.$imagesTable.on('click', this.selectors.imagesTableRow + ' .highlight', function () {
      if ($('not-checked').value=='') {
        self.showEditDialog($j(this).parents(self.selectors.imagesTableRow).find(self.selectors.editImageLink), self);
      }

      return false;
    });

    this.$imagesTable.on('click', this.selectors.rmImageLink, function () {
      var $this = $j(this),
          id = $this.data('imageId'),
          name = self.data[id]["source-id"];

      BS.confirm('Are you sure you want to remove the image "' + name + '"?', function () {
        self.removeImage($this);
      });
      return false;
    });

    this.$confirmRemoveButton.on('click', function(){
      if ($j("#terminateInstances").is(':checked')){
        self.terminateInstances(self._refreshUrl, $j('#removeSourceIds').val());
      }

      //BS.RemoveImageDialog.close();
      BS.Clouds.Admin.CreateProfileForm.saveForm();
      return false;

    });

    this.$cancelRemoveButton.on('click', function() {
      BS.RemoveImageDialog.close();
      return false;
    });

    $j('#newProfileForm')
        .off('submit')
        .attr('onSubmit', '')
        .on('submit', function(){
      var imgs = $j('#initial_images_list').val().split(',');
      imgs = $j.grep(imgs,function(img){return img != '';});
      Object.keys(self.data).forEach(function (imageId) {
        var src = self.data[imageId]['source-id'];
        imgs = $j.grep(imgs,function(img){return img != src;});
      });
      self.showTerminateInstancesDialogIfNecessary(self._refreshUrl, imgs);

      return false;
    });

  }
  ,
  showConfirmRemoveDialog: function(imgs) {

    $j('#RemoveImageDialogTitle').text('Terminate instances');
    $j('#removeSourceIds').val(imgs);
    $j('#terminateInstances').prop('checked', true);

    BS.Hider.addHideFunction('RemoveImageDialog', this.resetDataAndDialog.bind(this));

    BS.RemoveImageDialog.showCentered();

  },

  resetDataAndDialog: function () {
    this._initImage();
    this.clearOptionsErrors();
    this._destroyJQueryDropdowns();
    this.$instanceType.val('t2.micro');
    this.$instanceType.change();
    this.$ebsOptimized.prop('checked', false);
    this.$ebsOptimized.change();
    this.$maxImageInstances.trigger('change', '');
    this.$userTags.trigger('change', '');
    this.$subnetIdField.trigger('change', '');
    this.$avilabilityZone.trigger('change', '');
    this.$keyPairName.trigger('change','');
    this.$useSpotInstances.prop('checked', false);
    this.$useSpotInstances.change();
    this.$spotInstancePrice.trigger('change', '0');
    this.$sourceIdField.trigger('change', '');
    this.$imageNamePrefix.trigger('change', '');
    this.$userScript.trigger('change', '');
    this.$agentPoolId.trigger('change', '0');

    this.$securityGroupIds.val('');
    this.$securityGroupIds.change();
    this.syncSecurityGroupsUI();

  },

  showAddEditImageDialog: function(action, imageId){
    action = action ? 'Edit' : 'Add';

    $j('#AmazonDialogTitle').text(action + ' Image');
    this.$dialogSubmitButton.val(action === 'Edit' ? 'Save' : action).data('imageId', imageId);

    BS.Hider.addHideFunction('AmazonImageDialog', this.resetDataAndDialog.bind(this));
    typeof imageId !== 'undefined' && (this._imageData = $j.extend({}, this.data[imageId]));

    //BS.Clouds.AmazonEC2.updateSelection();
    BS.Clouds.AmazonEC2.subscribeSync();
    BS.Clouds.AmazonEC2.updateVPCSubnets();
    BS.Clouds.AmazonEC2.updateSpotPricingField();

    BS.AmazonImageDialog.showCentered();
    this._enableJQueryDropdowns();
  },
  showEditDialog: function ($elem) {
    this.showAddEditImageDialog('edit', $elem.data('imageId'));
    this._triggerDialogChange();
  },
  removeImage: function ($elem) {
    delete this.data[$elem.data('imageId')];
    this._imagesDataLength -= 1;
    $elem.parents(this.selectors.imagesTableRow).remove();
    this._saveImagesData();
    this._toggleImagesTable();
  },

  /**
   * @param {jQuery} [errorId]
   */
  clearErrors: function (errorId) {
    var target = errorId ? $j('.option-error_' + errorId) : this.$fetchOptionsError;

    if (errorId) {
      this._displayedErrors[errorId] = [];
    }

    target.empty();
  },
  /**
   * @param {html|String} errorHTML
   * @param {jQuery} [target]
   */
  addError: function (errorHTML, target) {
    (target || this.$fetchOptionsError)
        .append($j("<div>").html(errorHTML));
  },
  addOptionError: function (errorKey, optionName) {
    var html;
    this._displayedErrors[optionName] = this._displayedErrors[optionName] || [];

    if (typeof errorKey !== 'string') {
      html = this._errors[errorKey.key];
      Object.keys(errorKey.props).forEach(function(key) {
        html = html.replace('%%'+key+'%%', errorKey.props[key]);
      });
      errorKey = errorKey.key;
    } else {
      html = this._errors[errorKey];
    }

    if (this._displayedErrors[optionName].indexOf(errorKey) === -1) {
      this._displayedErrors[optionName].push(errorKey);
      this.addError(html, $j('.option-error_' + optionName));
    }
  },
  /**
   * @param {string[]} [options]
   */
  clearOptionsErrors: function (options) {
    (options || this._errorIds).forEach(function (optionName) {
      this.clearErrors(optionName);
    }.bind(this));
  },

  /**
   * returns source type for current image or the one provided
   * @param {jQuery} $source
   * @returns {string}
   * @private
   */
  _getSourceType: function ($source) {
    var _source = $source || this._imageData.$image;

    return (_source && _source.length) ?
           _source.get(0).nodeName.toLowerCase() :
           null;
  },

  _errors: {
    required: 'The field must not be empty',
    not_unique: 'Source must be unique within a profile. You can add it to another profile',
    positiveNumber: 'Must be empty or a positive number',
    nonexistent: 'The %%elem%% &laquo;%%val%%&raquo; does not exist',
    no_spaces: 'Spaces are not allowed',
    max_length: 'Maximum allowed length is %%length%%',
    invalid_tag: 'Invalid tag data: %%tag%%',
    invalid_script: "The provided value is not a valid %%os_name%% script.<br/> Please refer to <a target='_blank' href='%%url%%'>documentation</a> for details."
  },


  validateOptions: function (options) {
    var maxInstances = this._imageData['image-instances-limit'],
        isValid = true,
        validators = {
          sourceId: function () {
            if ( ! this._imageData["source-id"]) {
              if ($j('#source-id').val() == 'custom'){
                this.addOptionError('required', 'source-id-custom');
              } else {
                this.addOptionError('required', 'source-id');
              }
              isValid = false;
            }
          }.bind(this),
          keyPairName: function () {
            if (! this._imageData["key-pair-name"]) {
              this.addOptionError('required', 'key-pair-name');
              isValid = false;
            }
          }.bind(this),
          securityGroupIds: function () {
            if (! this._imageData["security-group-ids"]) {
              this.addOptionError('required', 'security-group-ids');
              isValid = false;
            }
          }.bind(this),
          spotInstancePrice: function(){
            if (this._imageData["use-spot-instances"] == true || this._imageData["use-spot-instances"] == 'true'){
              var spotPrice = this._imageData['spot-instance-price'];
              if (!spotPrice || !$j.isNumeric(spotPrice) || spotPrice < 0){
                this.addOptionError('positiveNumber', 'spot-instance-price');
                isValid = false;
              }
            }
          }.bind(this),
          maxInstances: function () {
            if (!maxInstances)
                return;
            if (!maxInstances || !$j.isNumeric(maxInstances) || maxInstances < 0) {
              this.addOptionError('positiveNumber', 'image-instances-limit');
              isValid = false;
            }
          }.bind(this),
          userTags :function(){
            var tags = this._imageData['user-tags'];
            if (!tags)
              return;
            var that = this;
            tags.split(',').forEach(function(tagData){
              if (tagData.trim().length == 0)
                return;

              var split = tagData.split('=');
              if (split.length < 2 || $j.trim(split[0]) == '' || $j.trim(split[0]).length > 127 || $j.trim(split[1]).length > 255){
                that.addOptionError({key: 'invalid_tag', props: {tag: tagData}}, 'user-tags');
                isValid = false;
              }
            });
          }.bind(this),
          userScript: function(){
            var userScript = this._imageData["user-script"];
            if (!userScript)
              return;
            if (userScript.length > 14 * 1024) {
              this.addOptionError({key: 'max_length', props: {length: '14kb'}}, 'user-script');
              isValid = false;
              return;
            }
            var items = $j.grep(this.regionData['source-id'], function (e) {
              return e['value'] == this._imageData["source-id"];
            }.bind(this));
            if (!items || items.length == 0) {
              return;
            }
            var platform = items[0]['platform'];
            if (platform == 'windows') {
              // validate windows
              var scriptValid = (userScript.indexOf('<script>') == 0 && userScript.indexOf('</script>') == userScript.length - '</script>'.length)
                                || (userScript.indexOf('<powershell>') == 0 && userScript.indexOf('</powershell>') == userScript.length - '</powershell>'.length);

              if (!scriptValid) {
                this.addOptionError({key: 'invalid_script', props: {os_name: 'Windows', url: 'http://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/ec2-instance-metadata.html'}},
                                    'user-script');
                isValid = false;
              }

            } else {
              if (userScript.indexOf('#') != 0) {
                this.addOptionError({key: 'invalid_script', props: {os_name: 'shell or cloud-init', url: 'http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html'}},
                                    'user-script');
                isValid = false;
              }
            }
          }.bind(this)
        };

    if (options && ! $j.isArray(options)) {
      options = [options];
    }
    this.clearOptionsErrors(options);

    (options || Object.keys(validators)).forEach(function(option) {
      if (validators[option]) {
        if (Array.isArray(validators[option])) {
          validators[option].some(function (validator) {
            return validator();
          });
        } else {
          validators[option](); // validators are already bound to parent object
        }
      }
    });

    return isValid;
  },

  _triggerDialogChange: function () {
    var image = this._imageData;

    this.$sourceIdField.trigger('change', image['source-id'] || '');

    this.$subnetIdField.trigger('change', image['subnet-id'] || '');

    this.$avilabilityZone.trigger('change', image['avilability-zone'] || '');

    this.$iamInstanceProfile.trigger('change', image['iam-instance-profile'] || '');

    this.$keyPairName.trigger('change', image['key-pair-name'] || '');

    this.$userScript.trigger('change', image['user-script'] || '');
    this.$instanceType.trigger('change', image['instance-type'] || '');

    this.$ebsOptimized.prop('checked', true == image['ebs-optimized'] || 'true' == image['ebs-optimized']);
    this.$useSpotInstances.prop('checked', 'true' == image['use-spot-instances'] || true == image['use-spot-instances']);
    this.$useSpotInstances.change();
    this.$spotInstancePrice.trigger('change', image['spot-instance-price'] || '');
    this.$imageNamePrefix.trigger('change', image['image-name-prefix'] || '');

    this.$maxImageInstances.trigger('change', image['image-instances-limit'] || '');
    this.$userTags.trigger('change', image['user-tags'] || '');

    this.$securityGroupIds.val(image['security-group-ids'] || '');

    this.$agentPoolId.trigger('change', image['agent_pool_id'] || '');

    this.updateSpotPricingField();
    this.syncSecurityGroupsUI();
  },

  _enableJQueryDropdowns: function () {
    BS.enableJQueryDropDownFilter(this.$sourceIdField.attr('id'), {});
    BS.enableJQueryDropDownFilter(this.$subnetIdField.attr('id'), {});
    BS.enableJQueryDropDownFilter(this.$avilabilityZone.attr('id'), {});
    BS.enableJQueryDropDownFilter(this.$iamInstanceProfile.attr('id'), {});
    BS.enableJQueryDropDownFilter(this.$keyPairName.attr('id'), {});
    BS.enableJQueryDropDownFilter(this.$instanceType.attr('id'), {});
    BS.enableJQueryDropDownFilter(this.$agentPoolId.attr('id'), {});
  },

  _destroyJQueryDropdowns: function () {
    this.$sourceIdField.ufd('destroy');
    this.$subnetIdField.ufd('destroy');
    this.$iamInstanceProfile.ufd('destroy');
    this.$keyPairName.ufd('destroy');
    this.$instanceType.ufd('destroy');
    this.$agentPoolId.ufd('destroy');
  },

  _initData: function(){
    var self = this,
        rawImagesData = this.$imagesDataElem.val() || '[]',
        imagesData;

    try {
      imagesData = JSON.parse(rawImagesData);
    } catch (e) {
      imagesData = [];
      BS.Log.error('bad images data: ' + rawImagesData);
    }

    this.data = imagesData.reduce(function (accumulator, imageDataStr) {
      // drop images without sourceId
      if (imageDataStr["source-id"]) {
        accumulator[self._lastImageId++] = imageDataStr;
        self._imagesDataLength++;
      }

      return accumulator;
    }, {});

  },

  _initImage: function () {
    this._imageData = {};
  },

  _saveImagesData: function () {
    var imageData = Object.keys(this.data).reduce(function (accumulator, id) {
      var _val = $j.extend({}, this.data[id]);

      accumulator.push(_val);

      return accumulator;
    }.bind(this), []);

    this.$imagesDataElem.val(JSON.stringify(imageData));
  },
  _updateDataAndView: function (imageId) {
    this.data[imageId] = this._imageData;
    this._saveImagesData();
    this.renderImagesTable(false);

  },

  validateImages: function () {
    return true;
  },

  _toggleEditLinks: function (enable) {
    $j(this.selectors.editImageLink).toggleClass('hidden', !enable);
    $j(this.selectors.editImageLink + '_disabled').toggleClass('hidden', !!enable);
  },

  _submitDialogHandler: function () {
    if (this.validateOptions()) {
      if (this.$dialogSubmitButton.val().toLowerCase() === 'save') {
        this._updateDataAndView(this.$dialogSubmitButton.data('imageId'));
      } else {
        this._imagesDataLength += 1;
        this._updateDataAndView(this._lastImageId++);
      }

      this.validateImages();
      BS.AmazonImageDialog.close();
      this._toggleEditLinks(true);
    }

    return false;
  },

  terminateInstances: function(url, imgsString){

    if (BS.Clouds.Admin.CreateProfileForm.formElement() == null) return false;

    BS.ajaxRequest(url, {
      parameters: {
        action: 'terminateInstances',
        profileId: $j('#profileId').val(),
        sources: imgsString
      },
      method: 'post'
    });
  },

  showTerminateInstancesDialogIfNecessary: function(url, imgs){
    if (BS.Clouds.Admin.CreateProfileForm.formElement() == null) return false;

    var self = this;
    BS.ajaxRequest(url, {
      parameters: {
        action: 'getInstances2terminate',
        projectId: $j('#projectId').val(),
        profileId: $j('#profileId').val(),
        sources: imgs.toString()
      },
      method: 'post',
      onComplete: function(response) {
        var xml = response.responseXML;
        var instances = xml.documentElement.getElementsByTagName("instance");
        $j('#instances2Terminate').empty();
        $j('#images2Remove').empty();
        if (instances.length > 0) {
          $j.each(instances,
                  function (i, elem) {
                    $j('#instances2Terminate').append('<li>' + $j(elem).text() + '</li>');
                  }
          );
          debugger;
          $j.each(xml.documentElement.getElementsByTagName("image"), function(i, elem){
            $j('#images2Remove').append('<li>' + $j(elem).attr('name') + '</li>');
                  }
          );

          self.showConfirmRemoveDialog(imgs);
        } else {
          BS.Clouds.Admin.CreateProfileForm.saveForm();
        }
      }
    });

  },

  refreshProfilesOptions: function (isAutomatic) {
    //Check if form was unloaded
    if (BS.Clouds.Admin.CreateProfileForm.formElement() == null) return false;
    var that = this,
        refreshUrl = this._refreshUrl;

    $('error_fetch_data').innerHTML = '';

    if (!!isAutomatic) {
      refreshUrl += '?useRegionCache=1'
    }

    BS.FormSaver.save(BS.Clouds.Admin.CreateProfileForm, refreshUrl, OO.extend(BS.ErrorsAwareListener, {
      onBeginSave: function (form) {
        if (BS.Clouds.Admin.CreateProfileForm.formElement() == null) return;

        BS.Clouds.Admin.CreateProfileForm._savingIndicator = BS.Clouds.Admin.CreateProfileForm.savingIndicator;
        BS.Clouds.Admin.CreateProfileForm.savingIndicator = function() {
          return $('amazonRefreshableParametersLoadingWrapper');
        };

        BS.ErrorsAwareListener.onBeginSave(form);

        $j('#amazonRefreshableParametersLoadingWrapper').removeClass('hidden');
        $('amazonRefreshableParametersButton').disabled = true;
        that._bindShowDialogHandler(false);

        $j('#amazonShowDialogButton').attr('disabled','disabled');

      },

      onCompleteSave: function (form, responseXML, err) {
        if (BS.Clouds.Admin.CreateProfileForm.formElement() == null) return;
        var wereErrors = BS.XMLResponse.processErrors(responseXML, {}, form.propertiesErrorsHandler);

        $j('#amazonRefreshableParametersLoadingWrapper').addClass('hidden');
        $('amazonRefreshableParametersButton').disabled = false;
        $j('#amazonShowDialogButton').removeAttr('disabled');
        that._bindShowDialogHandler(true);

        BS.ErrorsAwareListener.onCompleteSave(form, responseXML, err);
        BS.Clouds.Admin.CreateProfileForm.savingIndicator = BS.Clouds.Admin.CreateProfileForm._savingIndicator;

        if (wereErrors) {
          BS.Util.reenableForm(form.formElement());
          return;
        }

        var regionsTags = responseXML.getElementsByTagName("regions");
        var regions = regionsTags[0].getElementsByTagName("region");

        that.regionData = {};

        var region = regions[0];

        var value = region.getAttribute('url');
        var info = region.getAttribute('info');
        var iamDisabled = region.getAttribute('iam-profiles-disabled') == 'true';
        if (iamDisabled) {
          $j('#iam-profile-disabled').removeClass('hidden');
          $j('#iam-instance-profile').addClass('hidden');
        } else {
          $j('#iam-profile-disabled').addClass('hidden');
          $j('#iam-instance-profile').removeClass('hidden');
        }

        var errorElement = region.getElementsByTagName('error');
        if (errorElement.length > 0) {
          $('error_fetch_data').innerHTML +=
              '<div class="attentionComment"> Failed to fetch data from region ' + info
              + '<div style="margin-left: 2em;">URL: ' + value + '</div>'
              + '<div style="margin-left: 2em;">' + errorElement[0].firstChild.nodeValue + '</div>'
              + '</div>';
          return;
        }

        var parse = function (elementName, mapping, result) {
          $j.each(region.getElementsByTagName(elementName) || [],
                  function (i, el) {
                    var obj = {};
                    $j.each(mapping, function (k, v) {
                      obj[k] = el.getAttribute(v);
                    });
                    result.push(obj);
                  });
          return result;
        };
        that.regionData['source-id'] = parse("source-id", {name: 'name', value: 'value', type: 'type', platform:'platform'},[
          {name:'<Please select>', value:''} , 
          {name:'Public AMI (please specify below)', value:'custom'}
        ]);
        that.regionData['avilability-zone'] = parse('zone-info', {value: 'name', name: 'amazon-value'}, [{name: 'default', value: ''}]);
        that.regionData['key-pair-name'] = parse("key-pair", {name: 'name', value: 'name'}, [{name:'<Please select>', value:''}]);
        that.regionData['iam-instance-profile'] = parse("iam-profile", {name: 'name', value: 'name'}, [{name: '(no IAM profile)', value: ''}]);
        that.regionData['subnet-id'] = parse("subnet", {name: 'name', value: 'value', availabilityZone: 'availabilityZone', vpc: 'vpc-id'},
                                                  [{name: '(no VPC)', value: '', availabilityZone: '', vpc: ''}]);
        that.regionData['securityGroupsUI'] = parse("security-group", {value: 'id', oldValue: 'name', name: 'description', vpc: 'vpc-id'}, []);

        that.regionData.subnet_to_vpc = {};
        that.regionData.subnet_to_zone = {};
        $j.each(that.regionData['subnet-id'], function (i, n) {
          that.regionData.subnet_to_vpc[n.value] = n.vpc;
          that.regionData.subnet_to_zone[n.value] = n.availabilityZone;
        });


        //that.updateSelectionEx(state);

        BS.Util.reenableForm(form.formElement());
        that.renderImagesTable(false);
        that.enableRefreshableElements();
      }
    }));

    return false;
  },

  _findHumanReadableName: function(className, value){
    var retval = value;
    $j.each(this.regionData[className], function(i, n){
      if (n.value==value)
        retval = n.name;
    });
    return retval;
  },

  data: [],
  regionData: {},

  foreachUpdatableSelect: function (action) {
    for (var i = 0; i < this.updatableSelect.length; i++) {
      action(this.updatableSelect[i]);
    }
  },

  _updateSelectionEx_pending: false,

  updateSelectionEx: function (state) {
    if (this._updateSelectionEx_pending) return;
    this._updateSelectionEx_pending = true;
    var that = this;

    this.foreachUpdatableSelect(function (sel) {
      sel.updateList(that.regionData, state);
    });
    this.updateVPCSubnets();

    this._updateSelectionEx_pending = false;
  },

  updateSelection: function () {
    this.updateSelectionEx(this.rememberSelection());
  },

  rememberSelection: function () {
    var state = {
      'endpoint-url': $('endpoint-url').value
    };
    this.foreachUpdatableSelect(function (sel) {
      sel.rememberState(state);
    });
    return state;
  },

  updateRefreshableElements: function (action) {
/*
    $('amazonRefreshableSection_start').nextSiblings().each(
        function (el) {
          if (el.id == 'amazonRefreshableSection_end') throw $break;

          var form = BS.Clouds.Admin.CreateProfileForm.formElement();
          var filter = function (e) {
            return BS.Util.descendantOf(e, el);
          };
          action(form, el, filter);
        });
*/
  },

  updateVPCSubnets: function () {
    var value = $('subnet-id').value;
    if (value) {
      //var data = ((this.regionData || {} )[$('endpoint-url').value]) || {};
      var zone = (this.regionData.subnet_to_zone || {} )[value];
      $('amazonVPCZone').innerHTML = zone || 'default';
      BS.Util.show('availabilityZoneContainerVPC');
      BS.Util.show('auto-assign-public-ip');
      BS.Util.hide('availabilityZoneContainerNoVPC');
    } else {
      BS.Util.hide('availabilityZoneContainerVPC');
      BS.Util.hide('auto-assign-public-ip');
      BS.Util.show('availabilityZoneContainerNoVPC');
    }

    this.updateSelection();
    BS.MultilineProperties.updateVisible();
  },

  updateSpotPricingField: function() {

  },

  updateUseInstanceIamRole: function() {
    var iamrole = $j('#use-instance-iam-role');
    if (iamrole.length > 0 && iamrole.is(':checked')){
      $j('.credentials-tr').hide();
    } else {
      $j('.credentials-tr').show();
    }
  },

  disableRefreshableElements: function () {
    $('not-checked').value = 'true';
    this._toggleEditLinks(false);
    this.updateRefreshableElements(function (form, el, filter) {
      //BS.Util.disableFormTemp(form, filter);
      BS.Util.hide(el);
    });
  },

  enableRefreshableElements: function () {
    $('not-checked').value = '';
    this._toggleEditLinks(true);
    this.updateRefreshableElements(function (form, el, filter) {
      //BS.Util.reenableForm(form, filter);
      BS.Util.show(el);
    });

    BS.MultilineProperties.updateVisible();
  },

  syncSecurityGroupsUI: function(){
    var val = this.$securityGroupIds.val();
    var groupsArray = val.split(/[,;]/).filter(function(val){return val != undefined && val != '';});
    var opts = $('securityGroupsUI').options;
    for (var i = 0; i < opts.length; i++) {
      opts[i].selected = $j.inArray(opts[i].value, groupsArray)>=0;
    }

  },

  syncSecurityGroups: function () {
    var val = "";
    var opts = $('securityGroupsUI').options;
    for (var i = 0; i < opts.length; i++) {
      var opt = opts[i];
      if (opt.selected) {
        val += opt.value + ",";
      }
    }
    this.$securityGroupIds.val(val);
  },

  subscribeSync: function () {
    var self = this;
    $('securityGroupsUI').on("click", function () {
      BS.Clouds.AmazonEC2.syncSecurityGroups();
      self.$securityGroupIds.trigger('change');
    });
    $('securityGroupsUI').on("change", function () {
      BS.Clouds.AmazonEC2.syncSecurityGroups();
      self.$securityGroupIds.trigger('change');
    });
    $('securityGroupsUI').on("mouseout", function () {
      BS.Clouds.AmazonEC2.syncSecurityGroups();
    });

    var that = BS.Clouds.Admin.CreateProfileForm.beforeSaveForm;
    BS.Clouds.Admin.CreateProfileForm.beforeSaveForm = function () {
      BS.Clouds.AmazonEC2.syncSecurityGroups();
      that();
    };
  },

  _clearImagesTable: function () {
    this.$imagesTable.find(this.selectors.imagesTableRow).remove();
  },

  _toggleImagesTable: function () {
    var toggle = !!this._imagesDataLength;
    this.$imagesTableWrapper.show();
    this.$imagesTable.toggle(toggle);
  },

  _renderImageRow: function (data, id) {
    var $row = this._imagesTableRowTemplate.clone();
    var that = this;

    Object.keys(data).forEach(function (className) {
      if (typeof data[className] === 'string') {
        var humanReadableName = that._findHumanReadableName(className, data[className]);
        var split = humanReadableName.split(/\n/);

        $row.find('.' + className).text('');
        $j.each(split, function(i, v){
          if (i > 0){
            $row.find('.' + className).append('<br/>');
          }
          $row.find('.' + className).append(v);
        });

      }
    });
    if (data["use-spot-instances"] == true ||data["use-spot-instances"]=='true'){
      $row.find('.spot-instances').text('$'+data['spot-instance-price']);
    } else {
      $row.find('.spot-instances').text('<Not Used>');
    }

    if (data["image-name-prefix"]){
      $row.find('.source-id').append("<br/>Agent name prefix: " + data["image-name-prefix"]);
    }

    $row.attr('data-image-id', id)
        .find(this.selectors.rmImageLink).data('imageId', id).end()
        .find(this.selectors.editImageLink).data('imageId', id);
    this.$imagesTable.append($row);
  },

  renderImagesTable: function(initialLoad){
    this._clearImagesTable();

    if (this._imagesDataLength) {
      Object.keys(this.data).forEach(function (imageId) {
        if (initialLoad == true){
          var src = this.data[imageId]['source-id'];
          $j('#initial_images_list').val($j('#initial_images_list').val() + src + ",");
        }
        this._renderImageRow(this.data[imageId], imageId);
      }.bind(this));
    }

    this._toggleImagesTable();
    BS.Clouds.Admin.CreateProfileForm.checkIfModified();

  }
});

BS.AmazonImageDialog = OO.extend(BS.AbstractModalDialog, {
  getContainer: function() {
    return $('AmazonImageDialog');
  }
});

BS.RemoveImageDialog = OO.extend(BS.AbstractModalDialog, {
  getContainer: function () {
    return $('RemoveImageDialog');
  }
});
