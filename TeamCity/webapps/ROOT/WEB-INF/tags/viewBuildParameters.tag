<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ attribute name="buildParameters" type="jetbrains.buildServer.controllers.buildType.ParametersBean" required="true"
  %><%@attribute name="nameValueSeparator" required="false" %>
<c:set var="separator" value="${empty nameValueSeparator ? ':' : nameValueSeparator}"/>
<div class="parameter"><span class="groupTitle2">Configuration parameters:</span> <c:if test="${empty buildParameters.configurationParameters}">none defined</c:if></div>

<c:if test="${not empty buildParameters.configurationParameters}">
<div class="nestedParameter">
<table class="settings">
  <tr>
    <th class="name" style="width: 30%;">Name</th>
    <th class="name" style="width: 70%;">Value</th>
  </tr>
  <c:forEach items="${buildParameters.configurationParameters}" var="val">
    <tr>
      <td style="white-space: nowrap;"><c:out value="${val.nameWithPrefix}"/></td>
      <td>
        <bs:out value="${val.value}"/>
      </td>
    </tr>
  </c:forEach>
</table>
</div>
</c:if>

<div class="parameter"><span class="groupTitle2">System properties:</span> <c:if test="${empty buildParameters.systemProperties}">none defined</c:if></div>

<c:if test="${not empty buildParameters.systemProperties}">
<div class="nestedParameter">
<table class="settings">
  <tr>
    <th class="name" style="width: 30%;">Name</th>
    <th class="name" style="width: 70%;">Value</th>
  </tr>
<c:forEach items="${buildParameters.systemProperties}" var="val">
  <tr>
    <td style="white-space: nowrap;"><c:out value="${val.nameWithPrefix}"/></td>
    <td>
      <bs:out value="${val.value}"/>
    </td>
  </tr>
</c:forEach>
</table>
</div>
</c:if>

<div class="parameter"><span class="groupTitle2">Environment variables:</span> <c:if test="${empty buildParameters.environmentVariables}">none defined</c:if></div>
<c:if test="${not empty buildParameters.environmentVariables}">
  <div class="nestedParameter">
  <table class="settings">
    <tr>
      <th class="name" style="width: 30%;">Name</th>
      <th class="name" style="width: 70%;">Value</th>
    </tr>
  <c:forEach items="${buildParameters.environmentVariables}" var="val">
    <tr>
      <td style="white-space: nowrap;"><c:out value="${val.nameWithPrefix}"/></td>
      <td>
        <bs:out value="${val.value}"/>
      </td>
    </tr>
  </c:forEach>
  </table>
  </div>
</c:if>


<c:if test="${not empty buildParameters.dependencyParameters}">
  <div class="parameter"><span class="groupTitle2">Dependency parameters (redefined):</span></div>
  <div class="nestedParameter">
    <table class="settings">
      <tr>
        <th class="name" style="width: 30%;">Name</th>
        <th class="name" style="width: 70%;">Value</th>
      </tr>
      <c:forEach items="${buildParameters.dependencyParameters}" var="val">
        <tr>
          <td style="white-space: nowrap;"><c:out value="${val.nameWithPrefix}"/></td>
          <td>
            <bs:out value="${val.value}"/>
          </td>
        </tr>
      </c:forEach>
    </table>
  </div>
</c:if>
