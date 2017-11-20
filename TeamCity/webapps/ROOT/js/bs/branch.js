/*
 * Copyright 2000-2017 JetBrains s.r.o.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// Facility for build branches.

BS.Branch = {
  WILDCARD_NAME: "__all_branches__",  // BranchUtil.WILDCARD_BRANCH
  DEFAULT_NAME: "<default>",          // BranchUtil.DEFAULT_BRANCH_NAME and Branch.DEFAULT_BRANCH_NAME

  baseUrl: null,                      // The URL where branch links should lead to (by default, build type overview page).
  _branches: {},                      // Holds the branches per project (on a current page).
  
  branchParamPrefix: 'branch_',       // we encode branch in URL in the following format: branch_<externalProjectId>=<branchName>

  _allBranchesTabNames : [
    "buildTypeStatusDiv",
    "buildTypeChains",
    "buildTypeHistoryList",
    "buildTypeChangeLog",
    "buildTypeIssueLog",
    "projectBuildChains",
    "testDetails",
    "projectChangeLog",
    "buildTypeStatistics"
  ],

  _activeBranchesTabNames: [
    "projectOverview",
    "buildTypeBranches",
    "pendingChangesDiv",
    "stats"
  ],

  _wildcardName: function(options, noEscaping){
    var wildcardName = options.wildcardDisplayName;
    var tab = (options || {})["tab"];
    if (!wildcardName) {
      wildcardName = this._allBranchesTabNames.indexOf(tab) > -1  ?
                     "&lt;All branches&gt;" :
                     "&lt;Active branches&gt;";
    }
    return !noEscaping ? wildcardName : wildcardName.replace('&lt;','<').replace('&gt;','>');
  },

  makeDropdown: function(userBranch, enabled, id, activeBranches, otherBranches, options) {
    var select = $j("<select class='branchNameSelector' id='" + id + "'/>").prop("disabled", !enabled);

    var wildcardName = this._wildcardName(options);

    this._addOption(select, wildcardName, this.WILDCARD_NAME, userBranch);
    if (!options['excludeDefaultBranch']) {
      this._addOption(select, "&lt;Default branch&gt;", this.DEFAULT_NAME, userBranch);
    }

    var i, group;
    if (activeBranches) {
      group = this._addOptionGroup(select, "Active branches");
      for (i = 0; i < activeBranches.length; ++i) {
        this._addBranchOption(group, activeBranches[i], userBranch);
      }
    }

    if (otherBranches) {
      if (activeBranches) {
        group = this._addOptionGroup(select, "Inactive branches");
      } else {
        group = select;
      }
      for (i = 0; i < otherBranches.length; ++i) {
        this._addBranchOption(group, otherBranches[i], userBranch);
      }
    }

    return select;
  },

  addChangeHandler: function(select, options) {
    var that = this;

    select.change(function() {
      that._addChangeHandler(options,$j(this).find("option:selected").val());
    });
  },

  addRestChooserChangeHandler: function(select, options) {
    var that = this;

    select.on('branch-changed',function(e) {
      that._addChangeHandler(options, e.detail.branch.webUrl);
    });

  },

  _addChangeHandler: function(options, selectedBranch) {
    var projectId = options.projectId,
        projectExternalId = options.projectExternalId;

      var url = BS.Branch._getUrl(window.location.href, selectedBranch, projectExternalId);
      if (selectedBranch != BS.Branch.WILDCARD_NAME) {
        url = url.replace(/tab=buildTypeBranches/g, "tab=buildTypeStatusDiv");    // See TW-22583.
      }

      var that = this;

      if (options.save) {  // overview page
        BS.User.setProperty("ui.overview.branch." + projectId, selectedBranch, {
          afterComplete: function() {
            that.registerProjectBranch(projectExternalId, selectedBranch);
            BS.Projects.updateProjectView(projectId, projectExternalId, options.isFirst, true);
          }
        });
      } else {
        window.location.href = url;
      }
  },

  _discoverName:function(branch){
    if (branch == this.WILDCARD_NAME){
      return "<All branches>";
    }
    if (branch == this.DEFAULT_NAME){
      return "<Default branch>";
    }
    return branch;
  },

  installDropdownToBreadcrumb: function(userBranch, enabled, activeBranches, otherBranches, options) {

    var tabsContainer = $j("#tabsContainer3");
    var branchNameSelector = $j(".branchNameSelector");
    var breadcrumbs = $j('#mainNavigation');
    var showInBreadcrumbs = BS.internalProperty('teamcity.ui.branches.inBreadcrumbs', false);

    if (!tabsContainer.length || branchNameSelector.length) {
      return;
    }

    this.registerProjectBranch(options.projectExternalId, userBranch);
    var  dropdown = this.makeDropdown(userBranch, enabled, "branchNameSelector", activeBranches, otherBranches, options);
      this.addChangeHandler(dropdown, options);
      branchNameSelector = $j("<p class='branchNameSelector'/>").addClass(showInBreadcrumbs ? 'branchNameSelector_inline' : '')
          .append(dropdown)
          .wrap($j('<li class="main-navigation_branch-name-selector"/>')).parent();

    if (showInBreadcrumbs) {
      if (breadcrumbs.find('li:last').hasClass('breadcrumbHealthIndicators')) {
        branchNameSelector.insertBefore(breadcrumbs.find('li:last'));
      } else {
        breadcrumbs.append(branchNameSelector);
      }
    } else {
      tabsContainer
        .addClass("simpleTabsWithSelector")
        .find("ul.tabs")
        .prepend(branchNameSelector);
    }

      if (document.documentElement.className.indexOf('ua-ie') > -1) {
        $j(document).ready(function () {
          BS.jQueryDropdown(dropdown, {skin: "popup"});
        });
      } else {
        BS.jQueryDropdown(dropdown, {skin: "popup"});
      }

    this.injectBranchParamToLinks(tabsContainer, options.projectExternalId);
  },


  installRestDropdownToBreadcrumb: function(userBranch, options) {

    var tabsContainer = $j("#tabsContainer3");
    var branchInBreadcrumbsSelector = $j("#restPageTitle .branch-search");

    if (!tabsContainer.length || branchInBreadcrumbsSelector.length) {
      return;
    }

    var tab = (options || {})["tab"];

    if (tab != undefined && this._allBranchesTabNames.indexOf(tab) == -1  && this._activeBranchesTabNames.indexOf(tab) == -1){
      return; // we don't need branch selector on this tab
    }


    this.registerProjectBranch(options.projectExternalId, userBranch);
    var dropdown;

      var name = this._wildcardName(options, true);
      var initialName = userBranch;
      if (userBranch == this.WILDCARD_NAME){
        userBranch = name;
      }

    $j("<div class='branchSearchWrapper'></div>").insertAfter('#restPageTitle .selected');

    if (userBranch != undefined && userBranch.length > 30){
      $j(".branchSearchWrapper").css("width",userBranch.length * 6 + "px");
    } else {
      $j(".branchSearchWrapper").css("width","250px");
    }


    var self = this;

    BS.RestProjectsPopup.componentPlaceholder('.branchSearchWrapper', 'branch-search', function(){
      var height = BS.RestProjectsPopup.height();
      var dropdown = document.createElement('branch-search');
      dropdown.id = "restBranchSelector";
      dropdown.minimalistic = 'minimalistic';
      dropdown.includeBuildTypeDependency = options.includeSnapshots;
      dropdown.selected = {name: self._discoverName(userBranch), webUrl: initialName};
      dropdown.settings = {
        "hideFirstServerHeader": true, "height" : height, "options" : {"wildcardName" : name}};
      dropdown.server = base_uri;
      if (options.buildTypeId != undefined){
        dropdown.buildTypeId = options.buildTypeId;
      } else {
        dropdown.projectId = options.projectExternalId;
        dropdown.subprojects = options.includeSubprojects;
        dropdown.activeOnly = self._allBranchesTabNames.indexOf(tab) == -1;
      }
      $j(dropdown).css("display","inline-block");
      $j(dropdown).css("max-width","468px");
      $j(dropdown).css("width","100%");
      $j(dropdown).css("vertical-align","top");
      $j('.branchSearchWrapper').append(dropdown);
      self.addRestChooserChangeHandler(dropdown, options);
    }, "<span class='branchNameSelector_placeholder minimalistic'><span class='icon branch'></span><input disabled value='"+ (userBranch==this.DEFAULT_NAME ? "<Default branch>": userBranch) +"'/><span class='icon branch loading'></span></span>");

    this.injectBranchParamToLinks(tabsContainer, options.projectExternalId);
  },

  registerProjectBranch: function(projectExtId, userBranch) {
    this._branches[projectExtId] = userBranch;
  },

  installDropDownToProjectPane: function(pane, userBranch, activeBranches, otherBranches, options) {
    pane = $j(pane);

    var id = "branchNameSelector" + options.projectId;
    var restSelector = !BS.internalProperty('teamcity.ui.restSelectors.disabled', false);

    var select;
    if (!restSelector) {
      select = this.makeDropdown(userBranch, true, id, activeBranches, otherBranches, options);
      this.addChangeHandler(select, options);
    } else {
      var name = this._wildcardName(options, true);
      if (userBranch == this.WILDCARD_NAME){
        userBranch = name;
      }
      var height = BS.RestProjectsPopup.height();

      select = document.createElement('branch-search');
      select.id = "restBranchSelector";
      select.activeOnly = true;
      select.selected = {name: this._discoverName(userBranch), webUrl: userBranch};
      select.settings = {
        "hideFirstServerHeader": true, "height" : height, "options" : {"wildcardName" : name}};
      select.server = base_uri;
      select.projectId = options.projectExternalId;
      select.subprojects = false;

      select = $j(select);

      this.addRestChooserChangeHandler(select, options);
    }

    this.registerProjectBranch(options.projectExternalId, userBranch);
    options.save = true;

    pane.append(select);

    if (!restSelector){
      BS.jQueryDropdown(select, {skin: "popup", propagateTrigger: false});
    }
    pane.width(select.parent().outerWidth());
  },

  _addBranchOption: function(select, branch, userBranch) {
    this._addOption(select, branch.escapeHTML(), branch, userBranch);
  },

  _addOption: function(select, name, value, userBranch) {
    $j("<option/>").val(value)
                   .append(name)
                   .prop("selected", userBranch == value)
                   .appendTo(select);
  },

  _addOptionGroup: function(select, name) {
    return $j("<optgroup/>").attr("label", name)
                            .appendTo(select);
  },

  /**
   * <p>Adds the branch parameter to all anchor elements referencing a project
   * or a build configuration, depending on currently selected branch. If no
   * branch is selected, {@link WILDCARD_NAME} value is used.</p>
   *
   * <p>If you need an anchor element within the <code>container</code> to
   * be skipped by this method, add <code>js_ignore-branch</code> class to such
   * an anchor.</p>
   *
   * @param {jQuery} container
   * @param {String} projectExternalId
   * @external jQuery
   */
  injectBranchParamToLinks: function(container, projectExternalId) {
    var /**String*/ branch = this.getBranchFromUrl(projectExternalId);
    if (branch == null) { // exit on null or undefined
      return;
    }

    var /**BS.Branch*/ that = this;
    container.find("a:not(.js_ignore-branch)").each(function() {
      var /**HTMLAnchorElement*/ link = this;
      var /**String*/ href = link.href;

      if (!href || href.startsWith("#") || href.startsWith("javascript:")) {
        return;
      }

      // One more exception. See TW-22583.
      if (href.indexOf("tab=buildTypeBranches") >= 0) {
        return;
      }

      /*-
       * Inject branch parameter into links in breadcrumb.
       */
      if (href.indexOf("viewType.html") >= 0 || href.indexOf("project.html") >= 0) {
        link.href = that._getUrl(href, branch, projectExternalId);
      }
    });
  },

  setLink: function(link, buildTypeId, projectExternalId, branch) {
    if (link.getAttribute('href') == "#") {
      var url = this.baseUrl;
      if (!url) {
        url = window["base_uri"] + "/viewType.html?buildTypeId=" + buildTypeId;
      }
      link.setAttribute("href", this._getUrl(url, branch, projectExternalId));
    }
  },

  _getUrl: function(url, branch, projectExternalId) {
    var query = url.indexOf("?") >= 0 ? url.toQueryParams() : {};
    for (var param in query) {
      if (param.indexOf(this.branchParamPrefix) != -1) { // remove all other branch_ parameters
        delete query[param];
      }
    }
    query[this.branchParamPrefix + projectExternalId] = branch;  // No need to escape. toQueryString() will do that.
    var basePath = url.indexOf("?") >= 0 ? url.substring(0, url.indexOf("?") + 1) : url + "?";
    return basePath + Object.toQueryString(query);
  },

  getBranchFromUrl: function(projectExternalId) {
    return this._branches[projectExternalId];
  },

  addBranchToParams: function(params, projectExternalId) {
    var branch = this.getBranchFromUrl(projectExternalId);
    if (branch) {
      params[this.branchParamPrefix + projectExternalId] = branch;
    }
  },

  getAllBranchesFromUrl: function() {
    var result = {};
    for (var key in this._branches) {
      result[this.branchParamPrefix + key] = this._branches[key];
    }
    return result;
  },

  isCustomBranch: function(branch) {
    return branch && !(branch == this.WILDCARD_NAME || branch == this.DEFAULT_NAME);
  }
};
