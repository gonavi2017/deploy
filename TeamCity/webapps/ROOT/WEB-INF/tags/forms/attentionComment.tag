<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"

%><%@ attribute name="additionalClasses" type="java.lang.String" required="false"%><%@
    attribute name="id" type="java.lang.String"

%><c:set var="classes">tc-icon_before icon16 attentionComment<c:if test="${not empty additionalClasses}"> ${additionalClasses}</c:if></c:set
><c:set var="id"><c:if test="${not empty id}"> id="${id}"</c:if></c:set

><div class="${classes}" ${id}><jsp:doBody/></div>