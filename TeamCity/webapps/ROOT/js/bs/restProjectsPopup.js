BS.RestProjectsPopup = new BS.Popup(
    'restProjectsPopup', {
      delay: 0,
      hideOnMouseOut: false,
      doScroll: false,
      shift: {
        x: -100,
        y: 15
      },
      textProvider: function (popup) {
        var settings = popup.options.restPopupSettings;
        var parentProjectId = settings.parentProjectId;
        var buildId = settings.buildId;
        var quickNavigation = settings.quickNavigation;
        if (buildId != undefined){
          return "Not implemented yet";
        }
        settings.baseUri = base_uri;
        settings.currentServer = BS.RestProjectsPopup.serverRootUrl;
        settings.expandSingleNode = true;
        // `settings.baseUri` never has trailing comma,
        // but `settings.currentServerl` can,
        // resulting to erroneous URL in `ConverterBehaviour._adaptHref`
        if ((/\/$/).test(settings.currentServer) && ! (/\/$/).test(settings.baseUri)) {
          settings.baseUri += '/';
        }
        if (parentProjectId == undefined) {
          settings.height = quickNavigation ? BS.RestProjectsPopup.quickNavigationHeight() : BS.RestProjectsPopup.height();
          settings.hideFirstServerHeader = BS.RestProjectsPopup.hideFirstServersHeader();
          return BS.RestProjectsPopup.progressContent(settings.height) + "<teamcity-search-popup current-user='" + BS.RestProjectsPopup.currentUser +
                 "' settings='" +  JSON.stringify(settings) + "' servers='[" + BS.RestProjectsPopup.loadedServers.toString() + "]'></teamcity-search-popup>";
        }
        settings.height = BS.RestProjectsPopup.breadcrumbsHeight();
        settings.hideFirstServerHeader = true;
        settings.breadcrumbsMode = true;
        settings.pageUri = document.location.href;
        settings.editMode = BS.Navigation.discoverMode().adminPart == true;

        BS.RestProjectsPopup.addUrlFormats(settings);


        return BS.RestProjectsPopup.progressContent(settings.height) + "<teamcity-breadcrumbs-popup settings='" + JSON.stringify(settings) + "' root-project='" + BS.RestProjectsPopup.rootProject(popup)
               + "' current-id='" + parentProjectId + "' server='" +
               BS.RestProjectsPopup.server(popup) + "'></teamcity-breadcrumbs-popup>";
      },
      backgroundColor: 'white',
      loadingText: 'Loading...',
      forceReload: true
    });

BS.RestProjectsPopup.removeProgress = function(){
  var allDone = BS.RestProjectsPopup.checkComponentRegistration(['teamcity-search-popup']);
  if (!allDone){
    window.setTimeout(BS.RestProjectsPopup.removeProgress, 100);
  } else {
    $j('#restProjectsPopupProgress').css('display','none');
  }
};

BS.RestProjectsPopup.progressContent = function(height){
  var allDone = BS.RestProjectsPopup.checkComponentRegistration(['teamcity-search-popup']);
  if (allDone){
    return "";
  }
  BS.RestProjectsPopup.removeProgress(height);
  $j('#restProjectsPopup').css('height',height);
  return '<div style="vertical-align: middle; font-style: italic; color: grey; margin-bottom: 5px;" id="restProjectsPopupProgress"><span class="loader"></span><span>Loading data...</span></div>';
};

BS.RestProjectsPopup.addUrlFormats = function(settings){
  if (BS.Navigation.items == undefined || settings == undefined || settings.currentId == undefined){
    settings.btUrlFormat = undefined;
    settings.projectUrlFormat = undefined;
    return;
  }
  for (var i=0; i < BS.Navigation.items.length; i++){
    var item = BS.Navigation.items[i];
    if (item.buildTypeId == settings.currentId || item.projectId == settings.currentId){
      if (item.siblingsTree != undefined) {
        settings.btUrlFormat = item.siblingsTree.buildTypeUrlFormat;
        settings.projectUrlFormat = item.siblingsTree.projectUrlFormat;
      }
      break;
    }
  }
};

BS.RestProjectsPopup.serversLoadingFinished = false;

BS.RestProjectsPopup.loadedServers = [];

BS.RestProjectsPopup.federationServers = [];

BS.RestProjectsPopup.loadServers = function () {
  BS.RestProjectsPopup.loadedServers = ["\"" + base_uri + "\""];
  $j.getJSON(base_uri  + '/app/rest/federation/servers', function(data) {
    if (data.server != undefined){
      data.server.forEach(function(s){
        BS.RestProjectsPopup.federationServers.push(s);
        BS.RestProjectsPopup.loadedServers.push("\"" + s.url + "\"");
      });
    }
  })
      .fail(function() {
        console.error('An error occurred in attempt to load servers list from /app/rest/federation/servers');
      })
      .always(function() {
        BS.RestProjectsPopup.serversLoadingFinished = true;
      });
};

