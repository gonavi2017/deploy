<%@ page import="jetbrains.buildServer.vcs.perforce.PerforceConstants" %>
<%@include file="/include.jsp"%>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="intprop" uri="/WEB-INF/functions/intprop"%>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<c:set var="dagProp" value="<%= PerforceConstants.ENABLE_DAG%>"/>
<c:set var="withDAG" value="${intprop:getBooleanOrTrue(dagProp)}"/>

<table class="runnerFormTable">
  <l:settingsGroup title="P4 Connection Settings">
    <tr>
      <th><label for="port">Port: <l:star/></label></th>
      <td><props:textProperty name="port" className="longField" maxlength="128"/>
        <span class="error" id="error_port"></span>
        <span class="smallNote">The format is host:port. On a build agent can be overridden with TEAMCITY_P4PORT environment variable.</span>
      </td>
    </tr>

    <tr>
      <c:set var="toFocus" value=".stream"/>
      <c:set var="myValue" value="stream"/>
      <c:set var="myTitle" value="Stream"/>
      <c:set var="myHelpAnchor" value="perforceStreamOptionDescription"/>
      <%@ include file="useClientRadioButton.jspf" %>

      <td><props:textProperty name="stream" className="longField stream"  disabled="${propertiesBean.properties['use-client'] != 'stream'}"/>
      <span class="error" id="error_stream"></span>
      <span class="smallNote">The format is //streamdepot/streamname. <br>
        For StreamAtChange option you can use the field <em>Label/changelist to sync</em>, below.</span>

        <c:if test="${withDAG}">
          <div class="js-branchSpec">
            <c:set var="rootDagProp" value="<%= PerforceConstants.USE_DAG_FOR_STREAMS%>"/>
            <props:checkboxProperty name="${rootDagProp}" onclick="p4.toggleBranchSpec(this.form);"/>
            <label for="${rootDagProp}" class="labelAfterControl">Enable feature branches support (experimental)</label>

            <div class="js-branchSpecTextarea" style="display: ${ propertiesBean.properties[rootDagProp] == 'true' ? 'block':'none'}">
              <bs:branchSpecProperty/>
            </div>
          </div>
        </c:if>
      </td>
    </tr>

    <tr>
      <c:set var="toFocus" value="#client"/>
      <c:set var="myValue" value="true"/>
      <c:set var="myTitle" value="Client"/>
      <c:set var="myHelpAnchor" value="perforceClientOptionDescription"/>
      <%@ include file="useClientRadioButton.jspf" %>

      <td><props:textProperty name="client" className="longField"  disabled="${propertiesBean.properties['use-client'] != 'true'}"/>
      <span class="error" id="error_client"></span></td>
    </tr>

    <tr>
      <c:set var="toFocus" value="#client-mapping"/>
      <c:set var="myValue" value="false"/>
      <c:set var="myTitle" value="Client mapping"/>
      <c:set var="myHelpAnchor" value="perforceClientMappingOptionDescription"/>
      <%@ include file="useClientRadioButton.jspf" %>

      <td><c:set var="note">Use "team-city-agent" instead of client name in the mapping. <bs:help file="Perforce" anchor="perforceClientMappingOptionDescription"/></c:set
          ><span><props:multilineProperty name="client-mapping" rows="4" cols="45" linkTitle="Enter the client mapping" className="longField"
                                         disabled="${propertiesBean.properties['use-client'] != false}" expanded="${propertiesBean.properties['use-client'] == false}" note="${note}"/></span>
      </td>
    </tr>

    <tr>
      <th><label for="user">Username:</label></th>
      <td><props:textProperty name="user" className="longField" />
      <span class="error" id="error_user"></span></td>
    </tr>

    <tr>
      <th><label for="secure:passwd">Password or ticket:</label></th>
      <td><props:passwordProperty name="secure:passwd" className="longField"/>
      <span class="error" id="error_secure:passwd"></span></td>
    </tr>

    <props:hiddenProperty name="use-login" />

  </l:settingsGroup>

  <l:settingsGroup title="Checkout On Agent Settings" className="advancedSetting">

    <tr class="advancedSetting">
      <th>
        <label for="prop:workspace-options">Workspace options:</label><bs:help file="Perforce" anchor="perforceWorkspaceOptions"/>
      </th>
      <td><props:textarea name="prop:workspace-options" textAreaName="prop:workspace-options" value="${propertiesBean.properties['workspace-options']}"
                          linkTitle="Enter Perforce workspace options" cols="70" rows="3" expanded="false" className="buildTypeParams longField"/>
        <bs:smallNote>
          Here you can set some settings for '<a href="http://www.perforce.com/perforce/doc.current/manuals/cmdref/p4_client.html#p4_client.form_fields" target="_blank">p4 client</a>'
          command, namely Host, Options, SubmitOptions, and LineEnd.
        </bs:smallNote>
      </td>
    </tr>

    <tr class="advancedSetting">
      <th><label for="use-p4-clean">Run 'p4 clean' for cleanup:</label></th>
      <td><props:checkboxProperty name="use-p4-clean"/> <label for="use-p4-clean" class="labelAfterControl">Cleans up your workspace from extra files before build (since p4 2014.1)</label>
      </td>
    </tr>
    <tr class="advancedSetting">
      <th><label for="use-sync-p">Skip the have list update:</label></th>
      <td><props:checkboxProperty name="use-sync-p"/> <label for="use-sync-p" class="labelAfterControl">Don't track files on the Perforce server on sync (always transfers all files to the agent,
        <a href="http://www.perforce.com/perforce/doc.current/manuals/cmdref/p4_sync.html" target="_blank">p4 sync -p</a>)</label>
      </td>
    </tr>
    <tr class="advancedSetting">
      <th><label for="extra-sync-options">Extra sync options:</label></th>
      <td><props:textProperty name="extra-sync-options" className="longField"/>
        <bs:smallNote>
          Specify extra 'p4 sync' options, like --parallel (<a href="http://www.perforce.com/perforce/doc.current/manuals/cmdref/p4_sync.html" target="_blank">p4 sync docs</a>)
        </bs:smallNote>
      </td>
    </tr>
  </l:settingsGroup>

  <l:settingsGroup title="Other Settings">

    <c:set var="customPathProp" value="<%= PerforceConstants.CUSTOM_P4_PATH%>"/>
    <c:choose>
      <c:when test="${fn:length(intprop:getProperty(customPathProp, '')) > 0}">
        <props:hiddenProperty name="p4-exe"/>
      </c:when>
      <c:otherwise>
        <tr>
          <th class="noBorder"><label for="p4-exe">Path to P4 executable:</label></th>
          <td class="noBorder"><props:textProperty name="p4-exe" className="longField" />
            <span class="error" id="error_p4-exe"></span></td>
        </tr>
      </c:otherwise>
    </c:choose>

    <tr class="advancedSetting">
      <th><label for="label-revision">Label/changelist to sync:</label><bs:help file="Perforce" anchor="perforceLabelToCheckout"/></th>
      <td><props:textProperty name="label-revision" className="longField"/>
        <span class="error" id="error_label-revision"></span>
        <span class="smallNote">Leave empty to sync the latest changelist.</span>
      </td>
    </tr>

    <tr class="advancedSetting">
      <th><label for="charset">Charset:</label></th>
      <td><props:selectProperty name="charset" enableFilter="true" className="longField">
      <props:option value="">&lt;not set&gt;</props:option>
      <props:option value="none">none</props:option>
      <props:option value="iso8859-1">iso8859-1</props:option>
      <props:option value="iso8859-15">iso8859-15</props:option>
      <props:option value="eucjp">eucjp</props:option>
      <props:option value="shiftjis">shiftjis</props:option>
      <props:option value="winansi">winansi</props:option>
      <props:option value="macosroman">macosroman</props:option>
      <props:option value="utf8">utf8</props:option>
      <props:option value="utf8-bom">utf8-bom</props:option>
    </props:selectProperty>
    <span class="error" id="error_charset"></span></td>
    </tr>

    <tr class="advancedSetting">
      <th><label for="detect-utf-16">Support UTF-16 encoding:</label></th>
      <td><props:checkboxProperty name="detect-utf-16"/>
      <label for="detect-utf-16" class="labelAfterControl">Enable support for files with UTF-16 encoding</label></td>
    </tr>
  </l:settingsGroup>
