<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="afn" uri="/WEB-INF/functions/authz" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>

<%@ attribute name="title" type="java.lang.String" required="true" %>
<%@ attribute name="isProjectTab" type="java.lang.Boolean" required="false" %>
<%@ attribute name="reportTabsForm" type="jetbrains.buildServer.controllers.admin.reportTabs.EditReportTabsForm" required="true" %>
<%@ attribute name="project" type="jetbrains.buildServer.serverSide.SProject" required="false"%>
<c:set var="isRoot" value="${project.rootProject}"/>

<c:url var="action" value="/admin/action.html"/>

<%@include file="/admin/reports/dialogs/_buildReportTabDialog.jspf" %>
<%@include file="/admin/reports/dialogs/_projectReportTabDialog.jspf" %>