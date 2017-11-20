<%@ include file="/include-internal.jsp" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<jsp:useBean id="buildForm" type="jetbrains.buildServer.controllers.admin.projects.EditableBuildTypeSettingsForm" scope="request"/>
<admin:editBuildTypePage selectedStep="runType">
  <jsp:attribute name="head_include">
    <bs:linkCSS>
      /css/admin/iprSettings.css
      /css/admin/runParams.css
    </bs:linkCSS>
  </jsp:attribute>
  <jsp:attribute name="body_include">

    <form id="editBuildTypeForm" action="<c:url value='/admin/editRunType.html?id=${buildForm.settingsId}&runnerId=${buildForm.buildRunnerBean.id}'/>"
          method="post" onsubmit="return BS.EditBuildRunnerForm.submitBuildRunner('${buildForm.settingsId}')">

    <div id="runnerParams" class="clearfix">
      <jsp:include page="/admin/runnerParams.html">
        <jsp:param name="runTypeInfoKey" value="${empty param['runTypeInfoKey'] ? buildForm.multipleRunnersBean.currentBuildRunnerBean.runTypeInfoKey : param['runTypeInfoKey']}"/>
      </jsp:include>
    </div>

    <script type="text/javascript">
      BS.updateRunnerContainer = function() {
        var runType = $('runTypeInfoKey').getValue();
        BS.Util.show('chooseRunnerProgress');
        BS.MultilineProperties.clearProperties();
        BS.EditBuildRunnerForm.removeUpdateStateHandlers();

        BS.ajaxUpdater($('runnerParams'), '<c:url value="/admin/runnerParams.html?id=${buildForm.settingsId}&runnerId=${buildForm.buildRunnerBean.id}&runTypeInfoKey="/>' + runType, {
          evalScripts : true,
          onComplete: function() {
            if (runType == '') {
              $('saveButtons').hide();
            } else {
              $('saveButtons').show();
            }

            BS.EditBuildRunnerForm.setupEventHandlers('${buildForm.settingsId}');
            BS.Util.hide('chooseRunnerProgress');
            BS.EditBuildRunnerForm.saveInSession();
            BS.AvailableParams.attachPopups('settingsId=${buildForm.settingsId}', 'textProperty', 'multilineProperty');
            BS.EditBuildRunnerForm.setupCtrlEnterForTextareas('${buildForm.settingsId}');
          }
        });
      };

      <c:if test="${empty buildForm.multipleRunnersBean.currentBuildRunnerBean.runTypeInfoKey}">
        $j(document).ready(function() {
          $j('#runTypeInfoKey').prevAll('input').focus();
        });
      </c:if>
    </script>

    <c:if test="${not buildForm.buildRunnerBean.inherited}">
    <div class="saveButtonsBlock" id="saveButtons" style="${not buildForm.buildRunnerBean.runnerTypeSelected ? 'display:none' : 'display:block'}">
      <forms:submit name="submitButton" label="Save"/>
      <forms:cancel cameFromSupport="${buildForm.cameFromSupport}"/>
      <forms:saving/>

      <input type="hidden" value="${buildForm.numberOfSettingsChangesEvents}" name="numberOfSettingsChangesEvents"/>
    </div>
    </c:if>

    </form>
    <forms:modified/>

    <script type="text/javascript">
    <c:if test="${not buildForm.buildRunnerBean.inherited}">
    BS.MultilineProperties.updateVisible();
    BS.EditBuildRunnerForm.setupEventHandlers('${buildForm.settingsId}');
    BS.EditBuildRunnerForm.setModified(${buildForm.buildRunnerBean.stateModified});
    </c:if>
    <c:if test="${buildForm.readOnly or buildForm.buildRunnerBean.inherited}">
    BS.EditBuildRunnerForm.setReadOnly();
    </c:if>
    BS.AvailableParams.attachPopups('settingsId=${buildForm.settingsId}', 'textProperty', 'multilineProperty');
    BS.EditBuildRunnerForm.setupCtrlEnterForTextareas('${buildForm.settingsId}');
    </script>
  </jsp:attribute>
</admin:editBuildTypePage>
