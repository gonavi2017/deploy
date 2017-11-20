<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<jsp:useBean id="testRunner" class="jetbrains.buildServer.dotNet.testRunner.server.DotNetTestRunnerBean"/>
<jsp:useBean id="bean" class="jetbrains.buildServer.dotNet.mspec.server.MSpecBean"/>

<tr>
  <th><label for="${bean.pathToMSpecKey}">Path to MSpec.exe: <l:star/></label></th>
  <td><props:textProperty name="${bean.pathToMSpecKey}" className="longField"/>
    <span class="error" id="error_${bean.pathToMSpecKey}"></span>
    <span class="smallNote">Enter the path to mspec.exe.</span></td>
</tr>


<tr>
  <th rowspan="2"><label>.NET Runtime: </label></th>
  <td>
      <label for="${bean.platformBitmessKey}" class="fixedLabel">Platform:</label>
      <props:selectProperty name="${bean.platformBitmessKey}" enableFilter="true" className="smallField">
        <c:forEach var="item" items="${bean.platformBits}">
          <props:option value="${item.value}"><c:out value="${item.description}"/></props:option>
        </c:forEach>
      </props:selectProperty>
  </td>
</tr>

<tr>
  <td>
      <label for="${bean.platformRuntimeVersionKey}" class="fixedLabel">Version:</label>
      <props:selectProperty name="${bean.platformRuntimeVersionKey}" enableFilter="true" className="smallField">
        <c:forEach var="item" items="${bean.platformRuntimeVersions}">
          <props:option value="${item.value}"><c:out value="${item.description}"/></props:option>
        </c:forEach>
      </props:selectProperty>
  </td>
</tr>

<tr>
  <th><label for="${bean.assembliesIncludeKey}">Run tests from: <l:star/></label></th>
  <td><c:set var="note">Enter comma- or newline-separated paths to assembly files relative to the checkout directory. Wildcards are supported.</c:set
    ><props:multilineProperty
      name="${bean.assembliesIncludeKey}"
      className="longField"
      linkTitle="Edit assemblies include list"
      rows="3"
      cols="49"
      expanded="${true}"
      note="${note}"
      /></td>
</tr>

<tr>
  <th><label for="${bean.assembliesExcludeKey}">Do not run tests from:</label></th>
  <td><c:set var="note">Enter comma- or newline-separated paths to assembly files relative to the checkout directory. Wildcards are supported.</c:set
    ><props:multilineProperty
      name="${bean.assembliesExcludeKey}"
      className="longField"
      linkTitle="Edit assemblies exclude list"
      rows="3"
      cols="49"
      expanded="${not empty propertiesBean.properties[bean.assembliesExcludeKey]}"
      note="${note}"
      /></td>
</tr>


<tr>
  <th><label for="${bean.specIncludeKey}">Include specifications:</label></th>
  <td><c:set var="note">Enter a comma- or newline-separated list of specifications to include. Equivalent to <strong>--include</strong> argument.</c:set
    ><props:multilineProperty
      name="${bean.specIncludeKey}"
      className="longField"
      linkTitle="Edit specifications include list"
      rows="3"
      cols="49"
      expanded="${not empty propertiesBean.properties[bean.specIncludeKey]}"
      note="${note}"
      /></td>
</tr>

<tr>
  <th><label for="${bean.specExcludeKey}">Exclude specifications:</label></th>
  <td><c:set var="note">Enter comma- or newline-separated paths of specifications to exclude. Equivalent to <strong>--exclude</strong> argument.</c:set
    ><props:multilineProperty
      name="${bean.specExcludeKey}"
      className="longField"
      linkTitle="Edit specifications exclude list"
      rows="3"
      cols="49"
      expanded="${not empty propertiesBean.properties[bean.specExcludeKey]}"
      note="${note}"
      /></td>
</tr>

<tr class="advancedSetting">
  <th><label for="${bean.additionalArgs}">Additional command line parameters:</label></th>
  <td>
    <props:textProperty name="${bean.additionalArgs}" className="longField" expandable="true"/>
    <span class="error" id="error_${bean.additionalArgs}"></span>
    <span class="smallNote">Enter additional command line parameters for mspec.exe</span>
  </td>
</tr>

<props:hiddenProperty name="${testRunner.testRunnerTypeKey}" value="${testRunner.testRunnerTypeMSpecValue}"/>
