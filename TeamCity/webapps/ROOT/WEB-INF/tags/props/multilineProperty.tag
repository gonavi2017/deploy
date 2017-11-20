<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ attribute name="name" required="true" %>
<%@ attribute name="linkTitle" required="true" %>
<%@ attribute name="cols" required="true" type="java.lang.Integer" %>
<%@ attribute name="rows" required="true" type="java.lang.Integer" %>
<%@ attribute name="onkeydown" required="false"%>
<%@ attribute name="style" required="false"%>
<%@ attribute name="expanded" required="false" type="java.lang.Boolean" rtexprvalue="true" %>
<%@ attribute name="disabled" required="false" type="java.lang.Boolean"%>
<%@ attribute name="className" required="false"%>
<%@ attribute name="value" required="false" type="java.lang.String"
%><%@ attribute name="note" required="false" type="java.lang.String"
%><jsp:useBean id="propertiesBean" type="jetbrains.buildServer.controllers.BasePropertiesBean" scope="request"/>
<c:set var="actualValue" value="${empty value ? propertiesBean.properties[name] : value}" />
<c:set var="defaultValue" value="${propertiesBean.defaultProperties[name]}" />
<c:if test="${defaultValue != actualValue}"><c:set var="className">${className} valueChanged</c:set></c:if>
<c:if test="${empty expanded}"><c:set var="expanded" value="${fn:length(actualValue) > 0}"/></c:if>
<c:set var="noteClasses">smallNote<c:if test="${not expanded}"> smallNote_hidden</c:if></c:set>
<props:textarea name="${name}" textAreaName="prop:${name}" value="${actualValue}"
                linkTitle="${linkTitle}" cols="${cols}" rows="${rows}" disabled="${disabled}"
                expanded="${expanded}" onkeydown="${onkeydown}" style="${style}" className="${className}"/>
<span id="error_${name}" class="error expanded_${expanded}"></span><c:if test="${not empty note}"
    ><span class="${noteClasses}" id="note_${name}">
  ${note}
</span></c:if>