<%@ page import="jetbrains.buildServer.serverSide.crypt.RSACipher" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/include-internal.jsp"%>
<jsp:useBean id="currentProject" type="jetbrains.buildServer.serverSide.SProject" scope="request"/>
<jsp:useBean id="oauthConnections" type="java.util.Map" scope="request"/>
<jsp:useBean id="supportedProviders" type="java.util.Map" scope="request"/>

<c:url var="oauthConnectionsUrl" value="/admin/oauth/connections.html"/>
<c:set var="afterAddUrl" value="${param['afterAddUrl']}"/>

<style type="text/css">
.serviceSettings, .gitHubUrl {
  display: none;
}

#OAuthConnectionDialog {
  width: 45em;
}

table.runnerFormTable td:first-child {
  width: 10em;
}

table.runnerFormTable label {
  width: 10em;
}

table.runnerFormTable input[type='text'] {
  width: 20em;
}

table.runnerFormTable td {
  vertical-align: top;
}
</style>
<script type="text/javascript">
  BS.OAuthConnectionDialog = OO.extend(BS.PluginPropertiesForm, OO.extend(BS.AbstractModalDialog, {
    getContainer: function() {
      return $('OAuthConnectionDialog');
    },

    formElement: function() {
      return $('OAuthConnection');
    },

    savingIndicator: function() {
      return $('saveProgress');
    },

    showAddDialog: function(type) {
      this.enable();
      $j('#OAuthConnectionTitle').text('Add Connection');
      $j('#connectionType').show();
      $j('#readOnlyConnectionType').hide();
      this.formElement().connectionId.value = '';
      this.formElement().afterAddUrl.value = '<bs:escapeForJs text="${afterAddUrl}"/>';
      $('typeSelector').setSelectValue(type == null ? '' : type);
      this.providerChanged($('typeSelector'));
      this.showCentered();
    },

    showEditDialog: function(connId, providerDisplayName, readOnly) {
      this.enable();
      $j('#OAuthConnectionTitle').text('Edit Connection');
      $j('#connectionType').hide();
      $j('#readOnlyConnectionType').show();
      $j('#readOnlyConnectionType').text(providerDisplayName);
      this.formElement().providerType.value = '';
      this.formElement().connectionId.value = connId;
      this.loadParameters(readOnly);
      this.showCentered();
    },

    providerChanged: function(selector) {
      this.formElement().providerType.value = '';
      $j('#connectionParams').html('');
      if (selector.selectedIndex > 0) {
        this.formElement().providerType.value = selector.options[selector.selectedIndex].value;
        this.loadParameters();
      }
    },

    loadParameters: function(readOnly) {
      $('parametersProgress').show();
      var that = this;
      BS.ajaxUpdater('connectionParams', window['base_uri'] + '/admin/oauth/showConnection.html', {
        parameters: 'providerType=' + this.formElement().providerType.value + "&projectId=" + this.formElement().projectId.value + "&connectionId=" + this.formElement().connectionId.value,
        evalScripts: true,
        onComplete: function () {
          $('parametersProgress').hide();

          if (readOnly) {
            that.disable();
          }
          that.recenterDialog();
        }
      });
    },

    save: function() {
      if (this.formElement().connectionId.value == '' && $('typeSelector').selectedIndex <= 0) {
        alert("Please select a type of OAuth connection");
        return false;
      }

      BS.FormSaver.save(this, this.formElement().action, OO.extend(BS.ErrorsAwareListener, {
        onCompleteSave: function(form, responseXML, err) {
          err = BS.XMLResponse.processErrors(responseXML, {}, BS.PluginPropertiesForm.propertiesErrorsHandler);

          form.setSaving(false);
          if (err) {
            form.enable();
          } else {
            if (!BS.XMLResponse.processRedirect(responseXML)) {
              $('connectionsTable').refresh();
              BS.OAuthConnectionDialog.close();
            }
          }
        }
      }));
      return false;
    }
  }));

  BS.OAuth = {
    deleteConnection: function(connectionId) {
      if (!confirm("Are you sure you want to delete this OAuth connection?")) return;

      BS.ajaxRequest('${oauthConnectionsUrl}', {
        parameters: 'deleteConnection=' + connectionId + "&projectId=${currentProject.externalId}",

        onComplete: function() {
          $('connectionsTable').refresh();
        }
      });
    }
  };
