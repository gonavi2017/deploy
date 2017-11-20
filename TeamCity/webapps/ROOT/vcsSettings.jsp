<%@ include file="/include-internal.jsp"%>
<%@ taglib prefix="profile" tagdir="/WEB-INF/tags/userProfile" %>
<c:set var="pageTitle" value="Version Control Username Settings" scope="request"/>
<jsp:useBean id="vcsSettingsForm" type="jetbrains.buildServer.controllers.profile.vcs.VcsSettingsForm" scope="request"/>

<div class="vcsUsernamesContainer">
  <c:if test="${fn:length(vcsSettingsForm.availableVcsUsernames) > 0}">
  <c:set var="defaultValue"><bs:escapeForJs text="${vcsSettingsForm.owner.username}" forHTMLAttribute="true"/></c:set>
  <forms:addButton onclick="BS.EditVcsUsername.showAddDialog('${defaultValue}'); return false">Add new VCS username</forms:addButton>
  </c:if>

  <bs:refreshable containerId="vcsUsernames" pageUrl="${pageUrl}">
    <c:if test="${fn:length(vcsSettingsForm.specifiedVcsUsernames) > 0}">
    <bs:messages key="settingsUpdated"/>
    <l:tableWithHighlighting id="vcsSettingsTable" className="settings userProfileTable" highlightImmediately="true">
      <tr>
        <th class="vcsRoot">VCS root</th>
        <th colspan="3" class="username">Usernames</th>
      </tr>
      <c:forEach items="${vcsSettingsForm.specifiedVcsUsernames}" var="vcsUsername">
        <c:set var="editDialogTitle"><profile:vcsDisplayName vcsUsername="${vcsUsername}"/></c:set>
        <c:set var="onclick">BS.EditVcsUsername.showEditDialog('${vcsUsername.key}','<bs:escapeForJs text="${vcsUsername.newLineSeparatedUsernames}" forHTMLAttribute="true"/>','<bs:escapeForJs text="${editDialogTitle}" forHTMLAttribute="true"/>')</c:set>
        <tr>
          <td class="highlight" onclick="${onclick}"><profile:vcsDisplayName vcsUsername="${vcsUsername}"/></td>
          <td class="highlight" onclick="${onclick}">
            <c:forEach var="name" items="${vcsUsername.usernames}">
              <div><c:out value="${name}"/></div>
            </c:forEach>
          </td>
          <td class="edit highlight" onclick="${onclick}"><a href="#" showdiscardchangesmessage="false" onclick="${onclick}; Event.stop(event)">Edit</a>
          </td>
          <td class="edit"><a href="#" onclick="BS.EditVcsUsername.deleteUsername('${vcsUsername.key}'); return false">Delete</a></td>
        </tr>
      </c:forEach>
    </l:tableWithHighlighting>
    </c:if>
    <profile:vcsSettingsForm form="${vcsSettingsForm}"/>
  </bs:refreshable>
</div>