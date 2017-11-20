<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>

<jsp:useBean id="ckeys" scope="request" type="jetbrains.buildServer.dotNetCoverage.CoveragePlatformKeys"/>
<jsp:useBean id="cbean" scope="request" type="jetbrains.buildServer.dotNetCoverage.CoverageBean"/>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>

<div class="parameter">
  Coverage runner .NET Runtime:
  <strong>
    <c:set var="aType" value="${propertiesBean.properties[ckeys.platformBitness]}"/>
    <c:forEach var="item" items="${cbean.platformBitness}">
      <c:if test="${aType eq item.value}"><c:out value="${item.description}"/></c:if>
    </c:forEach>
  </strong>

  <strong>
    <c:set var="aType" value="${propertiesBean.properties[ckeys.platformVersion]}"/>
    <c:forEach var="item" items="${cbean.platformVersions}">
      <c:if test="${aType eq item.value}"><c:out value="${item.description}"/></c:if>
    </c:forEach>
  </strong>

</div>
