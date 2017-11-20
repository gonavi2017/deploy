<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    attribute name="handleId" rtexprvalue="true" %><%@
    attribute name="expandedIcon" %><%-- deprecated and is actually never used --%><%@
    attribute name="collapsedIcon" %><%-- deprecated and is actually never used --%><%@
    attribute name="collapsed" %><%@
    attribute name="imgTitle" %><%@
    attribute name="cssOnly" type="java.lang.Boolean" %><%-- deprecated and is actually never used --%><%@
    attribute name="additionalClasses" required="false"

%><c:if test="${empty imgTitle}"><c:set var="imgTitle" value="Click to collapse/expand details"/></c:if
 ><c:set var="state_class" value="${collapsed ? 'handle_collapsed' : 'handle_expanded'}"
/><span title="${imgTitle}" class="icon icon16 handle ${state_class}<c:if test="${not empty additionalClasses}"
> ${additionalClasses}</c:if>" <c:if test="${not empty handleId}">id="blockHandle${handleId}"</c:if>></span>