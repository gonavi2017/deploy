<%@ include file="/include.jsp"%>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<jsp:useBean id="pns" scope="request" class="jetbrains.buildServer.dotNetCoverage.partCover.PartCoverConstants"/>
<jsp:useBean id="cbean" scope="request" type="jetbrains.buildServer.dotNetCoverage.CoverageBean"/>

<bs:changeRequest key="ckeys" value="${pns}">
  <jsp:include page="viewDotNetCoverageRuntime.jsp"/>
</bs:changeRequest>

<div class="parameter">
  Path to PartCover: <props:displayValue name="dotNetCoverage.PartCover.executable" emptyValue="<empty>"/>
</div>

<div class="parameter">
  Additional PartCover Arguments: <props:displayValue name="dotNetCoverage.PartCover.arguments" emptyValue="<empty>" showInPopup="true" popupTitle="Additional arguments" popupLinkText="view content"/>
</div>

<div class="parameter">
  Include Assemblies: <props:displayValue name="dotNetCoverage.PartCover.includes" emptyValue="<empty>" showInPopup="true" popupTitle="Assemblies to profile" popupLinkText="view content"/>
</div>

<div class="parameter">
  Exclude Assemblies: <props:displayValue name="dotNetCoverage.PartCover.excludes" emptyValue="<empty>" showInPopup="true" popupTitle="Assemblies to exclude" popupLinkText="view content"/>
</div>

<div class="parameter">
  Report XSLT: <props:displayValue name="${pns.reportXslts}" emptyValue="<empty>" showInPopup="true" popupTitle="Assemblies to exclude" popupLinkText="view content"/>
</div>
