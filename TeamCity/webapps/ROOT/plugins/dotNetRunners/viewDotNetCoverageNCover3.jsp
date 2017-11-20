<%@ include file="/include.jsp"%>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<jsp:useBean id="c3s" scope="request" class="jetbrains.buildServer.dotNetCoverage.ncover3.NCover3Constants"/>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<jsp:useBean id="cbean" scope="request" type="jetbrains.buildServer.dotNetCoverage.CoverageBean"/>

<bs:changeRequest key="ckeys" value="${c3s}">
  <jsp:include page="viewDotNetCoverageRuntime.jsp"/>
</bs:changeRequest>

<div class="parameter">
  Path to NCover 3: <props:displayValue name="${c3s.ncoverPathKey}" emptyValue="<empty>"/>
</div>

<div class="parameter">
  NCover Arguments: <props:displayValue name="${c3s.ncoverArgsKey}" emptyValue="<empty>" showInPopup="true" popupTitle="NCover Arguments"/>
</div>

<div class="parameter">
  NCover Reporting Arguments: <props:displayValue name="${c3s.reporterExecutableArgsKey}" emptyValue="<empty>" showInPopup="true" popupTitle="NCover Reporting Arguments"/>
</div>

<div class="parameter">
  NCover Reporting File: <props:displayValue name="${c3s.coverageReportIndexKey}" emptyValue="<default>"/>
</div>

<props:hiddenProperty name="dotNetCoverage.NCover3.Reg" value="selected"/>
