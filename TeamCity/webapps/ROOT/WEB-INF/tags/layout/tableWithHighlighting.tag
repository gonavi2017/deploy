<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<%@attribute name="className" required="false" %>
<%@attribute name="style" required="false" %>
<%@attribute name="mouseovertitle" required="false" %><%-- Deprecated, don't use --%>
<%@attribute name="highlightingDisabled" required="false" %>
<%@attribute name="id" required="false" %>
<%-- whether to enable table highlighting immediately after showing the table or on page load --%>
<%@attribute name="highlightImmediately" required="false" type="java.lang.Boolean"
    %><c:set var="className"><c:if test="${not highlightingDisabled}">highlightable</c:if
    ><c:if test="${not empty className}"> ${className}</c:if></c:set
><table <c:if test="${not empty id}">id="${id}"</c:if> class="${className}" style="${style}">
  <jsp:doBody/>
</table>