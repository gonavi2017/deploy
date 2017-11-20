<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="name" required="true" type="java.lang.String"%>
<%@ attribute name="id" required="false" type="java.lang.String"%>
<%@ attribute name="value" required="false" type="java.lang.String"%>
<%@ attribute name="disabled" required="false" type="java.lang.String"%>
<%@ attribute name="checked" required="false" type="java.lang.Boolean"%>
<%@ attribute name="style" required="false" type="java.lang.String"%>
<%@ attribute name="className" required="false" type="java.lang.String"%>
<%@ attribute name="onclick" required="false" type="java.lang.String"%>

<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>

<c:set var="disabled" value="${disabled ? 'disabled=true' : ''}"/>
<c:set var="checked" value="${(checked or (not empty value and propertiesBean.properties[name] == value)) ? 'checked=true' : ''}"/>
<c:set var="defaultValue" value="${propertiesBean.defaultProperties[name]}"/>
<c:if test="${defaultValue != propertiesBean.properties[name]}"><c:set var="className">${className} valueChanged</c:set></c:if>
<input type="radio" name="prop:${name}" id="${id}" value="${value}" <c:if test="${not empty className}">class="${className}"</c:if> style="${style}" ${disabled} ${checked} onclick="${onclick}"/>
