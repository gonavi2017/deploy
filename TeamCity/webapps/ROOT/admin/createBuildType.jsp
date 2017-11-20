<%@include file="/include-internal.jsp"%>
<jsp:useBean id="project" type="jetbrains.buildServer.serverSide.SProject" scope="request"/>
<jsp:useBean id="availableParents" type="java.util.List" scope="request"/>
<jsp:useBean id="cameFromSupport" type="jetbrains.buildServer.web.util.CameFromSupport" scope="request"/>
<bs:linkCSS>
  /css/admin/adminMain.css
  /css/admin/buildTypeForm.css
</bs:linkCSS>
<style type="text/css">
  #createFromTemplateParams table.runnerFormTable td {
    border-right: 0;
    padding: 8px;
  }

  #createFromTemplateParams table.runnerFormTable td.name {
    width: 26%;
  }

  #createFromTemplateParams table.runnerFormTable td.value {
    width: 74%;
  }

  #createFromTemplateParams table.runnerFormTable td.value div {
    width: 70%;
  }
</style>

<div id="container" class="clearfix" style="width:70%;">
  <bs:unprocessedMessages/>

  <c:url value='/admin/createBuildType.html' var="actionUrl"/>
  <c:set var="templates" value="${project.availableTemplates}"/>
  <form id="createBuildTypeForm" action="${actionUrl}" onsubmit="return BS.CreateBuildTypeForm.submit()">
    <table class="runnerFormTable">
      <tr>
        <th>
          <label for="parentProjectId"><strong>Parent project:</strong></label>
        </th>
        <td>
          <bs:projectsFilter name="parentProjectId" id="parentProjectId" className="longField"
                             projectBeans="${availableParents}"
                             selectedProjectExternalId="${project.externalId}"
                             disableRoot="true" onchange="BS.CreateBuildTypeForm.parentProjectChanged(this.options[this.selectedIndex].value)"/>
          <span class="error" id="error_parentProject"></span>
        </td>
      </tr>

      <tr>
        <th>
          <label for="buildTypeName"><strong>Name: <l:star/></strong></label>
        </th>
        <td>
          <forms:textField name="buildTypeName" maxlength="80" className="longField"/>
          <span class="error" id="error_buildTypeName"></span>
          <span class="error" id="error_createBuildTypeFailed"></span>
        </td>
      </tr>
      <tr>
        <th>
          <label for="buildTypeExternalId"><strong>Build configuration ID: <l:star/></strong><bs:help file="Identifier"/></label>
        </th>
        <td>
          <forms:textField name="buildTypeExternalId" maxlength="80" className="longField"/>
          <span class="smallNote">This ID is used in URLs, REST API, HTTP requests to the server, and configuration settings in the TeamCity Data Directory.</span>
          <span class="error" id="error_buildTypeExternalId"></span>
        </td>
      </tr>
      <tr>
        <th><label for="description">Description:</label></th>
        <td><forms:textField name="description" className="longField" maxlength="256" value=""/></td>
      </tr>
      <c:if test="${not empty templates}">
        <tr id="templateChooserContainer">
          <th>
            <label for="templateId"><strong>Based on template:</strong></label>
          </th>
          <td>
            <forms:select name="templateId" style="width: 30em;" enableFilter="true" onchange="BS.CreateBuildTypeForm.onTemplateChange()">
              <option value="">&lt;Do not attach to a template&gt;</option>
              <c:set var="curPrj" value=""/>
              <c:forEach items="${templates}" var="template">
                <c:if test="${template.projectId != curPrj}">
                  <forms:option value="">-- <c:out value="${template.project.fullName}"/> project templates --</forms:option>
                  <c:set var="curPrj" value="${template.projectId}"/>
                </c:if>
                <forms:option value="${template.externalId}" selected="${templateId == template.externalId}"><c:out value="${template.name}"/></forms:option>
              </c:forEach>
            </forms:select> <forms:saving id="templateParamsUpdateProgress" style="float: none;"/>
            <span class="error" id="error_templateId"></span>
          </td>
        </tr>
      </c:if>
    </table>

    <div id="createFromTemplateParams"></div>

    <div class="saveButtonsBlock">
      <forms:submit name="createBuildType" label="Create"/>
      <forms:saving id="createProgress"/>
    </div>

  </form>

  <script type="text/javascript">
    <jsp:include page="/js/bs/editBuildType.js"/>

    BS.AdminActions.prepareBuildTypeIdGenerator("buildTypeExternalId", "buildTypeName", $('parentProjectId'));

    BS.CreateBuildTypeForm = OO.extend(BS.AbstractWebForm, {
      parentProjectChanged: function (projectId) {
        if (!projectId) return;
        var href = document.location.href;
        document.location.href = href.replace("projectId=${project.externalId}", "projectId=" + projectId);
      },

      formElement: function () {
        return $('createBuildTypeForm');
      },

      savingIndicator: function () {
        return $('createProgress');
      },

      onTemplateChange: function() {
        var curProjectId = '${project.externalId}';
        this.clearErrors();
        var selectedTemplateId = $j('#templateId').find("option:selected").val();
        this._prepareForTemplateId(selectedTemplateId, curProjectId);
      },

      _prepareForTemplateId: function (templateId, curProjectId) {
        $('createFromTemplateParams').innerHTML = '';
        var that = this;

        if (!templateId) {
          return;
        }

        this.disable();
        BS.TemplateParametersLoader.loadParameters(
            "templateId=" + templateId + "&projectId=" + curProjectId,
            "createFromTemplateParams",
            "templateParamsUpdateProgress",
            function () {
              that.enable();
              BS.VisibilityHandlers.updateVisibility(that.formElement());
            }
        );
      },

      submit: function () {
        var that = this;
        BS.FormSaver.save(this, this.formElement().action, OO.extend(BS.ErrorsAwareListener, {
          createFailed: function (elem) {
            $('error_createBuildTypeFailed').innerHTML = fixErrorMessage(elem.firstChild.nodeValue);
          },

          invalidName: function (elem) {
            this.emptyName(elem);
          },

          emptyName: function (elem) {
            $('error_buildTypeName').innerHTML = fixErrorMessage(elem.firstChild.nodeValue);
            that.highlightErrorField($("buildTypeName"));
          },

          onParentProjectNotFoundError: function (elem) {
            $('error_parentProject').innerHTML = fixErrorMessage(elem.firstChild.nodeValue);
          },

          invalidId: function (elem) {
            $('error_buildTypeExternalId').innerHTML = fixErrorMessage(elem.firstChild.nodeValue);
            that.highlightErrorField($("buildTypeExternalId"));
          },

          templateNotFound: function (elem) {
            $('error_templateId').innerHTML = fixErrorMessage(elem.firstChild.nodeValue);
            that.highlightErrorField($("templateId"));
          },

          emptyId: function (elem) {
            this.invalidId(elem);
          },

          duplicateId: function (elem) {
            this.invalidId(elem);
          },

          onConfigInRootError: function (elem) {
            $("error_parentProject").innerHTML = fixErrorMessage(elem.firstChild.nodeValue);
            that.highlightErrorField($("parentProjectId"));
          },

          onCompleteSave: function (form, responseXML, err) {
            BS.ErrorsAwareListener.onCompleteSave(form, responseXML, err);

            if (!err) {
              BS.XMLResponse.processRedirect(responseXML);
            } else {
              form.enable();
            }
          }
        }));
        return false;
      }
    });

    BS.CreateBuildTypeForm.onTemplateChange();
    $j('#buildTypeName').focus();
  </script>
</div>
