<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>

<jsp:useBean id="ckeys" scope="request" type="jetbrains.buildServer.dotNetCoverage.CoveragePlatformKeys"/>
<jsp:useBean id="cbean" scope="request" type="jetbrains.buildServer.dotNetCoverage.CoverageBean"/>

<tr class="noBorder">
  <th rowspan="3"><label>.NET Runtime: </label></th>
  <td>
    <label for="${ckeys.platformBitness}" class="fixedLabel">Platform:</label>
    <props:selectProperty name="${ckeys.platformBitness}" enableFilter="true" className="smallField">
      <c:forEach var="item" items="${cbean.platformBitness}">
        <props:option value="${item.value}"><c:out value="${item.description}"/></props:option>
      </c:forEach>
    </props:selectProperty>
  </td>
</tr>

<tr>
  <td>
    <label for="${ckeys.platformVersion}" class="fixedLabel">Version:</label>
    <props:selectProperty name="${ckeys.platformVersion}" enableFilter="true" className="smallField">
      <c:forEach var="item" items="${cbean.platformVersions}">
        <props:option value="${item.value}"><c:out value="${item.description}"/></props:option>
      </c:forEach>
    </props:selectProperty>
  </td>
</tr>

<tr>
  <td>
    <span class="smallNote">
      Specify .NET Runtime to be used to start .NET Coverage tool.
      Select 'auto' to let OS decide what runtime to use
    </span>
  </td>
</tr>
