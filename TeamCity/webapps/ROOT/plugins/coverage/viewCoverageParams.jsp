<%@ page import="jetbrains.buildServer.runner.CoverageConstants" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<jsp:useBean id="coverageRunnersMap" scope="request" type="java.util.Map"/>
<c:set var="coverageRunnerProp" value="<%=CoverageConstants.COVERAGE_RUNNER%>"/>
<c:set var="coverageRunner" value="${propertiesBean.properties[coverageRunnerProp]}"/>
<c:if test="${empty coverageRunner}">
  <div class="parameter">Java code coverage: <strong>disabled</strong></div>
</c:if>
<c:if test="${not empty coverageRunner}">
<div class="parameter">
  Java coverage runner: <strong><c:out value="${coverageRunnersMap[coverageRunner].displayName}"/></strong>
</div>

<c:choose>
  <c:when test="${coverageRunner == 'IDEA'}">
    <div class="nestedParameter">
      Include patterns: <props:displayValue name="teamcity.coverage.idea.includePatterns" emptyValue="none specified"/>
    </div>
    <div class="nestedParameter">
      Exclude patterns: <props:displayValue name="teamcity.coverage.idea.excludePatterns" emptyValue="none specified"/>
    </div>
  </c:when>
  <c:when test="${coverageRunner == 'EMMA'}">
    <div class="nestedParameter">
      Coverage instrumentation parameters: <props:displayValue name="teamcity.coverage.emma.instr.parameters" emptyValue="none specified"/>
    </div>

    <div class="nestedParameter">
      Include source files in coverage data:
      <c:choose>
        <c:when test="${propertiesBean.properties['teamcity.coverage.emma.include.source']}">
          <strong>ON</strong>
        </c:when>
        <c:otherwise>
          <strong>OFF</strong>
        </c:otherwise>
      </c:choose>
    </div>
  </c:when>
  <c:when test="${coverageRunner == 'JACOCO'}">
    <div class="nestedParameter">

      Include patterns: <props:displayValue name="teamcity.coverage.jacoco.includePatterns" emptyValue="none specified"/>
    </div>
    <div class="nestedParameter">
      Exclude patterns: <props:displayValue name="teamcity.coverage.jacoco.excludePatterns" emptyValue="none specified"/>
    </div>
  </c:when>
</c:choose>
</c:if>