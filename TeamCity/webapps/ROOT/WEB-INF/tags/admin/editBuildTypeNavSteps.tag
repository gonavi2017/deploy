<%@ tag import="java.util.Map" %>
<%@ tag import="jetbrains.buildServer.controllers.admin.projects.ConfigurationStep" %>
<%@ tag import="jetbrains.buildServer.controllers.admin.projects.EditBuildTypeForm" %>
<%@ tag import="jetbrains.buildServer.controllers.admin.projects.EditTemplateForm" %>
<%@ tag import="jetbrains.buildServer.controllers.admin.projects.EditableBuildTypeSettingsForm" %>
<%@ tag import="jetbrains.buildServer.serverSide.BuildTypeTemplate" %>
<%@ tag import="jetbrains.buildServer.serverSide.SBuildType" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ attribute name="settings" required="true" type="jetbrains.buildServer.serverSide.BuildTypeSettings"
  %><%
  String settingsId = settings instanceof SBuildType ? EditBuildTypeForm.getSettingsId(((SBuildType)settings).getExternalId()) : EditTemplateForm.getSettingsId(((BuildTypeTemplate)settings).getExternalId());
  final Map<String,ConfigurationStep> configurationSteps = EditableBuildTypeSettingsForm.getConfigurationSteps(settingsId, null, settings);

  request.setAttribute("buildConfigSteps", new java.util.ArrayList<jetbrains.buildServer.controllers.admin.projects.ConfigurationStep>(configurationSteps.values()));
  request.setAttribute("buildConfigStepsMap", configurationSteps);
%>