</table>


<script>

  window.p4 = (function($) {

    return {
      setWithBranches: function(withBranches) {
        $('.js-branchSpec')[withBranches ? 'show' : 'hide']();
      },

      /**
       * Toggle view of branch spec specification when feature branches section is already shown
       * @param form
       */
      toggleBranchSpec: function(form) {
        $(".js-branchSpecTextarea").slideToggle(100, function() {
          BS.MultilineProperties.updateVisible();

          var allBranches = '+:*';
          var specTextarea = form['teamcity:branchSpec'];
          // Enable monitoring of all branches by default
          if ($(specTextarea).is(":visible")) {
            if (specTextarea.value.trim() == '') {
              specTextarea.value = allBranches;
            }
          }
          else {
            if (specTextarea.value.trim() == allBranches) {
              specTextarea.value = '';
            }
          }
        });
      },


      useClient: function(selector) {
        $('.stream').prop('disabled', true);
        $('#client-mapping').prop('disabled', true);
        $('#client').prop('disabled', true);

        $(selector).prop('disabled', false);
        $(selector).first().focus();

        this.setWithBranches($(selector).hasClass('stream'));

        BS.VisibilityHandlers.updateVisibility('vcsRootProperties');

        // Fix https://youtrack.jetbrains.com/issue/TW-44332:
        BS.MultilineProperties.updateVisible();
      }
    }
  })(window.jQuery);

  p4.setWithBranches('${propertiesBean.properties['use-client']}' == 'stream');

</script>
