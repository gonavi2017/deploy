<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>

<l:settingsGroup title="Ant Parameters">

  <tr>
    <th>
      <c:set var="onclick">
        if (this.checked) {
          $('build-file-path').focus();
        }
      </c:set>
      <props:radioButtonProperty name="use-custom-build-file" value="" id="custom1"
                                 checked="${empty propertiesBean.properties['use-custom-build-file']}" onclick="${onclick}"/>
      <label for="custom1">Path to a build.xml file:</label>
    </th>
    <td>
      <div class="posRel">
        <props:textProperty name="build-file-path" className="longField"/>
        <bs:vcsTree fieldId="build-file-path"/>
      </div>
      <span class="error" id="error_build-file-path"></span>
      <span class="smallNote">The specified path should be relative to the checkout directory.</span>
    </td>
  </tr>
 <tr>
  <th>
    <c:set var="onclick">
      if (this.checked) {
        try {
          BS.MultilineProperties.show('build-file', true);
          $('build-file').focus();
        } catch(e) {}
      }
    </c:set>
    <props:radioButtonProperty name="use-custom-build-file" value="true" id="custom2" onclick="${onclick}"/>
  <label for="custom2">Build file content:</label>
  </th>
  <td>
   <props:multilineProperty expanded="${propertiesBean.properties['use-custom-build-file'] == true}" name="build-file" rows="10" cols="58" linkTitle="Enter the build file content" onkeydown="$('custom2').checked = true;"  className="longField"/>
  </td>
</tr>

  <props:workingDirectory />

  <tr>
    <th>
      <label for="target">Targets:</label>
    </th>
    <td>
      <div class="posRel">
        <props:textProperty name="target" className="longField"/>
        <bs:projectData type="AntTargets" sourceFieldId="build-file-path" targetFieldId="target" popupTitle="Select targets to invoke"/>
      </div>
      <span class="smallNote">Space- or comma-separated targets are supported.</span>
    </td>
  </tr>

  <tr class="advancedSetting">
    <th><label for="ant.home">Ant home path: <bs:help file="Ant" anchor="antAntParamsOptionDescription"/></label></th>
    <td><props:textProperty name="ant.home" className="longField"/>
        <span class="smallNote">Optional, specify if you don't want to use the Ant bundled with TeamCity. The path should be relative to the checkout directory. Ant versions 1.6.5+ are supported.</span>
    </td>
  </tr>

  <tr class="advancedSetting">
    <th><label for="runnerArgs">Additional Ant command line parameters:</label></th>
    <td><props:textProperty name="runnerArgs" className="longField" expandable="true"/></td>
  </tr>

</l:settingsGroup>

<props:javaSettings/>

<l:settingsGroup title="Test Parameters" className="advancedSetting">
  <props:reduceTestFailureFeedback showRecentlyFailed="true" showRunNewAndModified="true"/>
</l:settingsGroup>
