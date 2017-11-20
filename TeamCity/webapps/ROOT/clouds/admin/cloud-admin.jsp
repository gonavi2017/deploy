<%@ page import="jetbrains.buildServer.web.util.WebUtil" %>
<%@include file="/include-internal.jsp" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="clouds" tagdir="/WEB-INF/tags/clouds" %>
<%@ taglib prefix="util" uri="/WEB-INF/functions/util" %>

<jsp:useBean id="cons" class="jetbrains.buildServer.clouds.server.web.CloudWebConstants"/>
<jsp:useBean id="form" type="jetbrains.buildServer.clouds.server.web.beans.CloudTabForm" scope="request"/>
<jsp:useBean id="project" type="jetbrains.buildServer.serverSide.SProject" scope="request"/>
<jsp:useBean id="pageUrl" scope="request" type="java.lang.String"/>
<jsp:useBean id="currentIntegrationStatus" scope="request" type="jetbrains.buildServer.clouds.server.ProjectCloudIntegrationStatus"/>

<c:set var="escapedPageUrl" value="<%=WebUtil.encode(pageUrl)%>"/>
<c:set var="profileAjaxUrl"><c:url value="/clouds/admin/cloudAdminProfile.html"/></c:set>
<c:set var="ajaxUrl"><c:url value="/clouds/admin/cloudAdmin.html?projectId=${project.externalId}"/></c:set>
<c:set var="numProfiles" value="${fn:length(form.selfProfiles)}"/>
<c:set var="numSubprojectsProfiles" value="${fn:length(form.subProjectsProfiles)}"/>
<script type="text/javascript">
  BS.Clouds.Admin.registerRefresh();
</script>

<bs:refreshable containerId="cloudRefreshable" pageUrl="${pageUrl}">

<c:if test="${form.configurationEnabled}">
  <div class="right_info_pane">
    <c:if test="${currentIntegrationStatus.enabled}">
      <div class="statusInfo">Cloud integration <strong>is enabled</strong> in this project</div>
    </c:if>
    <c:if test="${not currentIntegrationStatus.enabled}">
      <div class="statusInfo">Cloud integration <span class="red-text">is disabled</span> in this project</div>
    </c:if>
    <c:if test="${currentIntegrationStatus.subprojectsEnabled}">
      <div class="statusInfo">Cloud integration <strong>is enabled</strong> in subprojects</div>
    </c:if>
    <c:if test="${not currentIntegrationStatus.subprojectsEnabled}">
      <div class="statusInfo">Cloud integration <span class="red-text">is disabled</span> in subprojects</div>
    </c:if>

    <c:if test="${not project.readOnly}">
      <div>
        <input class="btn btn_mini" type="submit" value="Change cloud integration status" onclick="BS.Clouds.Admin.ConfirmShutdownDialog.showConfirmDisableDialog()">
      </div>
    </c:if>
  </div>
</c:if>

  <h2 class="noBorder">Cloud Profiles</h2>
  <div class="grayNote">
    Images and running instances of configured cloud profiles are shown on the <a href="<c:url value="/agents.html?tab=clouds"/>">Clouds tab</a>.
  </div>

  <c:if test="${not project.readOnly}">
    <c:set var="addUrl"><c:url value="/admin/editProject.html?projectId=${project.externalId}&tab=clouds&action=new&showEditor=true"/></c:set>
    <p><forms:addButton href="${addUrl}">Create new profile</forms:addButton></p>
  </c:if>

<div class="cloudProfile cloudAdminProfile">
  <clouds:disabledWarning disabled="${form.disabled}"/>
  <script type="text/javascript">
    BS.Clouds.Admin.setRunningInstancesCount(${form.runningInstancesCount});
    BS.Clouds.Problems = BS.Clouds.Problems || {};
  </script>
  <div class="actionBar">
    <forms:checkbox name="showSubProjects" checked="${form.showSubProjects}"
                    onclick="BS.Clouds.Admin.submitFilter('${form.projectExtId}', this.checked)"/> <label for="showSubProjects">Show cloud profiles from sub project(s)</label>
  </div>

