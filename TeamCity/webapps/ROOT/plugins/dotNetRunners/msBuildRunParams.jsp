<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<jsp:useBean id="bean" class="jetbrains.buildServer.runner.MSBuild.MSBuildBean"/>

<tr>
  <th><label for="${bean.buildFilePathKey}">Build file path: <l:star/></label></th>
  <td>
    <div class="posRel">
      <props:textProperty name="${bean.buildFilePathKey}" className="longField"/>
      <bs:vcsTree fieldId="${bean.buildFilePathKey}"/>
    </div>
    <span class="error" id="error_${bean.buildFilePathKey}"></span>
    <span class="smallNote">The specified path should be relative to the checkout directory.</span></td>
</tr>

<props:workingDirectory />

<tr>
  <th><label for="${bean.versionKey}">MSBuild version: </label></th>
  <td>
    <props:selectProperty name="${bean.versionKey}" enableFilter="true" className="mediumField">
      <c:forEach var="item" items="${bean.versions}">
        <props:option value="${item.value}"><c:out value="${item.description}"/></props:option>
      </c:forEach>
    </props:selectProperty>
  </td>
</tr>

<tr>
  <th><label for="${bean.toolsVersionKey}">MSBuild ToolsVersion:</label></th>
  <td>
    <props:selectProperty name="${bean.toolsVersionKey}" enableFilter="true" className="mediumField">
      <c:forEach var="item" items="${bean.toolsVersions}">
        <props:option value="${item.propertyValue}"><c:out value="${item.description}"/></props:option>
      </c:forEach>
    </props:selectProperty>
    <span class="error" id="error_${bean.toolsVersionKey}"></span>
  </td>
</tr>

<tr>
  <th><label for="${bean.runPlatformKey}">Run platform: </label></th>
  <td>
    <props:selectProperty name="${bean.runPlatformKey}" enableFilter="true" className="mediumField">
      <c:forEach var="item" items="${bean.runPlatforms}">
        <props:option value="${item.value}"><c:out value="${item.description}"/></props:option>
      </c:forEach>
    </props:selectProperty>
  </td>
</tr>

<tr>
  <th><label for="${bean.targetsKey}">Targets:</label></th>
  <td>
    <div class="posRel">
      <props:textProperty name="${bean.targetsKey}" className="longField"/>
      <bs:projectData type="MSBuildTargets" sourceFieldId="${bean.buildFilePathKey}" targetFieldId="${bean.targetsKey}" popupTitle="Select targets to invoke"/>
    </div
    <span class="error" id="error_${bean.targetsKey}"></span>
    <span class="smallNote">Enter targets separated by space or semicolon.</span></td>
</tr>

<tr>
  <th><label for="${bean.runnerArgsKey}">Command line parameters:</label></th>
  <td><props:textProperty name="${bean.runnerArgsKey}" className="longField" expandable="true"/>
    <span class="error" id="error_${bean.runnerArgsKey}"></span>
    <span class="smallNote">Enter additional command line parameters to MSBuild.exe.</span>
  </td>
</tr>

<props:reduceTestFailureFeedback showRecentlyFailed="true" showRunNewAndModified="false"/>
