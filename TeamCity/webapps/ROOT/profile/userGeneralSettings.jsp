<%@ page import="jetbrains.buildServer.controllers.admin.users.AdminEditUserController" %>
<%@ include file="/include-internal.jsp" %>
<%@ taglib prefix="profile" tagdir="/WEB-INF/tags/userProfile"%>
<jsp:useBean id="currentUser" type="jetbrains.buildServer.users.User" scope="request"/>
<jsp:useBean id="profileForm" type="jetbrains.buildServer.controllers.profile.EditPersonalProfileForm" scope="request"/>
<jsp:useBean id="profileBean" type="jetbrains.buildServer.controllers.admin.GroupedExtensionsBean" scope="request"/>

<div id="profilePage">
<script type="text/javascript">
$j(document).ready(function() {
  BS.UpdatePersonalProfileForm.setupEventHandlers();

  BS.UpdatePersonalProfileForm.setModified(${profileForm.stateModified});
});
</script>

<form id="profileForm" action="profile.html" onsubmit="return BS.UpdatePersonalProfileForm.submitPersonalProfile()" method="post" autocomplete="off">

<input type="hidden" id="submitUpdateUser" name="submitUpdateUser" value="storeInSession"/>
<input type="hidden" name="item" value="${profileBean.selectedExtension.tabId}"/>

<bs:messages key="<%=AdminEditUserController.USER_CHANGED_MESSAGES_KEY%>"/>

<profile:general profileForm="${profileForm}" adminMode="false"/>

<c:url var="favoritePageLink" value="/favoriteBuilds.html"/>
<l:settingsBlock title="UI Settings">
  <label class="ui-settings__label" for="highlightMyChanges"><forms:checkbox name="highlightMyChanges" checked="${profileForm.highlightMyChanges}"/> Highlight my changes and investigations</label>
  <label class="ui-settings__label" for="autodetectTimeZone"><forms:checkbox name="autodetectTimeZone" checked="${profileForm.autodetectTimeZone}"/> Show date/time in my timezone</label>
  <label class="ui-settings__label" for="showAllPersonalBuilds"><forms:checkbox name="showAllPersonalBuilds" checked="${profileForm.showAllPersonalBuilds}"/> Show all personal builds</label>
  <label class="ui-settings__label" for="addTriggeredBuildToFavorites"><forms:checkbox name="addTriggeredBuildToFavorites" checked="${profileForm.addTriggeredBuildToFavorites}"/> Add  builds triggered by me to <a href="${favoritePageLink}">favorites</a></label>
</l:settingsBlock>

<c:if test="${not isSpecialUser}">
  <profile:userAuthSettings profileForm="${profileForm}"/>
  <%--<profile:notifications profileForm="${profileForm}" adminMode="false"/>--%>
</c:if>

  <div class="saveButtonsBlock saveButtonsBlock_noborder">
    <forms:submit label="Save changes"/>
    <forms:saving id="saving1"/>
  </div>

</form>

<forms:modified/>
</div>
