<%@include file="/include-internal.jsp"%>
<jsp:useBean id="triggerService" type="jetbrains.buildServer.buildTriggers.BuildTriggerService" scope="request"/>
<jsp:useBean id="buildForm" type="jetbrains.buildServer.controllers.admin.projects.EditableBuildTypeSettingsForm" scope="request"/>

<table class="runnerFormTable" style="width: 99%;">
  <c:if test="${not empty triggerService.editParametersUrl}">
    <jsp:include page="${triggerService.editParametersUrl}"/>
  </c:if> 
</table>
<c:choose>
  <c:when test="${buildForm.readOnly}">
    <script type="text/javascript">$('triggerSaveButtonsBlock').hide(); BS.EditTriggersDialog.setReadOnly([{name: 'triggerNameSelector'}, {className: 'submitButton'}])</script>
  </c:when>
  <c:otherwise><script type="text/javascript">$('triggerSaveButtonsBlock').show()</script></c:otherwise>
</c:choose>

<admin:showHideAdvancedOpts containerId="editTriggerDialog" optsKey="buildTriggers"/>
<admin:highlightChangedFields containerId="editTriggerDialog"/>
