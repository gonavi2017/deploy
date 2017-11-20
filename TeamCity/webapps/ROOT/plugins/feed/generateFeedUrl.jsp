<%@ include file="/include.jsp" %>
<%@ taglib prefix="util" uri="/WEB-INF/functions/util" %>

<c:set var="pageTitle" value="Feed URL Generator" scope="request"/>

<%@ page import="jetbrains.buildServer.feedNotificator.generator.FeedRequestParameters" %>
<%@ page import="jetbrains.buildServer.web.util.WebUtil" %>
<jsp:useBean id="serverTC" type="jetbrains.buildServer.serverSide.SBuildServer" scope="request"/>
<jsp:useBean id="serverUrl" type="java.lang.String" scope="request"/>
<jsp:useBean id="feed_sortedUsers" scope="request" type="java.util.SortedSet"/>
<jsp:useBean id="feed_guestLoginEnabled" type="java.lang.Boolean" scope="request"/>
<jsp:useBean id="feed_buildTypesWithExternalStatus" scope="request" type="java.util.List"/>
<jsp:useBean id="feed_buildTypesAvailableToGuest" scope="request" type="java.util.List"/>
<jsp:useBean id="feed_buildTypesAll" scope="request" type="java.util.List"/>
<jsp:useBean id="feed_currentUser" scope="request" type="jetbrains.buildServer.users.User"/>

<c:set var="buildTypeIdUrlPramName" value="<%=FeedRequestParameters.BUILD_TYPE_ID_URL_PARAMETER_NAME%>" scope="request"/>
<c:set var="projectIdUrlPramName" value="<%=FeedRequestParameters.PROJECT_ID_URL_PARAMETER_NAME%>" scope="request"/>
<c:set var="feedUrlPath" value="<%=FeedRequestParameters.FEED_URL_PATH%>" scope="request"/>
<c:set var="feedItemsTypeParameterName" value="<%=FeedRequestParameters.FEED_ITEMS_TYPE_PARAMETER_NAME%>" scope="request"/>
<c:set var="buildStatusParameterName" value="<%=FeedRequestParameters.BUILD_STATUS_PARAMETER_NAME%>" scope="request"/>
<c:set var="committerParameterName" value="<%=FeedRequestParameters.COMMITTER_PARAMETER_NAME%>" scope="request"/>
<c:set var="serverUrl" value="<%=WebUtil.escapeUrlForQuotes(serverUrl)%>"/>

<bs:page>
<jsp:attribute name="head_include">
  <bs:linkCSS>
    /css/admin/adminMain.css
    /css/admin/projectConfig.css
  </bs:linkCSS>

  <style type="text/css">
    .icon-rss-sign {
      color: #DF6722;
    }
  </style>

  <bs:linkScript>
    /js/bs/blocks.js
    /js/bs/blocksWithHeader.js
    /js/bs/copyProject.js
    /js/bs/editProject.js
    /js/bs/testConnection.js
  </bs:linkScript>

  <script type="text/javascript">
    BS.Navigation.items = [
      {title:"My Settings & Tools", url:'<c:url value="/profile.html"/>'},
      {title:"${pageTitle}", selected:true}
    ];
  </script>
</jsp:attribute>

