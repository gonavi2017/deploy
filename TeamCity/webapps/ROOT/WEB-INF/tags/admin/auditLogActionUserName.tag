<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@attribute name="auditLogAction" required="true" type="jetbrains.buildServer.serverSide.audit.AuditLogAction"
%><c:choose><c:when test="${auditLogAction.userAction}"><c:set var="user" value="${auditLogAction.user}"
/><c:if test="${not empty user}"><c:out value="${user.descriptiveName}"/></c:if
><c:if test="${empty user}">&lt;user account deleted&gt;</c:if></c:when><c:otherwise>&lt;system action&gt;</c:otherwise
></c:choose>