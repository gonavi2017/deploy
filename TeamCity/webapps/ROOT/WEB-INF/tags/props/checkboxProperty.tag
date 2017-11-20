<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="name" required="true" type="java.lang.String"%>
<%@ attribute name="checked" required="false" type="java.lang.Boolean"%>
<%@ attribute name="disabled" required="false" type="java.lang.Boolean"%>
<%@ attribute name="onclick" required="false" type="java.lang.String"%>
<%@ attribute name="style" required="false" type="java.lang.String"%>
<%@ attribute name="className" required="false" type="java.lang.String"%>
<%@ attribute name="value" required="false" type="java.lang.String"%>
<%@ attribute name="uncheckedValue" required="false" type="java.lang.String"%>
<%@ attribute name="treatFalseValuesCorrectly" required="false" type="java.lang.Boolean"%><%-- not used since 8.1 --%>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<c:set var="actualValue" value='${propertiesBean.properties[name]}'/>
<c:set var="defaultValue" value='${propertiesBean.defaultProperties[name]}'/>

<c:set var="value" value="${empty value ? 'true' : value}"/>
<c:if test="${not checked and actualValue == value}"><c:set var="checked" value="${true}"/></c:if>
<c:set var="disabled" value="${disabled ? 'disabled=true' : ''}"/>
<c:if test="${(not empty actualValue or not empty defaultValue) and actualValue != defaultValue}"><c:set var="className">${className} valueChanged</c:set></c:if>

<input type="checkbox" name="prop:${name}" id="${name}" onclick="${onclick}" ${checked ? "checked=checked" : ""} ${disabled} value="${value}"
        <c:if test="${not empty className}">class="${className}"</c:if>
        <c:if test="${not empty uncheckedValue}">unchecked-value="${uncheckedValue}"</c:if>
        style="margin:0; padding:0; ${style}"/>