BS.RestProjectsPopup.hideFirstServersHeader = function(){
  return BS.RestProjectsPopup.loadedServers.length < 2;
};

BS.RestProjectsPopup.height = function () {
  var wHeight = $j(window).height() - 200;
  if (wHeight < 200){
    wHeight = 200;
  }
  return "" + wHeight + "px";
};

BS.RestProjectsPopup.breadcrumbsHeight = function () {
  return BS.RestProjectsPopup.height();
};

BS.RestProjectsPopup.quickNavigationHeight = function () {
  return BS.RestProjectsPopup.height() / 1.5;
};

BS.RestProjectsPopup.server = function (popup) {
  return base_uri;
};

BS.RestProjectsPopup.rootProject = function (popup) {
  return popup.options.restPopupSettings.parentProjectId;
};

BS.RestProjectsPopup.globalSearchOptions = function (event) {
  return {
    restPopupSettings: {
      parentProjectId: undefined,
      quickNavigation: false,
      currentId: undefined,
      editMode: false,
      buildId: undefined,
      source: 'global',
      cache: BS.RestProjectsPopup.restProjectPopupCacheDisabled != undefined && BS.RestProjectsPopup.restProjectPopupCacheDisabled == 'true'?
             'nocache': (BS.RestProjectsPopup.restProjectPopupCacheStrategy != undefined ? BS.RestProjectsPopup.restProjectPopupCacheStrategy : 'lzutf8')
    },
    delay: event != undefined && event.type == 'mouseover' ? 300 : 0,
    doScroll: false,
    shift: {
      x: -75,
      y: 15
    }
  }
};

BS.RestProjectsPopup.quickNavigationOptions = function () {
  return {
    restPopupSettings: {
      parentProjectId: undefined,
      currentId: undefined,
      buildId: undefined,
      editMode: false,
      quickNavigation: true,
      source: 'quickNavigation',
      cache: BS.RestProjectsPopup.restProjectPopupCacheDisabled != undefined && BS.RestProjectsPopup.restProjectPopupCacheDisabled == 'true'?
             'nocache': (BS.RestProjectsPopup.restProjectPopupCacheStrategy != undefined ? BS.RestProjectsPopup.restProjectPopupCacheStrategy : 'lzutf8')
    },
    doScroll: false
  }
};

BS.RestProjectsPopup.breadcrumbsOptions = function (parentId, currentId, currentNodeType, buildId, editMode, branch, shiftX, shiftY) {
  return {
    restPopupSettings: {
      quickNavigation: false,
      parentProjectId: parentId,
      currentId: currentId,
      currentNodeType: currentNodeType,
      buildId: buildId,
      editMode: editMode,
      branch: branch,
      source: 'breadcrumbs',
      firstFocusValue: {id:currentId}
    },
    doScroll: false,
    shift: {
      x: shiftX != undefined ? shiftX : -10,
      y: shiftY != undefined ? shiftY : 15
    }
  }
};


BS.RestProjectsPopup.checkComponentRegistration = function (elementsToCheck) {
  function isRegistered(name) {
    return document.createElement(name).constructor != HTMLElement;
  }

  var registered = true;
  elementsToCheck.forEach(function (el) {
    var b = isRegistered(el);
    registered = registered && b;
  });
  return registered && BS.RestProjectsPopup.serversLoadingFinished;
};

BS.RestProjectsPopup.hideCurrentPopIfAny = function() {
  if (BS.RestProjectsPopup.isShown()) {
    BS.RestProjectsPopup.hidePopup(0, true);
  }
};

BS.RestProjectsPopup.showGlobal = function(img, event){
  BS.RestProjectsPopup.hideCurrentPopIfAny();

  BS.RestProjectsPopup.showPopupNearElement(img, BS.RestProjectsPopup.globalSearchOptions(event));

};

BS.RestProjectsPopup.showQuickNavigation = function(){
  BS.RestProjectsPopup.hideCurrentPopIfAny();

  _.extend(this.options, BS.RestProjectsPopup.quickNavigationOptions());
  BS.RestProjectsPopup._showWithDelay($j(document).width() / 2 - 230, $j(document).scrollTop() + 100, function() {
  });
};


