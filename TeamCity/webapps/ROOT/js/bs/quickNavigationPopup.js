BS.QuickNavigation = {
  _items: [],

  setUp: function() {
    var items = this._items;
    for (var i = 0; i < items.length; ++i) {
      items[i].normName = items[i].name.toLowerCase();
    }

    this._projectDivider = $j(".project.divider");
    this._buildTypeDivider = $j(".build-type.divider");
    this._noResults = $j("#no-results");
    this._notAllResults = $j("#not-all-results");

    this.initNavigation();
  },

  applyFilter: function(field, forceAll) {
    function checkByPrefixes(item, keyword) {
      // eg "Some configuration" should be matched by "so co" filter
      var parts = item.normName.split(" ");
      var keywords = keyword.split(" ");
      if (parts.length < keywords.length) return null;

      var highlighted = "";
      var start = 0;
      for (var i = 0, partsI = 0; i < keywords.length; ++i, ++partsI) {
        while (partsI < parts.length && !parts[partsI].startsWith(keywords[i])) {
          highlighted += item.name.substr(start, parts[partsI].length) + " ";
          start += parts[partsI].length + 1;
          ++partsI;
        }
        if (partsI == parts.length) return null;
        highlighted += "<span class=\"hl\">" + item.name.substr(start, keywords[i].length) + "</span>" + item.name.substr(start + keywords[i].length, parts[partsI].length - keywords[i].length) + " ";
        start += parts[partsI].length + 1;
      }
      if (partsI < parts.length) {
        highlighted += item.name.substr(start);
      }

      return highlighted;
    }

    field = field || $("quickNavList_filter");

    var items = this._items,
        keyword = field.value.toLowerCase(),
        emptyFilter = keyword.length < 2 || keyword.blank();

    var regex = new RegExp(keyword.replace(/([\\\/+\[\]{}()|.?*])/g, "\\$1"), "gi"),
        resultsNumber = 0,
        noMoreResults = false;

    var projectDivider = this._projectDivider.hide(),
        buildTypeDivider = this._buildTypeDivider.hide(),
        noResults = this._noResults.hide(),
        notAllResults = this._notAllResults.hide();

    for (var i = 0; i < items.length; ++i) {
      var item = items[i],
          name = item.name;

      var div = item.div || (item.div = document.getElementById(item.id)),
          val = item.val || (item.val = div.getElementsByClassName("val")[0]);

      var byPrefixes = null;
      if (!emptyFilter && !noMoreResults && (item.normName.include(keyword) || (byPrefixes = checkByPrefixes(item, keyword)) != null)) {
        if (div.className.lastIndexOf("match") == -1) {
          if (!div.className.endsWith(" ")) {
            div.className += " ";
          }
          div.className += "match";
        }

        name = byPrefixes || item.name.replace(regex, function (m) {
          return "<span class='hl'>" + m + "</span>";
        });
        val.innerHTML = name;

        if (item.type == 'p') {
          projectDivider.show();
        } else {
          buildTypeDivider.show();
        }

        resultsNumber++;
        if (!forceAll && resultsNumber > 15) {
          noMoreResults = true;
        }
      } else {
        if (div.className.lastIndexOf("match") >= 0) {
          div.className = div.className.replace("match", "");
        }
      }
    }

    if (!emptyFilter && resultsNumber == 0) {
      noResults.show();
    }
    if (noMoreResults) {
      notAllResults.show();
    }
  },

  initNavigation: function() {
    var filter = $j("#quickNavList_filter"),
        list = $j("#quickNavList");

    function activate(elem) {
      if (elem.is("input") || elem.is("a")) {
        elem.focus();
      } else {
        elem.find(".nav").focus();
      }
      return false;
    }

    filter.on("keydown", function(e) {
      var code = e.keyCode;
      if (code == Event.KEY_DOWN) {
        var result = list.children(".entry:visible:first");
        if (result.length) {
          return activate(result);
        }
      }
      return true;
    });

    list.on("keydown", function(e) {
      var code = e.keyCode;
      var currentFocus = $j(":focus");
      if ((code != Event.KEY_DOWN && code != Event.KEY_UP) || !currentFocus.length) {
        return true;
      }

      var parent = currentFocus.parent(),
          elem;
      if (code == Event.KEY_DOWN) {
        elem = parent.nextAll(".entry:visible:first");
      } else {
        elem = parent.prevAll(".entry:visible:first");
        if (!elem.length) elem = filter;
      }

      return activate(elem);
    });
  },

  clear: function() {
    this._items = [];
    this._projectDivider = null;
    this._buildTypeDivider = null;
    this._noResults = null;
  }
};

BS.QuickNavigationPopup = new BS.Popup("quickNav", {
  shift: {x: 0},
  url: window['base_uri'] + "/quickNav.html",
  delay: 0,
  beforeShow: function(div) {
    $j(div).show().position({
      my: "center",
      at: "center",
      of: window,
      offset: "0 -200"
    });
  },
  afterHideFunc: function() {
    BS.QuickNavigation.clear();   // avoid memory leaks
  }
});

(function($) {
  // Invoking from the keyboard ('q' shortcut).
  $(document).keydown(function(e) {
    if (e.keyCode == 81 && !BS.Util.isModifierKey(e)) {
      var element = $(e.target);
      if (element.is("input") || element.is("textarea") || element.is("select")) {
        return;
      }
      if (!BS.QuickNavigationPopup._loading) {
        BS.QuickNavigationPopup._showWithDelay(null, null, function() {
          $j("#quickNav").position({
            my: "center",
            at: "center",
            of: window,
            offset: "0 -200"
          });
          BS.QuickNavigationPopup._loading = false;
        });
        BS.QuickNavigationPopup._loading = true;
      }
    }
  });
})(jQuery);
