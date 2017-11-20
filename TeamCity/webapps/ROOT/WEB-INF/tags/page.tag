<%@ tag import="jetbrains.buildServer.controllers.PageBeforeContentPagePlaceController"
  %><%@ tag import="jetbrains.buildServer.controllers.buildType.BuildTypeController"
  %><%@ tag import="jetbrains.buildServer.controllers.interceptors.ProjectIdConverterInterceptor"
  %><%@ tag import="jetbrains.buildServer.web.openapi.PlaceId"
  %><%@ tag import="jetbrains.buildServer.web.util.WebUtil"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="afn" uri="/WEB-INF/functions/authz"
  %><%@ taglib prefix="ufn" uri="/WEB-INF/functions/user"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz"
  %><%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin"
  %><%@ taglib prefix="ext" tagdir="/WEB-INF/tags/ext"
  %><%@ taglib prefix="et" tagdir="/WEB-INF/tags/eventTracker"
  %><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
  %><%@ taglib prefix="resp" tagdir="/WEB-INF/tags/responsible"
  %><%@ taglib prefix="tags" tagdir="/WEB-INF/tags/tags"
  %><%@ taglib prefix="problems" tagdir="/WEB-INF/tags/problems"
  %><%@ taglib prefix="intprop" uri="/WEB-INF/functions/intprop"
  %><%@ attribute name="page_title" fragment="true"
  %><%@ attribute name="head_include" fragment="true"
  %><%@ attribute name="body_include" fragment="true"
  %><%@ attribute name="sidebar_include" fragment="true"
  %><%@ attribute name="toolbar_include" fragment="true"
  %><%@ attribute name="quickLinks_include" fragment="true"
  %><%@ attribute name="beforeTabs_include" fragment="true"
  %><%@ attribute name="besideTabs_include" fragment="true"
  %><%@ attribute name="disableScrollingRestore" fragment="false"
  %><%@ tag body-content="empty"
  %><jsp:useBean id="serverSummary" type="jetbrains.buildServer.web.openapi.ServerSummary" scope="request"
  /><jsp:useBean id="serverTC" type="jetbrains.buildServer.serverSide.SBuildServer" scope="request"
  /><jsp:useBean id="currentUser" type="jetbrains.buildServer.users.SUser" scope="request"
  /><jsp:useBean id="websocketFeature" type="jetbrains.buildServer.push.impl.WebSocketFeature" scope="request"/>
  <c:set var="pageAppTitle">
  <c:choose>
    <c:when test="${not empty pageTitle}"><c:out value="${pageTitle}"/></c:when>
    <c:otherwise>
      <c:set var="pageTitleFragment">
        <jsp:invoke fragment="page_title"/>
      </c:set>
      <c:if test="${not empty pageTitleFragment}">${pageTitleFragment} </c:if>
    </c:otherwise>
  </c:choose>
  </c:set>
  <c:set var="pageTitle">
  <c:choose>
    <c:when test="${not empty pageTitle}"><c:out value="${pageTitle}"/> &mdash; TeamCity</c:when>
    <c:otherwise>
      <c:set var="pageTitleFragment">
        <jsp:invoke fragment="page_title"/>
      </c:set>
      <c:if test="${not empty pageTitleFragment}">${pageTitleFragment} &mdash; </c:if>TeamCity
    </c:otherwise>
  </c:choose>
