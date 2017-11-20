<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>

<props:displayIdeaSettingsValue />

<div class="parameter">
  Artifacts to build: <props:displayValue name="artifactsToBuild" emptyValue="none defined" showInPopup="true" popupTitle="Artifacts to build" popupLinkText="view artifact names"/>
</div>

<div class="parameter">
  Run configurations to execute: <props:displayValue name="runConfigurations" emptyValue="none defined" showInPopup="true" popupTitle="Run configurations" popupLinkText="view run configurations"/>
</div>

<props:viewJavaHome/>
<props:viewJvmArgs/>
<props:viewRunRiskGroupTestsFirst/>