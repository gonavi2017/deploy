<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@
    attribute name="valFailed" type="java.lang.Integer" required="true" %><%@
    attribute name="valIgnored" type="java.lang.Integer" required="true" %><%@
    attribute name="noText" type="java.lang.Boolean"%><c:if test="${valFailed + valIgnored > 0}">
  &nbsp;(<c:if test="${valFailed > 0}"><strong style="color: darkred">${valFailed}</strong><c:if test="${not noText}"> failed</c:if></c:if><c:if test="${valFailed > 0 and valIgnored > 0}">,
</c:if><c:if test="${valIgnored > 0}"><strong style="color: gray;">${valIgnored}</strong><c:if test="${not noText}"> ignored</c:if></c:if>)</c:if>