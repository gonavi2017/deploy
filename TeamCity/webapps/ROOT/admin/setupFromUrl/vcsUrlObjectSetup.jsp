<%@include file="/include-internal.jsp"%>
<jsp:useBean id="vcsUrlObjectSetupBean" type="jetbrains.buildServer.controllers.admin.projects.setupFromUrl.VcsUrlObjectSetupBean" scope="request"/>
<jsp:useBean id="cameFromSupport" type="jetbrains.buildServer.web.util.CameFromSupport" scope="request"/>
<bs:linkCSS>
  /css/admin/vcsSettings.css
</bs:linkCSS>

<div>
  VCS repository connection has been verified.
  <c:if test="${vcsUrlObjectSetupBean.objectType == 'PROJECT'}">
  Please review project and build configuration names and click <strong>Proceed</strong> to create new project.
  </c:if>
  <c:if test="${vcsUrlObjectSetupBean.objectType == 'BUILD_TYPE'}">
  Please review build configuration name and click <strong>Proceed</strong> to create new build configuration.
  </c:if>
</div>

<div style="margin-top: 1em">

<c:url value="/admin/vcsUrlObjectSetup.html" var="action"/>
<form id="createProjectForm" action="${action}" method="post" onsubmit="return BS.VcsUrlObjectSetupForm.submit()">

<table class="runnerFormTable">
  <c:if test="${vcsUrlObjectSetupBean.objectType == 'PROJECT'}">
  <tr>
    <th>Project name: <l:star/></th>
    <td>
      <forms:textField name="projectName" value="${vcsUrlObjectSetupBean.projectName}" className="longField"/>
      <span class="error" id="error_projectName"></span>
      <span class="error" id="error_persistFailed"></span>
    </td>
  </tr>
  </c:if>
  <tr>
    <th>Build configuration name: <l:star/></th>
    <td>
      <forms:textField name="buildTypeName" value="${vcsUrlObjectSetupBean.buildTypeName}" className="longField"/>
      <span class="error" id="error_buildTypeName"></span>
      <c:if test="${vcsUrlObjectSetupBean.objectType == 'BUILD_TYPE'}">
        <span class="error" id="error_persistFailed"></span>
      </c:if>
    </td>
  </tr>
  <tr>
    <th>VCS Repository:</th>
    <td>
      (<c:out value="${vcsUrlObjectSetupBean.detectedVcs.displayName}"/>) <c:out value="${vcsUrlObjectSetupBean.repositoryUrl}"/>
      <span class="error" id="error_vcsRoot"></span>
    </td>
  </tr>
</table>

<div class="saveButtonsBlock">
  <input type="hidden" name="selectedVcsRootId" value=""/>
  <input type="hidden" name="skipDuplicateVcsRootCheck" value="false"/>
  <forms:submit name="createProject" label="Proceed"/>
  <forms:cancel cameFromSupport="${cameFromSupport}"/>
  <forms:saving/>
</div>

<input type="hidden" id="parentProjectId" name="parentProjectId" value="${vcsUrlObjectSetupBean.parentProject.externalId}"/>
</form>

</div>

<script type="text/javascript">
  BS.VcsUrlObjectSetupForm = OO.extend(BS.AbstractWebForm, {
    formElement: function() {
      return $('createProjectForm');
    },

    submit: function() {
      var that = this;
      BS.FormSaver.save(this, this.formElement().action, OO.extend(BS.ErrorsAwareListener, {
        projectName: function(elem) {
          $j('#error_projectName').text(elem.firstChild.nodeValue);
          that.highlightErrorField($("projectName"));
        },

        buildTypeName: function(elem) {
          $j('#error_buildTypeName').text(elem.firstChild.nodeValue);
          that.highlightErrorField($("buildTypeName"));
        },

        persistFailed: function(elem) {
          $j('#error_persistFailed').text(elem.firstChild.nodeValue);
        },

        vcsRoot: function(elem) {
          $j('#error_vcsRoot').text(elem.firstChild.nodeValue);
        },

        duplicateVcsRootsFound: function(elem) {
          BS.DuplicateVcsRootsDialog.showDialog(elem.firstChild.nodeValue,
                                                function (vcsRootId) {
                                                  BS.VcsUrlObjectSetupForm.formElement().selectedVcsRootId.value = vcsRootId;
                                                  BS.VcsUrlObjectSetupForm.submit();
                                                },
                                                function () {
                                                  BS.VcsUrlObjectSetupForm.formElement().skipDuplicateVcsRootCheck.value = 'true';
                                                  BS.VcsUrlObjectSetupForm.submit();
                                                });
        },

        onSuccessfulSave: function(responseXml) {
          BS.XMLResponse.processRedirect(responseXml);
        }
      }));
      return false;
    }
  });
</script>

<admin:duplicateVcsRootsDialog/>
