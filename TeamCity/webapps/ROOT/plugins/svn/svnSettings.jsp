<%@include file="/include.jsp"%>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>

<style type="text/css">
  table.shortLabelingHelp td {
    padding: 5px;
    border: 1px solid #CCCCCC;
  }
  table.shortLabelingHelp td:first-child {
    text-align: right;
  }

  .uploadKeyBlock {
    display: inline-block;
    vertical-align: top;
    margin-bottom: 10px;
  }
</style>

<table class="runnerFormTable">
  <l:settingsGroup title="SVN Connection Settings">
    <tr>
      <th><label for="url">URL: <l:star/></label></th>
      <td><props:textProperty name="url" className="longField"/>
        <span class="error" id="error_url"></span></td>
    </tr>
    <tr>
      <th><label for="user">Username:</label></th>
      <td><props:textProperty name="user" className="longField"/><br>
        <bs:smallNote>The username specified here overrides the username from the URL.</bs:smallNote>
        <span class="error" id="error_user"></span></td>
    </tr>
    <tr>
      <th><label for="secure:svn-password">Password:</label></th>
      <td><props:passwordProperty name="secure:svn-password" className="longField"/>
        <span class="error" id="error_secure:svn-password"></span></td>
    </tr>

    <tr class="advancedSetting">
      <th><label for="svn-config-directory">Configuration directory:</label></th>
      <td><props:textProperty name="svn-config-directory" className="longField" disabled="${propertiesBean.properties['svn-use-default-config-directory'] == 'true'}"/>
        <span class="error" id="error_svn-config-directory"></span>

        <props:checkboxProperty name="svn-use-default-config-directory" onclick="$('svn-config-directory').disabled = this.checked ? 'disabled' : ''" style="margin-top:10px"/>
        <label for="svn-use-default-config-directory">Use default configuration directory</label>
      </td>
    </tr>
    <tr class="advancedSetting">
      <th><label for="externals-full">Externals support:</label></th>
      <td>
        <props:radioButtonProperty name="externals-mode" value="externals-full" id="externals-full"
                                   checked="${propertiesBean.properties['externals-mode'] == 'externals-full'}"

            /><label for="externals-full">Full support (load changes and checkout)</label>
        <br/>
        <props:radioButtonProperty name="externals-mode" value="externals-checkout" id="externals-checkout"
                                   checked="${propertiesBean.properties['externals-mode'] == 'externals-checkout'}"

            /><label for="externals-checkout">Checkout, but ignore changes</label>
        <br>
        <props:radioButtonProperty name="externals-mode" value="externals-none" id="externals-none"
                                   checked="${propertiesBean.properties['externals-mode'] == 'externals-none'}"

            /><label for="externals-none">Ignore externals</label>
      </td>
    </tr>

    <tr class="advancedSetting">
      <th><label for="enable-unsafe-ssl">HTTPS connections:</label></th>
      <td><props:checkboxProperty name="enable-unsafe-ssl"/> <label for="enable-unsafe-ssl">Accept non-trusted SSL certificates</label>
        <span class="error" id="error_enable-unsafe-ssl"></span></td>
    </tr>

  </l:settingsGroup>

  <l:settingsGroup title="SSH Settings" className="advancedSetting">
    <tr class="advancedSetting">
      <th><label for="ssh-key-file">Private key:</label></th>
      <td>
        <c:if test="${not empty vcsPropertiesBean.belongsToProject}">
          <c:set var="projectId" value="${vcsPropertiesBean.belongsToProject.externalId}" scope="request"/>
        </c:if>

        <input type="radio" name="ssh-file-type" value="teamcitySshKey"  id="ssh-file-type-teamcitySshKey">
        <label for="ssh-file-type-teamcitySshKey">Uploaded key:</label>
        <span class="uploadKeyBlock">
            <admin:sshKeys projectId="${projectId}" keySelectionCallback="(function(){})"/>
            <c:if test="${not empty vcsPropertiesBean.belongsToProject}">
              <c:url var="sshKeysUrl" value="/admin/editProject.html?projectId=${vcsPropertiesBean.belongsToProject.externalId}&tab=ssh-manager"/>
              / <a href="${sshKeysUrl}" target="_blank">Edit keys</a>
            </c:if>
            <span class="error" id="error_teamcitySshKey"></span>
        </span>

        <br>
        <input type="radio" name="ssh-file-type" value="path" id="ssh-file-type-path">
        <label for="ssh-file-type-path">File path on TeamCity server:</label> <props:textProperty name="ssh-key-file" className="mediumField"/><br>
        <span class="error" id="error_ssh-key-file"></span>
      </td>
    </tr>
    <tr class="advancedSetting">
      <th><label for="secure:ssh-passphrase">Private key password:</label></th>
      <td><props:passwordProperty name="secure:ssh-passphrase" className="longField"/>
        <span class="error" id="error_secure:ssh-passphrase"></span></td>
    </tr>
    <tr class="advancedSetting">
      <th class="noBorder"><label for="ssh-port">SSH port:</label></th>
      <td class="noBorder">
        <props:textProperty name="ssh-port" maxlength="40" className="mediumField"/>
        <span class="error" id="error_ssh-port"></span>
      </td>
    </tr>
  </l:settingsGroup>

  <c:set var="helpDetails"><bs:help file="VCS+Checkout+Mode"
                                    shortHelp="These settings are used when sources are obtained using <em>Automatically on agent</em> mode."/></c:set>
  <l:settingsGroup title="Checkout on Agent Settings ${helpDetails}" className="advancedSetting">
    <tr class="advancedSetting">
      <th><label for="working-copy-format">Working copy format:</label></th>
      <td>
        <props:selectProperty name="working-copy-format" enableFilter="true" className="mediumField">
          <props:option value="1.8">1.8 (default)</props:option>
          <props:option value="1.7">1.7</props:option>
          <props:option value="1.6">1.6</props:option>
          <props:option value="1.5">1.5</props:option>
          <props:option value="1.4">1.4</props:option>
        </props:selectProperty>
      </td>
    </tr>
    <tr class="advancedSetting">
      <th><label for="enforce-revert">Revert before update:</label></th>
      <td><props:checkboxProperty name="enforce-revert"/>
        <label for="enforce-revert">If selected, TeamCity will always run <em> svn revert</em> before updating sources</label>
      </td>
    </tr>
  </l:settingsGroup>

  <l:settingsGroup title="Labeling Settings" className="advancedSetting">
    <tr class="advancedSetting">
      <th><label for="labelingPatterns">Labeling rules</label></th>
      <td><props:multilineProperty name="labelingPatterns" cols="58" rows="6" linkTitle="Edit labeling rules" expanded="true"
                                   className="longField"/>

        <c:set var="shortLabelingHelp">
          Rules are separated by a newline. Each rule has the form <strong>trunkPath=>tagDirectoryPath</strong>.
          <p>
            There are two ways to specify a rule:
          <ol>
            <li>Generic way: both parts should be relative to <strong>SVN repository root</strong> and should start with <strong>/</strong></li>
            <li>Relative to VCS root: both parts should be relative to <strong>VCS root</strong> and should <strong>not</strong> start with <strong>/</strong></li>
          </ol>
          <strong>Example</strong>
          <table class="shortLabelingHelp">
            <tr>
              <td>Repository root:</td>
              <td>svn://server.com/path/repository</td>
            </tr>
            <tr>
              <td>VCS root:</td>
              <td>svn://server.com/path/repository/projects/projectFoo</td>
            </tr>
            <tr>
              <td>Trunk directory:</td>
              <td>svn://server.com/path/repository/projects/projectFoo/trunk</td>
            </tr>
            <tr>
              <td>Tags directory:</td>
              <td>svn://server.com/path/repository/projects/projectFoo/tags</td>
            </tr>
            <tr>
              <td><strong>Generic labeling rule:</strong></td>
              <td><strong>/projects/projectFoo/trunk=>/projects/projectFoo/tags</strong></td>
            </tr>
            <tr>
              <td><strong>The same, but relative to VCS root:</strong></td>
              <td><strong>trunk=>tags</strong></td>
            </tr>
          </table>
        </c:set>
        <bs:helpPopup linkText="What is the syntax of the rules?" helpFile="VCS+Labeling" helpFileAnchor="SubversionLabelingRules">
          <jsp:attribute name="helpContent">${shortLabelingHelp}</jsp:attribute>
        </bs:helpPopup>
      </td>
    </tr>
    <tr class="advancedSetting">
      <th><label for="labelingMessage">Labeling message</label></th>
      <td>
        <props:textProperty name="labelingMessage" className="longField" expandable="true"/>
        <span class="error" id="error_labelingMessage"></span>
      </td>
    </tr>
  </l:settingsGroup>
</table>


<script>
  (function initializeSvnFormState($) {
    // Setup handlers:
    $('#ssh-file-type-path').on('click', function() {
      $('#teamcitySshKey')[0].disabled = true;
      $('#teamcitySshKey')[0].selectedIndex = 0;

      $('#ssh-key-file')[0].disabled = false;
      $('#ssh-key-file').focus();
    });
    $('#ssh-file-type-teamcitySshKey').on('click', function() {
      $('#ssh-key-file')[0].disabled = true;
      $('#teamcitySshKey')[0].disabled = false;
    });

    // Select default option:
    if ($('#teamcitySshKey')[0].selectedIndex > 0 || $('#ssh-key-file').val().blank()) {
      $('#ssh-file-type-teamcitySshKey').click();
    }
    else {
      $('#ssh-file-type-path').click()
    }
  })(jQuery);
</script>
