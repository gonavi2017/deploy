BS.projectMap = {};
BS.typeVisibilityMap = {};
BS.visibilityList = [];

BS.BuildTypesPopup = function(projectId) {
  this.projectId = projectId;
  this.buildTypes = BS.projectMap[projectId];

  BS.Popup.call(this, projectId + "btPopup", {
    shift: {x: 30, y: -5},
    delay: 0,
    className: 'buildTypesPopup quickLinksMenuPopup custom-scroll',
    hideOnMouseOut: true,
    fitWithinWindowHeight: true,
    fitWithinWindowBottomMargin: 100,
    doScroll: false,

    textProvider: function(popup) {
      var visibilityMap = BS.typeVisibilityMap;
      var hasVisibleConfigurations = false;

      function isVisibleBuildType(typeId) {
        if (visibilityMap && visibilityMap[projectId]) {
          // If any types are visible, hide the types that don't match the current filter, otherwise - show all types
          for (var type in visibilityMap[projectId]) {
            if (visibilityMap[projectId][type] === 1) {
              hasVisibleConfigurations = true;
            }
          }

          if (hasVisibleConfigurations && visibilityMap[projectId][typeId] === 0) {
            return false;
          }
        }

        return true;
      }

      // Do not mark bold all build types, if all of them are visible.
      var allVisible = true;
      for (var i = 0; i < popup.buildTypes.length; i++) {
        allVisible = allVisible && popup.buildTypes[i].visible;
      }

      var urlFormat = $j("#buildTypeUrlFormat").attr("url") || window["base_uri"] + '/viewType.html?buildTypeId={id}';

      var menuList = '<ul class="menuList menuListFilterable">';
      for (i = 0; i < popup.buildTypes.length; i++) {
        var bt = popup.buildTypes[i];
        var typeId = bt.id;
        var url = urlFormat.replace("{id}", bt.extId);

        menuList += '<li class="menuItem btItem_' + typeId + (!allVisible && bt.visible ? " visible" : "") + '" ' +
                    'title="' + bt.description + '" data-bt-id="' + typeId +'"';

        if (isVisibleBuildType(typeId) === false) {
          menuList+= 'style="display: none"';
        }

        menuList += ">";
        menuList += '<a href="' + url + '" showdiscardchangesmessage="false" title="Open build configuration page" class="tc-icon_before icon16 buildType-icon">' + bt.name + '</a>';
        menuList += '</li>';
      }
      menuList += '</ul>';
      return menuList;
    }
  });

  this.install();
};

_.extend(BS.BuildTypesPopup.prototype, BS.Popup.prototype);
_.extend(BS.BuildTypesPopup.prototype, {
  install: function() {
    var el = $('buildTypesPopup' + this.projectId);
    if (!el) return;
    this.handle = el;

    var boundShow = function() {
      if (BS.BuildTypesPopup.current) {
        BS.BuildTypesPopup.current.hidePopup(0, true);
      }
      this.showPopupNearElement(this.handle);
      BS.BuildTypesPopup.current = this;
    }.bind(this);

    el.on('mouseover', boundShow);
  },

  uninstall: function() {
    if (this.handle) {
      Event.stopObserving(this.handle);
      this.handle = null;
    }
  }
});

BS.AllProjectsPopup = function(name, url, hideCallback) {
  BS.Popup.call(this, name, {
    url: url,
    shift: {x: 0, y: 21},
    delay: 0,
    hideOnMouseOut: false,

    afterShowFunc: function() {
      prepareBtPopups();
    }.bind(this),

    afterHideFunc: function() {
      this.btPopups = this.btPopups || [];
      for (var i = 0; i < this.btPopups.length; i ++) {
        var popup = this.btPopups[i];
        popup.hidePopup(0, true);
        popup.uninstall();
      }
      this.btPopups = [];
      BS.projectMap = {};
      BS.typeVisibilityMap = {};
      BS.visibilityList = [];

      $j(this.element()).html("");
      hideCallback && hideCallback();
    }.bind(this)
  });
};


_.extend(BS.AllProjectsPopup.prototype, BS.Popup.prototype);