</script>
<div class="section noMargin">
  <h2 class="noBorder">Connections</h2>
  <bs:smallNote>Supported types of connections: <c:forEach items="${supportedProviders}" var="pt" varStatus="pos"><c:out value="${pt.value.displayName}"/><c:if test="${not pos.last}">, </c:if></c:forEach>.</bs:smallNote>

  <bs:refreshable containerId="connectionsTable" pageUrl="${pageUrl}">

    <bs:messages key="connectionAdded"/>
    <bs:messages key="connectionUpdated"/>
    <bs:messages key="connectionRemoved"/>

    <c:set var="canEdit" value="${afn:permissionGrantedForProject(currentProject, 'EDIT_PROJECT')}"/>
    <c:if test="${not currentProject.readOnly and canEdit}">
    <div>
      <forms:addButton onclick="BS.OAuthConnectionDialog.showAddDialog()">Add Connection</forms:addButton>
    </div>
    </c:if>
    <c:if test="${not empty oauthConnections}">
    <c:forEach items="${oauthConnections}" var="entry">
      <c:set var="project" value="${entry.key}"/>
      <c:set var="projectConnections" value="${entry.value}"/>
      <c:set var="inherited" value="${project != currentProject}"/>

      <c:if test="${inherited}">
        <br/>
        <p>Connections inherited from <admin:editProjectLink projectId="${project.externalId}"><c:out value="${project.name}"/></admin:editProjectLink>:</p>
      </c:if>
      <l:tableWithHighlighting className="parametersTable" highlightImmediately="true">
        <tr>
          <th style="width: 30%">Connection</th>
          <th colspan="${inherited or not canEdit ? 1 : currentProject.readOnly ? 2 : 3}">Parameters Description</th>
        </tr>
      <c:forEach items="${projectConnections}" var="con">
        <c:choose>
          <c:when test="${inherited}">
            <tr>
              <td><c:if test="${con.connectionDisplayName != con.oauthProvider.displayName}"><em>(<c:out value='${con.oauthProvider.displayName}'/>)</em> </c:if><c:out value='${con.connectionDisplayName}'/></td>
              <td><bs:out value='${con.description}'/></td>
            </tr>
          </c:when>
          <c:otherwise>
            <c:set var="onclick" value="BS.OAuthConnectionDialog.showEditDialog('${con.id}', '${con.oauthProvider.displayName}', ${currentProject.readOnly})"/>
            <tr>
              <td class="highlight" onclick="${canEdit ? onclick : ''}"><c:if test="${con.connectionDisplayName != con.oauthProvider.displayName}"><em>(<c:out value='${con.oauthProvider.displayName}'/>)</em> </c:if><c:out value='${con.connectionDisplayName}'/></td>
              <td class="highlight" onclick="${canEdit ? onclick : ''}"><bs:out value='${con.description}'/></td>
              <c:if test="${not inherited and canEdit}">
                <td class="edit highlight" onclick="${onclick}"><a href="#" onclick="${onclick}">${currentProject.readOnly ? 'View' : 'Edit'}</a></td>
              <c:if test="${not currentProject.readOnly}">
                <td class="edit"><a href="#" onclick="BS.OAuth.deleteConnection('${con.id}')">Delete</a></td>
              </c:if>
              </c:if>
            </tr>
          </c:otherwise>
        </c:choose>
      </c:forEach>
      </l:tableWithHighlighting>
    </c:forEach>
    </c:if>
  </bs:refreshable>

  <bs:modalDialog formId="OAuthConnection" title="Add Connection" saveCommand="BS.OAuthConnectionDialog.save()" closeCommand="BS.OAuthConnectionDialog.close()" action="${oauthConnectionsUrl}">
    <table class="runnerFormTable" style="width: 99%;">
      <tr>
        <td>
          <label>Connection type: </label>
        </td>
        <td>
          <span id="connectionType">
            <forms:select name="typeSelector" enableFilter="true" onchange="BS.OAuthConnectionDialog.providerChanged(this)" className="longField" style="width:28em">
              <option value="">-- Select a connection type --</option>
              <c:forEach items="${supportedProviders}" var="sp">
                <option value="${sp.key}"><c:out value="${sp.value.displayName}"/></option>
              </c:forEach>
            </forms:select>
            <forms:saving id="parametersProgress" className="progressRingInline"/>
          </span>
          <span id="readOnlyConnectionType"></span>
        </td>
      </tr>
    </table>

    <div id="connectionParams"></div>

    <span class="error" id="error_providerType"></span>

    <div class="popupSaveButtonsBlock">
      <forms:submit label="Save"/>
      <forms:cancel onclick="BS.OAuthConnectionDialog.close()"/>
      <forms:saving id="saveProgress"/>
      <input type="hidden" name="projectId" value="${currentProject.externalId}"/>
      <input type="hidden" name="providerType" value=""/>
      <input type="hidden" name="connectionId" value=""/>
      <input type="hidden" name="afterAddUrl" value=""/>
      <input type="hidden" name="saveConnection" value="save"/>
      <input type="hidden" name="publicKey" id="publicKey" value="<c:out value='<%=RSACipher.getHexEncodedPublicKey()%>'/>"/>
    </div>
  </bs:modalDialog>
</div>
<script type="text/javascript">
  $j(document).ready(function() {
    var parsedHash = BS.Util.paramsFromHash('&');
    var type = parsedHash['addDialog'];
    if (type) {
      BS.OAuthConnectionDialog.showAddDialog(type);
      document.location.hash = "";
    }
  })
</script>
