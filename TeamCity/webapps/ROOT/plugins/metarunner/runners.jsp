<%@ include file="/include-internal.jsp" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<jsp:useBean id="metaRunnersMap" scope="request" type="java.util.Map"/>
<jsp:useBean id="project" scope="request" type="jetbrains.buildServer.serverSide.SProject"/>
<jsp:useBean id="controllerPath" scope="request" type="java.lang.String"/>
<jsp:useBean id="uploadPath" scope="request" type="java.lang.String"/>
<jsp:useBean id="inlineRunnerPath" scope="request" type="java.lang.String"/>
<jsp:useBean id="resourcesPath" scope="request" type="java.lang.String"/>
<c:url var="controllerUrl" value="${controllerPath}"/>

<bs:linkCSS dynamic="${true}">
  ${resourcesPath}/runners.css
</bs:linkCSS>

<script type="text/javascript">
  BS.MetaRunners = {
    deleteRunner: function(runnerType, projectId) {
      if (!confirm("Are you sure you want to remove this meta-runner?")) return false;

      BS.ajaxRequest('${controllerUrl}', {
                       method: "post",
                       parameters: "action=delete&metaRunnerId=" + runnerType + "&projectId=" + projectId,
                       onComplete: function () {
                         BS.reload();
                       }
                     }
      );

      return false;
    }
  };

  BS.UploadMetaRunnerDialog = OO.extend(BS.AbstractWebForm, OO.extend(BS.AbstractModalDialog, OO.extend(BS.FileBrowse, {
    getContainer: function () {
      return $('uploadMetaRunnerDialog');
    },

    showDialog: function() {
      this.cleanFields();
      this.clearErrors();
      this.showCentered();
    },

    cleanFields: function() {
      $j("#fileName").val('');
      $j('#file\\:fileToUpload').val('');
    },

    closeAndRefresh: function() {
      this.close();
      BS.reload(true);
    }
  })));

  BS.InlineMetaRunnerDialog = OO.extend(BS.AbstractWebForm, OO.extend(BS.AbstractModalDialog, {
    getContainer: function () {
      return $('inlineMetaRunnerDialog');
    },

    formElement: function() {
      return $('inlineMetaRunnerForm');
    },

    showDialog: function(runnerType, projectId) {
      this.clearErrors();
      this.showCentered();

      $('inlineRunnerContent').innerHTML = '<i class="icon-refresh icon-spin"></i> Loading...';

      var url = this.formElement().action;
      BS.ajaxUpdater($('inlineRunnerContent'), url, {
        method: 'get',
        evalScripts: true,
        parameters: 'runnerType=' + runnerType + '&projectId=' + projectId
      });
      return false;
    },

    submit: function() {
      BS.FormSaver.save(this, this.formElement().action, OO.extend(BS.ErrorsAwareListener, {
        metaRunnerError: function(elem) {
          alert(elem.firstChild.nodeValue);
        },

        createBuildTypeError: function(elem) {
          alert(elem.firstChild.nodeValue);
        },

        targetProjectError: function(elem) {
          $('targetProjectError').innerHTML = elem.firstChild.nodeValue;
        },

        buildTypeExternalIdError: function(elem) {
          $('buildTypeExternalIdError').innerHTML = elem.firstChild.nodeValue;
        },

        buildTypeNameError: function(elem) {
          $('buildTypeNameError').innerHTML = elem.firstChild.nodeValue;
        },

        onSuccessfulSave: function(responseXML) {
          BS.XMLResponse.processRedirect(responseXML);
        }
      }));
      return false;
    }
  }));
</script>