<c:choose>
  <c:when test="${numProfiles + numSubprojectsProfiles == 0}">
    <div>There are no cloud profiles configured in current project.</div>
  </c:when>
  <c:otherwise>
    <%--<div>You have ${numProfiles} profile<bs:s val="${numProfiles}"/> configured.</div>--%>

      <l:tableWithHighlighting className="highlightable parametersTable" highlightImmediately="true">
        <tr class="header">
          <c:if test="${form.showSubProjects}"><th>Project</th></c:if>
          <th colspan="${project.readOnly ? 2 : 4}">Profile Name</th>
        </tr>
        <c:set var="currentProjectNamePrinted" value="${false}"/>
        <c:forEach var="profileInfo" items="${form.selfProfiles}">
          <clouds:cloudProblemContent controlId="error_${profileInfo.id}" problems="${profileInfo.problems}" />
          <c:set var="editUrl"><c:url value="/admin/editProject.html?projectId=${project.externalId}&tab=clouds&action=edit&profileId=${profileInfo.profile.profileId}&showEditor=true"/></c:set>
          <c:set var="disable_profile_class"><c:if test="${not profileInfo.profile.enabled}">disabledProfile</c:if></c:set>
          <c:set value="${util:forJS(profileInfo.profile.profileName, true, true)}" var="escapedName"/>
          <tr>
            <c:if test="${form.showSubProjects and not currentProjectNamePrinted}">
            <td rowspan="${form.selfProfiles.size()}">
              <bs:projectLinkFull project="${profileInfo.project}" contextProject="${project}"/>
            </td>
              <c:set var="currentProjectNamePrinted" value="${true}"/>
            </c:if>
            <td class="highlight ${disable_profile_class}" onclick="BS.openUrl(event, '${editUrl}');"><clouds:profile profile="${profileInfo}"
                                                                                                    editUrl="${editUrl}"
                                                                                                    enabled="${not form.disabled and profileInfo.profile.enabled}"/></td>
            <td class="highlight edit">
              <a href="${editUrl}">${project.readOnly ? 'View' : 'Edit'}</a>
            </td>
            <c:if test="${not project.readOnly}">
              <td class="edit">
                <c:if test="${profileInfo.profile.enabled}">
                  <a href="#" onclick="return BS.Clouds.Admin.DisableEnableProfile.showDisableProfileDialog(
                      '<bs:forJs>${project.externalId}</bs:forJs>',
                      '<bs:forJs>${profileInfo.profile.profileId}</bs:forJs>',
                      '${escapedName}',
                    ${profileInfo.runningInstancesCount}); return false">Disable</a>
                </c:if>
                <c:if test="${not profileInfo.profile.enabled}">
                  <a href="#" onclick="return BS.Clouds.Admin.DisableEnableProfile.enableProfile(
                      '<bs:forJs>${project.externalId}</bs:forJs>',
                      '<bs:forJs>${profileInfo.profile.profileId}</bs:forJs>'
                      ); return false">Enable</a>
                </c:if>
              </td>
              <td class="edit"><a href="#" onclick="return BS.Clouds.Admin.ConfirmDeleteProfileDialog.showDeleteProfileDialog(
                  '<bs:forJs>${project.externalId}</bs:forJs>',
                  '<bs:forJs>${profileInfo.profile.profileId}</bs:forJs>',
                  '${escapedName}',
                ${profileInfo.runningInstancesCount}); return false">Delete</a></td>
            </c:if>
          </tr>
        </c:forEach>
        <c:forEach var="profileInfoGroup" items="${form.subprojectProfilesGrouped}">
          <c:set var="currentProjectNamePrinted" value="${false}"/>
          <c:forEach var="profileInfo" items="${profileInfoGroup.second}">
            <c:if test="${profileInfo.project != null}">
              <clouds:cloudProblemContent controlId="error_${profileInfo.id}" problems="${profileInfo.problems}"/>
              <c:set var="editUrl"><c:url
                  value="/admin/editProject.html?projectId=${profileInfo.project.externalId}&tab=clouds&action=edit&profileId=${profileInfo.profile.profileId}&showEditor=true&cameFromUrl=${escapedPageUrl}"/></c:set>
              <%--<c:set var="edit_onlick">document.location.href='<bs:forJs>${editUrl}</bs:forJs>'; return false;</c:set>--%>
              <c:set var="disable_profile_class"><c:if test="${not profileInfo.profile.enabled or not profileInfo.projectIntegrationEnabled}">disabledProfile</c:if></c:set>
              <c:set var="disable_project_class"><c:if test="${not profileInfo.projectIntegrationEnabled}">disabledProfile</c:if></c:set>
              <c:set value="${util:forJS(profileInfo.profile.profileName, true, true)}" var="escapedName"/>
              <tr>
                <c:if test="${not currentProjectNamePrinted}">
                  <td class="${disable_project_class}" rowspan="${profileInfoGroup.second.size()}">
                    <bs:projectLinkFull project="${profileInfoGroup.first}" contextProject="${project}"/>
                    <c:if test="${not profileInfo.projectIntegrationEnabled}">
                      (cloud integration disabled)
                    </c:if>
                  </td>
                  <c:set var="currentProjectNamePrinted" value="${true}"/>
                </c:if>
                <td class="highlight ${disable_profile_class}" onclick="BS.openUrl(event, '${editUrl}');"><clouds:profile profile="${profileInfo}"
                                                                                                                          editUrl="${editUrl}"
                                                                                                                          enabled="${profileInfo.projectIntegrationEnabled and profileInfo.profile.enabled}"/></td>
                <td class="highlight edit">
                  <a href="${editUrl}">${profileInfo.project.readOnly ? 'View' : 'Edit'}</a>
                </td>
                <c:if test="${not profileInfo.project.readOnly}">
                  <td class="edit">
                    <c:if test="${profileInfo.profile.enabled}">
                      <a href="#" onclick="return BS.Clouds.Admin.DisableEnableProfile.showDisableProfileDialog(
                          '<bs:forJs>${profileInfo.project.externalId}</bs:forJs>',
                          '<bs:forJs>${profileInfo.profile.profileId}</bs:forJs>',
                          '${escapedName}',
                        ${profileInfo.runningInstancesCount}); return false">Disable</a>
                    </c:if>
                    <c:if test="${not profileInfo.profile.enabled}">
                      <a href="#" onclick="return BS.Clouds.Admin.DisableEnableProfile.enableProfile(
                          '<bs:forJs>${profileInfo.project.externalId}</bs:forJs>',
                          '<bs:forJs>${profileInfo.profile.profileId}</bs:forJs>'
                          ); return false">Enable</a>
                    </c:if>
                  </td>
                  <td class="edit"><a href="#" onclick="return BS.Clouds.Admin.ConfirmDeleteProfileDialog.showDeleteProfileDialog(
                      '<bs:forJs>${profileInfo.project.externalId}</bs:forJs>',
                      '<bs:forJs>${profileInfo.profile.profileId}</bs:forJs>',
                      '${escapedName}',
                    ${profileInfo.runningInstancesCount}); return false">Delete</a></td>
                </c:if>
              </tr>
            </c:if>
          </c:forEach>
        </c:forEach>
      </l:tableWithHighlighting>
  </c:otherwise>
