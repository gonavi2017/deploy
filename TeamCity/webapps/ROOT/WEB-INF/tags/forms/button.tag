<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="util" uri="/WEB-INF/functions/util"%><%@
    attribute name="id" type="java.lang.String"%><%@
    attribute name="href" type="java.lang.String"%><%@
    attribute name="onclick" type="java.lang.String"%><%@
    attribute name="title" type="java.lang.String"%><%@
    attribute name="onmouseover" type="java.lang.String"%><%@
    attribute name="onmouseout" type="java.lang.String"%><%@
    attribute name="target" type="java.lang.String"%><%@
    attribute name="className" type="java.lang.String"%><%@
    attribute name="disabled" type="java.lang.Boolean"%><%@
    attribute name="showdiscardchangesmessage" type="java.lang.String"
%><c:if test="${empty href}"><c:set var="href">#</c:set></c:if
><c:set var="id"><c:if test="${not empty id}"> id="${id}"</c:if></c:set
><c:set var="onclick"><c:if test="${not empty onclick and not disabled}"> onclick="${onclick}"</c:if></c:set
><c:set var="title"><c:if test="${not empty title}"> title="${title}"</c:if></c:set
><c:set var="onmouseover"><c:if test="${not empty onmouseover}"> onmouseover="${onmouseover}"</c:if></c:set
><c:set var="onmouseout"><c:if test="${not empty onmouseout}"> onmouseout="${onmouseout}"</c:if></c:set
><c:set var="target"><c:if test="${not empty target}"> target="${target}"</c:if></c:set
><c:set var="showdiscardchangesmessage"><c:if test="${not empty showdiscardchangesmessage}"> showdiscardchangesmessage="${showdiscardchangesmessage}"</c:if></c:set
><c:set var="disabled"><c:if test="${disabled}"> disabled="disabled"</c:if></c:set
><a class="btn ${className}" href="${href}"${id}${onclick}${title}${onmouseout}${onmouseover}${target}${showdiscardchangesmessage}${disabled}><jsp:doBody/></a>