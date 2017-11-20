<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>

<c:set var="addLinkStyle">padding-left:1.5em; background:url('<c:url value='/img/add.png'/>') no-repeat;</c:set>
<c:set var="iprPathModalDialogStyle">
  width: 22em;
</c:set>

<props:iprSettings showWorkingDir="true" javaMinVersion="1.8"/>
<l:settingsGroup title="Compilation Settings" className="advancedSetting">
  <tr class="advancedSetting">
    <th><label for="makeRequiredModulesOnly">Classes to compile</label></th>
    <td>
      <props:checkboxProperty name="makeRequiredModulesOnly"/>
      <label for="makeRequiredModulesOnly">Only compile classes required to build artifacts and execute run configurations</label>
      <span class="smallNote">Whether to compile all classes in the project or only classes that are required by run configurations or for building artifacts.</span>
    </td>
  </tr>
  <tr class="advancedSetting">
    <th><label for="incrementalMake">Incremental make</label></th>
    <td>
      <props:checkboxProperty name="incrementalMake"/>
      <label for="incrementalMake">Compile classes and build artifacts incrementally when possible</label>
      <span class="smallNote">Incremental make will work if there are caches on the agent left by the previous build of this build configuration</span>
    </td>
  </tr>
</l:settingsGroup>
<l:settingsGroup title="Artifacts">
  <tr>
    <th><label for="artifactsToBuild">Artifacts to build:</label><bs:help file="IntelliJ+IDEA+Project" anchor="Artifacts"/></th>
    <td>
      <props:multilineProperty name="artifactsToBuild" linkTitle="IntelliJ IDEA Artifacts Names" cols="48" rows="6" className="longField"/>
      <bs:projectData type="IdeaArtifactNames" sourceFieldId="iprInfo.ipr" targetFieldId="artifactsToBuild" popupTitle="Select artifacts"/>
      <span class="smallNote">Provide names of artifacts to build. Names must be separated by newline. Note that artifact names are case sensitive.</span>
    </td>
  </tr>
</l:settingsGroup>
<l:settingsGroup title="Run Configurations">
  <tr>
    <th><label for="runConfigurations">Run configurations to execute:</label><bs:help file="IntelliJ+IDEA+Project" anchor="Runconfigurations"/></th>
    <td>
      <props:multilineProperty name="runConfigurations" linkTitle="IntelliJ IDEA Run Configurations" cols="48" rows="6" className="longField"/>
      <bs:projectData type="IdeaRunConfigurationNames" sourceFieldId="iprInfo.ipr" targetFieldId="runConfigurations" popupTitle="Select run configurations"/>
      <span class="smallNote">Provide names of IntelliJ IDEA project shared Run Configurations that you want to run after project compilation. Names must be separated by newline. Note that run configuration names are case sensitive.</span>
    </td>
  </tr>
</l:settingsGroup>
<l:settingsGroup title="Test Parameters" className="advancedSetting">
  <props:reduceTestFailureFeedback showRecentlyFailed="true" showRunNewAndModified="true" showDepsBasedTestRun="true"/>
</l:settingsGroup>
