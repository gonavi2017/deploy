<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="profile" tagdir="/WEB-INF/tags/userProfile"
  %><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@attribute name="form" required="true" rtexprvalue="true" type="jetbrains.buildServer.controllers.profile.vcs.VcsSettingsForm"
  %>
<c:url var="action" value="/vcsSettings.html"/>
<c:if test="${form.adminMode}"><c:url var="action" value="/admin/vcsSettings.html"/></c:if>
<bs:modalDialog formId="editVcsSettings"
                dialogClass="editVcsSettingsDialog"
                title=""
                action="${action}"
                closeCommand="BS.EditVcsUsername.close()"
                saveCommand="BS.EditVcsUsername.submitUsername()">

  <div style="margin-bottom: 1em;" id="vcsRootSelector">
    <label for="vcsRoot" class="tableLabel" style="width:8em;">VCS root:</label>
    <forms:select id="vcsRoot" name="vcsRoot" style="width: 20em;"
                  onchange="this.form.vcsUsernameKey.value = this.options[this.selectedIndex].value;" enableFilter="true">
      <c:forEach items="${form.availableVcsUsernames}" var="vcsUsername">
        <option value="${vcsUsername.key}"><profile:vcsDisplayName vcsUsername="${vcsUsername}"/></option>
      </c:forEach>
    </forms:select>
  </div>

  <label for="vcsUsername" class="tableLabel" style="width: 8em;">VCS usernames:</label>
  <textarea name="vcsUsername" id="vcsUsername" class="vcsUserNames" rows="4"></textarea>
  <div class="smallNote vcsUserNamesNote">New-line delimited set of case-insensitive usernames. <bs:help file="Managing+Users+and+User+Groups" anchor="vcsUsername"/></div>

  <input type="hidden" name="userId" value="${form.owner.id}"/>
  <input type="hidden" id="vcsUsernameKey" name="vcsUsernameKey" value=""/>

  <div class="popupSaveButtonsBlock">
    <forms:submit label="Save"/>
    <forms:cancel onclick="BS.EditVcsUsername.close()"/>
    <forms:saving id="savingUsername"/>
  </div>
</bs:modalDialog>