<jsp:attribute name="body_include">
  <script type="text/javascript">
    var serverBaseUrl = "${serverUrl}";
    var buildTypeURLPramName = "${buildTypeIdUrlPramName}";
    var projectURLPramName = "${projectIdUrlPramName}";
    var feedPath = "${feedUrlPath}";

    function updateFeedURL() {
      // see FeedRequestParameters.getUrl() for how to generate feed URL
      var result = "";

      var useExternalStatus = $("externalStatus_buildTypes_check").checked;
    <c:if test="${feed_guestLoginEnabled}">
      var useGuestAuth = $("availableToGuest_buildTypes_check").checked;
    </c:if>
      var useAll = $("all_buildTypes_check").checked;

      if (useAll && $("useCredentials").checked) {
        var protocol = serverBaseUrl.substring(0, serverBaseUrl.search("://") + 3);
        var serverBaseUrlWithourProtocol = serverBaseUrl.substr(protocol.length);
        result += protocol + encodeURIComponent($("feed_username").value) + ":" + encodeURIComponent($("feed_password").value) + "@" + serverBaseUrlWithourProtocol;
      } else {
        result += serverBaseUrl;
      }

      if (useAll) {
        result += "/httpAuth";
      }
        <c:if test="${feed_guestLoginEnabled}">
      else if (useGuestAuth) {
        result += "/guestAuth";
      }
    </c:if>
      result += feedPath;

      if ($("all_buildTypes_check").checked && $("buildTypes_all").selectedIndex == 0) {
        //All Projects selected - no parameters needed
      } else {
        var useMultiselect;
        if (useExternalStatus) {
          useMultiselect = $("buildTypes_externalStatus");
        }
      <c:if test="${feed_guestLoginEnabled}">
        if (useGuestAuth) {
          useMultiselect = $("buildTypes_availableToGuest");
        }
      </c:if>
        if (useAll) {
          useMultiselect = $("buildTypes_all");
        }
        result = addParamsFromMultiSelect(result, useMultiselect);
      }

      if ($("item_builds").checked) {
        result = addParameter(result, "${feedItemsTypeParameterName}", "builds");
        if ($("item_successful").checked || $("item_allStatuses").checked) {
          result = addParameter(result, "${buildStatusParameterName}", "successful");
        }
        if ($("item_failed").checked || $("item_allStatuses").checked) {
          result = addParameter(result, "${buildStatusParameterName}", "failed");
        }
      }
      if ($("item_changes").checked) {
        result = addParameter(result, "${feedItemsTypeParameterName}", "changes");
      }
      if ($("committer").selectedIndex != 0) {
        result = addParameter(result, "${committerParameterName}", $("committer").options[$("committer").selectedIndex].value);
      }

      if ( <c:if test="${feed_guestLoginEnabled}">useGuestAuth || </c:if>useAll) {
        var userKey="unique";
        <c:if test="${feed_guestLoginEnabled}">
        if (useGuestAuth){
          userKey="guest";
        }else</c:if> if ($("useCredentials").checked){
          userKey=encodeURIComponent($("feed_username").value);
        }else{
          userKey="feed";
        }
        result = addParameter(result, "userKey", userKey);
      }

      $("feedURL").value = result;
      $("feedLink").href = result;
    }

    function addParamsFromMultiSelect(url, select) {
      var result = url;
      $j("input", select).each(function() {
        var self = $j(this),
            param = self.attr("tcParamName");
        if (param && self.is(":checked")) {
          result = addParameter(result, param, self.val());
        }
      });
      return result;
    }

    function addParameter(url, paramName, paramValue) {
      var separatorSymbol = "";
      if (url[url.length - 1] != "?") {
        if (url.indexOf("?") == -1) {
          separatorSymbol = "?";
        } else {
          separatorSymbol = "&";
        }
      }
      return url + separatorSymbol + paramName + "=" + paramValue;
    }

    function showOrHide(selector, value) {
      if (value) {
        selector.show();
      } else {
        selector.hide();
      }
    }

    function updateControls() {
      showOrHide($j("#buildTypes_externalStatus").add($j("#buildTypes_externalStatus_filter").parent()),
                 $j("#externalStatus_buildTypes_check").prop("checked"));
      showOrHide($j("#buildTypes_availableToGuest").add($j("#buildTypes_availableToGuest_filter").parent()),
                 $j("#availableToGuest_buildTypes_check").prop("checked"));
      showOrHide($j("#buildTypes_all").add($j("#buildTypes_all_filter").parent()), $j("#all_buildTypes_check").prop("checked"));

      var buildStatusChooserEnabled = !$("item_builds").checked;
      $("item_allStatuses").disabled = buildStatusChooserEnabled;
      $("item_successful").disabled = buildStatusChooserEnabled;
      $("item_failed").disabled = buildStatusChooserEnabled;

      if ($("all_buildTypes_check").checked) {
        $("useCredentials").disabled = false;
      } else {
        $("useCredentials").disabled = true;
        $("useCredentials").checked = false;
      }

      $("feed_username").disabled = !$("useCredentials").checked;
      $("feed_password").disabled = !$("useCredentials").checked;
    }

    </script>
    <div id="container">
    <table class="runnerFormTable">
    <l:settingsGroup title="Select Build Configurations">
      <tr>
        <th>List build configurations:</th>
        <td>
          <input type="radio" name="filterBuildTypesGroup" id="externalStatus_buildTypes_check" checked="checked"
                 onclick="updateControls(); updateFeedURL();"/>
          <label for="externalStatus_buildTypes_check">With the external status enabled</label><bs:help file="Configuring+General+Settings" anchor="EnableStatusWidget"/><br/>
          <c:if test="${feed_guestLoginEnabled}">
            <input type="radio" name="filterBuildTypesGroup" id="availableToGuest_buildTypes_check"
                   onclick="updateControls(); updateFeedURL();" <c:if test="${fn:length(feed_buildTypesAvailableToGuest) == 0}">disabled="disabled" </c:if> />
            <label for="availableToGuest_buildTypes_check">Available to the Guest user</label><br/>
          </c:if>
          <input type="radio" name="filterBuildTypesGroup" id="all_buildTypes_check" onclick="updateControls(); updateFeedURL();"/>
          <label for="all_buildTypes_check">All (HTTP basic authorization is needed to view the feed)</label><br/>
        </td>
      </tr>

      <tr>
        <th>Select build configurations or projects:</th>
        <td>
          <bs:inplaceFilter containerId="buildTypes_externalStatus" activate="false" filterText="&lt;filter projects or build configurations>" style="width: 400px;"
                            afterApplyFunc="function(filterField) {BS.MultiSelect.update('#buildTypes_externalStatus', filterField);}"/>
          <div id="buildTypes_externalStatus" class="multi-select" style="width: 400px; height: 20em;">
            <c:forEach items="${feed_buildTypesWithExternalStatus}" var="bean">
              <c:set var="project" value="${bean.project}"/>
              <div class="inplaceFiltered user-depth-${bean.limitedDepth} group" data-depth="${bean.limitedDepth}">
                <label>
                  <input type="checkbox" class="group" name="buildTypes_externalStatus" value="${bean.project.externalId}">
                  <c:out value="${project.name}"/> <c:if test="${project.archived}">(archived)</c:if>
                </label>
              </div>
              <c:forEach var="buildType" items="${bean.buildTypes}"
                  ><div class="inplaceFiltered user-depth-${bean.limitedDepth + 1}" data-title="<c:out value="${buildType.fullName}"/>" data-depth="${bean.limitedDepth + 1}">
                <label>
                  <input type="checkbox" name="buildTypes_externalStatus" value="${buildType.externalId}" tcParamName="${buildTypeIdUrlPramName}">
                  <c:out value="${buildType.name}"/>
                </label>
              </div>
              </c:forEach>
            </c:forEach>
          </div>
          <script>
            BS.MultiSelect.init("#buildTypes_externalStatus", function() {updateFeedURL();});
          </script>

          <c:if test="${feed_guestLoginEnabled}">
            <bs:inplaceFilter containerId="buildTypes_availableToGuest" activate="false" filterText="&lt;filter projects or build configurations>" style="display: none; width: 400px;"
                              afterApplyFunc="function(filterField) {BS.MultiSelect.update('#buildTypes_availableToGuest', filterField);}"/>
            <div id="buildTypes_availableToGuest" class="multi-select" style="display: none; width: 400px; height: 20em;">
              <c:forEach items="${feed_buildTypesAvailableToGuest}" var="bean">
                <c:set var="project" value="${bean.project}"/>
                <div class="inplaceFiltered user-depth-${bean.limitedDepth} group" data-depth="${bean.limitedDepth}">
                  <label>
                    <input type="checkbox" class="group" name="buildTypes_availableToGuest" value="${bean.project.externalId}">
                    <c:out value="${project.name}"/> <c:if test="${project.archived}">(archived)</c:if>
                  </label>
                </div>
                <c:forEach var="buildType" items="${bean.buildTypes}">
                  <div class="inplaceFiltered user-depth-${bean.limitedDepth + 1}" data-title="<c:out value="${buildType.fullName}"/>" data-depth="${bean.limitedDepth + 1}">
                    <label>
                      <input type="checkbox" name="buildTypes_availableToGuest" value="${buildType.externalId}" tcParamName="${buildTypeIdUrlPramName}">
                      <c:out value="${buildType.name}"/>
                    </label>
                  </div>
                </c:forEach>
              </c:forEach>
            </div>
            <script>
              BS.MultiSelect.init("#buildTypes_availableToGuest", function() {updateFeedURL();});
            </script>
          </c:if>

          <bs:inplaceFilter containerId="buildTypes_all" activate="false" filterText="&lt;filter projects or build configurations>" style="display: none; width: 400px;"
                            afterApplyFunc="function(filterField) {BS.MultiSelect.update('#buildTypes_all', filterField);}"/>
          <div id="buildTypes_all" class="multi-select" style="display: none; width: 400px; height: 20em;">
            <c:forEach items="${feed_buildTypesAll}" var="bean">
              <c:set var="project" value="${bean.project}"/>
              <div class="inplaceFiltered user-depth-${bean.limitedDepth} group" data-depth="${bean.limitedDepth}">
                <label>
                  <input type="checkbox" class="group" name="buildTypes_all" value="${bean.project.externalId}">
                  <c:out value="${project.name}"/> <c:if test="${project.archived}">(archived)</c:if>
                </label>
              </div>
              <c:forEach var="buildType" items="${bean.buildTypes}">
                <div class="inplaceFiltered user-depth-${bean.limitedDepth + 1}" data-title="<c:out value="${buildType.fullName}"/>" data-depth="${bean.limitedDepth + 1}">
                  <label>
                    <input type="checkbox" name="buildTypes_all" value="${buildType.externalId}" tcParamName="${buildTypeIdUrlPramName}">
                    <c:out value="${buildType.name}"/>
                  </label>
                </div>
              </c:forEach>
            </c:forEach>
          </div>
          <script>
            BS.MultiSelect.init("#buildTypes_all", function() {updateFeedURL();});
          </script>

          <span class="smallNote">If external status for the build configuration is not enabled, the feed will be available only for authorized users.</span>
        </td>
      </tr>
    </l:settingsGroup>

    <l:settingsGroup title="Feed Entries Selection">
      <tr>
        <th>Generate feed items for:</th>
        <td>
          <forms:checkbox name="feedItemTypeSelector" id="item_builds" checked="true" onclick="updateControls(); updateFeedURL();"/>
          <label for="item_builds">Builds (default)</label><br/>
          <forms:checkbox name="feedItemTypeSelector" id="item_changes" onclick="updateFeedURL()"/>
          <label for="item_changes">Changes</label><br/>
        </td>
      </tr>

      <tr>
        <th>Include builds:</th>
        <td>
          <input type="radio" name="buildStatusSelector" id="item_allStatuses" checked="checked" onclick="updateFeedURL()">
          <label for="item_allStatuses">All (default)</label><br/>
          <input type="radio" name="buildStatusSelector" id="item_successful" onclick="updateFeedURL()">
          <label for="item_successful">Only successful</label><br/>
          <input type="radio" name="buildStatusSelector" id="item_failed" onclick="updateFeedURL()">
          <label for="item_failed">Only failed</label><br/>
        </td>
      </tr>

      <tr>
        <th>Only builds with changes of the user:</th>
        <td>
          <select id="committer" style="width:20em;" onchange="updateFeedURL();">
            <option value="tc_all_" onclick="updateFeedURL();">All users</option>
            <c:if test="${not empty feed_currentUser}"><option value="<c:out value='${feed_currentUser.username}'/>" onclick="updateFeedURL();">Myself</option></c:if>
            <c:forEach items="${feed_sortedUsers}" var="user">
              <option value="<c:out value='${user.username}'/>" onclick="updateFeedURL();"><c:out value="${user.descriptiveName}"/></option>
            </c:forEach>
          </select>
        </td>
      </tr>
    </l:settingsGroup>
    <l:settingsGroup title="Other Settings">
      <tr>
        <th>Feed Authentication Settings:</th>
        <td>
          <forms:checkbox name="" id="useCredentials" onclick="updateControls();updateFeedURL();"/>
          <label for="useCredentials">Include credentials for HTTP Authentication</label><br/>
          <table>
            <tr>
              <td>
                <label for="feed_username">TeamCity user:</label>
              </td>
              <td>
                <select id="feed_username" onchange="updateFeedURL();" disabled="disabled" style="width:20em;">
                  <c:forEach items="${feed_sortedUsers}" var="user">
                    <option value="<c:out value='${user.username}'/>"><c:out value="${user.descriptiveName}"/></option>
                  </c:forEach>
                </select>
              </td>
            </tr>
            <tr>
              <td class="noBorder">
                <label for="feed_password">User password:</label>
              </td>
              <td class="noBorder">
                <input type="password" id="feed_password" onchange="updateFeedURL();" disabled="disabled" style="width:20em;"/> Note: will
                be passed in clear
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </l:settingsGroup>

      <l:settingsGroup title="Copy and Paste the URL into Your Feed Reader">
        <tr>
          <th class="noBorder">
          </th>
          <td class="noBorder">
            <input type="text" name="feedURL" id="feedURL" style="width:50em;" onfocus="this.select()" onclick="this.select()">

            <p>or <i class="icon-rss-sign"></i> <a id="feedLink" href="#">Subscribe</a></p>
          </td>
        </tr>
      </l:settingsGroup>
    </table>
    <div class="saveButtonsBlock">
      <forms:cancel cameFromSupport="${feed_cameFromSupport}" label="Done"/>
    </div>
    </div>

    <script type="text/javascript">
      updateControls();
      updateFeedURL();
    </script>

  </jsp:attribute>
</bs:page>
