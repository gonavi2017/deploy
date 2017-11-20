<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="util" uri="/WEB-INF/functions/util"%><%@

    attribute name="additionalClasses" type="java.lang.String" required="false"%><%@
    attribute name="id" type="java.lang.String"%><%@
    attribute name="href" type="java.lang.String"%><%@
    attribute name="title" type="java.lang.String"%><%@
    attribute name="target" type="java.lang.String"%>

<c:if test="${empty href}"><c:set var="href">#</c:set></c:if>
<c:set var="classes">tc-icon_before icon16 addNew<c:if test="${not empty additionalClasses}"> ${additionalClasses}</c:if></c:set>
<c:set var="id"><c:if test="${not empty id}"> id="${id}"</c:if></c:set>
<c:set var="title"><c:if test="${not empty title}"> title="${title}"</c:if></c:set>
<c:set var="target"><c:if test="${not empty target}"> target="${target}"</c:if></c:set>
<a class="${classes}" href="${href}" ${id} ${title} ${target}><jsp:doBody/></a>
