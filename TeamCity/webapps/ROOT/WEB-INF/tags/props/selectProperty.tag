<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"%>
<%@ attribute name="name" required="true" type="java.lang.String"%>
<%@ attribute name="id" required="false" type="java.lang.String"%>
<%@ attribute name="disabled" required="false" type="java.lang.String"%>
<%@ attribute name="style" required="false" type="java.lang.String"%>
<%@ attribute name="className" required="false" type="java.lang.String"%>
<%@ attribute name="onchange" required="false" type="java.lang.String"%>
<%@ attribute name="onclick" required="false" type="java.lang.String"%>
<%@ attribute name="enableFilter" required="false" type="java.lang.Boolean"%>
<%@ attribute name="multiple" required="false" type="java.lang.Boolean"%>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<c:set var="selectedValue" value="${propertiesBean.properties[name]}" scope="request"/>
<c:set var="defaultValue" value="${propertiesBean.defaultProperties[name]}"/>
<c:set var="idValue" value="${id != null ? id : name}"/>
<c:if test="${defaultValue != selectedValue}"><c:set var="className">${className} valueChanged</c:set></c:if>
<forms:select name="prop:${name}" id="${idValue}" disabled="${disabled}" className="${className}" style="padding:0; margin:0; ${style}" onchange="${onchange}" onclick="${onclick}" enableFilter="${enableFilter}" multiple="${multiple}"><jsp:doBody /></forms:select>