<%@ include file="/include.jsp"%>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<jsp:useBean id="pns" scope="request" class="jetbrains.buildServer.dotNetCoverage.partCover.PartCoverConstants"/>
<jsp:useBean id="cbean" scope="request" type="jetbrains.buildServer.dotNetCoverage.CoverageBean"/>

<bs:changeRequest key="ckeys" value="${pns}">
  <jsp:include page="editDotNetCoverageRuntime.jsp"/>
</bs:changeRequest>


<tr class="noBorder">
  <th><label for="dotNetCoverage.PartCover.executable">Path to PartCover: <l:star/></label></th>
  <td>
    <props:textProperty name="dotNetCoverage.PartCover.executable" className="longField"/>
    <span class="smallNote">Path to coverage tool</span>
  </td>
</tr>
<tr class="noBorder">
  <th><label for="dotNetCoverage.PartCover.arguments">Additional PartCover Arguments:</label></th>
  <td>
    <props:multilineProperty name="dotNetCoverage.PartCover.arguments" className="longField" linkTitle="Additional arguments" cols="60" rows="5" expanded="${true}"
        note="Write additional coverage tool specific arguments"/>
  </td>
</tr>
<tr>
  <th><label for="dotNetCoverage.PartCover.includes">Include Assemblies:</label></th>
  <td>
    <c:set var="note">PartCover include pattern: [Assembly]Namespace, where Assembly and Namespace are wildcards. Use <strong>[*]*</strong> to include all assemblies</c:set>
    <props:multilineProperty name="dotNetCoverage.PartCover.includes" className="longField" linkTitle="Include patterns" cols="60" rows="5" expanded="${true}" note="${note}"/>
  </td>
</tr>
<tr>
  <th><label for="dotNetCoverage.PartCover.excludes">Exclude Assemblies:</label></th>
  <td>
    <props:multilineProperty name="dotNetCoverage.PartCover.excludes" className="longField" linkTitle="Exclude patterns" cols="60" rows="5" expanded="${true}"
        note="PartCover exclude pattern: [Assembly]Namespace, where Assembly and Namespace are wildcards"/>
  </td>
</tr>

<tr>
  <th><label for="${pns.reportXslts}">Report XSLT:</label></th>
  <td>
    <c:set var="note">Write xslt transformation rules one per line in format: file.xslt=&gt;generatedFileName.html,
      where file.xslt path should be relative to checkout directory.
      <br /><strong>Note that default xslt files bundled with PartCover 2.3 are broken and you need to write your own xslt files to be able to generate reports.</strong>
    </c:set>
    <props:multilineProperty name="${pns.reportXslts}" className="longField" linkTitle="Report xslt" cols="60" rows="5" expanded="${true}" note="${note}"/>
  </td>
</tr>
<props:hiddenProperty name="dotNetCoverage.PartCover.Reg" value="selected"/>
