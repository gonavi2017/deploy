<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>

<div class="parameter">
  Build file:
  <c:choose>
    <c:when test="${empty propertiesBean.properties['use-custom-build-file']}">
      <props:displayValue name="build-file-path" emptyValue="not specified"/>
    </c:when>
    <c:otherwise>
      <props:displayValue name="build-file" emptyValue="<empty>"  showInPopup="true" popupTitle="Build file content" popupLinkText="view build file content" syntax="ant"/>
    </c:otherwise>
  </c:choose>
</div>

<props:viewWorkingDirectory />

<div class="parameter">
  Targets: <strong><props:displayValue name="target-list" emptyValue="none specified"/></strong>
</div>

<div class="parameter">
  NAnt home: <strong><props:displayValue name="NAntHome" emptyValue="not specified"/></strong>
</div>

<div class="parameter">
  Target framework: <strong><props:displayValue name="targetframework" emptyValue="unspecified"/></strong>
</div>

<div class="parameter">
  Command line parameters to NAnt.exe: <strong><props:displayValue name="runnerArgs" emptyValue="not specified"/></strong>
</div>

<props:viewRunRiskGroupTestsFirst/>