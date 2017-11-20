<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="afn" uri="/WEB-INF/functions/authz" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>

<%@ attribute name="pageUrl" type="java.lang.String" required="true" %>
<%@ attribute name="reportTabsForm" type="jetbrains.buildServer.controllers.admin.reportTabs.EditReportTabsForm" required="true" %>
<%@ attribute name="project" type="jetbrains.buildServer.serverSide.SProject" required="true" %>

<c:set var="isRoot" value="${project.rootProject}"/>
<bs:refreshable containerId="reportTabsList" pageUrl="${pageUrl}">
  <bs:messages key="reportTabsUpdated"/>

<c:if test="${not project.readOnly and afn:permissionGrantedForProject(project, 'EDIT_PROJECT')}">
  <div style="margin-bottom: 2em">
    <c:if test="${not isRoot}">
      <forms:addButton onclick="BS.ProjectReportTabDialog.show(); return false">Create new project report tab</forms:addButton>
    </c:if>
    <forms:addButton onclick="BS.BuildReportTabDialog.show(); return false">Create new build report tab</forms:addButton>
  </div>
</c:if>

  <c:set var="reportTabs" value="${reportTabsForm.buildReportTabs}"/>
  <%@include file="/admin/reports/tabs/_buildReportTabs.jspf" %>

  <c:if test="${not isRoot}">
    <c:set var="projectReportTabs" value="${reportTabsForm.projectReportTabs}"/>
    <%@include file="/admin/reports/tabs/_projectReportTabs.jspf" %>
  </c:if>
</bs:refreshable>
