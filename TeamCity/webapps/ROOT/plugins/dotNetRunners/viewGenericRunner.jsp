<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<jsp:useBean id="testRunner" class="jetbrains.buildServer.dotNet.testRunner.server.DotNetTestRunnerBean"/>
<jsp:useBean id="bean" class="jetbrains.buildServer.dotNet.genericRunner.server.GenericRunnerBean"/>

<div class="parameter">
  .NET process runner: <strong><props:displayValue name="${bean.pathKey}" emptyValue="none specified"/></strong>
</div>
<div class="parameter">
  Command line parameters: <strong><props:displayValue name="${bean.args}" emptyValue="none specified" /></strong>
</div>

<props:viewWorkingDirectory/>

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
