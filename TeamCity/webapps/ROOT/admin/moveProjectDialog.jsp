<%@ include file="/include-internal.jsp"
%><jsp:useBean id="project" type="jetbrains.buildServer.serverSide.SProject" scope="request"
/><jsp:useBean id="parents" type="java.util.List" scope="request"
/><c:url value='/admin/moveProject.html' var="moveAction"

/><bs:modalDialog formId="moveProjectForm"
                      title="Move Project"
                      action="${moveAction}"
                      closeCommand="BS.MoveProjectForm.cancelDialog()"
                      saveCommand="BS.MoveProjectForm.submitMove()">
  <label for="parentId" >Move to project:<bs:help file="Creating+and+Editing+Projects" anchor="MovingProject"/></label>

  <bs:projectsFilter name="parentId" id="newParentId" style="width: 30em;"
                     defaultOption="true"
                     projectBeans="${parents}"
                     disableProjectExternalId="${project.parentProject.externalId}"/>
  <span class="error" id="errorParent"></span>

  <c:set var="subProjectsNum" value="${fn:length(project.projects)}"/>
  <c:if test="${subProjectsNum > 0}">
    <div style="margin-top: 0.5em;">
      This project has <b>${subProjectsNum}</b> subproject<bs:s val="${subProjectsNum}"/>, which will also be moved.
    </div>
  </c:if>

  <script type="text/javascript">
    $('moveProjectForm').parentId.onchange = function() {
      var selectedIdx = this.selectedIndex;
      var moveImpossibleEl = $('moveProjectImpossibleDescription');
      if (selectedIdx < 1) {
        moveImpossibleEl.hide();
        $('moveProjectButton').disable();
        return;
      }

      var id = this.options[selectedIdx].value;

      $('moveProjectButton').disable();
      BS.MoveForm.checkCanMove(id, 'projectId=' + '${project.externalId}', 'Project', function(msg) {
        if (msg != null) {
          moveImpossibleEl.show();
          moveImpossibleEl.innerHTML = msg;
        } else {
          moveImpossibleEl.hide();
          moveImpossibleEl.innerHTML = '';
          $('moveProjectButton').enable();
        }
      });
    }

  </script>

  <div id="moveProjectImpossibleDescription" style="display: none; margin-top: 0.5em;"></div>

  <div class="popupSaveButtonsBlock">
    <forms:submit label="Move" id="moveProjectButton"/>
    <forms:cancel onclick="BS.MoveProjectForm.cancelDialog()"/>
    <forms:saving id="moveProjectProgress"/>
  </div>

  <input type="hidden" name="projectId" value="${project.externalId}"/>
</bs:modalDialog>
