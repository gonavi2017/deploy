//====================================================================================
// TABS:
//====================================================================================
/*

  Example of tabbed pane usage:

var pane = new TabbedPane();
pane.addTab("tab1", {
  caption: "<b>Some caption1</b>",
  onselect: function(tab) {
    alert("myId: " + tab.getId());
  }
});
pane.addTab("tab2", {
  captionFrom: "elementId",
  url: "http://www.google.com"
});

pane.showIn('parentElementId');
pane.setActiveTab('tab2');      // Clicking on the tab
pane.setActiveCaption('tab1');  // Just mark the tab as selected
*/

function TabbedPane(level) {
  this.level = level;
  this.myTabs = [];
}

_.extend(TabbedPane.prototype, {

  dispose: function() {
    if (this.container) {
      BS.stopObservingInContainers(this.container);
    }
  },

  getContainer: function() {
    return this.container;
  },

  clearTabs: function() {
    this.myTabs = [];
  },

  getNumberOfTabs: function() {
    return this.myTabs.length;
  },

  /**
   * @param tabId unique tab identifier
   * @param options may include url, captionFrom: "elementId", caption, onselect: function(tab)
   * */
  addTab: function(tabId, options) {
    var tab = new TabbedPane.Tab(this, tabId, options);
    this.myTabs.push(tab);
    this.myTabs[this._makeId(tabId)] = tab;
  },

  getTabs: function() {
    return this.myTabs;
  },

  _makeId: function(tabId) {
    return "id:" + tabId;
  },

  setFirstActive: function() {
    this.setActiveTab(this.myTabs[0].getId());
  },

  setActiveTab: function(tabId) {
    this.setActiveCaption(tabId);
    var tab = this.myTabs[this._makeId(tabId)];
    if (tab) {
      tab.activate();
      return true;
    }
  },

  /**
   * @param shift if 1, go to next tab, if -1 - to the previous tab
   * */
  gotoTextTab: function(shift) {
    for (var i = 0; i < this.myTabs.length; i ++) {
      var tab = this.myTabs[i];
      if (tab.isSelected()) {
        var to_select = i + shift;
        if (to_select >= 0 && to_select < this.myTabs.length) {
          this.setActiveTab(this.myTabs[to_select].getId());
          return;
        }
      }
    }
  },

  setActiveCaption: function(tabId) {
    for (var i = 0; i < this.myTabs.length; i ++) {
      var tab = this.myTabs[i];
      tab.setSelected(tab.getId() == tabId);
    }
  },

  getActiveTab: function() {
    for (var i = 0; i < this.myTabs.length; i ++) {
      var tab = this.myTabs[i];
      if (tab.isSelected()) {
        return tab;
      }
    }
    return null;
  },

  getTab: function(tabId) {
    return this.myTabs[this._makeId(tabId)];
  },

  showIn: function(container) {
    container = $(container);

    try {
      if (!container) {
        BS.Log.warn("Unable to show tabbed pane in " + container);
        return;
      }

      this.dispose();

      this.container = container;
      BS.stopObservingInContainers(container);

      if (this.myTabs.length == 0) {
        container.menuFilled = true;
        return;
      }

      var ul = document.createElement("ul");
      ul.className = 'tabs';

      for (var i = 0; i < this.myTabs.length; i ++) {
        var tabLi = document.createElement("li");
        var first = (i == 0);
        var last = (i == this.myTabs.length - 1);

        this.myTabs[i].fillTabContent(tabLi);
        ul.appendChild(tabLi);
        if (first) {
          $(tabLi).addClassName("first");
        }
        if (last) {
          $(tabLi).addClassName("last");
        }
      }

      container.style.display = 'block';
      container.innerHTML = "";
      container.appendChild(ul);
      container.menuFilled = true;

      $j(document).trigger("bs.breadcrumbRendered");
    } catch (e) {
      BS.Log.error(e);
      alert(e);
    }
  },

  showSidebarIn: function(parentElementId) {
    this.showIn(parentElementId);
  }
});