<div class="metaRunnersSettings section noMargin">
  <h2 class="noBorder">Meta-Runners</h2>
  <bs:smallNote>Meta-Runner is a generalized build step that can be used across different configuration<bs:help file="Working+with+Meta-Runner"/></bs:smallNote>

  <bs:messages key="metaRunnerUploaded"/>
  <bs:messages key="metaRunnerRemoved"/>
  <bs:messages key="metaRunnerUpdated"/>

  <authz:authorize allPermissions="EDIT_PROJECT" projectId="${project.projectId}">
    <forms:addButton id="uploadMetaRunner" onclick="BS.UploadMetaRunnerDialog.showDialog(); return false">Upload Meta-Runner</forms:addButton>
  </authz:authorize>

  <c:set var="numRunners" value="${fn:length(metaRunnersMap[project])}"/>
  <c:if test="${numRunners == 0}">
    <p>
      There are no meta-runners defined in the current project.
    </p>
  </c:if>

  <c:forEach items="${metaRunnersMap}" var="entry">
    <c:set var="specs" value="${entry.value}"/>
    <c:set var="ownerProject" value="${entry.key}"/>
    <c:set var="canEditProject" value="${afn:permissionGrantedForProject(ownerProject, 'EDIT_PROJECT')}"/>
    <c:if test="${ownerProject.projectId != project.projectId}">
      <p style="margin-top: 2em">Meta-runners inherited from <admin:editProjectLink projectId="${ownerProject.externalId}"><c:out value="${ownerProject.fullName}"/></admin:editProjectLink>:</p>
    </c:if>
    <c:if test="${ownerProject.projectId eq project.projectId}">
      <p style="margin-top: 2em">Meta-runners defined in the current project:</p>
    </c:if>
    <l:tableWithHighlighting id="metaRunnersListTable" className="parametersTable">
      <thead>
        <tr>
          <th class="runnerId">Runner ID</th>
          <th class="runnerName">Name</th>
          <th colspan="3">Usages</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="it" items="${specs}">
          <c:url var="editMetaRunnerLink" value="/admin/editProject.html?projectId=${ownerProject.externalId}&tab=metaRunner&editRunnerId=${it.runType}"/>
          <tr data-id="${it.runType}">
            <td class="highlight">
              <c:out value="${it.runType}"/>
            </td>
            <td class="highlight">
              <div class="runnerName"><c:out value="${it.shortName}"/></div>
              <div class="smallNote"><bs:trimWithTooltip>${it.description}</bs:trimWithTooltip></div>
            </td>
            <td class="runnerMisc highlight">
              <bs:changeRequest key="it" value="${it}">
                <%@ include file="runnerUsages.jspf"%>
              </bs:changeRequest>
            </td>
            <td class="runnerActions runnerActions_edit highlight">
              <a href="${editMetaRunnerLink}" class="edit">${canEditProject ? 'Edit' : 'View'}</a>
            </td>
            <td class="runnerActions">
              <bs:actionsPopup controlId="mrActions${it.runType}"
                               popup_options="shift: {x: -150, y: 20}, className: 'quickLinksMenuPopup'">
                <jsp:attribute name="content">
                  <div>
                    <ul class="menuList">
                      <l:li>
                        <a href="#" title="Create build configuration from meta-runner" onclick="return BS.InlineMetaRunnerDialog.showDialog('${it.runType}', '${project.externalId}')">Create build configuration from meta-runner...</a>
                      </l:li>
                      <c:if test="${canEditProject}">
                      <l:li>
                        <c:choose>
                          <c:when test="${it.hasUsages}">
                            <a href="#" onclick="alert('This meta-runner is used and cannot be deleted.');">Delete meta-runner...</a>
                          </c:when>
                          <c:otherwise><a href="#" onclick="return BS.MetaRunners.deleteRunner('${it.runType}', '${ownerProject.externalId}')">Delete meta-runner...</a></c:otherwise>
                        </c:choose>
                      </l:li>
                      </c:if>
                    </ul>
                  </div>
                </jsp:attribute>
                <jsp:body></jsp:body>
              </bs:actionsPopup>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </l:tableWithHighlighting>
  </c:forEach>
</div>

<c:url var="action" value="${uploadPath}"/>
<bs:dialog dialogId="uploadMetaRunnerDialog"
           dialogClass="uploadDialog"
           title="Upload Meta-Runner"
           closeCommand="BS.UploadMetaRunnerDialog.close()">
  <forms:multipartForm id="uploadMetaRunnerForm" action="${action}" targetIframe="hidden-iframe" onsubmit="return BS.UploadMetaRunnerDialog.validate();">
    <table class="runnerFormTable">
      <tr>
        <th><label for="fileName">File name:</label></th>
        <td>
          <forms:textField name="fileName" value="" />
          <span class="smallNote">File name (without extension) must be valid identifier <bs:help file="Identifier"/></span>
        </td>
      </tr>
      <tr>
        <th><label for="file:fileToUpload">Meta-Runner file: <l:star/></label></th>
        <td>
          <forms:file name="fileToUpload"/>
          <span id="uploadError"  class="error hidden"></span>
        </td>
      </tr>
    </table>
    <input type="hidden" name="action" value="uploadMetaRunner"/>
    <input type="hidden" name="projectId" value="${project.externalId}"/>
    <div class="popupSaveButtonsBlock">
      <forms:submit label="Save"/>
      <forms:cancel onclick="BS.UploadMetaRunnerDialog.close()"/>
    </div>
  </forms:multipartForm>
</bs:dialog>

<script type="text/javascript">
  <c:if test="${canEditProject}">
  $j('#metaRunnersListTable').on('click', '.highlight', function (e) {
    if (e.which === 1 && ! (e.altKey || e.ctrlKey || e.shiftKey || e.metaKey)) { // `which` is normalized by jQuery
      document.location.href = $j(e.currentTarget).parent().find('.runnerActions_edit a.edit').attr('href');
      return false;
    }
  });
  </c:if>
  BS.UploadMetaRunnerDialog.setFiles([<c:forEach var="spec" items="${metaRunnersMap[project]}"><c:if test="${spec.deletable}">'${spec.runType}.xml'</c:if>,</c:forEach>]);
  BS.UploadMetaRunnerDialog.prepareFileUpload();
</script>


<bs:dialog dialogId="inlineMetaRunnerDialog"
           dialogClass=""
           title="Create Build Configuration from Meta-Runner"
           closeCommand="BS.InlineMetaRunnerDialog.close()">
  <form id="inlineMetaRunnerForm" action="<c:url value='${inlineRunnerPath}'/>" onsubmit="return BS.InlineMetaRunnerDialog.submit()">
    <div id="inlineRunnerContent"></div>

    <div class="popupSaveButtonsBlock">
      <forms:submit label="Create"/>
      <forms:cancel onclick="BS.InlineMetaRunnerDialog.close()"/>
    </div>
</form>
</bs:dialog>
