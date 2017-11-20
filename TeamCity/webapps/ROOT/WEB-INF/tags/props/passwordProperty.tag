<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="name" required="true" type="java.lang.String"%>
<%@ attribute name="size" required="false" type="java.lang.Integer"%>
<%@ attribute name="maxlength" required="false" type="java.lang.Integer"%>
<%@ attribute name="style" required="false" type="java.lang.String"%>
<%@ attribute name="className" required="false" type="java.lang.String"%>
<%@ attribute name="disabled" required="false" type="java.lang.String"%>
<%@ attribute name="onchange" required="false" type="java.lang.String"%>
<%@ attribute name="autofill" required="false" type="java.lang.Boolean"%>

<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>

<%
  String random = String.valueOf(Math.random());
  request.setAttribute("randomValue", random);
%>

<c:set var="disabled" value="${disabled ? 'disabled=true' : ''}"/>
<c:set var="value" value="${propertiesBean.properties[name] != null ? requestScope['randomValue'] : ''}"/>
<c:if test="${not empty value}"><c:set var="className">${className} valueChanged</c:set></c:if>

<c:if test="${not autofill}"><!-- These fake fields are a workaround to disable chrome autofill -->
<input style="visibility:hidden;height:0;width:1px;position:absolute;left:0;top:0" type="text" value=" "/>
<input style="visibility:hidden;height:0;width:1px;position:absolute;left:0;top:0" type="password" value=" " autocomplete="new-password"/>
</c:if>

<input type="password"
       name="prop:${name}"
       id="${name}"
       value="${value}"
       size="${size}"
       maxlength="${maxlength}"
       style="${style}"
       class="textProperty ${className}"
       onkeyup="{
          if ($('prop:encrypted:${name}').value == '') return;
          if (this.value == '${value}') return;
          $('prop:encrypted:${name}').value = '';
       }"
       onchange="${onchange}"
       onfocus="this.select()"
       autocomplete="new-password"
       ${disabled}/>
<input type="hidden" name="prop:encrypted:${name}" id="prop:encrypted:${name}" value="<%=propertiesBean.getEncryptedPropertyValue(name)%>"/>

