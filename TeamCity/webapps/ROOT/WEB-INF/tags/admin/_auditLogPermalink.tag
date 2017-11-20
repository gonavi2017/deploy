<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="util" uri="/WEB-INF/functions/util" %><%@
    attribute name="data" type="jetbrains.buildServer.controllers.audit.AuditLogData" required="true"

%><c:set var="myLink" value="/admin/admin.html?item=audit&actionsPerPage=${data.selectedActionsPerPage}&page=${data.pager.currentPage}"
/><c:if test="${data.actionTypeFilterApplied}"><c:set var="myLink" value="${myLink}&actionType=${util:urlEscape(data.selectedActionType.DBId)}"/></c:if
><c:if test="${data.actionTypeSetFilterApplied}"><c:set var="myLink" value="${myLink}&actionTypeSet=${util:urlEscape(data.selectedActionTypeSet.id)}"/></c:if
><c:if test="${data.objectTypeFilterApplied}"><c:set var="myLink" value="${myLink}&objectType=${util:urlEscape(data.selectedObjectType.id)}"/></c:if
><c:if test="${data.subjectTypeFilterApplied}"><c:set var="myLink" value="${myLink}&subjectType=${util:urlEscape(data.selectedSubjectType.id)}"/></c:if
><c:if test="${data.objectIdFilterApplied}"><c:set var="myLink" value="${myLink}&objectId=${util:urlEscape(data.objectId)}"/></c:if
><c:if test="${data.objectExternalIdFilterApplied}"><c:set var="myLink" value="${myLink}&objectExternalId=${util:urlEscape(data.objectExternalId)}"/></c:if
><c:if test="${data.filterScopeIdFilterApplied}"><c:set var="myLink" value="${myLink}&filterScopeId=${util:urlEscape(data.filterScopeId)}"/></c:if
><c:if test="${data.userIdFilterApplied}"><c:set var="myLink" value="${myLink}&userId=${util:urlEscape(data.selectedUserId)}"/></c:if
><c:set var="myLink"><c:url value="${myLink}"/></c:set
><a href="${myLink}">Permalink</a>