// Define Tab class:
TabbedPane.Tab = function(pane, tabId, tabOptions) {
  this.myPane = pane;
  this.myTabId = tabId;
  this.myOptions = _.extend({
    postLink: ""
  }, tabOptions||{});
  this.eventHandlerBound = false;
};

_.extend(TabbedPane.Tab.prototype, {
  activate: function () {

    if (!this.myOptions.onselect || this.myOptions.onselect(this)) {

      var href = $j($(this.myElement)).find("a.tabs").attr("href");

      if (href && href != "#") {
        document.location.href = href;
      }
      else if (this.myOptions.url) {
        document.location.href = this.myOptions.url;
      }
    }
  },

  setSelected: function(selected, el) {
    this.mySelected = selected;

    el = el ? $(el) : $(this.myElement);

    if (el) {
      if (selected) {
        el.addClassName('selected');
      } else {
        el.removeClassName('selected');
      }
    }
  },

  isSelected: function() {
    return this.mySelected;
  },

  getId: function() {
    return this.myTabId;
  },

  getDomId: function() {
    return this.myTabId + "_Tab";
  },

  fillTabContent: function(el) {
    el.setAttribute('id', this.getDomId());
    this.myElement = el.id;

    this.fillWithText(el);

    if (this.myOptions.width) {
      el.style.width = this.myOptions.width;
    }

    this.setSelected(this.mySelected, el);
  },

  fillWithText: function(el) {
    var text = '',
        addin = '';

    if (this.myOptions.caption) {
      text = this.myOptions.caption;
    }
    if (this.myOptions.captionFrom && $(this.myOptions.captionFrom)) {
      text = $(this.myOptions.captionFrom).innerHTML;
    }
    if (this.myOptions.captionAddin) {
      addin = this.myOptions.captionAddin;
    }

    text = jQuery.trim(text);

    var count = this.extractCount(text);
    if (count && count.text) {
      text = jQuery.trim(text.substring(0, count.pos - 1));
      addin += '<span class="tabCounter">' + 
               count.text + 
               '</span>';
    }

    var url = "#";
    if (this.myOptions.url) {
      url = this.myOptions.url;
    }

    this.bindEventHandler(el);
    el.innerHTML = '<p>' +
                   '<a class="tabs" showdiscardchangesmessage="false" href="' + url + '">' + text + '</a>' +
                   addin +
                   this.myOptions.postLink +
                   '</p>';
    this.setSelected(this.mySelected); // To update class of the element
  },

  extractCount: function(text) {
    var re = /\(([\d\+]+)\)$/; // tab title format can be: (<num>), (<num>+) or (+)
    var count = text.match(re);

    if (count) {
      return {
        text: count[1].toString() == '+' ? "&#x2713;" : count[1].toString(),
        pos: text.indexOf(count[0])
      }
    }
  },

  bindEventHandler: function(el) {
    if (el.hasHandler) return;

    if (!this.eventHandlerBound) {
      this.eventHandlerBound = function(evt) {
        if (!evt.ctrlKey && !evt.altKey && !evt.metaKey && evt.button != 1) {
          this.myPane.setActiveTab(this.getId());
          Event.stop(evt);
        }
        return true;
      }.bindAsEventListener(this);
    }

    $(el).on("click", this.eventHandlerBound);
    el.hasHandler = true;
  },

  setCaption: function(text) {
    this.myOptions.caption = text;
    this.fillTabContent($(this.getDomId()));
  },

  setPostLinkContent: function(text) {
    this.myOptions.postLink = text;
  },

  extractCountForElements: function(selector) {
    var that = this;
    jQuery(selector).each(function() {
      var self = jQuery(this),
          text = self.text();

      var count = that.extractCount(text);
      if (count && count.text) {
        text = jQuery.trim(text.substring(0, count.pos - 1));
        self.html(text).append('<span class="tabCounter">' + count.text + '</span>');
      }
    });
  }
});