</c:choose>

    <script>BS.Clouds.GCProblems();</script>
</div>
</bs:refreshable>

<bs:modalDialog formId="newProfileForm"
                title="Create Cloud Profile"
                action="${profileAjaxUrl}"
                closeCommand="BS.Clouds.Admin.CreateProfileDialog.close()"
                saveCommand="BS.Clouds.Admin.CreateProfileDialog.submit()">
  <bs:refreshable containerId="newProfileFormMainRefresh" pageUrl="${profileAjaxUrl}"/>
</bs:modalDialog>


<bs:modalDialog formId="confirmShutdown"
                title="Disable cloud integration"
                action="${ajaxUrl}"
                closeCommand="BS.Clouds.Admin.ConfirmDialog.close();"
                saveCommand="BS.Clouds.Admin.ConfirmDialog.submit();"
                dialogClass="modalDialog_small">
  <input type="hidden" name="projectId" id="projectId" value="${project.externalId}"/>
  <input type="hidden" id="projectInstancesCount" value="${form.runningInstancesCount}"/>
  <input type="hidden" id="subprojectsInstancesCount" value="${form.subprojectsInstancesCount}"/>
  <input type="hidden" id="initiallyEnabled" value="${currentIntegrationStatus.enabled}"/>
  <input type="hidden" id="initiallySubprojectsEnabled" value="${currentIntegrationStatus.subprojectsEnabled}"/>
  <span id="confirmShutdown_action"></span>
  <div id="enableCheckbox" class="hidden">
    <forms:checkbox name="enableProject"
                    checked="${currentIntegrationStatus.enabled}"
                    onclick="BS.Clouds.Admin.updateDependentCheckboxes();"
    />
    <label for="enableProject" id="enable_message">
      Enable cloud integration in this project
    </label>
  </div>
  <div id="enableSubprojectsCheckbox" class="grayNote">
    <forms:checkbox name="enableSubprojects"
                    checked="${currentIntegrationStatus.subprojectsEnabled && currentIntegrationStatus.enabled}"
                    disabled="${not(currentIntegrationStatus.subprojectsEnabled && currentIntegrationStatus.enabled)}"
                    onclick="BS.Clouds.Admin.updateDependentCheckboxes();"
    />
    <label for="enableSubprojects" id="enableSubprojects_message">
      Enable cloud integration in subprojects
    </label>
  </div>
  <div id="terminateInstancesCheckbox" class="hidden">
    <forms:checkbox name="terminateInstances" checked="${false}"/>
    <label for="terminateInstances" id="confirmShutdown_instances_message">
      Terminate <span id="confirmShutdown_instanceCount"></span> running instance<bs:s val="${form.runningInstancesCount}"/>
    </label>
  </div>
  <c:if test="${cons.allowOverrideStatusInSubprojectsProp()}">
    <div id="allowSubprojectsOverwriteCheckbox">
      <forms:checkbox name="allowSubprojectsOverwrite" checked="${currentIntegrationStatus.allowOverride}"/>
      <label for="allowSubprojectsOverwrite" id="allowSubprojectsOverwrite_message">
        Allow overriding of status in subprojects (experimental)
      </label>
    </div>
  </c:if>
  <div class="popupSaveButtonsBlock">
    <forms:submit label="Agree" id="confirmShutdown_submit"/>
    <forms:cancel onclick="BS.Clouds.Admin.ConfirmShutdownDialog.close()"/>
    <forms:saving id="confirmShutdownDialog_loader"/>
  </div>
</bs:modalDialog>
