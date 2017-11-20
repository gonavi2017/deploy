<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include-internal.jsp" %>

<jsp:useBean id="healthStatusItem" type="jetbrains.buildServer.serverSide.healthStatus.HealthStatusItem" scope="request"/>
<jsp:useBean id="showMode" type="jetbrains.buildServer.web.openapi.healthStatus.HealthStatusItemDisplayMode" scope="request"/>

<%--@elvariable id="buildType" type="jetbrains.buildServer.serverSide.SBuildType"--%>
<c:set var="buildType" value="${healthStatusItem.additionalData['buildType']}"/>
<%--@elvariable id="buildTypeTemplate" type="jetbrains.buildServer.serverSide.BuildTypeTemplate"--%>
<c:set var="buildTypeTemplate" value="${healthStatusItem.additionalData['buildTypeTemplate']}"/>
<%--@elvariable id="buildTypeTemplate" type="java.util.Set<java.lang.String>"--%>
<c:set var="errors" value="${healthStatusItem.additionalData['errors']}"/>

<c:choose>
  <c:when test="${not empty buildType}">
    <c:set var="target" value="${buildType}"/>
    <div>
      <%@include file="_renderBuildType.jspf"%>
    </div>
  </c:when>
  <c:when test="${not empty buildTypeTemplate}">
    <c:set var="target" value="${buildTypeTemplate}"/>
    <div>
      <%@include file="_renderTemplate.jspf"%>
    </div>
  </c:when>
</c:choose>