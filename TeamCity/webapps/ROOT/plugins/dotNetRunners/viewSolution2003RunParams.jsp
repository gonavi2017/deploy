<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>

<div class="parameter">
  Solution file path: <strong><props:displayValue name="solution" emptyValue="none specified"/></strong>
</div>

<props:viewWorkingDirectory />

<div class="parameter">
  Build configuration: <strong><props:displayValue name="config" emptyValue="none specified"/></strong>
</div>

<div class="parameter">
  Output path:
  <c:choose>
    <c:when test="${propertiesBean.properties['use_output']}">
      <strong><props:displayValue name="output" emptyValue="not specified"/></strong>
    </c:when>
    <c:otherwise>
      <strong>Not overriden</strong>
    </c:otherwise>
  </c:choose>
</div>

<div class="parameter">
   Use WebDAV to resolve URLs: 
  <c:choose>
    <c:when test="${propertiesBean.properties['webDAV']}">
      <strong>ON</strong>
    </c:when>
    <c:otherwise>
      <strong>OFF</strong>
    </c:otherwise>
  </c:choose>
</div>

<div class="parameter">
  Includes Visual Studio search folders in reference search path:
  <strong><props:displayValue name="vsReference" emptyValue="not specified"/></strong>
</div>

<div class="parameter">
  NAnt home: <strong><props:displayValue name="NAntHome" emptyValue="not specified"/></strong>
</div>
<div class="parameter">
  Command line parameters to NAnt.exe: <strong><props:displayValue name="commandLine" emptyValue="not specified"/></strong>
</div>

<props:viewRunRiskGroupTestsFirst/>

<div class="parameter">
  Run NUnit tests for: <strong><props:displayValue name="nunit_include" emptyValue="none specified"/></strong>
</div>

<div class="parameter">
  Ignore NUnit tests for: <strong><props:displayValue name="nunit_exclude" emptyValue="none specified"/></strong>
</div>

