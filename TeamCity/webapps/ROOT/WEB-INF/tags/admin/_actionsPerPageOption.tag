<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ attribute name="value" type="java.lang.Integer" required="true"
%><%@ attribute name="auditLogData" type="jetbrains.buildServer.controllers.audit.AuditLogData" required="true"
%><option <c:if test="${auditLogData.selectedActionsPerPage == value}">selected="true"</c:if> value="${value}">${value}</option>