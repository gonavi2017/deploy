<%@include file="/include-internal.jsp"%>
<jsp:useBean id="buildFeature" type="jetbrains.buildServer.serverSide.BuildFeature" scope="request"/>
<jsp:useBean id="buildForm" type="jetbrains.buildServer.controllers.admin.projects.EditableBuildTypeSettingsForm" scope="request"/>

<table class="runnerFormTable featureDetails">
  <c:if test="${not empty buildFeature.editParametersUrl}">
    <jsp:include page="${buildFeature.editParametersUrl}"/>
  </c:if>
</table>
<c:choose>
  <c:when test="${buildForm.readOnly}">
    <script type="text/javascript">$('featureSaveButtonsBlock').hide(); BS.BuildFeatureDialog.setReadOnly([{name: 'featureTypeSelector'}, {className: 'submitButton'}, {name: 'buildFailureOnMessage.finishedBuildId'}])</script>
  </c:when>
  <c:otherwise><script type="text/javascript">$('featureSaveButtonsBlock').show()</script></c:otherwise>
</c:choose>

<admin:showHideAdvancedOpts containerId="buildFeatures" optsKey="buildFeatures"/>
<admin:highlightChangedFields containerId="buildFeatures"/>
