<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %><%@
  attribute name="id" required="false" %><%@
  attribute name="name" required="true" type="java.lang.String"%><%@
  attribute name="size" required="false" type="java.lang.Integer"%><%@
  attribute name="maxlength" required="false" type="java.lang.Integer"%><%@
  attribute name="style" required="false" type="java.lang.String"%><%@
  attribute name="className" required="false" type="java.lang.String"%><%@
  attribute name="disabled" required="false" type="java.lang.String"%><%@
  attribute name="onchange" required="false" type="java.lang.String"%><%@
  attribute name="onclick" required="false" type="java.lang.String"%><%@
  attribute name="onkeyup" required="false" type="java.lang.String"%><%@
  attribute name="expandable" required="false" type="java.lang.Boolean"%><%@
  attribute name="value" required="false" type="java.lang.String"
%><jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"
  /><c:set var="id" value="${empty id ? name : id}"
  /><c:set var="actualValue" value="${empty value ? propertiesBean.properties[name] : value}"
  /><c:set var="defValue" value="${propertiesBean.defaultProperties[name]}"
  /><c:if test="${defValue != actualValue}"><c:set var="className">${className} valueChanged</c:set></c:if
  ><forms:textField name="prop:${name}" id="${id}" expandable="${expandable}" value="${actualValue}" size="${size}" maxlength="${maxlength}" style="${style}" className="textProperty ${className}" disabled="${disabled == 'disabled' || disabled == 'true'}" onchange="${onchange}" onclick="${onclick}" onkeyup="${onkeyup}"/>
