<%@ page import="jetbrains.buildServer.controllers.admin.AuthAdminPage" %><%@
    include file="/include-internal.jsp"
%><jsp:useBean id="bean" type="jetbrains.buildServer.controllers.admin.AuthAdminBean" scope="request"
/><jsp:useBean id="presets" type="java.util.List" scope="request"/>

<c:set var="advanced" value="${param['advanced'] == 'true'}"/>
<c:url var="url" value="/admin/admin.html?item=auth"/>

<bs:refreshable containerId="authModules" pageUrl="${pageUrl}">
  <bs:messages key="<%=AuthAdminPage.MESSAGE_KEY%>"/>
  <bs:messages key="<%=AuthAdminPage.WARNING_MESSAGE_KEY%>" isWarning="true"/>

  <c:if test="${not empty bean.currentModuleIfNotAvailable}">
    <div class="icon_before icon16 attentionComment">
      Authentication module which you used to log in (<b><c:out value="${bean.currentModuleIfNotAvailable.type.displayName}"/></b>)
      is not active anymore and you might not be able to log in again.
    </div>
  </c:if>
  <c:forEach items="${bean.validationErrors}" var="error">
    <div class="icon_before icon16 attentionComment"><c:out value="${error}"/></div>
  </c:forEach>

  <h3>Credentials authentication modules <bs:help file="Configuring+Authentication+Settings"/></h3>
  <bs:_adminAuthTable authModules="${bean.loginModules}" advancedView="${advanced}" canRemove="${fn:length(bean.loginModules) > 1}"/>

  <c:if test="${not empty bean.httpSchemes}">
    <h3>HTTP authentication modules</h3>
    <bs:_adminAuthTable authModules="${bean.httpSchemes}" advancedView="${advanced}" canRemove="true"/>
  </c:if>

  <div class="buttons">
    <c:set var="showPresets" value="${not advanced and not empty presets}"/>
    <c:if test="${showPresets}">
      <a href="#" class="btn" onclick="return BS.AdminAuthPresetsDialog.show();">Load preset...</a>
    </c:if>

    <c:set var="availableAuthModuleTypes" value="${bean.availableAuthModules}"/>
    <c:set var="canAdd" value="${advanced and not empty availableAuthModuleTypes}"/>
    <c:if test="${canAdd}">
      <forms:addButton onclick="return BS.AdminAuthAddDialog.showAdd();">Add module</forms:addButton>
    </c:if>

    <c:if test="${not advanced}">
      <a href="${url}&advanced=true">Switch to advanced mode</a>
    </c:if>
    <c:if test="${advanced}">
      <a href="${url}">Switch to simple mode</a>
    </c:if>
  </div>

  <form id="generalSettings" action="">
    <h3>General settings</h3>
    <table class="runnerFormTable">
      <tr>
        <th>Guest user login:</th>
        <td>
          <forms:checkbox name="guestLoginAllowed" checked="${bean.guestLoginAllowed}"/>
          <label for="guestLoginAllowed">Allow login as guest user</label>
        <span class="smallNote">Allow users to log into TeamCity without authentication.
          <c:if test="${bean.perProjectPermissions}">
            <authz:authorize anyPermission="CHANGE_USER, CHANGE_USER_ROLES_IN_PROJECT">
              <a href="<c:url value='/admin/editUser.html?init=1&userId=${bean.guestUserId}&cameFromUrl=${pageUrl}'/>" class="external">Configure guest user roles</a>
              to set permissions for these users.
            </authz:authorize>
          </c:if>
        </span>
        </td>
      </tr>
      <tr>
        <th class="noBorder"><label for="guestUsername">Guest user username:</label></th>
        <td class="noBorder">
          <forms:textField name="guestUsername" value="${bean.guestUsername}"/>
          <span style="display: none" class="error" id="invalidGuestUsername">Guest user username must not be empty</span>
        </td>
      </tr>
      <tr>
        <th><label for="textForLoginPage">Welcome text on the login page:</label></th>
        <td><forms:textField name="textForLoginPage" style="width: 40em;" value="${bean.textForLoginPage}" expandable="true"/></td>
      </tr>
      <tr>
        <th>
          <label>Per-project permissions:</label>
        </th>
        <td>
          <forms:checkbox name="perProjectPermissions" checked="${bean.perProjectPermissions}"/>
          <label for="perProjectPermissions">Enable per-project permissions</label>
        </td>
      </tr>
      <tr>
        <th>
          <label>Email verification:</label>
        </th>
        <td>
          <forms:checkbox name="emailVerificationEnabled" checked="${bean.emailVerificationEnabled}"/>
          <label for="emailVerificationEnabled">Enable email verification</label> <bs:help file="Enabling+Email+Verification"/>
          <span class="smallNote">If email verification is enabled, the email field in the user registration form becomes mandatory.</span>
        </td>
      </tr>
    </table>
  </form>

  <div class="saveButtonsBlock">
    <forms:submit label="Save" onclick="return BS.AdminAuth.saveAll();"/>
    <forms:cancel label="Revert" onclick="return BS.AdminAuth.cancelAll();"/>
    <forms:saving id="authProgress"/>
  </div>

  <forms:modified onSave="return BS.AdminAuth.saveAll();"/>
  <script type="text/javascript">
    BS.AdminAuth.init();
    BS.AdminAuth.setModified(${bean.stateModified});
  </script>

  <c:if test="${showPresets}">
    <bs:modalDialog formId="authPresetsForm"
                    title="Load Preset"
                    action="#"
                    closeCommand="BS.AdminAuthPresetsDialog.cancel();"
                    saveCommand="BS.AdminAuthPresetsDialog.applyPreset();"
                    dialogClass="modalDialog_small">
      <label for="presetFileName">Preset:</label>
      <forms:select name="presetFileName" enableFilter="true" onchange="BS.AdminAuthPresetsDialog.presetSelected();" className="longField">
        <forms:option value="">-- Select preset --</forms:option>
        <c:forEach items="${presets}" var="authPreset" varStatus="status">
          <%--@elvariable id="authPreset" type="jetbrains.buildServer.controllers.admin.AuthAdminPage.AuthPreset"--%>
          <c:set var="authPresetFileName"><c:out value='${authPreset.fileName}'/></c:set>
          <forms:option value="${authPresetFileName}"><c:out value="${authPreset.presetName}"/></forms:option>
          <c:if test="${not empty authPreset.description}">
            <script type="text/javascript">
              BS.AdminAuthPresetsDialog._descriptions[${status.index + 1}] = '<bs:escapeForJs text="${authPreset.description}"/>';
            </script>
          </c:if>
        </c:forEach>
      </forms:select>

      <div id="presetDescription"></div>

      <div class="popupSaveButtonsBlock">
        <forms:submit id="authPresetsSubmitButton" label="Apply"/>
        <forms:cancel onclick="return BS.AdminAuthPresetsDialog.cancel();"/>
        <forms:saving id="authPresetsFormProgress"/>
      </div>
    </bs:modalDialog>
  </c:if>

  <c:if test="${canAdd}">
    <bs:modalDialog formId="addAuthModule"
                    title="Add Module"
                    action="#"
                    closeCommand="BS.AdminAuthAddDialog.cancel();"
                    saveCommand="BS.AdminAuthAddDialog.submit();">
      <div id="authModuleChooserDiv">
        <label for="addAuthModuleType">New module:</label>
        <forms:select id="addAuthModuleType" name="moduleType" enableFilter="true" onchange="BS.AdminAuthAddDialog.reloadEditee();" className="longField">
          <forms:option value="">-- Select authentication module --</forms:option>
          <c:forEach var="entry" items="${availableAuthModuleTypes}">
            <optgroup label="${entry.key}">
              <c:forEach var="moduleType" items="${entry.value}">
                <%--@elvariable id="moduleType" type="jetbrains.buildServer.serverSide.auth.AuthModuleType"--%>
                <forms:option value="${moduleType.name}"><c:out value="${moduleType.displayName}"/></forms:option>
              </c:forEach>
            </optgroup>
          </c:forEach>
        </forms:select>
        <forms:saving id="loadEditeeProgressDiv" className="progressRingInline"/>
      </div>

      <div class="content"></div>

      <div class="popupSaveButtonsBlock">
        <forms:submit label="Add" onclick="return BS.AdminAuthAddDialog.submit();"/>
        <forms:cancel onclick="return BS.AdminAuthAddDialog.cancel();"/>
        <forms:saving id="addAuthProgress"/>
      </div>
    </bs:modalDialog>
  </c:if>

  <bs:modalDialog formId="editAuthModule"
                  title="Edit Authentication Module"
                  action="#"
                  closeCommand="BS.AdminAuthEditDialog.cancel();"
                  saveCommand="BS.AdminAuthEditDialog.submit();">
    <div class="content"></div>

    <div class="popupSaveButtonsBlock">
      <forms:submit label="Done" onclick="return BS.AdminAuthEditDialog.submit();"/>
      <forms:cancel onclick="return BS.AdminAuthEditDialog.cancel();"/>
      <forms:saving id="editAuthProgress"/>
    </div>

    <input type="hidden" id="authModuleId" name="authModuleId"/>
  </bs:modalDialog>
</bs:refreshable>
