<%@ page import="jetbrains.buildServer.maven.util.ServerMavenUtil" %>
<!-- Snapshot trigger does not have any options -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/include-internal.jsp"%>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<jsp:useBean id="propertiesBean" type="jetbrains.buildServer.controllers.BasePropertiesBean" scope="request"/>
<c:set var="warnOfMultipleMavenSteps" value="<%=ServerMavenUtil.hasMultipleMavenRunners((jetbrains.buildServer.serverSide.BuildTypeSettings)request.getAttribute(jetbrains.buildServer.controllers.admin.projects.triggers.ShowTriggerParametersController.BUILD_TYPE_SETTINGS_PARAM))%>"/>
<tr>
  <td colspan="2">
    <em>Maven Snapshot Dependencies Trigger will add a new build to the queue when the content of any snapshot dependency changes in the remote repository.</em><bs:help file="Configuring+Maven+Triggers" anchor="MavenSnapshotDependencyTrigger"/>
    <c:if test="${warnOfMultipleMavenSteps}">
    <div class="icon_before icon16 attentionComment" style="margin-top:0.5em;">This build configuration contains multiple Maven build steps. The trigger will take dependency information only from the first Maven step.</div>
    </c:if>
  </td>
</tr>
<tr>
  <td colspan="2">
    <props:checkboxProperty name="skipIfRunning"/><label for="skipIfRunning">Do not trigger a build if currently running builds can produce snapshot dependencies</label>
  </td>
</tr>