<%@ include file="/include.jsp"%>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>

<jsp:useBean id="c3s" scope="request" class="jetbrains.buildServer.dotNetCoverage.ncover3.NCover3Constants"/>
<jsp:useBean id="cbean" scope="request" type="jetbrains.buildServer.dotNetCoverage.CoverageBean"/>

<bs:changeRequest key="ckeys" value="${c3s}">
  <jsp:include page="editDotNetCoverageRuntime.jsp"/>
</bs:changeRequest>

<tr>
  <th><label for="${c3s.ncoverPathKey}">Path to NCover 3: <l:star/></label></th>
  <td>
    <props:textProperty name="${c3s.ncoverPathKey}" className="longField"/>
    <span class="smallNote">NCover 3 installation folder. Use <strong>%<c:out value="${c3s.agentNcover32}"/>%</strong> or
      <strong>%<c:out value="${c3s.agentNcover64}"/>%</strong> to refer to autodetected NCover 3 on a build agent
    </span>
  </td>
</tr>

<tr class="noBorder">
  <th><label for="${c3s.ncoverArgsKey}">NCover Arguments:</label></th>
  <td>
    <c:set var="note">Write additional coverage tool specific arguments. Use <strong>//ias .*</strong> to profile all assemblies</c:set>
    <props:multilineProperty name="${c3s.ncoverArgsKey}" className="longField" linkTitle="Additional NCover Arguments" cols="60" rows="5" expanded="${true}" note="${note}"/>
  </td>
</tr>
<tr class="noBorder">
  <th><label for="${c3s.reporterExecutableArgsKey}">NCover Reporting Arguments:</label></th>
  <td>
    <c:set var="note">Write additional NCover.Reporting tool arguments.
      Use <strong><c:out value="${c3s.reportPath}"/></strong> as path to report folder in the reporting commandline arguments.
      Try "<strong>//or FullCoverageReport:Html:<c:out value="${c3s.reportPath}"/></strong>" to create full coverage report.</c:set>
    <props:multilineProperty name="${c3s.reporterExecutableArgsKey}" className="longField" linkTitle="Additional NCover Reporting Arguments" cols="60" rows="5" expanded="${true}" note="${note}"/>
  </td>
</tr>
<tr class="noBorder">
  <th><label for="${c3s.coverageReportIndexKey}">NCover Report Index File:</label></th>
  <td>
    <props:textProperty name="${c3s.coverageReportIndexKey}" className="longField"/>
    <span class="smallNote">Write the name of the index file (i.e. <strong>fullcoveragereport.html</strong>) in generated HTML report</span>
  </td>
</tr>

<props:hiddenProperty name="dotNetCoverage.NCover3.Reg" value="selected"/>
