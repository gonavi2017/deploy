<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    attribute name="respInfo" required="true" rtexprvalue="true" type="jetbrains.buildServer.responsibility.ResponsibilityEntry" %><%@
    attribute name="doNotUseAssigned" required="false" type="java.lang.Boolean" %><%@
    taglib prefix="responsible" uri="/WEB-INF/functions/resp"
    
%><c:set var="action" value="${responsible:isActive(respInfo) ? (doNotUseAssigned ? '' : 'assigned') : 'done'}"
/><c:if test="${responsible:hasResponsible(respInfo) && respInfo.reporterUser != null &&
                respInfo.responsibleUser.id != respInfo.reporterUser.id}"> (${action} by <c:out value="${respInfo.reporterUser.descriptiveName}"/>)</c:if>