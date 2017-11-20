<%@ page import="jetbrains.buildServer.controllers.admin.users.AdminEditUserController" %>
<%@ page import="jetbrains.buildServer.controllers.emailVerification.EmailVerificationController" %>
<%@ include file="/include-internal.jsp" %>
<%@ taglib prefix="profile" tagdir="/WEB-INF/tags/userProfile"%>
<jsp:useBean id="adminEditUserForm" type="jetbrains.buildServer.controllers.admin.users.AdminEditUserForm" scope="request"/>
<div id="profilePage">
<form action="<c:url value='/admin/editUser.html?userId=${adminEditUserForm.userId}'/>" onsubmit="return BS.AdminUpdateUserForm.submitUserProfile()" method="post" autocomplete="off">

  <authz:authorize allPermissions="DELETE_USER">
  <c:if test="${adminEditUserForm.canRemoveUserAccount}">
    <input class="btn btn_mini submitButton" type="button" value="Delete User Account" onclick="BS.AdminUpdateUserForm.deleteUserAccount()" style="margin-right: 10px"/>
    <div class="clr"></div>
    <br/>
  </c:if>
  </authz:authorize>

  <bs:messages key="<%=AdminEditUserController.USER_CHANGED_MESSAGES_KEY%>"/>
  <bs:messages key="<%=EmailVerificationController.MESSAGE_KEY%>" permanent="${true}"/>

  <profile:general profileForm="${adminEditUserForm}" adminMode="true"/>
  <c:if test="${not adminEditUserForm.perProjectPermissionsEnabled}">
    <l:settingsBlock title="Administrator status">
      <admin:perProjectRolesNote/>
      <forms:checkbox name="administrator" checked="${adminEditUserForm.administrator}" disabled="${not adminEditUserForm.canEditPermissions or adminEditUserForm.administratorStatusInherited}"/>
      <label for="administrator">Give this user administrative privileges</label>
      <c:if test="${adminEditUserForm.administratorStatusInherited}">
        <bs:smallNote>Administrative privileges are inherited from one or more parent groups</bs:smallNote>
      </c:if>
    </l:settingsBlock>
  </c:if>
  <profile:userAuthSettings profileForm="${adminEditUserForm}"/>

  <div class="saveButtonsBlock saveButtonsBlock_noborder">
    <forms:submit label="Save changes"/>
    <forms:cancel cameFromSupport="${adminEditUserForm.cameFromSupport}"/>
    <forms:saving id="saving1"/>
  </div>

  <input type="hidden" id="submitUpdateUser" name="submitUpdateUser" value="storeInSession"/>
  <input type="hidden" name="userId" value="${adminEditUserForm.userId}"/>
  <input type="hidden" name="tab" value="${currentTab}"/>

</form>

<forms:modified/>
<script type="text/javascript">
  BS.AdminUpdateUserForm.setupEventHandlers();
  BS.AdminUpdateUserForm.setModified(${adminEditUserForm.stateModified});
</script>
</div>