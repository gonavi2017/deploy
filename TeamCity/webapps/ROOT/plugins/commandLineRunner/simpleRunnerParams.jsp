<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>

<props:workingDirectory />

<c:set var="showCustomScriptSettings"
       value="${not empty propertiesBean.properties['use.custom.script'] or empty propertiesBean.properties['command.executable']}"/>

<tr>
  <th>
    <label for="use.custom.script">Run: </label>
  </th>
  <td>
    <script type="text/javascript">
      commandLineScriptTypeChange = function() {
        var mode = $('use.custom.script').value == 'true' ? 'customScript' : 'executable';
        BS.Util.toggleDependentElements(mode, 'scriptMode', true);
        if (mode == 'customScript') {
          BS.MultilineProperties.updateVisible();
          $('script.content').focus();
        } else {
          $('command.executable').focus();
        }
        BS.VisibilityHandlers.updateVisibility('mainContent');
      };
    </script>
    <props:selectProperty name="use.custom.script" onchange="commandLineScriptTypeChange()" enableFilter="true" className="mediumField">
      <props:option value="true" selected="${showCustomScriptSettings}">Custom script</props:option>
      <props:option value="" selected="${not showCustomScriptSettings}">Executable with parameters</props:option>
    </props:selectProperty>
  </td>
</tr>

<tr id="command.executable.container" class="scriptMode executable" style="${showCustomScriptSettings ? 'display:none;' : ''}">
  <th>
    <label for="command.executable">Command executable: <l:star/></label>
  </th>
  <td>
    <props:textProperty name="command.executable" className="longField"/>
    <bs:vcsTree fieldId="command.executable"/>
    <span class="error" id="error_command.executable"></span>
  </td>
</tr>
<tr id="command.parameters.container" class="scriptMode executable" style="${showCustomScriptSettings ? 'display:none;' : ''}">
  <th>
    <label for="use.custom.script.false">Command parameters: </label>
  </th>
  <td>
  <props:textProperty name="command.parameters" className="longField" expandable="true"/>
  </td>
</tr>
<tr id="script.content.container" class="scriptMode customScript" style="${showCustomScriptSettings ? '' : 'display:none;'}">
  <th>
    <label for="script.content">Custom script: <l:star/></label>
  </th>
  <td>
    <props:multilineProperty name="script.content" className="longField" cols="58" rows="10" expanded="true" linkTitle="Enter build script content"
                             note="A platform-specific script, which will be executed as a .cmd file on Windows or as a shell script in Unix-like environments."/>
  </td>
</tr>
