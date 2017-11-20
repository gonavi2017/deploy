<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="util" uri="/WEB-INF/functions/util" %><%@
    attribute name="cameFromSupport" required="false" type="jetbrains.buildServer.web.util.CameFromSupport"%><%@
    attribute name="id" type="java.lang.String"%><%@
    attribute name="onclick" type="java.lang.String"%><%@
    attribute name="href" type="java.lang.String"%><%@
    attribute name="label" type="java.lang.String"%><%@
    attribute name="showdiscardchangesmessage" type="java.lang.String"
%><c:set var="cancelCommand"
    ><c:if test="${not empty onclick}"> onclick="${onclick}; return false"</c:if
    ><c:if test="${not empty href}"> href="${href}"</c:if
></c:set
><c:if test="${empty label}"><c:set var="label">Cancel</c:set></c:if
><c:set var="id"><c:if test="${not empty id}"> id="${id}"</c:if></c:set
><c:set var="showdiscardchangesmessage"><c:if test="${not empty showdiscardchangesmessage}"> showdiscardchangesmessage="${showdiscardchangesmessage}"</c:if></c:set
><c:choose
    ><c:when test="${not empty cameFromSupport}"><a class="btn cancel" href="${util:escapeUrlForQuotes(cameFromSupport.cameFromUrl)}" ${id} ${showdiscardchangesmessage}>${label}</a></c:when
    ><c:otherwise><a class="btn cancel" ${cancelCommand} ${id} ${showdiscardchangesmessage}>${label}</a></c:otherwise
></c:choose
><script>BS.fixCancel();</script>