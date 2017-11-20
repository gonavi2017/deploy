<%@ page import="jetbrains.buildServer.maintenance.CurrentNodeInfo" %>
<%@include file="/include-internal.jsp"%>
<jsp:useBean id="assignedBuildsStatsMap" type="java.util.Map" scope="request"/>
<jsp:useBean id="totalRunning" type="java.lang.Integer" scope="request"/>
<jsp:useBean id="teamcityNodes" type="java.util.List" scope="request"/>
<c:set var="messagesNodeName" value="<%=CurrentNodeInfo.ServerMode.MESSAGES_PROCESSOR.getDisplayName().toLowerCase()%>"/>
<jsp:useBean id="currentUser" type="jetbrains.buildServer.users.SUser" scope="request"/>

<bs:linkCSS>
  /css/forms.css
</bs:linkCSS>
<script type="text/javascript">
BS.ClusterAdmin = {
  url: window['base_uri'] + "/admin/action.html",

  setNodeEnabled: function(elem, nodeUrl, enabled) {
    if (enabled) {
      if (!confirm('After enabling the ${messagesNodeName}, the data from all of the newly started builds will be sent to this node. ' +
                   'The builds that are already running will continue using the main TeamCity server until their finish.\n' +
                   '\nPlease confirm enabling of this node.')) return false;
    }

    if (!enabled) {
      if (!confirm('After disabling the ${messagesNodeName}, the data from all of the newly started builds will be sent to the main TeamCity server. ' +
                   'The builds that are already running will continue using the ${messagesNodeName} until their finish.\n' +
                   '\nPlease confirm disabling of this node.')) return false;
    }

    $j("span.error").text('');
    $j(elem).hide();
    $j('#changeStatusProgress').show();
    BS.ajaxRequest(this.url, {
      parameters: '&nodeUrl=' + nodeUrl + "&actionName=" + (enabled ? 'enableNode' : 'disableNode'),
      onComplete: function (transport) {
        $j('#changeStatusProgress').hide();
        $j(elem).show();
        var errors = BS.XMLResponse.processErrors(transport.responseXML, {
          toggleNodeStatusFailed: function(elem) {
            $j("span.error").text(elem.firstChild.nodeValue);
          },

          nodeTestConnectionFailed: function(elem) {
            $j("span.error").text("Could not verify connection to the ${messagesNodeName} using URL: " + nodeUrl + "\n" +
                                  elem.firstChild.nodeValue +
                                  "\nPlease check that ${messagesNodeName} URL is correct.");
          }
        });

        if (!errors) {
          BS.reload(true);
        }
      }
    });
  }
};
</script>
<style type="text/css">
  table.nodeInfo {
    width: 100%;
    border: 0;
  }

  table.nodeInfo td {
    padding-bottom: 1em;
  }

  div.diagnosticDetails {
    margin-top: 0.5em;
    width: 100%;
  }

  table.nodeDiagnosticInfo {
    width: 100%;
  }

  table.nodeDiagnosticInfo tr td {
    padding: 2px;
  }

  .nodeDiagnosticInfo tr, .nodeDiagnosticInfo tr td {
    border: none;
  }

  table.settings td {
    vertical-align: top;
  }

  table.settings th.name.nodeUrl {
    width: 25em;
    white-space: nowrap;
  }

  table.settings th.name.buildNum {
    width: 13em;
  }

  table.settings th.name.startTime {
    width: 15em;
  }

  table.settings th.name.enableDisable, table.settings td.enableDisable {
    border-right: none;
    width: 1em;
  }

  .tc-icon_switch {
    margin: auto;
  }

  span.error {
    white-space: pre-wrap;
    margin-left: 0;
  }

  span.smallNote {
    margin-left: 0;
  }

  .projectsPopupConfig {
    margin-bottom: 3em;
  }

  h2 {
    border-bottom: none;
  }
</style>

<bs:linkScript>
  /js/bs/blocks.js
  /js/bs/blocksWithHeader.js
  /js/bs/jvmStatusForm.js
  /js/bs/chart.js
  /js/flot/jquery.flot.js
  /js/flot/excanvas.min.js
  /js/flot/jquery.flot.selection.min.js
  /js/flot/jquery.flot.time.min.js
</bs:linkScript>

