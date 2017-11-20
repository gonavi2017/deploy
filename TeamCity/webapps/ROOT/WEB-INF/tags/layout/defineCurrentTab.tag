<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="util" uri="/WEB-INF/functions/util" %><%@
    attribute name="defaultTab" %><%@
    variable name-given="currentTab" scope="AT_END"
%><c:set var="currentTab" value="${util:escapeUrlForQuotes(param['tab'])}" scope="request"
/><c:if test="${empty currentTab}"
    ><c:set var="currentTab" value="${util:escapeUrlForQuotes(defaultTab)}" scope="request"
/></c:if>