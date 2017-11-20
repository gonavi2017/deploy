<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="util" uri="/WEB-INF/functions/util"%><%@
    attribute name="type" type="java.lang.String"%><%@
    attribute name="id" type="java.lang.String"%><%@
    attribute name="onclick" type="java.lang.String"%><%@
    attribute name="name" type="java.lang.String"%><%@
    attribute name="className" type="java.lang.String"%><%@
    attribute name="disabled" type="java.lang.Boolean"%><%@
    attribute name="label" required="true" type="java.lang.String"%>
<c:set var="type"><c:choose><c:when test="${not empty type}">${type}</c:when><c:otherwise>submit</c:otherwise></c:choose></c:set>
<c:set var="id"><c:if test="${not empty id}"> id="${id}"</c:if></c:set>
<c:set var="name"><c:if test="${not empty name}"> name="${name}"</c:if></c:set>
<c:set var="onclick"><c:if test="${not empty onclick}"> onclick="${onclick}"</c:if></c:set>
<c:set var="disabled"><c:if test="${disabled}"> disabled="disabled"</c:if></c:set>
<input type="${type}" value="${label}" class="btn btn_primary submitButton ${className}" ${id} ${onclick} ${name} ${disabled} />
<c:if test="${not empty sessionScope['tc-csrf-token']}">
  <input type="hidden" name="tc-csrf-token" value="${sessionScope['tc-csrf-token']}">
</c:if>