BS.RestProjectsPopup.register = function () {
  var img = jQuery('#allPopupImg');
  img
      .on('mouseover', function (e) {
        img.addClass('hovered');
        BS.RestProjectsPopup.showGlobal(img, e);
      })
      .on('mouseout', function () {
        img.removeClass('hovered');
        BS.RestProjectsPopup.hidePopup(1000);
      })
      .on('click', function (e) {
        BS.RestProjectsPopup.showGlobal(img, e);
        e.stopPropagation();
      });
  img.removeClass('disabled');

  jQuery(document).keydown(function(e) {
    if ((e.keyCode == 81 || e.keyCode == 80) && !BS.Util.isModifierKey(e)) {

      var element = jQuery(e.target);
      if (element.is("input") || element.is("textarea") || element.is("select")) {
        return;
      }
      BS.RestProjectsPopup.showQuickNavigation();
    }
  });

};

BS.RestProjectsPopup.install = function (serverRootUrl, requestContext, currentUser, restProjectPopupCacheDisabled, restProjectPopupCacheStrategy) {

  BS.RestProjectsPopup.serverRootUrl = serverRootUrl;
  BS.RestProjectsPopup.requestContext = requestContext;
  BS.RestProjectsPopup.currentUser = currentUser;
  BS.RestProjectsPopup.restProjectPopupCacheStrategy = restProjectPopupCacheStrategy;
  BS.RestProjectsPopup.restProjectPopupCacheDisabled = restProjectPopupCacheDisabled;

  BS.RestProjectsPopup.loadServers();

  BS.RestProjectsPopup.register();
};

BS.RestProjectsPopup.discoverEditMode = function(container){
  var firstLi = container.find("li:first");
  var firstA = firstLi.find("a");
  var text = firstA.length > 0 ? firstA[0].innerText : "";

  return !!(text == 'Administration' && firstLi.attr('data-projectid') == undefined && firstLi.attr('data-buildtypeid') == undefined);

};

BS.RestProjectsPopup.discoverCurrentBranch = function(){
  var branchEls = $j('.branchName');

  if (branchEls.length != 1){
    return undefined;
  }

  var branchLink = branchEls[0];
  $j(branchLink).trigger("mouseover");

  var branchObject = BS.RestProjectsPopup.getBranch(branchLink.href);

  if (branchObject == undefined){
    return undefined;
  }

  return branchObject.paramName + '=' + branchObject.paramValue;
};

BS.RestProjectsPopup.getBranch = function(href) {
  var params = URI(href).search(true);
  for (var param in params) {
    if (param.startsWith(BS.Branch.branchParamPrefix)) {
      return {paramName: param, paramValue: params[param]};
    }
  }
  return undefined;
};


BS.RestProjectsPopup.installRestBreadcrumbs = function () {

  var container = $j('#restBreadcrumbs');

  var spans = container.find("div[data-parentId], li[data-parentId]");

  var rootProjectSpan = container.find('[data-projectid="_Root"]');

  if (rootProjectSpan.length > 0){
    spans.push(rootProjectSpan[0]);
  }

  var build_span = container.find("div[data-buildid]");

  if (build_span.length > 0){
    spans.push(build_span[0]);
  }

  spans.each(function (index) {

    var parentId = $j(this).attr('data-parentId');

    var currentId = $j(this).attr('data-projectid');
    var currentNodeType = "project";

    if (parentId == undefined || parentId == ''){
      parentId = currentId; //happens for _Root project
    }

    if (currentId == undefined){
      currentId = $j(this).attr('data-buildtypeid');
      currentNodeType = "bt";
    }

    var buildId = $j(this).attr('data-buildid');

    var icon = $j(this);
    var anchor = icon.find("i");
    anchor.removeClass('icon_disabled');
    anchor
        .on('click', function () {
          if (BS.RestProjectsPopup && !BS.RestProjectsPopup.isShown()) {
            BS.RestProjectsPopup.showPopupNearElement(anchor, BS.RestProjectsPopup.breadcrumbsOptions(parentId, currentId, currentNodeType, buildId, BS.Navigation.discoverMode().adminPart, undefined, -2, (anchor.height())));
          } else {
            BS.RestProjectsPopup.stopHidingPopup();
          }
        });
  });
};

BS.RestProjectsPopup.componentPlaceholder = function(selector, elementType, callback, placeholderContent){
  function componentLoaded(){
    var allDone = BS.RestProjectsPopup.checkComponentRegistration([elementType]);
    if (!allDone){
      window.setTimeout(componentLoaded, 100);
    } else {
      $j(selector).html('');
      callback.apply();
    }
  }

  var registration = BS.RestProjectsPopup.checkComponentRegistration([elementType]);
  if (registration){
    callback.apply();
  } else {
    var placeholder = placeholderContent != undefined
      ? placeholderContent
      : '<span style="margin-bottom: 5px;">' +
          '<span class="loader" style="margin-right: 8px; vertical-align: -7px;"></span>' +
          '<span style="font-style: italic; color: grey; ">Loading data...</span>' +
        '</span>';
    $j(selector).html(placeholder);
    componentLoaded();
  }
};

