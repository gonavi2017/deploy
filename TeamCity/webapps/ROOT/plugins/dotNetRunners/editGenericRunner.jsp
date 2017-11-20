<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<jsp:useBean id="testRunner" class="jetbrains.buildServer.dotNet.testRunner.server.DotNetTestRunnerBean"/>
<jsp:useBean id="bean" class="jetbrains.buildServer.dotNet.genericRunner.server.GenericRunnerBean"/>

<tr>
  <th><label for="${bean.pathKey}">Path: <l:star/></label></th>
  <td><props:textProperty name="${bean.pathKey}" className="longField"/><bs:vcsTree fieldId="${bean.pathKey}"/>
    <span class="error" id="error_${bean.pathKey}"></span>
    <span class="smallNote">Specify the path to the .NET executable.</span></td>
</tr>

<tr>
  <th><label for="${bean.args}">Command line parameters:</label></th>
  <td><props:multilineProperty
      name="${bean.args}"
      linkTitle="Edit command line"
      rows="3"
      cols="60"
      expanded="${true}" className="longField"
      note="Newline- or space-separated command line parameters are supported."
      />
  </td>
</tr>

<props:workingDirectory />

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

<props:hiddenProperty name="${testRunner.testRunnerTypeKey}" value="${testRunner.genericRunnerValue}"/>
