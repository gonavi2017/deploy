<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
%><%@attribute name="buildTypeForm" type="jetbrains.buildServer.controllers.admin.projects.BuildTypeForm" required="true"
%><%@attribute name="fieldName" type="java.lang.String" required="true"
%><%@attribute name="optionName" type="java.lang.String" required="true"
%><%@attribute name="labelText" required="true" fragment="true"
%><%@attribute name="afterTextField" required="false" fragment="true"
%><%@attribute name="expandable" type="java.lang.Boolean" required="false"
%><%@attribute name="minheight" type="java.lang.String" required="false"
%><%--
  deprecated:  do not use "style" attribute, there's "className" and CSS for doing that
--%><%@attribute name="style" required="false" fragment="false"
%><%@attribute name="className" required="false" fragment="false" %>
<c:set var="enabled" value="${buildTypeForm.typedOptions[optionName].modifiable}"/>
<c:set var="hasSpec" value="${buildTypeForm.typedOptions[optionName].controlDescription != null}"/>
<c:set var="definedVal" value="${buildTypeForm.typedOptions[optionName].value}"/>
<c:set var="defaultVal" value="${buildTypeForm.typedOptions[optionName].defaultValue}"/>
<c:set var="actualVal">${buildTypeForm.optionValues[optionName]}</c:set>
<c:set var="changed" value="${actualVal != defaultVal}"/>
<c:set var="template" value="${buildTypeForm.settings.template}"/>
<c:set var="labelText"><jsp:invoke fragment="labelText"/></c:set>
<c:set var="className">${className} ${changed ? 'valueChanged' : ''}</c:set>
<div class="textOptionWrapper">
<label for="${fieldName}">${labelText}</label>
<forms:textField name="${fieldName}"
                 value="${actualVal}"
                 className="${className}"
                 expandable="${expandable}"
                 minheight="${minheight}"
                 disabled="${not enabled}"/>
<input type="hidden" name="removedOptions" id="removedOptions_${optionName}" value=""/>
<c:if test="${not empty afterTextField}"><jsp:invoke fragment="afterTextField"/></c:if>
<c:if test="${buildTypeForm.definedOptions[optionName] != null and not buildTypeForm.readOnly}"><a href="#" id="resetLink_${optionName}" onclick="$('${fieldName}').value = '<bs:escapeForJs text="${defaultVal}"/>'; $('removedOptions_${optionName}').value = '${optionName}'; $(this).hide(); if ($('inheritedOpt_${optionName}')) $('inheritedOpt_${optionName}').show(); return false" class="resetLink" showdiscardchangesmessage="false">Reset</a></c:if>
<c:if test="${hasSpec}">
  <c:choose>
    <c:when test="${not empty buildTypeForm.definedOptions[optionName] && buildTypeForm.definedOptions[optionName] != actualVal}">
      <i class="icon-lock undefinedParam" title="Actual value '${buildTypeForm.definedOptions[optionName]}' defined in this configuration is overriden by enforced settings"></i>
    </c:when>
    <c:otherwise>
      <i class="icon-lock protectedSetting" title="This option is bounded"></i>
    </c:otherwise>
  </c:choose>
</c:if>
<c:if test="${template != null}"><span class="inheritedParam" id="inheritedOpt_${optionName}" style="${buildTypeForm.definedOptions[optionName] != null ? 'display: none' : ''}"> (inherited)</span></c:if>
</div>
