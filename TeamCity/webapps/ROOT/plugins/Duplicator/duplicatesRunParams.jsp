<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>

<props:iprSettings javaMinVersion="1.8"/>

<%--TODO: Replace with constants: IdeaToolProvider.TOOL_TYPE and IdeaToolProvider.IDEA_APP_HOME_PROP--%>
<jsp:include page="/tools/editToolUsage.html?toolType=intellij&versionParameterName=idea.app.home&class=longField"/>

<l:settingsGroup title="Duplicate Finder Settings">
  
<tr>
  <th><label>Test sources:</label></th>
  <td><props:checkboxProperty name="duplicates.runner.include.tests"/>
    <label for="duplicates.runner.include.tests">Include test sources</label>
  </td>
</tr>
<tr class="advancedSetting">
  <th><label for="includeExclude.patterns">Include / exclude patterns:</label></th>
  <td>
    <c:set var="note">Newline-delimited set or rules in the form of [+:|-:]pattern <bs:help file="Inspections" anchor="IdeaPatterns"/></c:set>
    <props:multilineProperty name="includeExclude.patterns" linkTitle="Include / exclude patterns" cols="40" rows="3" className="longField" note="${note}"/>
  </td>
</tr>
<tr class="advancedSetting">
  <th>
    <label>Detalization level:</label>
  </th>
  <td>
      <props:checkboxProperty name="duplicates.runner.variable"/>
      <label for="duplicates.runner.variable">Distinguish variables</label>
      <br/>
      <props:checkboxProperty name="duplicates.runner.field"/>
      <label for="duplicates.runner.field">Distinguish fields</label>
      <br/>
      <props:checkboxProperty name="duplicates.runner.method"/>
      <label for="duplicates.runner.method">Distinguish methods</label>
      <br/>
      <props:checkboxProperty name="duplicates.runner.type"/>
      <label for="duplicates.runner.type">Distinguish types</label>
      <br/>
      <props:checkboxProperty name="duplicates.runner.literal"/>
   <label for="duplicates.runner.literal">Distinguish literals</label>
 </td>
</tr>

<tr class="advancedSetting">
  <th><label for="duplicates.runner.bound">Ignore duplicates with complexity simpler than:</label></th>
  <td>
    <props:textProperty name="duplicates.runner.bound" style="width:6em;" maxlength="12"/>
    <span class="error" id="error_duplicates.runner.bound"></span>
  </td>
</tr>
<c:set var="subexpressionCheckingEnabled" value="${propertiesBean.properties['duplicates.runner.discard'] > 0}"/>

<tr class="advancedSetting">
  <th class="noBorder"><label for="duplicates.runner.discard">Ignore duplicate subexpressions with complexity lower than:</label></th>
  <td class="noBorder">
    <c:set var="onchange">$('duplicates.runner.visibility').disabled = (this.value == 0);</c:set>
    <props:textProperty name="duplicates.runner.discard" style="width:6em;" maxlength="12" onchange="${onchange}"/>
    <span class="error" id="error_duplicates.runner.discard"></span>
    <br/>
    <props:checkboxProperty name="duplicates.runner.visibility" disabled="${not subexpressionCheckingEnabled}"/>
    <label for="duplicates.runner.visibility">Subexpressions can be extracted</label>
  </td>
</tr>

<props:ideaDisabledPlugins propertiesBean="${propertiesBean}"/>

</l:settingsGroup>

<l:settingsGroup title="Build Failure Conditions">

<tr>
  <th colspan="2">You can configure a build to fail if it has too many duplicates. To do so,
    add a corresponding
    <c:set var="editFailureCondLink"><admin:editBuildTypeLink step="buildFailureConditions" buildTypeId="${buildForm.settings.externalId}" withoutLink="true"/></c:set>
    <a href="${editFailureCondLink}#addFeature=BuildFailureOnMetric">build failure condition</a>.
  </th>
</tr>

</l:settingsGroup>