BS.AllProjectsPopup.showAll = function(e) {
  BS.SiblingsTreePopup.hideAll();

  if (BS.AllProjectsPopup.globalInstance) {
    var overviewTab = $('overview_Tab');
    var allPopupImg = $('allPopupImg');
    var dim = allPopupImg.getDimensions();
    var pos1 = allPopupImg.cumulativeOffset();
    var pos2 = overviewTab.cumulativeOffset();
    BS.AllProjectsPopup.globalInstance.showPopupNearElement(allPopupImg, {
      shift: {x: pos2[0] - pos1[0], y: dim.height},
      hideOnMouseOut: true,
      overrideHideIfActive: 'allProjectsPopupTable_filter',
      delay: e.type == 'mouseover' ? 300 : 0,
      fitWithinWindowHeight: true,
      fitWithinWindowBottomMargin: 100,
      doScroll: false
    });
    Event.stop(e);
  }
};

BS.AllProjectsPopup.install = function() {

  BS.AllProjectsPopup.globalInstance = new BS.AllProjectsPopup("allProjectsPopup", window['base_uri'] + "/allProjects.html");

  var img = jQuery('#allPopupImg');

  img
    .on('mouseover', function(e) {
      img.addClass('hovered');
      if (BS.AllProjectsPopup.globalInstance && !BS.AllProjectsPopup.globalInstance.isShown()) {
        BS.AllProjectsPopup.showAll(e);
      }
      else {
        BS.AllProjectsPopup.globalInstance.stopHidingPopup();
      }
    })
    .on('mouseout', function() {
      img.removeClass('hovered');
      if (BS.AllProjectsPopup.globalInstance.options.hideOnMouseOut) {
        BS.AllProjectsPopup.globalInstance.hidePopup(1000);
      }
    })
    .on('click', function(e) {
      BS.AllProjectsPopup.globalInstance.hidePopup(0);
      BS.AllProjectsPopup.showAll(e);
    });

  // Invoking "All projects" from the keyboard ('p' shortcut).
  jQuery(document).keydown(function(e) {
    if (e.keyCode == 80 && !BS.Util.isModifierKey(e)) {

      var element = jQuery(e.target);
      if (element.is("input") || element.is("textarea") || element.is("select")) {
        return;
      }
      BS.AllProjectsPopup.showAll(e);
    }
  });
};

BS.AllProjectsPopup.Navigation = {
  projects: [],
  selectedProjectIdx: -1,
  selectedProject: null,
  popup: null,
  buildTypes: null,
  selectedBuildTypeIdx: -1,
  selectedBuildType: null,

  init: function() {
    var that = this;
    jQuery("#allProjectsPopupTable_filter").on('keydown', function(e) {
      if (e.keyCode == Event.KEY_DOWN) {
        that.activate();
        return false;
      }
    });

    jQuery("#allProjectsPopupTable tr").on('keydown', function(e) {
      if (that.isActive()) {
        switch (e.keyCode) {
          case Event.KEY_DOWN: that.nextProject();  break;
          case Event.KEY_UP:   that.prevProject();  break;
          case Event.KEY_RIGHT: that.toBuildTypes(); break;
          case Event.KEY_RETURN: return true;
          default: return false;
        }
        return false;
      }
    });
  },

  activate: function() {
    this.projects = jQuery("#allProjectsPopupTable tr").filter(":visible");
    if (this.projects.length == 0) {
      return;
    }

    jQuery("#allProjectsPopupTable_filter").blur();
    this.selectProjectRow(0);
  },

  deactivate: function() {
    if (this.selectedProject) {
      this.unselectProjectRow();
    }

    this.projects = [];
    this.selectedProjectIdx = -1;
    this.selectedProject = null;
  },

  isActive: function() {
    return this.projects.length > 0;
  },

  selectProjectRow: function(idx) {
    this.selectedProjectIdx = idx;
    this.selectedProject = jQuery(this.projects[idx]);
    this.selectedProject.addClass("selected");
    this.selectedProject.find("a.projectLink").focus();
  },

  unselectProjectRow: function() {
    this.selectedProject.removeClass("selected");
  },

  selectBuildTypeItem: function(idx) {
    this.selectedBuildTypeIdx = idx;
    this.selectedBuildType = jQuery(this.buildTypes[idx]);
    this.selectedBuildType.addClass("selected");
    this.selectedBuildType.find("a").focus();
  },

  unselectBuildTypeItem: function() {
    this.selectedBuildType.removeClass("selected");
  },

  nextProject: function() {
    if (this.selectedProjectIdx < this.projects.length - 1) {
      this.unselectProjectRow();
      this.selectProjectRow(this.selectedProjectIdx + 1);
    }
  },

  prevProject: function() {
    if (this.selectedProjectIdx > 0) {
      this.unselectProjectRow();
      this.selectProjectRow(this.selectedProjectIdx - 1);
    } else {
      this.deactivate();
      jQuery("#allProjectsPopupTable_filter").focus();
    }
  },

  toBuildTypes: function() {
    var projectId = this.selectedProject.attr("data-filter-data");
    if (BS.projectMap[projectId].length == 0) {
      return;
    }

    this.popup = new BS.BuildTypesPopup(projectId);
    this.popup.showPopupNearElement(this.popup.handle);

    this.buildTypes = jQuery(BS.Util.escapeId(projectId + "btPopup")).find("li.menuItem").filter(":visible");
    this.unselectProjectRow();
    this.selectBuildTypeItem(0);

    var that = this;
    this.buildTypes.on('keydown', function(e) {
      switch (e.keyCode) {
        case Event.KEY_DOWN: that.nextBuildType();  break;
        case Event.KEY_UP:   that.prevBuildType();  break;
        case Event.KEY_LEFT: that.toProjects();     break;
        case Event.KEY_RETURN: return true;
        case Event.KEY_ESC:  that.toProjects(true); break;
        case Event.KEY_RIGHT:
        default: return false;
      }
      return false;
    });
  },

  toProjects: function(keep_popup) {
    this.unselectBuildTypeItem();
    if (!keep_popup) {
      this.popup.hidePopup(0, true);
    }
    this.selectProjectRow(this.selectedProjectIdx);
  },

  nextBuildType: function() {
    if (this.selectedBuildTypeIdx < this.buildTypes.length - 1) {
      this.unselectBuildTypeItem();
      this.selectBuildTypeItem(this.selectedBuildTypeIdx + 1);
    }
  },

  prevBuildType: function() {
    if (this.selectedBuildTypeIdx > 0) {
      this.unselectBuildTypeItem();
      this.selectBuildTypeItem(this.selectedBuildTypeIdx - 1);
    }
  }
};

