<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ attribute name="name" required="true" type="java.lang.String"%>
<%@ attribute name="style" required="false" type="java.lang.String"%>
<%@ attribute name="checkedValue" required="false" type="java.lang.String"%>
<%@ attribute name="uncheckedValue" required="false" type="java.lang.String"%>

<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<c:set var="_checkedValue" value="${checkedValue ? checkedValue : 'ON'}"/>
<c:set var="_uncheckedValue" value="${uncheckedValue ? uncheckedValue : 'OFF'}"/>

<c:choose>
  <c:when test="${not empty propertiesBean.properties[name]}"><c:out value="${_checkedValue}"/></c:when>
  <c:otherwise><c:out value="${_uncheckedValue}"/></c:otherwise>
</c:choose>
