<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<jsp:useBean id="bean" class="jetbrains.buildServer.runner.MSBuild.MSBuildBean"/>

<div class="parameter">
  Build file path: <props:displayValue name="${bean.buildFilePathKey}" emptyValue="not specified"/>
</div>

<props:viewWorkingDirectory/>

<div class="parameter">
  MSBuild version: 
  <strong>
    <c:set var="version" value="${propertiesBean.properties[bean.versionKey]}"/>
    <c:forEach var="item" items="${bean.versions}">
      <c:if test="${version eq item.value}"><c:out value="${item.description}"/></c:if>
    </c:forEach>
  </strong>
</div>

<div class="parameter">
  MSBuild ToolsVersion:
  <strong>
    <c:set var="tv" value="${propertiesBean.properties[bean.toolsVersionKey]}"/>
    <c:forEach var="item" items="${bean.toolsVersions}">
      <c:if test="${tv eq item.propertyValue}"><c:out value="${item.description}"/></c:if>
    </c:forEach>
  </strong>
</div>

<div class="parameter">
  Run platform:
  <strong>
    <c:set var="pl" value="${propertiesBean.properties[bean.runPlatformKey]}"/>
    <c:forEach var="item" items="${bean.runPlatforms}">
      <c:if test="${pl eq item.value}"><c:out value="${item.description}"/></c:if>
    </c:forEach>
  </strong>
</div>

<div class="parameter">
  Targets: <props:displayValue name="${bean.targetsKey}" emptyValue="none specified"/>
</div>

<div class="parameter">
  Command line parameters to MSBuild.exe: <props:displayValue name="${bean.runnerArgsKey}" emptyValue="none specified"/>
</div>

<props:viewRunRiskGroupTestsFirst/>