</c:set>
<!DOCTYPE html>
<html>
  <head>
    <title>${pageTitle}</title>
    <bs:XUACompatible/>
    <bs:pageMeta title="${pageAppTitle}"/>

    <bs:webComponentsSettings/>
    <c:if test="${!restSelectorsDisabled}">
    <!--[if (gt IE 9)|(!IE)]> -->
      <bs:importWebComponents/>
    <!-- <![endif]-->
    </c:if>

    <bs:jquery/>
    <bs:linkCSS>
      /css/FontAwesome/css/font-awesome.min.css
      /css/main.css
      /css/icons.css
      /css/footer.css
      /css/tabs.css
      /css/buildLog/buildResultsDiv.css
      /css/testGroups.css
      /css/testList.css
      /css/investigation.css
      /css/statusChangeLink.css
      /css/tree/oldTree.css
      /css/tree/tree.css
      /css/projectHierarchy.css
      /css/tags.css

      /css/quickLinksPopUp.css
      /css/forms.css
      /css/runCustomBuild.css
      /css/issues.css
      /css/ellipsis.css

      /css/autocompletion.css
    </bs:linkCSS>

    <bs:ua/>
    <bs:baseUri/>
    <c:if test="${ufn:booleanPropertyValue(currentUser, 'autodetectTimeZone') and empty sessionScope['userTimezoneKey']}">
      <script type="text/javascript" src="<c:url value='/js/bs/timezone.js'/>"></script>
    </c:if>

    <bs:prototype/>
    <bs:commonFrameworks/>

    <bs:predefinedIntProps/>

    <bs:linkScript>
      <%-- BS - utility components --%>
      /js/bs/bs.js
      /js/bs/cookie.js
      /js/bs/resize.js
      /js/bs/position.js
      /js/bs/refresh.js

      <%-- BS - common components --%>
      /js/bs/tabs.js
      /js/bs/forms.js
      /js/bs/basePopup.js
      /js/bs/menuList.js
      /js/bs/modalDialog.js
      /js/bs/investigation.js
      /js/bs/changeBuildStatus.js
      /js/bs/tree.js
      /js/bs/issues.js
      /js/bs/pluginProperties.js
      /js/bs/serverLink.js
      /js/bs/activation.js
      /js/bs/datepicker.js
      /js/bs/tags.js
      /js/bs/backgroundLoader.js
      /js/bs/bs-clipboard.js

      <%-- BS - business logic --%>
      /js/bs/adminActions.js
      /js/bs/advancedOptions.js
      /js/bs/runBuild.js
      /js/bs/stopBuild.js
      /js/bs/customControl.js
      /js/bs/parameters.js
      /js/bs/editParameters.js
      /js/bs/branch.js
      /js/bs/vcsSettings.js

      /js/bs/toggleOverview.js
    </bs:linkScript>

    <c:if test="${intprop:getBooleanOrTrue('teamcity.ui.codeMirrorEditor.enabled')}">
      <bs:linkCSS>
        /css/codemirror/codemirror.css
        /css/codemirror/codemirror-teamcity.css
        /css/codemirror/addon/hint/show-hint.css
      </bs:linkCSS>
      <bs:linkScript>
        /js/codemirror/lib/codemirror.js
        /js/codemirror/lib/codemirror-teamcity.js
        /js/codemirror/addon/edit/closetag.js
        /js/codemirror/addon/edit/matchbrackets.js
        /js/codemirror/addon/selection/active-line.js
        /js/codemirror/mode/xml/xml.js
        /js/codemirror/addon/mode/loadmode.js
        /js/codemirror/addon/hint/show-hint.js
        /js/bs/codemirror.js
      </bs:linkScript>
    </c:if>

    <bs:encrypt/>

    <problems:buildProblemStylesAndScripts/>

    <script type="text/javascript">
      BS.Socket.init(${websocketFeature.enabled});
      BS.ServerLink.init();

      <c:if test="${not empty currentUser}">
      BS.topNavPane = new TabbedPane('top');

      BS.topNavPane.addTab("overview", {
        caption: "Projects",
        url: "<c:url value="/overview.html"/>",
        postLink: "<div id='allPopupImg' class='icon icon16 icon_popup' title='View all projects'>&nbsp;</div>"
      });

      BS.topNavPane.addTab("changes", {
        caption: "Changes",
        url: "<c:url value="/changes.html"/>"
      });

      BS.topNavPane.addTab("agents", {
        caption: "Agents (${serverSummary.registeredAgentsCount})",
        url: "<c:url value="/agents.html"/>"
      });

      <c:set var="buildQueue" value="${serverTC.queue}"/>
      BS.topNavPane.addTab("queue", {
        caption: "Build Queue (${buildQueue.numberOfItems})",
        url: "<c:url value="/queue.html"/>"
      });
      </c:if>

      (function() {
        function initPage() {
        <c:if test="${empty disableScrollingRestore or not disableScrollingRestore}">
          if (document.location.href.indexOf('#') == -1) {
            restoreScrolling();
          }
        </c:if>

          if (typeof BS == "undefined") return;
          BS.initReloadBlocker();
        }

        $j(document).ready(initPage);
      })();

      $j(document).ready(function() {
        if (typeof BS == "undefined") return;
        BS.StatisticsMonitor.start();
        BS.InvestigationsCounterMonitor.start(${currentUser.id});
        BS.EventTracker.startTracking("<c:url value='/eventTracker.html'/>");
        BS.SubscriptionManager.start();
        BS.Clipboard.installGlobalHandler();
      });

      Event.observe(window, "unload", function() {
        rememberScrolling();
        if (typeof BS == "undefined") return;
        BS.blockRefreshPermanently();
        BS.SubscriptionManager.dispose();
      });

    </script>
  <jsp:invoke fragment="head_include"/>

  <ext:includeExtensions placeId="<%=PlaceId.ALL_PAGES_HEADER%>"/>
  </head>

  <body class="pageBG">
  <c:set var="webComponentSupport" value="<%= WebUtil.isWebComponentSupportAware(request) %>"></c:set>
  <c:if test="${not intprop:getBoolean('teamcity.ui.legacyIEwarning.disabled') and not webComponentSupport}">
    <div class="ie9-notification icon_before icon16 attentionComment clearfix">
      You are using an outdated version of the browser (Internet Explorer 9 or earlier) or IE compatibility mode is enabled.
      If you are using Internet Explorer 10 or newer, make sure compatibility mode is disabled.
      Next TeamCity version will only support Internet Explorer 10 and newer versions.
      Contact <a target="_blank" href="https://teamcity-support.jetbrains.com/hc/en-us/requests/new?ticket_form_id=66621">JetBrains TeamCity support</a> if this can affect your TeamCity usage.
    </div>
  </c:if>

  <div id="bodyWrapper">
    <div class="ring-header"></div> <!-- Ring placeholder, do not remove -->
      <div id="loadingWarning"><div class="ring-loader-inline"><!--[if (gt IE 9)|(!IE)]> -->
        <div class="ring-loader-inline__ball"></div>
        <div class="ring-loader-inline__ball ring-loader-inline__ball_second"></div>
        <div class="ring-loader-inline__ball ring-loader-inline__ball_third"></div><!-- <![endif]-->
      </div><span class="text">Loading...</span></div>
      <script type="text/javascript">
        (function() {
          function getLoadingDiv() {
            return document.getElementById('loadingWarning');
          }
          var loadingTimeout = setTimeout(function(){
            var div = getLoadingDiv();
            if (div != null) {
              div.style.display = 'block';
            }
          }, 500);

          $j(document).ready(function() {
            if (loadingTimeout) clearTimeout(loadingTimeout);
            var div = getLoadingDiv();
            if (div != null) {
              BS.Util.hide(div);
            }
          });
        })();
      </script>

    <div id="topWrapper">
      <div class="headBG clearfix">
        <div class="fixedWidth">

          <c:set var="customLogoStyle"
            ><c:if test="${fn:length(intprop:getProperty('teamcity.ui.logo.url', '')) > 0}"
              >style="background-image: url(${intprop:getProperty('teamcity.ui.logo.url', '')});"</c:if
          ></c:set>
          <a href="<c:url value="/"/>" class="headerLogo"><i class="headerLogoImg" ${customLogoStyle}></i></a>

          <div id="tabsContainer"></div>
          <div id="userPanel">
            <c:if test="${not empty currentUser}">
            <div class="info"><span class="investigationsTicker"></span>
              <c:url value="/profile.html?init=1" var="settingsUrl"/>
              <bs:popup_static controlId="sp_span_usernamePopup" popup_options="shift: {x: -120, y: 15}, className: 'quickLinksMenuPopup'">
                <jsp:attribute name="content">
                  <ul class="menuList">
                  <%--@elvariable id="isSpecialUser" type="boolean"--%>
                  <c:if test="${not isSpecialUser}">
                  <authz:authorize allPermissions="CHANGE_OWN_PROFILE">
                    <li>
                      <a href='<c:url value="/favoriteBuilds.html"/>' showdiscardchangesmessage='false'>My Favorite Builds</a>
                    </li>
                    <li>
                      <a href='<c:url value="/investigations.html?init=1"/>' showdiscardchangesmessage='false'>My Investigations</a>
                    </li>
                    <li>
                      <a href='${settingsUrl}' showdiscardchangesmessage='false'>My Settings & Tools</a>
                    </li>
                  </authz:authorize>
                  </c:if>
                  <c:url value="/ajax.html?logout=1" var="logoutUrl"/>
                    <li>
                      <a class="logout" href="#" onclick="BS.Logout('${logoutUrl}'); return false" showdiscardchangesmessage="false">Log out</a>
                    </li>
                  </ul>
                  </jsp:attribute>
                  <jsp:body
                    ><c:set var="username"><c:out value='${currentUser.descriptiveName}'/></c:set
                    ><authz:authorize allPermissions="CHANGE_OWN_PROFILE"
                      ><jsp:attribute name="ifAccessDenied">${username}</jsp:attribute
                      ><jsp:attribute name="ifAccessGranted"><c:choose><c:when test="${isSpecialUser}">${username}</c:when><c:otherwise><a href='${settingsUrl}'>${username}</a></c:otherwise></c:choose></jsp:attribute
                    ></authz:authorize
                  ></jsp:body>
              </bs:popup_static></div>
            <c:if test="${afn:adminSpaceAvailable()}">
              <div class="info admin"><a href='<c:url value="/admin/admin.html"/>'>Administration</a></div>
            </c:if>
            </c:if>
          </div>
        </div>
        <div id="header-ready"></div>
      </div>
      <script type="text/javascript">
        if (BS.topNavPane) {
          BS.topNavPane.showIn('tabsContainer');
          jQuery("#tabsContainer li").each(function() {
            var self = jQuery(this);
            if (!self.hasClass("first")) {
              self.addClass("leftBorder")
            }
          });
        }
      </script>
      <%--classes from allProjects.css are used in different part of the appliaction, we need then even if rest projects popup us enabed--%>
      <bs:linkCSS>
        /css/allProjects.css
      </bs:linkCSS>
      <c:choose>
        <c:when test="${!restSelectorsDisabled}">
          <!--[if (gt IE 9)|(!IE)]> -->
          <bs:linkScript>
            /js/bs/restProjectsPopup.js
          </bs:linkScript>
          <bs:linkCSS>
            /css/restProjectsPopup.css
          </bs:linkCSS>
          <script type="text/javascript">
            if (BS.topNavPane) {
              BS.RestProjectsPopup.install('${serverTC.rootUrl}','<%=request.getContextPath() %>', '${currentUser.id}', '${restProjectPopupCacheDisabled}', '${restProjectPopupCacheStrategy}');
            }
          </script>
          <!-- <![endif]-->
          <!--[if lte IE 9]>
          <bs:linkScript>
            /js/bs/allProjects.js
            /js/bs/quickNavigationPopup.js
          </bs:linkScript>
          <script type="text/javascript">
            if (BS.topNavPane) {
              BS.AllProjectsPopup.install();
            }
          </script>
          <![endif]-->
        </c:when>
        <c:otherwise>
          <bs:linkScript>
            /js/bs/allProjects.js
            /js/bs/quickNavigationPopup.js
          </bs:linkScript>
          <script type="text/javascript">
            if (BS.topNavPane) {
              BS.AllProjectsPopup.install();
            }
          </script>
        </c:otherwise>
      </c:choose>

      <%--<div id="headerBackground"></div>--%>

      <div class="fixedWidth clearfix">
        <div class="quickLinks">
          <jsp:invoke fragment="quickLinks_include"/>
        </div>

        <jsp:invoke fragment="toolbar_include"/>

        <c:choose>
          <c:when test="${!restSelectorsDisabled}">
            <div id="restBreadcrumbs">
              <ul id="restNavigation"><li></li></ul>
              <div id="restPageTitle"></div>
              <div id="restPageDescription"></div>
            </div>
            <script type="text/javascript">
              $j(document).on('bs.navigationRendered', function(){
                if (BS.RestProjectsPopup != undefined) {
                  BS.RestProjectsPopup.installRestBreadcrumbs();
                }
              });
            </script>
          </c:when>
          <c:otherwise>
            <ul id="mainNavigation"><li></li></ul>
          </c:otherwise>
        </c:choose>
      </div>
    </div>

    <script type="text/javascript">
      BS.Navigation.writeBreadcrumbs();
      BS.Navigation.installHealthItems();
    </script>

    <div class="fixedWidth">
      <bs:messages key="<%=ProjectIdConverterInterceptor.INTERNAL_PROJECT_ID_USED_MESSAGE_KEY%>" className="messageNote"/>
      <bs:messages key="<%=BuildTypeController.BUILD_TYPE_EXTERNAL_ID_CHANGED%>" className="messageNote"/>

      <jsp:include page="<%=PageBeforeContentPagePlaceController.PATH%>"/>

      <jsp:invoke fragment="beforeTabs_include"/>
      <table class="tabsTable">
        <tr>
          <td>
            <div id="tabsContainer3" class="simpleTabs"></div>
          </td>
          <td class="besideContent">
            <jsp:invoke fragment="besideTabs_include"/>
          </td>
        </tr>
      </table>
    </div>

    <div id="archivedProjectsContent" class="popupDiv" style="display:none;">
    </div>

    <bs:commonTemplates/>

    <div id="mainContent" class="fixedWidth clearfix">
      <div id="content">
        <bs:messages key="accessDenied"/>
        <jsp:invoke fragment="body_include"/>
      </div>
    </div>

    <jsp:include page="/footer.jsp"/>

  </div>

  <et:subscribeOnEvents>
    <jsp:attribute name="eventNames">
      SERVER_SHUTDOWN
    </jsp:attribute>
    <jsp:attribute name="eventHandler">
      BS.ServerLink.onShutdown();
    </jsp:attribute>
  </et:subscribeOnEvents>

  <bs:commonDialogs/>
  </body>
</html>
