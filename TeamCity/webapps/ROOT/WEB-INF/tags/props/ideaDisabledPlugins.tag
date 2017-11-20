<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@attribute name="propertiesBean" type="jetbrains.buildServer.controllers.BasePropertiesBean" required="true" %>
<tr class="advancedSetting">
  <th>
    <label for="disabled.plugins.file">Disabled plugins:</label>
  </th>
  <td>
    <c:set var="note">List of identifiers of IntelliJ IDEA disabled plugins. If plugin is disabled it won't be loaded when IntelliJ IDEA starts on the agent.
      Please refer to <strong>\${user.home}/.IntelliJIdea/config/disabled_plugins.txt</strong> on the machine where IntelliJ IDEA is installed for an example of such a list.</c:set>
    <props:multilineProperty name="disabled.plugins.file" className="longField" linkTitle="Enter disabled plugins file content" cols="40" rows="3" note="${note}"/>
  </td>
</tr>
