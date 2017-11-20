<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>

<tr class="advancedSetting">
  <th>
    <label for="teamcity.build.workingDir">Working directory: <bs:help file="Build+Working+Directory"
      shortHelp="Allows starting a build in a subdirectory of the checkout directory (use a relative path).
       <br />When not specified, the build is started in the checkout directory.
       <br /><strong>Note:</strong> All relative paths in TeamCity are relative to <em>checkout directory</em>."/></label>
  </th>
  <td>
    <props:textProperty name="teamcity.build.workingDir"  className="longField"/>
    <bs:vcsTree fieldId="teamcity.build.workingDir" treeId="teamcity-build-workingDir" dirsOnly="true"/>
    <span class="smallNote">Optional, set if differs from the checkout directory.</span>
  </td>
</tr>
