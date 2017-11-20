<%@ page import="jetbrains.buildServer.serverSide.TeamCityProperties" %>
<%@ page import="jetbrains.buildServer.buildTriggers.vcs.mercurial.Constants" %>
<%@ page import="jetbrains.buildServer.util.StringUtil" %>
<%@include file="/include.jsp"%>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%--
  ~ Copyright 2000-2014 JetBrains s.r.o.
  ~
  ~ Licensed under the Apache License, Version 2.0 (the "License");
  ~ you may not use this file except in compliance with the License.
  ~ You may obtain a copy of the License at
  ~
  ~ http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing, software
  ~ distributed under the License is distributed on an "AS IS" BASIS,
  ~ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  ~ See the License for the specific language governing permissions and
  ~ limitations under the License.
  --%>

<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<script type="text/javascript">
window.updateBranchName = function(repoPath) {
  if (repoPath.indexOf('#') != -1 && $('branchName').value == '') {
    $('branchName').value = repoPath.substring(repoPath.indexOf('#')+1);
  }
}
</script>
<c:set var="subreposGloballyDisabled" value="<%= !TeamCityProperties.getBooleanOrTrue(Constants.GLOBAL_DETECT_SUBREPO_CHANGES) %>"/>
<c:set var="showCustomClonePath" value="<%= TeamCityProperties.getBooleanOrTrue(Constants.CUSTOM_CLONE_PATH_ENABLED) &&
                                            (TeamCityProperties.getBoolean(Constants.SHOW_CUSTOM_CLONE_PATH)
                                            || !StringUtil.isEmpty(propertiesBean.getProperties().get(Constants.SERVER_CLONE_PATH_PROP))) %>"/>
<table class="runnerFormTable">

  <l:settingsGroup title="General Settings">
  <tr>
    <th><label for="repositoryPath">Pull changes from: <l:star/></label></th>
    <td><props:textProperty name="repositoryPath" className="longField" onchange="updateBranchName(this.value)"/>
      <jsp:include page="/admin/repositoryControls.html?projectId=${parentProject.externalId}&vcsType=hg"/>
      <span class="error" id="error_repositoryPath"></span></td>
  </tr>
  <tr>
    <th><label for="branchName">Default branch: </label></th>
    <td>
        <props:textProperty name="branchName" className="longField"/>
        <div class="smallNote" style="margin: 0;">The main branch to be monitored</div>
    </td>
  </tr>
  <bs:branchSpecTableRow/>
  <tr class="advancedSetting">
    <th><label for="reportTagRevisions">Use tags as branches:</label></th>
    <td>
      <props:checkboxProperty name="useTagsAsBranches"/>
      <label for="reportTagRevisions">If enabled tags can be used in branch specification</label>
    </td>
  </tr>
  <c:if test="${showCustomClonePath}">
    <tr class="advancedSetting">
      <th><label for="serverClonePath">Clone repository to: </label></th>
      <td><props:textProperty name="serverClonePath" className="longField"/>
        <div class="smallNote" style="margin: 0;">Provide path to a parent directory on TeamCity server where a cloned repository should be created (applicable to "Automatically on server" checkout mode only). Leave blank to use default path.</div>
      </td>
    </tr>
  </c:if>
  <tr class="advancedSetting">
    <th><label for="detectSubrepoChanges">Detect subrepo changes: </label></th>
      <td>
        <props:checkboxProperty name="detectSubrepoChanges"/>
        <c:if test="${subreposGloballyDisabled}">
          <div class="smallNote" style="margin: 0;">Currently <b>disabled</b> for the entire server with 'teamcity.hg.detectSubrepoChanges' internal property.</div>
        </c:if>
      </td>
    </tr>
  <tr class="advancedSetting">
    <th><label for="tagUsername">Username for tags/merge: </label></th>
    <td><props:textProperty name="tagUsername" className="longField"/>
      <div class="smallNote" style="margin: 0;">Format: User Name &lt;email&gt;</div>
    </td>
  </tr>
  <tr class="advancedSetting">
    <th><label for="uncompressedTransfer">Use uncompressed transfer: </label></th>
    <td><props:checkboxProperty name="uncompressedTransfer"/>
      <div class="smallNote" style="margin: 0;">Uncompressed transfer is faster for repositories in the LAN.</div>
    </td>
  </tr>
  <tr>
    <th><label for="hgCommandPath">HG command path: <l:star/></label></th>
    <td>
      <props:textProperty name="hgCommandPath" className="longField" />
      <span class="error" id="error_hgCommandPath"></span>
    </td>
  </tr>
  <tr class="advancedSetting">
    <th><label for="customHgConfig">Mercurial config:</label></th>
    <td>
      <props:multilineProperty name="customHgConfig" className="longField" linkTitle="Edit mercurial config" expanded="${true}" rows="3" cols="60"/>
      <span class="error" id="error_customHgConfig"></span>
    </td>
  </tr>
  </l:settingsGroup>
  <l:settingsGroup title="Authorization Settings">
  <tr>
    <th><label for="username">User name:</label></th>
    <td>
      <props:textProperty name="username" className="longField"/>
      <span class="smallNote">Leave blank to use settings from the server hgrc (see 'man hgrc' for details)</span>
    </td>
  </tr>
  <tr>
    <th><label for="secure:password">Password:</label></th>
    <td>
      <props:passwordProperty name="secure:password" className="longField"/>
      <span class="smallNote">Leave blank to use settings from the server hgrc (see 'man hgrc' for details)</span>
    </td>
  </tr>
  </l:settingsGroup>
  <l:settingsGroup title="Agent Settings" className="advancedSetting">
    <tr class="advancedSetting">
      <td colspan="2">Agent-specific settings that are used in case of agent checkout.</td>
    </tr>
    <tr class="advancedSetting">
      <th>
        <label for="purgePolicy">Purge settings:</label>
      </th>
      <td>
        <props:selectProperty name="purgePolicy" enableFilter="true" className="mediumField">
          <props:option value="">Don't run purge</props:option>
          <props:option value="PURGE_UNKNOWN">Purge unknown files</props:option>
          <props:option value="PURGE_ALL">Purge ignored & unknown files</props:option>
        </props:selectProperty>
      </td>
    </tr>
    <tr class="advancedSetting">
      <th><label for="useSharedMirrors">Use mirrors:</label></th>
      <td>
        <props:checkboxProperty name="useSharedMirrors"/>
        <div class="smallNote" style="margin: 0" >
          When this option is enabled, TeamCity creates a separate clone of the repository on each agent
          and uses it in the checkout directory via mercurial share extension.
        </div>
      </td>
    </tr>
  </l:settingsGroup>
  <script type="text/javascript">
    $j(document).ready(function() {
      if (BS.Repositories != null) {
        BS.Repositories.installControls($('repositoryPath'), function (repoInfo, cre) {
          $('repositoryPath').value = repoInfo.repositoryUrl;
          if (cre != null) {
            $('username').value = cre.oauthLogin;
          }
        });
      } else {
        $j('.listRepositoriesControls').hide();
      }
    });
  </script>
</table>
