<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>

<props:iprSettings javaMinVersion="1.8"/>

<%--TODO: Replace with constants: IdeaToolProvider.TOOL_TYPE and IdeaToolProvider.IDEA_APP_HOME_PROP--%>
<jsp:include page="/tools/editToolUsage.html?toolType=intellij&versionParameterName=idea.app.home&class=longField"/>

<l:settingsGroup title="Inspection Parameters">

<tr>
  <th><label for="profile">Inspection profile path:</label></th>
  <td><props:textProperty name="inspection.profile.file"  className="longField" />
    <bs:vcsTree fieldId="inspection.profile.file" treeId="inspection.profile.file"/>
    <span class="smallNote">
      Enter the path to the IntelliJ IDEA inspection profile file relative to the checkout directory
      (you only need to fill this in if you want to override profile mapping in the .ipr file).
    </span></td>
</tr>

<tr>
  <th><label for="inspection.profile.name">Inspection profile name:</label></th>
  <td>
    <div class="posRel">
    <props:textProperty name="inspection.profile.name"  className="longField" />
    <bs:projectData type="InspectionProfileNames" sourceFieldId="iprInfo.ipr" targetFieldId="inspection.profile.name" popupTitle="Select inspection profile" selectionMode="single"/>
    </div>
    <span class="smallNote">Leave empty for default profile.</span>
</tr>
<tr class="advancedSetting">
  <th><label for="includeExclude.patterns">Include / exclude patterns:</label></th>
  <td>
    <c:set var="note">Newline-delimited set or rules in the form of [+:|-:]pattern <bs:help file="Inspections" anchor="IdeaPatterns"/></c:set>
    <props:multilineProperty name="includeExclude.patterns" linkTitle="Include / exclude patterns" cols="40" rows="3" className="longField" note="${note}"/>
  </td>
</tr>
<props:ideaDisabledPlugins propertiesBean="${propertiesBean}"/>

</l:settingsGroup>

<l:settingsGroup title="Build Failure Conditions">

<tr>
  <th colspan="2">You can configure a build to fail if it has too many inspection errors or warnings. To do so,
    add a corresponding
    <c:set var="editFailureCondLink"><admin:editBuildTypeLink step="buildFailureConditions" buildTypeId="${buildForm.settings.externalId}" withoutLink="true"/></c:set>
    <a href="${editFailureCondLink}#addFeature=BuildFailureOnMetric">build failure condition</a>.
  </th>
</tr>

</l:settingsGroup>
