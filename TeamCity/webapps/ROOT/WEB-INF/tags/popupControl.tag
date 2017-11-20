<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    attribute name="showPopupCommand" required="true" %><%@
    attribute name="hidePopupCommand" required="true" %><%@
    attribute name="stopHidingPopupCommand" required="true" %><%@
    attribute name="controlId" required="true" %><%@
    attribute name="style" required="false" %><%@
    attribute name="clazz" required="false" %><%@
    attribute name="type" required="false"%><%@
    attribute name="topRightButton" required="false"
%><c:set var="clazz">pc<c:if test="${not empty type}"
> pc_${type}</c:if><c:if test="${not empty clazz}"
> ${clazz}</c:if><c:if test="${not empty topRightButton}"
> pc_topRightButton</c:if></c:set
><span class="${clazz}"<c:if test="${not empty style}"> style="${style}"</c:if> onmouseover="${stopHidingPopupCommand}" onmouseout="${hidePopupCommand}"
><span class="pc__label"><jsp:doBody/></span><span class="pc__toggle-wrapper">&nbsp;<span id="${controlId}" onmouseover="${showPopupCommand}" onclick="_tc_es(event)" class="icon icon16 toggle"></span></span></span>
