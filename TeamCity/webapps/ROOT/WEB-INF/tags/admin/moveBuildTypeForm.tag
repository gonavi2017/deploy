<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %><%@
    taglib prefix="afn" uri="/WEB-INF/functions/authz" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %><%@
    taglib prefix="l" tagdir="/WEB-INF/tags/layout" %><%@
    attribute name="sourceBuildType" required="true" type="jetbrains.buildServer.serverSide.SBuildType" %><%@
    attribute name="editableProjectBeans" required="true" type="java.util.List"
%><c:url value='/admin/moveBuildType.html' var="moveAction"/>
<bs:modalDialog formId="moveBuildTypeForm"
                title="Move Build Configuration"
                action="${moveAction}"
                closeCommand="BS.MoveBuildTypeForm.cancelDialog()"
                saveCommand="BS.MoveBuildTypeForm.submitMove()">
  <table>
    <tr>
      <td>
        <label for="moveToProjectId" style="padding-right: 1em;">Move to project:</label>
      </td>
      <td>
        <bs:projectsFilter id="moveToProjectId" name="projectId"
                           className="longField"
                           defaultOption="true"
                           disableRoot="true"
                           disableProjectExternalId="${sourceBuildType.projectExternalId}"
                           projectBeans="${editableProjectBeans}"/>
        <span class="error" id="error_moveBuildTypeForm_projectId"></span>
      </td>
    </tr>
  </table>

  <script type="text/javascript">
    $('moveBuildTypeForm').projectId.onchange = function() {
      var selectedIdx = this.selectedIndex;
      var moveImpossibleEl = $('moveImpossibleDescription');
      if (selectedIdx < 1) {
        moveImpossibleEl.hide();
        $('moveBuildTypeButton').disable();
        return;
      }

      var id = this.options[selectedIdx].value;

      $('moveBuildTypeButton').disable();
      BS.MoveBuildTypeForm.checkCanMove(id, 'buildTypeId=' + '${sourceBuildType.externalId}', 'Build configuration', function(msg) {
        if (msg != null) {
          moveImpossibleEl.show();
          moveImpossibleEl.innerHTML = msg;
        } else {
          moveImpossibleEl.hide();
          moveImpossibleEl.innerHTML = '';
          $('moveBuildTypeButton').enable();
        }
      });
    }
  </script>

  <div id="moveImpossibleDescription" style="display: none; margin-top: 0.5em;"></div>

  <div class="popupSaveButtonsBlock">
    <forms:submit name="moveBuildType" id="moveBuildTypeButton" label="Move"/>
    <forms:cancel onclick="BS.MoveBuildTypeForm.cancelDialog()" showdiscardchangesmessage="false"/>
    <forms:saving id="moveBuildTypeProgress"/>
  </div>

  <input type="hidden" name="buildTypeId" id="buildTypeId" value="${sourceBuildType.buildTypeId}"/>
  <input type="hidden" name="sourceProjectId" id="sourceProjectId" value="${sourceBuildType.projectExternalId}"/>
</bs:modalDialog>