<div>
  <bs:webComponentsSettings/>
  <c:if test="${!restSelectorsDisabled}">
  <div class="projectsPopupConfig">
    <h2>Cross-Server Projects Popup</h2>
    <!--[if lte IE 9]>
    <div class="tc-icon_before icon16 attentionComment">Cross-Server Projects Popup is not supported in this version of your browser. Try upgrading to the latest stable version.</div>
    <![endif]-->
    <!--[if (gt IE 9)|(!IE)]> -->
    <span class="smallNote">Configure TeamCity servers to be shown in cross-server projects popup.<bs:help file="Configuring+Cross-Server+Projects+Popup"/></span>
    <div id="linkedServers"><span class="commentText">Loading...</span></div>
    <div id="corsHelpLink" style="display: none;"><bs:help file="REST+API" anchor="CORSSupport"/></div>
    <script type="text/javascript">
      function installTeamcityServerListEditComponent(){
        var isRegistered = document.createElement("teamcity-server-list-edit").constructor != HTMLElement;
        if (isRegistered && BS.RestProjectsPopup.serversLoadingFinished){
          var editList = document.createElement("teamcity-server-list-edit");
          editList.updateUrl = base_uri + "/app/rest/federation/servers";
          editList.savedServers =  BS.RestProjectsPopup.federationServers.slice();
          $j('#linkedServers').html('');
          $j('#linkedServers').append(editList);
        } else {
          window.setTimeout(installTeamcityServerListEditComponent, 100);
        }
      }
      installTeamcityServerListEditComponent();
    </script>
    <!-- <![endif]-->
  </div>
  </c:if>

  <c:if test="${not empty teamcityNodes}">

  <h2>Running Builds Node</h2>
  <c:set var="main_server_mode" value="<%=CurrentNodeInfo.ServerMode.MAIN_SERVER%>"/>
  <c:set var="agent_messages_mode" value="<%=CurrentNodeInfo.ServerMode.MESSAGES_PROCESSOR%>"/>

  <span class="smallNote">
    ${agent_messages_mode.displayName} processes data coming from all of the running builds: build logs, artifacts, tests, statistic values, inspections results, etc.
    <bs:help file="Configuring+Running+Builds+Node"/>
  </span>

  <span class="error"></span>

  <bs:refreshable containerId="nodesData" pageUrl="${pageUrl}">
  <table class="settings runnerFormTable">
  <tr>
    <th class="name enableDisable"></th>
    <th class="name nodeUrl">URL</th>
    <th class="name">Description</th>
    <th class="name startTime">Start Time</th>
    <th class="name buildNum">Running Builds Num.</th>
    <th class="name">Diagnostics</th>
  </tr>
  <c:forEach items="${teamcityNodes}" var="n">
    <c:set var="startTime">N/A (offline)</c:set>
    <c:set var="mode" value="${agent_messages_mode}"/>
    <c:if test="${n.online}">
      <c:set var="startTime"><bs:date value="${n.startTime}"/> (online)</c:set>
      <c:set var="mode" value="${n.mode}"/>
    </c:if>
    <tr>
      <td class="enableDisable">
        <c:if test="${mode eq agent_messages_mode}">
          <c:choose>
            <c:when test="${n.enabled}">
              <c:set var="onClick">BS.ClusterAdmin.setNodeEnabled(this, '<bs:escapeForJs text="${n.url}"/>', false)</c:set>
              <c:set var="statusCss">icon icon16 tc-icon_switch tc-icon_switch_enabled</c:set>
            </c:when>
            <c:otherwise>
              <c:set var="onClick">BS.ClusterAdmin.setNodeEnabled(this, '<bs:escapeForJs text="${n.url}"/>', true)</c:set>
              <c:set var="statusCss">icon icon16 tc-icon_switch tc-icon_switch_disabled</c:set>
            </c:otherwise>
          </c:choose>
          <span href="#" onclick="${onClick}; event.stopPropagation();" class="${statusCss}" title="${n.enabled ? 'This node is enabled. Click to disable this node.' : 'This node is disabled. Click to enable this node.'}"></span>
          <forms:saving id="changeStatusProgress" style="margin-left: 6px"/>
        </c:if>
      </td>
      <td>
        <a href="${n.url}" target="_blank" onclick="event.stopPropagation();" class="nodeUrl"><c:out value="${n.url}"/></a>
      </td>
      <td>
        <c:out value="${mode.displayName}"/> <c:if test="${n.description ne 'N/A' and fn:length(n.description) ge 0}">(<c:out value="${n.description}"/>)</c:if>
      </td>
      <td>
        ${startTime}
      </td>
      <td>
        <c:set var="buildsNum" value="${assignedBuildsStatsMap.get(n.url)}"/>
        <c:if test="${empty buildsNum}">
          N/A
        </c:if>
        <c:if test="${not empty buildsNum}">
          ${buildsNum} of ${totalRunning}
        </c:if>
      </td>
      <td>
        <c:url var="diagUrl" value="/admin/admin.html?item=diagnostics&init=1"/>
        <a href="${diagUrl}">View diagnostics&nbsp;&raquo;</a>
      </td>
    </tr>
  </c:forEach>
  </table>
  </bs:refreshable>
  </c:if>
</div>
