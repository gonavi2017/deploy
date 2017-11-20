<%@ tag import="jetbrains.buildServer.serverSide.BuildTypeOptions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %><%@
    taglib prefix="l" tagdir="/WEB-INF/tags/layout" %><%@
    taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %><%@
    taglib prefix="props" tagdir="/WEB-INF/tags/props" %><%@
    attribute name="buildForm" required="true" type="jetbrains.buildServer.controllers.admin.projects.BuildTypeForm" %><%@
    attribute name="title" required="true"
%><table class="runnerFormTable">
  <tr>
    <th><label for="name">Name: <l:star/></label></th>
    <td><forms:textField name="name" className="longField" maxlength="80" value="${buildForm.name}"/>
    <span class="error" id="errorName"></span></td>
  </tr>

  <c:set var="object" value="${buildForm.template ? 'template' : 'configuration'}"/>
  <tr>
    <th><label for="name">Build ${object} ID: <l:star/><bs:help file="Identifier"/></label></th>
    <td>
      <forms:textField name="externalId" className="longField" maxlength="80" value="${buildForm.externalId}"/>
      <span class="smallNote">This ID is used in URLs, REST API, HTTP requests to the server, and configuration settings in the TeamCity Data Directory.</span>
      <span class="error" id="errorExternalId"></span>
    </td>
  </tr>
  <tr id="changeExternalIdWarning" style="display: none;">
    <td colspan="2">
      <div class="icon_before icon16 attentionComment" style="margin-top: 1em">
        Important: Modifying the ID will change all the URLs related to the build ${object}.
        It is highly recommended to update the ID in any of the URLs bookmarked or hard-coded in the scripts.
        The corresponding configuration and artifacts directory names on the disk will change too and it can take time.
      </div>
    </td>
  </tr>

  <c:if test="${not buildForm.template}">
  <tr>
    <th><label for="description">Description:</label></th>
    <td><forms:textField name="description" className="longField" maxlength="256" value="${buildForm.description}"/></td>
  </tr>
  </c:if>

  <tr class="advancedSetting">
    <th><label for="buildNumberFormat">Build number format: <l:star/></label><bs:help file="Configuring+General+Settings" anchor="BuildNumberFormat" /></th>
    <td>
      <admin:textOption buildTypeForm="${buildForm}" fieldName="buildNumberFormat" optionName="<%=BuildTypeOptions.BT_BUILD_NUMBER_PATTERN.getKey()%>" className="buildTypeParams longField">
        <jsp:attribute name="labelText"></jsp:attribute>
      </admin:textOption>
      <span class="error" id="errorBuildNumberFormat"></span>
      <span class="smallNote">
        The format may include '%build.counter%' as a placeholder for the build counter value, for example, <b>1.%build.counter%</b>.<br>
        It may also contain a reference to any other available parameter, for example, <b>%build.vcs.number.VCSRootName%</b>.
      </span>
      <span class="smallNote">Note: The maximum length of a build number after all substitutions is <strong>256</strong> characters.</span>
    </td>
  </tr>
  <c:if test="${not buildForm.template}">
  <tr class="advancedSetting">
    <th><label for="buildCounter">Build counter: <l:star/><bs:help file="Configuring+General+Settings"
                                                                   anchor="buildCounter" /></label></th>
    <td><forms:textField name="buildCounter" style="width:10em;" maxlength="80"
                         value="${buildForm.buildCounter}"/>&nbsp;<a title="Next build number will be set to 1"
                                                                     showdiscardchangesmessage="false"
                                                                     href="#" onclick="$('buildCounter').value = '1'; return false">Reset</a>
      <c:if test="${buildForm.readOnly}">&nbsp;<forms:button id="updateBuildCounterButton" title="Save build counter" className="btn btn_mini" onclick="return BS.EditBuildTypeForm.submitBuildType()">Save</forms:button></c:if>
      <span class="error" id="errorBuildCounter"></span></td>
  </tr>
  </c:if>

  <tr>
    <th><label for="artifactPaths">Artifact paths: <bs:help file="Configuring+General+Settings" anchor="ArtifactPaths"/></label></th>
    <td>
      <admin:textOption buildTypeForm="${buildForm}" fieldName="artifactPaths" optionName="<%=BuildTypeOptions.BT_ARTIFACT_RULES.getKey()%>" expandable="true" className="buildTypeParams longField" minheight="40">
        <jsp:attribute name="labelText"></jsp:attribute>
        <jsp:attribute name="afterTextField">
          <c:if test="${not buildForm.template}">
            <i class="tc-icon icon16 tc-icon_folders agentTree"
                 title="Select files from the latest build"
                 showdiscardchangesmessage="false" onclick="return BS.EditArtifacts.showPopup(this, '${buildForm.externalId}');"></i>
          </c:if>
        </jsp:attribute>
      </admin:textOption>
      <span class="smallNote">
        Newline- or comma-separated paths in the form of <kbd>[+:]source [ => target]</kbd> to include and <kbd>-:source [ => target]</kbd> to exclude files or directories to
        publish as build artifacts. Ant-style wildcards are supported, e.g. use <kbd>**/* => target_directory</kbd>, <kbd>-: **/folder1 => target_directory</kbd> to publish all
        files except for <kbd>folder1</kbd> into the <kbd>target_directory</kbd>.
      </span>
    </td>
  </tr>

  <tr class="advancedSetting">
    <th class="noBorder"><label>Build options:</label><bs:help file="Configuring+General+Settings"
                                                               anchor="buildOptions" /></th>
    <td class="noBorder">
      <admin:booleanOption buildTypeForm="${buildForm}" optionName="<%=BuildTypeOptions.BT_HANGING_BUILDS_DETECTION_ENABLED.getKey()%>" fieldName="hangingBuildsDetectionEnabled">
        <jsp:attribute name="labelText">enable hanging builds detection</jsp:attribute>
      </admin:booleanOption>

      <br/>

      <admin:booleanOption buildTypeForm="${buildForm}" optionName="<%=BuildTypeOptions.BT_ALLOW_PERSONAL_BUILD_TRIGGERING.getKey()%>" fieldName="allowPersonalBuildTriggering">
        <jsp:attribute name="labelText">allow triggering personal builds</jsp:attribute>
      </admin:booleanOption>

      <br/>

      <admin:booleanOption buildTypeForm="${buildForm}" optionName="<%=BuildTypeOptions.BT_ALLOW_EXTERNAL_STATUS.getKey()%>" fieldName="allowExternalStatus">
        <jsp:attribute name="labelText">enable status widget <bs:help file="Configuring+General+Settings" anchor="EnableStatusWidget"/></jsp:attribute>
      </admin:booleanOption>

      <br/>

      <admin:textOption buildTypeForm="${buildForm}" optionName="<%=BuildTypeOptions.BT_MAX_RUNNING_BUILDS.getKey()%>" fieldName="maxBuilds">
        <jsp:attribute name="labelText">Limit the number of simultaneously running builds (0 &mdash; unlimited)</jsp:attribute>
      </admin:textOption>
      <span class="error" id="errorMaxBuilds"></span>
    </td>
  </tr>
</table>
<script type="text/javascript">
  BS.MultilineProperties.updateVisible();
  <c:if test="${buildForm.template and not buildForm.readOnly}">
    BS.AdminActions.prepareTemplateIdGenerator("externalId", "name", "${buildForm.project.externalId}", true);
  </c:if>
  <c:if test="${not buildForm.template and not buildForm.readOnly}">
    BS.AdminActions.prepareBuildTypeIdGenerator("externalId", "name", "${buildForm.project.externalId}", true);
  </c:if>
</script>
