<%@ include file="/include-internal.jsp" %>
<jsp:useBean id="currentProject" type="jetbrains.buildServer.serverSide.SProject" scope="request"/>

<style type="text/css">
  div.projectRoots {
    margin-left: 1em;
  }
  div.usagesCategory {
    font-weight: bold;
  }
</style>

<script type="text/javascript">
  BS.SshKeysDialog = OO.extend(BS.AbstractWebForm, OO.extend(BS.AbstractModalDialog, OO.extend(BS.FileBrowse, {
    getContainer: function () {
      return $('sshKeyDialog');
    },

    deleteKey: function(projectId, keyName) {
      if (confirm('Are you sure you want to delete this key?')) {
        BS.ajaxRequest('<c:url value="/admin/sshKeysActions.html"/>', {
          parameters: Object.toQueryString({action: 'deleteSshKey', projectId: projectId, keyName: keyName}),
          onComplete: function(transport) {
            window.location.reload();
          }
        });
      }
    },

    createKey: function() {
      this.cleanFields();
      this.cleanErrors();
      this.showCentered();
    },

    cleanFields: function() {
      $j('#fileName').val('');
      $j('#file\\:fileToUpload').val('');
    },

    cleanErrors: function() {
      $("uploadError").innerHTML = '';
    },

    closeAndRefresh: function() {
      Form.enable($('sshKeyForm'));
      BS.SshKeysDialog.close();
      window.location.reload();
    }
  })));
</script>

<div class="section noMargin">
  <h2 class="noBorder">SSH Keys</h2>
  <bs:smallNote>Supported formats: OpenSSH RSA or DSA private keys. <bs:help file="SSH+Keys+Management"/></bs:smallNote>

  <c:set var="cameFromUrl" value="${param['cameFromUrl']}"/>
  <bs:refreshable containerId="keys" pageUrl="${pageUrl}">
    <bs:messages key="sshKeyUploaded"/>
    <bs:messages key="sshKeyDeleted"/>

    <c:set var="canEditProject" value="${afn:permissionGrantedForProject(currentProject, 'EDIT_PROJECT')}"/>

    <c:if test="${canEditProject}">
      <forms:addButton id="createNewKey" onclick="BS.SshKeysDialog.createKey(); return false">Upload SSH Key</forms:addButton>
    </c:if>

    <c:if test="${not empty keys}">
      <table class="parametersTable" style="width: 100%">
        <tr>
          <th style="width: 45%">Key Name</th>
          <th colspan="${canEditProject ? 2 : 1}">Usage</th>
        </tr>
        <c:forEach var="key" items="${keys}">
          <tr>
            <td>
              <c:out value="${key.name}"/>
            </td>
            <td>
              <c:set var="keyUsages" value="${ownKeysUsages[key]}"/>
              <%--@elvariable id="keyUsages" type="jetbrains.buildServer.ssh.web.SshKeyUsages"--%>
              <c:choose>
                <c:when test="${not keyUsages.used}">
                  Key is not used
                </c:when>
                <c:otherwise>
                  Key is used in
                  <c:if test="${not empty keyUsages.rootUsages}"><%@include file="sshKeyRootUsages.jsp"%></c:if>
                  <c:if test="${not empty keyUsages.sshAgentUsages}"><%@include file="sshKeySshAgentUsages.jsp"%></c:if>
                </c:otherwise>
              </c:choose>
            </td>
            <c:if test="${canEditProject}">
              <td class="edit">
                <a href="#" onclick="BS.SshKeysDialog.deleteKey('${currentProject.projectId}', '${key.name}')">Delete</a>
              </td>
            </c:if>
          </tr>
        </c:forEach>
      </table>
    </c:if>

    <c:forEach var="e" items="${inheritedKeys}">
      <c:set var="parentProject" value="${e.key}"/>
      <c:set var="keys" value="${e.value}"/>
      <p style="margin-top: 2em">Keys inherited from
        <authz:authorize projectId="${parentProject.externalId}" allPermissions="EDIT_PROJECT" >
          <jsp:attribute name="ifAccessGranted">
            <c:url var="editUrl" value="/admin/editProject.html?projectId=${parentProject.externalId}&tab=ssh-manager"/>
            <a href="${editUrl}"><c:out value="${parentProject.extendedFullName}"/></a>
          </jsp:attribute>
          <jsp:attribute name="ifAccessDenied">
            <bs:projectLink project="${parentProject}"><c:out value="${parentProject.extendedFullName}"/></bs:projectLink>
          </jsp:attribute>
        </authz:authorize>
      </p>
      <table class="parametersTable" style="width: 100%">
        <tr>
          <th style="width: 45%">Key Name</th>
          <th colspan="2">Usage</th>
        </tr>
        <c:forEach var="key" items="${keys}">
          <tr>
            <td>
              <c:out value="${key.name}"/>
            </td>
            <td>
              <c:set var="keyUsages" value="${inheritedKeysUsages[key]}"/>
              <%--@elvariable id="keyUsages" type="jetbrains.buildServer.ssh.web.SshKeyUsages"--%>
              <c:choose>
                <c:when test="${not keyUsages.used}">
                  Key is not used
                </c:when>
                <c:otherwise>
                  Key is used in
                  <c:if test="${not empty keyUsages.rootUsages}"><%@include file="sshKeyRootUsages.jsp"%></c:if>
                  <c:if test="${not empty keyUsages.sshAgentUsages}"><%@include file="sshKeySshAgentUsages.jsp"%></c:if>
                </c:otherwise>
              </c:choose>
            </td>
          </tr>
        </c:forEach>
      </table>
    </c:forEach>
  </bs:refreshable>
</div>

<c:url var="action" value="/admin/sshKeys.html"/>
<bs:dialog dialogId="sshKeyDialog"
           dialogClass="sshKeyDialog uploadDialog"
           title="Upload SSH Key"
           closeCommand="BS.SshKeysDialog.close()">
  <forms:multipartForm id="sshKeyForm" action="${action}" targetIframe="hidden-iframe" onsubmit="return BS.SshKeysDialog.validate();">
    <table class="runnerFormTable">
      <tr>
        <th>Name: </th>
        <td><input type="text" id="fileName" name="fileName" value="" class="mediumField"/></td>
      </tr>
      <tr>
        <th>Private Key: <l:star/></th>
        <td>
          <forms:file name="fileToUpload" size="28"/>
          <span id="uploadError" class="error hidden"></span>
        </td>
      </tr>
    </table>
    <input type="hidden" name="action" value="createSshKey"/>
    <input type="hidden" name="projectId" value="${currentProject.projectId}"/>
    <div class="popupSaveButtonsBlock">
      <forms:submit id="sshKeysDialogSubmit" label="Save"/>
      <forms:cancel onclick="BS.SshKeysDialog.close()"/>
    </div>
  </forms:multipartForm>
</bs:dialog>

<script type="text/javascript">
  BS.SshKeysDialog.setFiles([<c:forEach var="key" items="${keys}">'${key.name}',</c:forEach>]);
  BS.SshKeysDialog.prepareFileUpload();
</script>
