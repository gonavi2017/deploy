<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<jsp:useBean id="testRunner" class="jetbrains.buildServer.dotNet.testRunner.server.DotNetTestRunnerBean"/>
<jsp:useBean id="bean" class="jetbrains.buildServer.dotNet.mspec.server.MSpecBean"/>

<div class="parameter">
  MSpec runner: <strong><props:displayValue name="${bean.pathToMSpecKey}" emptyValue="none specified"/></strong>
</div>

<div class="parameter">
  .NET Runtime:
  <strong>
    <c:set var="type" value="${propertiesBean.properties[bean.platformBitmessKey]}"/>
    <c:forEach var="item" items="${bean.platformBits}">
      <c:if test="${type eq item.value}"><c:out value="${item.description}"/></c:if>
    </c:forEach>
  </strong>

  <strong>
    <c:set var="type" value="${propertiesBean.properties[bean.platformRuntimeVersionKey]}"/>
    <c:forEach var="item" items="${bean.platformRuntimeVersions}">
      <c:if test="${type eq item.value}"><c:out value="${item.description}"/></c:if>
    </c:forEach>
  </strong>
</div>

<div class="parameter">
  Run tests from: <strong><props:displayValue name="${bean.assembliesIncludeKey}" emptyValue="none specified"/></strong>
</div>

<div class="parameter">
  Do not run tests from: <strong><props:displayValue name="${bean.assembliesExcludeKey}" emptyValue="none specified"/></strong>
</div>

<div class="parameter">
  Specifications include: <strong><props:displayValue name="${bean.specIncludeKey}" emptyValue="none specified"/></strong>
</div>

<div class="parameter">
  Specifications exclude: <strong><props:displayValue name="${bean.specExcludeKey}" emptyValue="none specified"/></strong>
</div>

<div class="parameter">
  Additional commandline parameters: <strong><props:displayValue name="${bean.additionalArgs}" emptyValue="none specified" /></strong>
</div>
