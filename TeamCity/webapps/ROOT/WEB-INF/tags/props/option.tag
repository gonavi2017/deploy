<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ attribute name="value" required="true" type="java.lang.String"
  %><%@ attribute name="selected" required="false" type="java.lang.Boolean"
  %><%@ attribute name="id" required="false" type="java.lang.String"
  %><%@ attribute name="currValue" required="false" type="java.lang.String"
  %><%@ attribute name="title" required="false" type="java.lang.String"
  %><%@ attribute name="className" required="false" type="java.lang.String"%>

<c:if test="${not empty currValue}"><c:set var="selectedValue">${currValue}</c:set></c:if>
<c:set var="selected" value="${selected or (value == selectedValue) ? 'selected' : ''}"/>

<option value="${value}" data-title="<c:out value='${title}'/>" <c:if test="${not empty id}">id="${id}"</c:if> <c:if test="${not empty className}">class="${className}" </c:if>${selected}><jsp:doBody/></option>
