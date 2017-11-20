/*
 * Copyright (c) 2006, JetBrains, s.r.o. All Rights Reserved.
 */
BS.TagsEditingMixin = {
  init: function (that) {
    var _afterClose = that.afterClose;

    that.afterClose = function () {
      _afterClose && _afterClose.call(that);
      BS.TagsEditingMixin.afterClose.call(that);
    };

    that.showTags = function (availableTagsContainerId, partOfChain) {
      $(this.formId + '_availableTags').innerHTML = '';
      if ($(availableTagsContainerId)) {
        $(this.formId + '_availableTags').innerHTML = $(availableTagsContainerId).innerHTML;
        var checkbox = $j($(this.formId + '_availableTags')).find('.all-tags-switch');
        checkbox.attr('id', checkbox.attr('data-id'));
      }

      if (partOfChain) {
        $j(BS.Util.escapeId(this.formId) + " .tagsApplyAll").show();
      }

      $j(document)
        .off('bs.appendTag')
        .on('bs.appendTag', function (e, tag) {
          that.appendTag(tag);
        });
    };

  },
  afterClose: function () {
    $j(document).off('bs.appendTag')
    $j(BS.Util.escapeId(this.formId + '_availableTags'))
      .find('.all-tags-switch').removeAttr('id');
  }
};

BS.Tags = OO.extend(BS.AbstractModalDialog, {
  formId: "editBuildTagsForm",

  getContainer: function() {
    return $(this.formId + 'Dialog');
  },

  showEditDialog: function(promotionId, escapedPublicTags, escapedPrivateTags, partOfChain, availableTagsContainerId) {
    var form = $(this.formId);
    form.editTagsForPromotion.value = promotionId;
    form.buildTagsInfo.value = escapedPublicTags;

    var privateTagsInfo = form.buildPrivateTagsInfo;
    if (privateTagsInfo) privateTagsInfo.value = escapedPrivateTags;

    this.showTags(availableTagsContainerId, partOfChain);

    this.showCentered();
    $j('#buildTagsInfoEditTags').focus();

    this.bindCtrlEnterHandler(this.submitTags.bind(this));
    return false;
  },

  triggerAppendTags: function (tag) {
    $j(document).trigger('bs.appendTag', tag);
  },

  appendTag: function(tag) {
    BS.Util.addWordToTextArea($j(BS.Util.escapeId(this.formId) + ' textarea')[0], tag);
  },

  submitTags: function(){
    var f = $(this.formId);
    Form.disable(f);
    BS.Util.show('savingTags');
    BS.ajaxRequest(f.action, {
      parameters: BS.Util.serializeForm(f),
      onComplete: function() {
        BS.Util.hide('savingTags');
        BS.Tags.close();
        BS.reload(true);
        Form.enable(f);
      }
    });

    return false;
  }
});

BS.TagsEditingMixin.init(BS.Tags);

BS.FavoriteBuilds = {
  loadingMore: false,
  tagBuild: function (actionUrl, buildPromotion, refid, pageReload) {
    var makeFavorite = $j("#"+refid).hasClass("addToFavorite");
    var form = document.createElement("form");
    form.innerHTML = "<input type='hidden' value='" + buildPromotion + "' name='favoriteBuild'/><input type='hidden' value='" + makeFavorite + "' name='makeFavorite'/>";
    BS.ajaxRequest(actionUrl, {
      parameters: BS.Util.serializeForm(form),
      onComplete: function () {
        if (pageReload){
          BS.reload(true);
        } else{
          if (makeFavorite){
            $j("#"+refid).removeClass("addToFavorite");
            $j("#"+refid).html('<i class="icon-star"></i>');
          } else {
            $j("#"+refid).addClass("addToFavorite");
            $j("#"+refid).html('<i class="icon-star-empty"></i>');
          }
        }
      }
    });
  },
  loadMore: function(){
    console.log("loading more: " + this.loadingMore);
     if (this.loadingMore) return;
      this.loadingMore = true;
      $j('#showMoreFavoriteBuildsProgress').css("visibility","visible");
      $j('#count').val(parseInt($j('#count').val()) + 50);
      $j('#favoriteBuildsForm').submit();
  }

};

