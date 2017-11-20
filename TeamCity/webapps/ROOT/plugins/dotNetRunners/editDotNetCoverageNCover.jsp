<%@ include file="/include.jsp"%>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<jsp:useBean id="cns" scope="request" class="jetbrains.buildServer.dotNetCoverage.ncover.NCoverConstants"/>
<jsp:useBean id="cbean" scope="request" type="jetbrains.buildServer.dotNetCoverage.CoverageBean"/>

<bs:changeRequest key="ckeys" value="${cns}">
  <jsp:include page="editDotNetCoverageRuntime.jsp"/>
</bs:changeRequest>

<tr class="noBorder">
  <th><label for="${cns.NCoverToolKey}">Path to NCover: <l:star/></label></th>
  <td>
    <props:textProperty name="${cns.NCoverToolKey}" className="longField"/>
    <span class="error" id="error_${cns.NCoverToolKey}"></span>
    <span class="smallNote">Path to coverage tool. Use <strong>%<c:out value="${cns.agentNcover}"/>%</strong> to
      refer to autodetected NCover on a build agent
    </span>
  </td>
</tr>
<tr class="noBorder">
  <th><label for="${cns.explorerExecutable}">Path to NCoverExplorer: <l:star/></label></th>
  <td>
    <props:textProperty name="${cns.explorerExecutable}" className="longField"/>
    <span class="error" id="error_${cns.explorerExecutable}"/>
    <span class="smallNote">Path to NCoverExplorer.</span>
  </td>
</tr>
<tr class="noBorder">
  <th><label for="${cns.NCoverToolArgs}">Additional NCover Arguments:</label></th>
  <td>
    <c:set var="note">Write additional coverage tool specific arguments</c:set>
    <props:multilineProperty name="${cns.NCoverToolArgs}" className="longField" linkTitle="Additional arguments" cols="60" rows="5" expanded="${true}" note="${note}"/>
  </td>
</tr>

<tr class="noBorder">
  <th><label for="${cns.NCoverToolAssemblies}">Assemblies to Profile:</label></th>
  <td>
    <c:set var="note">Write assembly names separated with new line.
      Leave blank for all assembly names (without paths and ".dll" or ".exe" extensions) to profile.
      Equivalent to //a NCover.Console option</c:set>
    <props:multilineProperty name="${cns.NCoverToolAssemblies}" className="longField" linkTitle="Assembly names to profile" cols="60" rows="5" expanded="${true}" note="${note}"/>
  </td>
</tr>
<tr class="noBorder">
  <th><label for="${cns.NCoverToolExclude}">Exclude Attributes:</label></th>
  <td>
    <c:set var="note">List of attributes making classes or methods to be excluded from coverage. Equivalent to //ea NCover.Console option</c:set>
    <props:multilineProperty name="${cns.NCoverToolExclude}" className="longField" linkTitle="Exclude Attributes" cols="60" rows="5" expanded="${true}" note="${note}"/>
  </td>
</tr>
<tr class="noBorder">
  <th><label for="${cns.reportType}">Report Type:</label></th>
  <td>
    <props:selectProperty name="${cns.reportType}" enableFilter="true" className="mediumField">
      <c:forEach var="type" items="${cns.reportTypeValues}">
        <props:option value="${type.key}"><c:out value="${type.value}"/></props:option>
      </c:forEach>
    </props:selectProperty>
  </td>
</tr>
<tr class="noBorder">
  <th><label for="${cns.reportOrder}">Sorting:</label></th>
  <td>
    <props:selectProperty name="${cns.reportOrder}" enableFilter="true" className="mediumField">
      <c:forEach var="order" items="${cns.reportOrderValues}">
        <props:option value="${order.key}"><c:out value="${order.value}"/></props:option>
      </c:forEach>
    </props:selectProperty>
  </td>
</tr>

<tr class="noBorder">
  <th><label for="${cns.explorerExecutableArgs}">Additional NCover Explorer Arguments:</label></th>
  <td>
    <c:set var="note">Write additional coverage tool specific arguments</c:set>
    <props:multilineProperty name="${cns.explorerExecutableArgs}" className="longField" linkTitle="Additional arguments" cols="60" rows="5" note="${note}"/>
  </td>
</tr>


<props:hiddenProperty name="dotNetCoverage.NCover.Reg" value="selected"/>
