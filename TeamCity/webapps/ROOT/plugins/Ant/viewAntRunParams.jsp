<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>

<div class="parameter">
  build.xml file:
  <c:choose>
    <c:when test="${empty propertiesBean.properties['use-custom-build-file']}">
      <props:displayValue name="build-file-path" emptyValue="not specified"/>
    </c:when>
    <c:otherwise>
      <props:displayValue name="build-file" emptyValue="<empty>" showInPopup="true" popupTitle="Build file content" popupLinkText="view build file content" syntax="ant"/>
    </c:otherwise>
  </c:choose>
</div>

<props:viewWorkingDirectory />

<div class="parameter">
  Targets: <props:displayValue name="target" emptyValue="none specified"/>
</div>

<div class="parameter">
  Ant home path: <props:displayValue name="ant.home" emptyValue="not specified"/>
</div>

<div class="parameter">
  Additional Ant command line parameters: <props:displayValue name="runnerArgs" emptyValue="not specified"/>
</div>

<props:viewJavaHome/>
<props:viewJvmArgs/>
<props:viewRunRiskGroupTestsFirst/>