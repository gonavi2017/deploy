<%--@elvariable id="buildTypeSettings" type="jetbrains.buildServer.controllers.buildType.BuildTypeSettingsBean"--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>

<div class="parameter">
  Working directory:
  <strong><props:displayValue name="teamcity.build.workingDir" emptyValue="same as checkout directory"/></strong>
</div>
