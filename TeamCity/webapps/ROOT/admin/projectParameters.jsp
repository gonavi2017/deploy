<%@ include file="/include-internal.jsp" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<jsp:useBean id="currentProject" type="jetbrains.buildServer.serverSide.SProject" scope="request"/>
<jsp:useBean id="projectParametersBean" type="jetbrains.buildServer.controllers.admin.projects.EditableUserDefinedParametersBean" scope="request"/>

<c:url var="actionUrl" value="/admin/editProjectParams.html?projectId=${currentProject.externalId}"/>
<c:url value="/admin/parameterAutocompletion.html?projectId=${currentProject.externalId}" var="autocompletionUrl"/>
<bs:unprocessedMessages/>
<admin:userDefinedParameters userParametersBean="${projectParametersBean}" parametersActionUrl="${actionUrl}" parametersAutocompletionUrl="${autocompletionUrl}"
                             readOnly="${currentProject.readOnly or not afn:permissionGrantedForProject(currentProject, 'EDIT_PROJECT')}" externalId="${currentProject.externalId}"/>

<script type="text/javascript">
  $j(document).ready(function() {
    BS.AvailableParams.attachPopups('projectId=${currentProject.externalId}', 'buildTypeParams');
    BS.VisibilityHandlers.updateVisibility('mainContent');
  });
</script>
