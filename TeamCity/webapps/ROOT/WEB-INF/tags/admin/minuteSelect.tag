<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ attribute name="name" required="true" %>
<%@ attribute name="selectedValue" required="false" type="java.lang.Integer"%>
<%@ attribute name="minuteStep" required="false" type="java.lang.Integer"%>
<%@ attribute name="style" required="false" %>
<%@ attribute name="showEmptyOption" required="false" %>
<%@ attribute name="disabled" required="false" %>

<c:set var="step" value="${empty minuteStep ? 5 : minuteStep}"/>

<select name="${name}" id="${name}" style="${style}" ${disabled ? 'disabled="disabled"' : ''}>
  <c:if test="${showEmptyOption}">
    <option value="-1">--</option>
  </c:if>
  <c:forEach begin="0" end="59" step="${step}" varStatus="pos">
    <option value="${pos.index}" <c:if test="${pos.index == selectedValue}">selected</c:if>><c:if test="${pos.index < 10}">0</c:if>${pos.index}</option>
  </c:forEach>
</select>
