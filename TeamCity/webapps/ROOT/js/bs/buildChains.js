
var _user_agent = navigator.userAgent.toLowerCase();

BS.BuildChains = {
  _chainRefreshTid: null,
  _scrollPos: null,
  _allChainsRefreshTid: null,

  scheduleAllChainsRefresh: function(delay) {
    if (this._allChainsRefreshTid) {
      window.clearTimeout(this._allChainsRefreshTid);
    }

    this._allChainsRefreshTid = window.setTimeout(function() {
      BS.reload(false, function() {
        var activeGraphId = $j('div.layeredGraph').attr('id');
        if (activeGraphId != null && BS.BuildChains._refreshBlocked(activeGraphId.replace(/graph_/, ''))) {
          BS.BuildChains.scheduleAllChainsRefresh(delay); // reschedule
          return;
        }

        var div = $j('#allChains')[0];
        if (div) {
          var expandedChainId = $j('.buildChainBlock .blockHeader.expanded').nextAll('.buildChainGraph').data('chain-id');
          if (!expandedChainId) expandedChainId = "";
          $j(window).off('scroll', BS.BuildChains._scrollHandler);
          div.refresh(null, "&currentlyExpandedId=" + expandedChainId);
        } else {
          BS.reload(true);
        }
      });
    }, delay);
  },

  scheduleChainRefresh: function (chainId) {
    if (this._chainRefreshTid != null) {
      window.clearTimeout(this._chainRefreshTid);
    }

    this._chainRefreshTid = window.setTimeout(function () {
      if (BS.BuildChains._refreshBlocked(chainId)) {
        BS.BuildChains.scheduleChainRefresh(chainId);
        return;
      }

      var elem = $j('#chainRefresh_' + chainId)[0];
      var collapsed = $j('#chainRefresh_' + chainId + ' .blockHeader').hasClass('collapsed');
      if (elem && elem.refresh) {
        $j(window).off('scroll', BS.BuildChains._scrollHandler);
        elem.refresh("", "&collapsed=" + collapsed, BS.BuildChains._afterUpdateFunction(elem, chainId));
      }
    }, 300);
  },

  refreshChain: function (chainId) {
    var elem = $j('#chainRefresh_' + chainId)[0];
    var collapsed = $j('#chainRefresh_' + chainId + ' .blockHeader').hasClass('collapsed');
    if (elem && elem.refresh) {
      elem.refresh("", "&collapsed=" + collapsed, BS.BuildChains._afterUpdateFunction(elem, chainId));
    }
  },

  _refreshBlocked: function (chainId) {
    var graphObjId = 'graph_' + chainId;
    return !BS.canReload() ||
           ($(graphObjId) && $(graphObjId).graphObject && $(graphObjId).graphObject.hasSelectedNodes()) ||
           $j('#' + graphObjId + " .nodeInfo.highlight")[0]; // disable refresh if some nodes are selected or highlighted
  },

  _afterUpdateFunction: function (elem, id) {
    return function () {
      if ($j(elem).is(':empty')) {
        // this can happen on queued build dependencies tab:
        // when build starts, queued build controller stops calling extensions and we get empty content here
        if (document.location.href.indexOf('viewQueued') != -1) {
          BS.reload(true);
        } else {
          BS.BuildChains.scheduleAllChainsRefresh(0);
        }

        return;
      }

      BS.Log.info("Refreshed: " + id);
    }
  },

  toggleChainBlock: function (eventTarget, blockId) {
    var blockSel = '#' + blockId;
    var collapsed = $j(eventTarget).hasClass('collapsed');

    $j('.buildChainBlock .expanded').each(function () {
      BS.BuildChains._hideChain($j(this).nextAll('.buildChainGraph')[0]);
    });

    if (collapsed) {
      BS.BuildChains._showChain($j(blockSel)[0]);
    } else {
      BS.BuildChains._hideChain($j(blockSel)[0]);
    }
  },

  _showChain: function (container) {
    if (!container) return;

    $j(container).prevAll('.blockHeader').addClass('expanded');
    $j(container).prevAll('.blockHeader').removeClass('collapsed');

    $j(container).show();
    if ($j(container).is(':empty')) {
      $j(container).html('<span><i class="icon-refresh icon-spin progressRing progressRingDefault" style="float:none"></i> Loading...</span>');
    }

    var url = $j(container).data('url');
    BS.ajaxUpdater(container, url, {method: 'get', evalScripts: true});

    BS.LocationHash.setHashParameter('expand', container.id);
  },

  _hideChain: function (container, restoreWidth) {
    if (!container) return;

    $j(container).prevAll('.blockHeader').addClass('collapsed');
    $j(container).prevAll('.blockHeader').removeClass('expanded');

    $j(container).hide();

    // need to cleanup tabs, otherwise we can get clash by ids when next chain is expanded
    $j(container).find('.chainChanges').html('');
    $j(container).find('.chainProblems').html('');

    BS.stopObservingInContainers(container);

    BS.LocationHash.setHashParameter('expand', '');

    // reset scroller hack
    $j(window).scrollLeft(0);
    $j('body').css({'margin-left': 0, 'margin-right': 0});
    BS.LocationHash.setHashParameter('hpos', null);
    BS.LocationHash.setHashParameter('vpos', null);
  },

  ungroupProject: function(chainId, projectId, currentlyUngrouped) {
    var val = currentlyUngrouped;
    if (val == null) val = "";
    if (val.length > 0) val += ",";
    val += projectId;

    BS.User.setProperty("buildChains.ungroupedProjectIds", val, {
      afterComplete: function() {
        BS.BuildChains.refreshChain(chainId);
      }
    });
  },

  groupProject: function(chainId, projectId, currentlyUngrouped) {
    var val = currentlyUngrouped.split(",");
    var idx = val.indexOf(projectId);
    if (idx > -1) {
      val.splice(idx, 1);
    }

    BS.User.setProperty("buildChains.ungroupedProjectIds", val.join(","), {
      afterComplete: function() {
        BS.BuildChains.refreshChain(chainId);
      }
    });
  },

  _scrollId : null,
  _scrollWithTimeout: !BS.Browser.windows || _user_agent.indexOf('msie') != -1 || _user_agent.indexOf('edge') != -1 || _user_agent.indexOf('trident') != -1,

  _scrollHandler : function(e) {
    var func = function() {
      var chainId = BS.LocationHash.getHashParameter('expand');
      if (chainId) {
        chainId = chainId.replace(/block_/, '');
      } else {
        // build chain in new window mode
        var found = document.location.search.match(/chainId=([^&]+)/);
        if (!found) return;
        if (found) {
          chainId = found[1];
        }
      }

      var hpos = $j(window).scrollLeft();
      var vpos = $j(window).scrollTop();

      var prevHPos = BS.LocationHash.getHashParameter('hpos');
      if (!prevHPos) prevHPos = 0;

      BS.BuildChains.shiftChainHorizontally(chainId, prevHPos, hpos);

      BS.LocationHash.setHashParameter('hpos', hpos);
      BS.LocationHash.setHashParameter('vpos', vpos);
    };

    if (!BS.BuildChains._scrollWithTimeout) {
      // Chrome and FF on windows does not create annoying flickering effect during horizontal scrolling, so we don't use timeout
      func();
    }

    if (BS.BuildChains._scrollId) {
      window.clearTimeout(BS.BuildChains._scrollId);
    }

    BS.BuildChains._scrollId = window.setTimeout(func, 200);
  },

  shiftChainHorizontally: function(chainId, prevHpos, hpos) {
    var delta = (prevHpos - hpos);
    if (delta == 0) return;

    // this keeps body horizontal position fixed during the horizontal scrolling
    var curHpos = $j(window).scrollLeft();
    $j('body').css({'margin-left': curHpos, 'margin-right': -curHpos});

    // since body is fixed, we need to shift graph
    $j('#graph_' + chainId).css({'margin-left': '+=' + delta + 'px'});
  }
};
