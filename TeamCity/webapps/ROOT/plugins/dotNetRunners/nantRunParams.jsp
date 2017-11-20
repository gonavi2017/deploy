<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>

<tr>
  <c:set var="onclick">
    if (this.checked) {
      $('build-file-path').focus();
    }
  </c:set>
  <th><props:radioButtonProperty name="use-custom-build-file" value="" id="custom1"
                               checked="${empty propertiesBean.properties['use-custom-build-file']}"
                               onclick="${onclick}"/>
    <label for="custom1">Path to a build file:</label></th>
  <td>
    <div class="posRel">
      <props:textProperty name="build-file-path" className="longField"/>
      <bs:vcsTree fieldId="build-file-path"/>
    </div>
    <span class="error" id="error_build-file-path"></span>
    <span class="smallNote">The specified path should be relative to the checkout directory.</span></td>
</tr>

<tr>
  <c:set var="onclick">
    if (this.checked) {
      try {
        BS.MultilineProperties.show('build-file', true);
        $('build-file').focus();
      } catch(e) {}
    }
  </c:set>
  <th><props:radioButtonProperty name="use-custom-build-file" value="true" id="custom2" onclick="${onclick}"/>
    <label for="custom2">Build file content:</label></th>
  <td><span><props:multilineProperty name="build-file" className="longField" linkTitle="Enter build file content" cols="58" rows="10"
                                     onkeydown="$('custom2').checked = true;" expanded="${propertiesBean.properties['use-custom-build-file'] == true}"/></span>
  </td>
</tr>

<props:workingDirectory />

<tr>
  <th><label for="target-list">Targets:</label></th>
  <td>
    <div class="posRel">
      <props:textProperty name="target-list" className="longField"/>
      <bs:projectData type="NAntTargets" sourceFieldId="build-file-path" targetFieldId="target-list" popupTitle="Select targets to invoke"/>
    </div>
    <span class="smallNote">Enter targets separated by space character.</span></td>
</tr>

<tr>
  <th><label for="NAntHome">NAnt home: <l:star/></label></th>
  <td><props:textProperty name="NAntHome" className="longField"/>
    <span class="smallNote">Enter path to NAnt home directory.</span></td>
</tr>

<tr class="advancedSetting">
  <th><label for="targetframework">Target framework: </label></th>
  <td>
    <props:selectProperty name="targetframework" id="targetframework" enableFilter="true" className="mediumField">
      <props:option value="unspecified">unspecified</props:option>
      <props:option value="net-1.0">net-1.0</props:option>
      <props:option value="net-1.1">net-1.1</props:option>
      <props:option value="net-2.0">net-2.0</props:option>
      <props:option value="net-3.5">net-3.5</props:option>
      <props:option value="net-4.0">net-4.0</props:option>
      <props:option value="mono-1.0">mono-1.0</props:option>
      <props:option value="mono-2.0">mono-2.0</props:option>
      <props:option value="mono-3.5">mono-3.5</props:option>
      <props:option value="netcf-1.0">netcf-1.0</props:option>
      <props:option value="netcf-2.0">netcf-2.0</props:option>
      <props:option value="sscli-1.0">sscli-1.0</props:option>
      <props:option value="silverlight-2.0">silverlight-2.0</props:option>
      <props:option value="moonlight-2.0">moonlight-2.0</props:option>
    </props:selectProperty>
    <span class="smallNote">Shortcut for -t: option of NAnt.exe. Also imposes corresponding agent requirements.</span>
  </td>
 </tr>

<tr class="advancedSetting">
  <th><label for="runnerArgs">Command line parameters:</label></th>
  <td><props:textProperty name="runnerArgs" className="longField" expandable="true"/>
    <span class="smallNote">Enter additional command line parameters to NAnt.exe.</span></td>
</tr>

<props:reduceTestFailureFeedback showRecentlyFailed="true" showRunNewAndModified="false"/>
