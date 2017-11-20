<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="name" required="true" %>
<%@ attribute name="id" required="false" %>
<%@ attribute name="style" required="false" type="java.lang.String"%>
<%@ attribute name="className" required="false" type="java.lang.String"%>
<%@ attribute name="checked" required="false" type="java.lang.Boolean"%>
<%@ attribute name="onclick" required="false"%>
<%@ attribute name="value" required="false"%>
<%@ attribute name="title" required="false"%>
<%@ attribute name="disabled" required="false" type="java.lang.Boolean"%><c:set var="idVal" value="${empty id ? name : id}"
  /><input type="radio"
       name="${name}"
       id="${idVal}"
       <c:if test="${not empty className}">class="${className}"</c:if>
       style="${style}"
       onclick="${onclick}"
       <c:if test="${checked == true}">checked</c:if>
       value="${empty value ? 'true' : value}"
       <c:if test="${not empty title}">title="${title}"</c:if>
       <c:if test="${disabled}">disabled="disabled"</c:if>/>