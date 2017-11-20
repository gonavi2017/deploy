<%@ page import="jetbrains.buildServer.controllers.admin.projects.BuildConfigurationSteps" %>
<%@ page import="jetbrains.buildServer.web.openapi.healthStatus.HealthStatusItemDisplayMode" %>
<%@ include file="/include-internal.jsp"%>
<jsp:useBean id="healthStatusItem" type="jetbrains.buildServer.serverSide.healthStatus.HealthStatusItem" scope="request"/>
<c:set var="targetBuildTypeExtId" value="${healthStatusItem.additionalData['targetBuildTypeExtId']}"/>
<c:set var="dependentBuildType" value="${healthStatusItem.additionalData['dependentBuildType']}"/>
<jsp:useBean id="showMode" type="jetbrains.buildServer.web.openapi.healthStatus.HealthStatusItemDisplayMode" scope="request"/>
<jsp:useBean id="healthStatusReportUrl" type="java.lang.String" scope="request"/>

<c:set var="inplaceMode" value="<%=HealthStatusItemDisplayMode.IN_PLACE%>"/>
<c:set var="cameFromUrl" value="${showMode eq inplaceMode ? pageUrl : healthStatusReportUrl}"/>
<admin:viewOrEditBuildTypeLinkFull buildType="${dependentBuildType}" step="<%=BuildConfigurationSteps.DEPENDENCIES_STEP_ID%>"/>
has an artifact dependency on a missing build configuration with the id '<c:out value="${targetBuildTypeExtId}"/>'

