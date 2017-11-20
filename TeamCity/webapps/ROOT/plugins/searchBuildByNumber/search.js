(function($) {
  BS.Search = {
    initEvents: function () {
      var searchField = $('#searchField, #headerSearchField');

      searchField.on('focus', function (e) {
        BS.Search.onfocus(e.target);
      });

      searchField.on('blur', function (e) {
        BS.Search.onblur(e.target);
      });

      searchField.on('keydown', function () {
        BS.Tooltip.hidePopup();
      });

      searchField.on('keypress', function (e) {
        if (e.keyCode == 13) {
          BS.Search.go(e.shiftKey, $j(this));
          return false;
        }
      });
    },

    installSearchField: function () {
      var userPanel = $('#userPanel'),
          inputIdF = $('#inputIdF');

      if (!userPanel.length || !inputIdF.length) return;

      userPanel = userPanel.get(0);
      inputIdF = inputIdF.get(0);
      
      Element.cleanWhitespace(userPanel);
      Element.cleanWhitespace(inputIdF);
      inputIdF.firstChild.id = 'headerSearchField';
      Element.insert(userPanel, {bottom: "<span class='search'>" + inputIdF.innerHTML + "</span>"});
      inputIdF.innerHTML = '';

      $('#headerSearchField').on('keypress paste', function (e) {
        if (BS.Search.timer) clearTimeout(BS.Search.timer);
        var url = BS.Search.getUrl();
        if (e.keyCode == Event.KEY_ESC) {
          return false;
        } else {
          BS.Search.timer = setTimeout(function () {
            BS.Search.showPopup(BS.Search.getUrl());
          }, 700);
        }
      });
    },

    disableSearchTooltip: function () {
      BS.Cookie.set("n_s_h", 'true', 60);
      BS.Tooltip.hidePopup();
    },

    onfocus: function (field) {
      $(field).parent().addClass('searchFocused');
    },

    onblur: function (field) {
      $(field).parent().removeClass('searchFocused');
    },

    go: function (newPage, searchField) {
      var inputIdF = $("#inputIdF"),
          searchByTime = $('#searchByTime');

      var url = window['base_uri'] + '/searchResults.html?query='
                    + encodeURIComponent(searchField.val())
                    + '&buildTypeId=' + inputIdF.attr("data-btId")
                    + '&byTime=' + (searchByTime.length > 0 ? searchByTime.val() : false);

      if (newPage) {
        window.open(url);
      } else {
        document.location.href = url;
      }
    },

    getUrl: function () {
      return window['base_uri'] + '/searchResults.html?query='
                 + encodeURIComponent($('#headerSearchField').val())
                 + '&buildTypeId=' + $("#inputIdF").attr("data-btId");
    },

    timer: null,

    showPopup: function (url) {
      new BS.Popup('searchResultsPopup', {
        delay: 0,
        shift: {x: -150, y: 22},
        hideOnMouseOut: false,
        loadingText: "Loading search results...",
        url: url + '&popupMode=true',
        afterShowFunc: function (popup) {
        }
      }).showPopupNearElement('headerSearchField', {forceReload: true});
    },

    highlightResult: function (searchIn) {
      var items = $(searchIn);
      var zones;

      items.each(function () {
        var item = $(this);
        zones = item.data('zones');

        if (zones) {
          zones = zones.split(' ');
          var searchableElements;

          if (zones.length > 0) {
            searchableElements = item.find(zones[0]);

            if (zones.length > 1) {
              for (var i = 1; i < zones.length; i++) {
                searchableElements.add(item.find(zones[i]));
              }
            }

            searchableElements.find('span.pc').addClass('highlightChanges');
          }
        }
      });
    }
  };

// Tricky part - insert search field into existing tag - userPanel (top right navigation)
  BS.WaitFor(function () {
    var headerReady = $('#header-ready');
    return headerReady.length ? headerReady.get(0) : null; 
  }, BS.Search.installSearchField);

  $(document).ready(BS.Search.initEvents);  
})(jQuery);
