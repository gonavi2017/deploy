<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="propName" value="teamcity.tests.runRiskGroupTestsFirst"/>
<%--@elvariable id="propertiesBean" type="jetbrains.buildServer.controllers.BasePropertiesBean"--%>
<c:set var="propValue" value="${propertiesBean.properties[propName]}"/>
<c:set var="recentlyFailedGroup" value="recentlyFailed"/>
<c:set var="newAndModifiedGroup" value="newAndModified"/>
<c:set var="affectedTestsDepsBasedGroup" value="affectedTestsDependencyBased"/>

<div class="parameter">
  Reduce test failure feedback time: <c:if test="${empty propValue}"><strong>OFF</strong></c:if>
  <c:if test="${not empty propValue}">
  <ul style="margin: 0;">
    <c:if test="${fn:contains(propValue, recentlyFailedGroup)}"><li>run recently failed tests first</li></c:if>
    <c:if test="${fn:contains(propValue, newAndModifiedGroup)}"><li>run new and modified tests first</li></c:if>
    <c:if test="${fn:contains(propValue, affectedTestsDepsBasedGroup)}"><li>run affected tests only (dependency based)</li></c:if>
  </ul>
  </c:if>
</div>
