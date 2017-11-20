<%@ include file="/include.jsp"%>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>

<script type="text/javascript">
  // A Jira specific feature: allows to prefill all available projects in a text field.
  // Details: we send several values to the TeamCity to get the required data (server host, encrypted
  // credentials and the public key). TeamCity performs the action and returns the list of projects
  // in a XML file.
  (function() {
    BS.JIRA = {};
    BS.JIRA.init = function() {
      BS.JIRA.validateUsername();
      BS.JIRA.toggleAutoSync();
    };
    BS.JIRA.getJiraProjects = function() {
      var host = $('host').value;
      if (!host) {
        alert('Please, set the "host" property (and optionally credentials)');
        return;
      }
      var user = $('username').value;
      var publicKey = $('publicKey').value;
      var pass = $('secure:password').value;
      var encryptedPass;
      if ($('prop:encrypted:secure:password').value != '') {
        encryptedPass = $('prop:encrypted:secure:password').value;
      } else {
        encryptedPass = BS.Encrypt.encryptData(pass, publicKey);
      }
      $('error_idPrefix').innerHTML = '';
      $('error_host').innerHTML = '';
      BS.Util.show('getProjectsProgress');

      var url = window['base_uri'] + "/admin/jira/getProjects.html";
      BS.ajaxRequest(
          url,
          {
            method: "post",
            parameters: "username=" + user +
                        "&encryptedPassword=" + encryptedPass +
                        "&publicKey=" + publicKey +
                        "&host=" + encodeURIComponent(host),
            onComplete: function (transport) {
              var errors = BS.XMLResponse.processErrors(transport.responseXML, {}, BS.PluginPropertiesForm.propertiesErrorsHandler);
              if (!errors) {
                var prefixField = $('idPrefix');
                prefixField.value = '';
                var child = transport.responseXML.firstChild.firstChild;
                while (child) {
                  if (prefixField.value.length > 0) {
                    prefixField.value += ' ';
                  }
                  prefixField.value += child.attributes.getNamedItem('key').value;
                  child = child.nextSibling;
                }
              }
              BS.Util.hide('getProjectsProgress');
            }
          }
      );
    };

    BS.JIRA.validateUsername = function() {
      var user = $('username').value;
      if (user.indexOf("@") != -1) {
        BS.Util.show('userNote');
      } else {
        BS.Util.hide('userNote');
      }
    };

    BS.JIRA.toggleAutoSync = function() {
      var checked = $('autoSync').checked;
      if (checked) {
        BS.Util.hide('getAllProjects');
      } else {
        BS.Util.show('getAllProjects');
      }
      $j('#idPrefix').prop('disabled', checked);
    }
  })();
</script>

<div>
  <table class="editProviderTable">
    <%--@elvariable id="showType" type="java.lang.Boolean"--%>
    <c:if test="${showType}">
      <tr>
        <th><label class="shortLabel">Connection Type:</label></th>
        <td>JIRA</td>
      </tr>
    </c:if>
    <tr>
      <th><label for="name" class="shortLabel">Display Name: <l:star/></label></th>
      <td>
        <props:textProperty name="name" maxlength="100"/>
        <span id="error_name" class="error"></span>
      </td>
    </tr>
    <tr>
      <th><label for="host" class="shortLabel">Server URL: <l:star/></label></th>
      <td>
        <props:textProperty name="host" maxlength="100"/>
        <span id="error_host" class="error"></span>
      </td>
    </tr>
    <tr>
      <th><label for="username" class="shortLabel">Username:</label></th>
      <td>
        <props:textProperty name="username" maxlength="100" onkeyup="BS.JIRA.validateUsername();"/>
        <span id="error_username" class="error"></span>
        <p>
          <style> #userNote { width:20em; } </style>
          <forms:attentionComment id="userNote">
            Please provide username, not an email address. Username can be found in the user profile.
          </forms:attentionComment>
        </p>
      </td>
    </tr>
    <tr>
      <th><label for="secure:password" class="shortLabel">Password:</label></th>
      <td>
        <props:passwordProperty name="secure:password" maxlength="100"/>
        <span id="error_secure:password" class="error"></span>
      </td>
    </tr>
    <tr>
      <th><label for="idPrefix" class="shortLabel">Project Keys: <l:star/></label></th>
      <td>
        <jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
        <props:textProperty name="idPrefix" expandable="true"
                            value="${propertiesBean.properties['idPrefix']}"
                            disabled="${propertiesBean.properties['autoSync']}"/>
        <span class="fieldExplanation">
          Space-separated list of Project keys.
          <a id="getAllProjects" href="#" style="white-space: nowrap;"
             title="Recognize all Jira projects"
             onclick="BS.JIRA.getJiraProjects(); return false">Get all projects</a>
          <forms:saving id="getProjectsProgress" className="progressRingInline"/>
        </span>
        <span id="error_idPrefix" class="error"></span>
        <div>
          <label for="autoSync">
            <forms:checkbox name="prop:autoSync" id="autoSync"
                            checked="${propertiesBean.properties['autoSync']}"
                            onclick="BS.JIRA.toggleAutoSync();"/>
            Use all JIRA projects automatically
          </label>
        </div>
      </td>
    </tr>
  </table>
</div>

<script type="text/javascript">
  BS.JIRA.init();
</script>
