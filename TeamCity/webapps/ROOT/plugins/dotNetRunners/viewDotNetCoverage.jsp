<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<jsp:useBean id="coverage" scope="request" type="jetbrains.buildServer.dotNetCoverage.CoverageTypeForm"/>
<jsp:useBean id="teamcityPluginResourcesPath" scope="request" type="java.lang.String"/>
<jsp:useBean id="cbean" scope="request" type="jetbrains.buildServer.dotNetCoverage.CoverageBean"/>

<c:set var="foundCoverageType" value="${false}"/>
<c:forEach items="${coverage.types}" var="type">
  <c:if test="${propertiesBean.properties[cbean.coverageToolNameField] eq type.id}">
    <c:set var="foundCoverageType" value="${true}"/>
    <div class="parameter">
      .NET Code Coverage: <strong><c:out value="${type.name}"/></strong>
    </div>

    <jsp:include page="${teamcityPluginResourcesPath}/${type.viewPage}"/>
  </c:if>
</c:forEach>


<c:if test="${not foundCoverageType}">
  <div class="parameter">
    .NET Code Coverage: <strong>disabled</strong>
  </div>
</c:if>