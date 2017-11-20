<%@ include file="/include.jsp"%>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<jsp:useBean id="cns" scope="request" class="jetbrains.buildServer.dotNetCoverage.ncover.NCoverConstants"/>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<jsp:useBean id="cbean" scope="request" type="jetbrains.buildServer.dotNetCoverage.CoverageBean"/>

<bs:changeRequest key="ckeys" value="${cns}">
  <jsp:include page="viewDotNetCoverageRuntime.jsp"/>
</bs:changeRequest>

<div class="parameter">
  Path to NCover: <props:displayValue name="dotNetCoverage.NCover.executable" emptyValue="<empty>" />
</div>

<div class="parameter">
  Path to NCoverExplorer: <props:displayValue name="${cns.explorerExecutable}" emptyValue="<empty>" />
</div>

<div class="parameter">
  Additional NCover Arguments: <props:displayValue name="dotNetCoverage.NCover.arguments" emptyValue="<empty>" showInPopup="true" popupTitle="Additional Arguments" popupLinkText="view content"/>
</div>

<div class="parameter">
  Assemblies to Profile: <props:displayValue name="dotNetCoverage.NCover.Assemblies" emptyValue="<empty>" showInPopup="true" popupTitle="Assemblies to Profile" popupLinkText="view content"/>
</div>

<div class="parameter">
  Exclude Attributes: <props:displayValue name="dotNetCoverage.NCover.ExcludeAttributes" emptyValue="<empty>" showInPopup="true" popupTitle="Excluded Assemblies" popupLinkText="view content"/>
</div>

<div class="parameter">
  Report Type: <strong><c:forEach var="type" items="${cns.reportTypeValues}"><c:if test="${type.key == propertiesBean.properties[cns.reportType]}"><c:out value="${type.value}"/></c:if></c:forEach></strong>
</div>

<div class="parameter">
  Sorting: <strong><c:forEach var="type" items="${cns.reportOrderValues}"><c:if test="${type.key == propertiesBean.properties[cns.reportOrder]}"><c:out value="${type.value}"/></c:if></c:forEach></strong>
</div>

<div class="parameter">
  Additional NCover Explorer Arguments: <props:displayValue name="${cns.explorerExecutableArgs}" emptyValue="<empty>" showInPopup="true" popupTitle="Additional Arguments" popupLinkText="view content"/>
</div>
