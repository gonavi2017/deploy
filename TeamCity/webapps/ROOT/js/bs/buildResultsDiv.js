(function($) {
  BS.BuildResults = {
    _compilerErrors: [],
    _compilerWarnings: [],
    _expanded_count: 0,

    expandStacktrace: function(element, buildId, testId, onCompleteFun) {
      element = $(element).get(0);
      if (!element.firstChild) {
        BS.Log.info("Loading stacktrace for build " + buildId + " testId " + testId);

        BS.ajaxUpdater(element, "failedTestText.html?buildId=" + buildId + "&testId=" + testId, {
          onComplete: function() {
            BS.BuildResults.doExpand(element);
            if (onCompleteFun) { onCompleteFun(); }
          }
        });
      } else {
        this.doExpand(element);
      }
    },

    doExpand: function(element) {
      if (element.innerHTML == "") {
        element.innerHTML = "No stacktrace available"
      }
    },

    stacktraceShown: function() {
      this._expanded_count++;
      BS.blockRefreshPermanently('stacktrace');
      BS.Util.show('noRefreshWarning');
    },

    stacktraceHidden: function() {
      if (this._expanded_count > 0) {
        this._expanded_count--;
      }
      if (this._expanded_count == 0) {
        BS.unblockRefresh('stacktrace');
        BS.Util.hide('noRefreshWarning');
      }
    },

    installBuildDetailsPopup: function(buildId) {
      var popupPrefix = "sp_span_",
          popupId = "buildDetails";

      var popupArrowIcon = $("<span class='pc__toggle-wrapper'>&nbsp;</span>")
            .append($("<span/>").attr({id: popupId}).addClass("icon icon16 toggle"));
      var popupSpan = $("<span/>").attr({
                                           id: popupPrefix + popupId
                                         }).addClass("pc");

      var restTitle = $j('#restPageTitle');

      if (restTitle.length > 0){
        var div = restTitle.find(".selected");
        div.append(popupArrowIcon).wrapInner(popupSpan);
      } else {
        $("#mainNavigation").children('.last').append(popupArrowIcon).wrapInner(popupSpan);
      }

      BS.Util.runWithElement(popupPrefix + popupId, function() {
        BS.install_simple_popup(popupPrefix + popupId, {
          url: window['base_uri'] + '/buildDetails.html?buildId=' + buildId,
          shift: {y: 20},
          afterShowFunc: function() {
            $("#sp_span_buildDetailsContent").addClass("statusBlockContainer").css("margin-left", $("#mainNavigation,#restNavigation").offset().left + "px");
          }
        });
      });
    },

    updateStateIcon: function() {
      var icon = $("#restBreadcrumbs .buildDataIcon, #mainNavigation .buildDataIcon").get(0),
        newIcon = $("#buildDataIcon").get(0);

      if (icon && newIcon) {
        icon.className =  newIcon.className;
      }

      ($j(newIcon).parent().hasClass('hidden') ? $j(newIcon).parent() : newIcon).remove();
    }
  };

  BS.BuildArtifacts = {
    updateDetails: function(url, sizeId, linkId, noteId) {
      BS.ajaxRequest(url, {
        method : "get",
        onComplete: function(transport) {
          var data = transport.responseText.evalJSON();
          $("#" + sizeId).html(data.size);
          if (data.showLink) {
            BS.Util.show(linkId);
          }
          if (data.hasHidden) {
            BS.Util.show(noteId);
          }
        }
      });
    }
  };
})(jQuery);
