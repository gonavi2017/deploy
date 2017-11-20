<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>

<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<tr>
  <th><label for="solution">Solution file path: <l:star/></label></th>
  <td>
    <props:textProperty name="solution" className="longField"/>
    <bs:vcsTree fieldId="solution"/>
    <span class="error" id="error_solution"></span>
    <span class="smallNote">Specify path to Microsoft Visual Studio .NET 2003 Solution file. It should be relative to the project root
      directory.
    </span></td>
</tr>

<props:workingDirectory />

<tr>
  <th><label for="config">Configuration: <l:star/></label></th>
  <td><props:textProperty name="config"  className="longField"/>
    <span class="error" id="error_config"></span>
    <span class="smallNote">Specify solution configuration to build.</span></td>
</tr>

<tr>
  <th><label>Projects output:</label></th>
  <td><props:checkboxProperty name="use_output" onclick="if (this.checked) {BS.Util.show('outputField'); } else { BS.Util.hide('outputField');} BS.MultilineProperties.updateVisible();"/>
      <label for="use_output">Override projects output</label></td>
</tr>

<tr id="outputField">
  <th><label for="output">Output directory for all projects:</label></th>
  <td><props:textProperty name="output" className="longField"/>
    <span class="error" id="error_output"></span></td>
</tr>
<script type="text/javascript">
  if (!$('use_output').checked) {
    BS.Util.hide('outputField');
  }
</script>
<c:set var="useDAV" value="${propertiesBean.properties['webDAV'] == true}"/>
<tr>
  <th><props:radioButtonProperty name="webDAV" id="webDAV_false" value="false" onclick="BS.MultilineProperties.show('webMap', true)" checked="${not useDAV}"/>
    <label for="webDAV_false">Resolve URLs via map:</label></th>
  <td><span>
      <props:multilineProperty name="webMap"
                               className="longField"
                               linkTitle="Enter the URL map"
                               cols="40" rows="6"
                               onkeydown="$('webDAV_false').checked = true;$('webDAV_true').checked = false;"
                               expanded="${not useDAV}"
                               note="You should specify WebMap in the following format: &lt;url&gt;=&lt;local-path&gt;"/>
    </span>
</tr>


<tr>
  <th colspan="2"><props:radioButtonProperty name="webDAV" id="webDAV_true" value="true"/>
    <label for="webDAV_true">Resolve URLs via WebDAV</label></th>
  <%--<td></td>--%>
</tr>

<tr>
  <th><label>MS Visual Studio reference path:</label></th>
  <td><props:checkboxProperty name="vsReference"/>
    <label for="vsReference">Include MS Visual Studio reference path</label></td>
</tr>

<tr class="groupingTitle">
  <td colspan="2">NAnt Settings</td>
</tr>

<tr>
  <th><label for="NAntHome">NAnt home:</label></th>
  <td><props:textProperty name="NAntHome" className="longField"/>
    <span class="smallNote">Enter path to NAnt home directory.</span></td>
</tr>
<tr>
  <th><label for="runnerArgs">Command line parameters:</label></th>
  <td><props:textProperty name="runnerArgs" className="longField" expandable="true"/>
    <span class="smallNote">Enter additional command line parameters to NAnt.exe.</span></td>
</tr>

<tr class="groupingTitle">
  <td colspan="2">NUnit Test Settings</td>
</tr>

<tr>
  <th><label for="nunit_include">Run NUnit tests for:</label></th>
  <td><props:textProperty name="nunit_include" className="longField"/>
    <span class="error" id="error_nunit_include"></span>
    <span class="smallNote">Enter comma-separated paths to assembly files relative to the project root path. Wildcards are supported.</span></td>
</tr>

<tr>
  <th><label for="nunit_exclude">Do not run NUnit tests for:</label></th>
  <td><props:textProperty name="nunit_exclude" className="longField"/>
    <span class="error" id="error_nunit_exclude"></span>
    <span class="smallNote">Enter comma-separated paths to assembly files relative to the project root path. Wildcards are supported.</span>
  </td>
</tr>

<props:reduceTestFailureFeedback showRecentlyFailed="true" showRunNewAndModified="false"/>