// Performs a search across build types in addition to projects, highlights projects which contain matching build types
BS.AllProjectsPopup.populateVisibilityMap = function(keyword) {
  var visibilityMap = BS.typeVisibilityMap,
      allProjectsPopupTable = $j('#allProjectsPopupTable'),
      btPopups = BS.AllProjectsPopup.globalInstance.btPopups || [],
      projectId,
      buildTypes,
      parentProject,
      hasMatch,
      matchCount;

  BS.visibilityList = [];

  function hasMatchingType(buildTypeName, keyword, parentProject) {
    var projectName = parentProject['projectName'].toUpperCase();
    var hasMatch = 0;

    buildTypeName = buildTypeName.replace(/&lt;/g,'<').replace(/&gt;/g,'>').replace(/&amp;/g,'&').replace(/&#034;/g, '"').replace(/&#039;/g, '\'').toUpperCase();

    if (keyword == '' || (buildTypeName.indexOf(keyword) > -1 && projectName.indexOf(keyword) == -1)) {
      hasMatch = 1;
    }

    return hasMatch;
  }

  for (var i = 0; i < btPopups.length; i++) {
    matchCount = 0;
    projectId = btPopups[i].projectId;
    buildTypes = btPopups[i].buildTypes;

    visibilityMap[projectId] = visibilityMap[projectId] || {};
    visibilityMap[projectId]._domCache = visibilityMap[projectId]._domCache || {};

    parentProject = BS.projectMap[projectId][0];
    for (var j = 0; j < buildTypes.length; j++) {
      hasMatch = hasMatchingType(buildTypes[j].name, keyword, parentProject);
      visibilityMap[projectId][buildTypes[j].id] = hasMatch;
      matchCount += hasMatch;
    }
    if (matchCount || allProjectsPopupTable.find('#inplaceFiltered_' + projectId).is(':visible')) {
      BS.visibilityList.push(projectId);
    }
  }

  return visibilityMap;
};

BS.AllProjectsPopup.searchBuildTypes = function(element) {
  var keyword = element.value.toUpperCase(),
      allProjectsPopupTable = $j('#allProjectsPopupTable');

  BS.AllProjectsPopup.populateVisibilityMap(keyword);

  function toggleVisibility() {
    var visibilityCount = BS.visibilityList.length,
        projectId;

    for (var i = 0; i < visibilityCount; i++) {
      projectId = BS.visibilityList[i];
      var visibleConfigurationsCount = 0;
      var markedForHiding = [];
      var projectDomCache = BS.typeVisibilityMap[projectId]._domCache;

      var projectRow = projectDomCache.projectRowEl ||
                       (projectDomCache.projectRowEl = allProjectsPopupTable.find('#inplaceFiltered_' + projectId));

      var countEl = projectDomCache.countEl || (projectDomCache.countEl = projectRow.find('.btCount'));

      // Reset highlighting
      if (countEl.data('originalCount')) {
        countEl.text(countEl.data('originalCount'));
      }
      countEl.removeClass('btCountHighlighted');

      for (var type in BS.typeVisibilityMap[projectId]) {
        if (type == '_domCache') continue;

        var typeDomCache = BS.typeVisibilityMap[projectId]._domCache['typeRowEl' + type];
        var typeRow = typeDomCache || (typeDomCache = $j('#' + projectId + 'btPopup').find('.btItem_' + type));

        // Reset filtering
        typeRow.show();

        if (keyword.length > 0) {
          // Apply highlighting
          if (BS.typeVisibilityMap[projectId][type] === 1) {
            visibleConfigurationsCount++;
          }

          // Apply filtering
          if (BS.typeVisibilityMap[projectId][type] === 0) {
            markedForHiding.push(typeRow);
          }
        }
      }

      if (visibleConfigurationsCount > 0) {
        $j.each(markedForHiding, function(i, typeRow) {
          typeRow.hide();
        });

        if (!countEl.data('originalCount')) {
          countEl.data('originalCount', countEl.html());
        }
        countEl
            .text(visibleConfigurationsCount)
            .addClass('btCountHighlighted');

        projectRow.data('visibleElem', true).show();
      }

      if (projectRow.data('visibleElem')) {
        var depth = parseInt(projectRow.attr("data-depth"));
        while (depth > 0) {
          depth--;
          var parent = BS.typeVisibilityMap[projectId].parent;
          if (!parent && BS.projectMap[projectId].parentProjectId) {
            parent = allProjectsPopupTable.find('#inplaceFiltered_' + BS.projectMap[projectId].parentProjectId);
            BS.typeVisibilityMap[projectId].parent = parent;
          }
          parent.data('visibleElem', true).show();
          projectRow = parent;
          projectId = BS.projectMap[projectId].parentProjectId;
        }
      }
    }
  }

  toggleVisibility();
};

// Siblings tree.

BS.SiblingsTreePopup = {
  hideAll: function() {
    var allProjectsPopup = BS.AllProjectsPopup,
        breadcrumbsInstance = allProjectsPopup.breadcrumbsInstance,
        globalInstance = allProjectsPopup.globalInstance;

    if (breadcrumbsInstance && breadcrumbsInstance.isShown()) {
      breadcrumbsInstance.hidePopup(0, true);
    }
    if (globalInstance && globalInstance.isShown()) {
      globalInstance.hidePopup(0, true);
    }
  },

  show: function(img, params) {
    this.hideAll();

    var url = window['base_uri'] + "/allProjects.html?" + Object.toQueryString(params);
    ;
    var popup = new BS.AllProjectsPopup("siblingsTreePopup", url, function() {
      BS.AllProjectsPopup.breadcrumbsInstance = null;
    });
    BS.AllProjectsPopup.breadcrumbsInstance = popup;

    prepareBtPopups();

    popup.showPopupNearElement(img[0], {
      fitWithinWindowHeight: true,
      fitWithinWindowBottomMargin: 100,
      doScroll: false
    });
  }
};

function prepareBtPopups() {
  setTimeout(function() {
    this.btPopups = [];
    for (var projectId in BS.projectMap) {
      this.btPopups.push(new BS.BuildTypesPopup(projectId));
    }
    BS.AllProjectsPopup.populateVisibilityMap('');
  }.bind(BS.AllProjectsPopup.globalInstance), 200);

  if ($("allProjectsPopupTable_filter")) {
    $("allProjectsPopupTable_filter").activate();
  }
}

BS.ArchivedProjectsPopup = {
  highlightMatchIfNeeded: function() {
    var filter = $j("#allProjectsPopupTable_filter");
    var keyword = filter.val();
    if (!keyword) {
      return;
    }

    var regex = new RegExp(keyword.replace(/([().?*])/g, "\\$1"), "gi");
    $j("#archivedProjectsPopupTable td.projectName a").each(function() {
      var self = $j(this);
      var name = self.html().trim();
      var newName = name.replace(regex, function (m) {
        return "<span class='hl'>" + m + "</span>";
      });
      self.html(newName);
    });
  }
};
