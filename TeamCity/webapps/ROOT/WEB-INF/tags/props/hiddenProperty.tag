<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="name" required="true" type="java.lang.String"%>
<%@ attribute name="value" required="false" type="java.lang.String"%>
<%@ attribute name="id" required="false" type="java.lang.String"%>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<c:set var="defaultValue" value="${propertiesBean.defaultProperties[name]}"/>
<c:choose>
  <c:when test="${empty value}">
    <c:set var="actualValue" value="${propertiesBean.properties[name]}"/>
  </c:when>
  <c:otherwise>
    <c:set var="actualValue" value="${value}"/>
  </c:otherwise>
</c:choose>
<c:choose>
  <c:when test="${not empty id}">
    <c:set var="idActual">${id}</c:set>
  </c:when>
  <c:otherwise>
    <c:set var="idActual">${name}</c:set>
  </c:otherwise>
</c:choose>
<input type="hidden"
       name="prop:${name}"
       id="${idActual}"
       value="${actualValue}"
       class="${defaultValue != actualValue ? 'valueChanged' : ''}"
    />
