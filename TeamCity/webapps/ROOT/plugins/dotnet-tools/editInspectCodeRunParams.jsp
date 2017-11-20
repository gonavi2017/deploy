<%--
  ~ Copyright 2000-2010 JetBrains s.r.o.
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

<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="constants" class="jetbrains.buildServer.dotnetTools.server.inspectCode.InspectCodeConstantsBean"/>

<jsp:include page="/tools/editToolUsage.html?toolType=${constants.cltToolTypeName}&versionParameterName=${constants.cltPathKey}&class=longField"/>

<l:settingsGroup title="Sources to Analyze">

  <tr>
    <th><label for="${constants.solutionPathKey}">Solution file path: <l:star/></label></th>
    <td><props:textProperty name="${constants.solutionPathKey}" className="longField"/>
      <bs:vcsTree fieldId="${constants.solutionPathKey}" treeId="${constants.solutionPathKey}"/>
      <span class="error" id="error_${constants.solutionPathKey}"></span>
      <span class="smallNote">Specified path should be relative to the checkout directory.</span>
    </td>
  </tr>

  <tr class="advancedSetting">
    <th>
      <label for="${constants.projectFilerKey}">Projects filter:</label>
    </th>
    <td>
      <span>
        <c:set var="note">
          Analyze only projects selected by provided wildcards separated by new lines.<br/>
          Leave blank to analyze whole solution.<br/>
          Example: JetBrains.CommandLine.Tests.*
        </c:set>
        <props:multilineProperty name="${constants.projectFilerKey}"
                                 linkTitle="Project name wildcards" note="${note}"
                                 cols="55" rows="5"/>
      </span>
    </td>
  </tr>

</l:settingsGroup>

<l:settingsGroup title="Environment Requirements" className="advancedSetting">

  <tr class="advancedSetting">
    <th>
      <label>Target Frameworks: <bs:help file="Inspections+%28.NET%29" anchor="targetFramework"/></label>
    </th>
    <td>
      <c:forEach var="target" items="${constants.availableTargetFrameworks}">
        <props:checkboxProperty name="${target.id}"/>
        <label for="${target.id}">${target.name}</label>
        <br/>
      </c:forEach>
      <span class="smallNote" style="padding-top: 8px">
        Specify all versions of .NET Framework Target Pack which are required to build your project.<br/>
      </span>
    </td>
  </tr>

</l:settingsGroup>

<l:settingsGroup title="InspectCode Options" className="advancedSetting">

  <tr class="advancedSetting">
    <th><label for="${constants.customSettingsProfilePathKey}">Custom settings profile path: <bs:help file="Inspections+%28.NET%29" anchor="settings"/></label></th>
    <td>
      <props:textProperty name="${constants.customSettingsProfilePathKey}" className="longField"/>
      <bs:vcsTree fieldId="${constants.customSettingsProfilePathKey}" treeId="${constants.customSettingsProfilePathKey}"/>
      <span class="error" id="error_${constants.customSettingsProfilePathKey}"></span>
      <span class="smallNote">
        Leave blank to use build-in <a href="http://www.jetbrains.com/resharper/">JetBrains ReSharper</a> settings.<br>
        Specified path should be relative to the checkout directory.
      </span>
    </td>
  </tr>

  <tr class="advancedSetting">
    <th>
      <label for="${constants.debugKey}">Enable debug output: <bs:help file="Inspections+%28.NET%29" anchor="debug"/></label>
    </th>
    <td>
      <props:checkboxProperty name="${constants.debugKey}"/>
      <span class="error" id="error_${constants.debugKey}"></span>
    </td>
  </tr>

  <tr class="advancedSetting">
    <th><label for="${constants.customCommandlineKey}">Additional inspectCode.exe arguments: <bs:help file="Inspections+%28.NET%29" anchor="cmdArgs"/></label></th>
    <td>
      <props:multilineProperty name="${constants.customCommandlineKey}" linkTitle="Commandline" cols="60" rows="5" note="Additional commandline parameters to add to calling inspectCode.exe separated by new lines."/>
    </td>
  </tr>

</l:settingsGroup>

<l:settingsGroup title="Build Failure Conditions">

<tr>
  <th colspan="2">You can configure a build to fail if it has too many inspection errors or warnings. To do so, add a corresponding
    <c:set var="editFailureCondLink"><admin:editBuildTypeLink step="buildFailureConditions" buildTypeId="${buildForm.settings.externalId}" withoutLink="true"/></c:set>
    <a href="${editFailureCondLink}#addFeature=BuildFailureOnMetric">build failure condition</a>.
  </th>
</tr>

</l:settingsGroup>
