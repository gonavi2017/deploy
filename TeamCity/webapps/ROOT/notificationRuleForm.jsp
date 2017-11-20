<%@ page import="jetbrains.buildServer.notification.WatchType" %>
<%@ include file="include-internal.jsp" %>
<%@ taglib prefix="profile" tagdir="/WEB-INF/tags/userProfile" %>
<jsp:useBean id="notificationRulesForm" type="jetbrains.buildServer.controllers.profile.notifications.NotificationRulesForm" scope="request"/>
<jsp:useBean id="ruleBean" type="jetbrains.buildServer.controllers.profile.notifications.NotificationRulesForm.EditableNotificationRule" scope="request"/>
<c:set value="<%=WatchType.SPECIFIC_PROJECT_BUILD_TYPES.name()%>" var="SPECIFIC_PROJECT_BUILD_TYPES"/>
<c:set value="<%=WatchType.SYSTEM_WIDE.name()%>" var="SYSTEM_WIDE"/>
<bs:webComponentsSettings/>

<script type="text/javascript">
  $j(function () {
    BS.NotificationRuleForm.initPage('${SPECIFIC_PROJECT_BUILD_TYPES}', '${SYSTEM_WIDE}');
  });
</script>
<div class="settingsBlockTitle">
  <c:choose>
    <c:when test="${ruleBean.newRule}">Add New Rule</c:when>
    <c:otherwise>Edit Rule</c:otherwise>
  </c:choose>
</div>
<form id="notificationRuleForm" style="margin-top:0;" action="<c:url value='/notificationRules.html'/>" method="post" onsubmit="return BS.NotificationRuleForm.submitRule();">
  <div class="panelsContainer">
    <div class="leftPanel">
      <h3>Watch:</h3>
      <div class="watchTypeRule">
        <input type="radio" name="watchType1" id="watchTypeBuildConfigurations"
               <c:if test="${ruleBean.selectedBuildTypesRule}">checked</c:if> onclick="{
        BS.NotificationRuleForm.switchToWatchTypeBuildConfigurations();
      }"><label for="watchTypeBuildConfigurations">Events related to following projects and build configurations:</label>
      </div>
      <div id="watchTypeBuildTypeSettings" <c:if test="${not ruleBean.selectedBuildTypesRule}">style="display: none;"</c:if>>
        <c:choose>
          <c:when test="${!restSelectorsDisabled}">
            <input type="hidden" name="_buildTypeId" value=""/>
            <input type="hidden" id="watchType" name="watchType" value="${ruleBean.watchType}"/>
            <span class="error" style="margin-left: 0" id="errorBuildType"></span>
            <div id="selectorWrapper" style="width: 385px;">

            </div>
            <div id="selectorResult" style="visibility: hidden; height: 0px;"></div>
            <style>
              #selectorWrapper .dropdown-content {
                width: 383px;
                border-top: none !important;
              }

              #selectorWrapper #searchResults {
                width: 383px;
              }

              #selectorWrapper .ironListClass {
                overflow-x: auto;
              }

            </style>
            <script type="text/javascript">
              BS.RestProjectsPopup.componentPlaceholder('#selectorWrapper', 'project-buildtype-multiselect', function(){
                var multiselect = document.createElement('project-buildtype-multiselect');
                multiselect.server = base_uri;
                multiselect.checkedItems = [];
                <c:forEach items="${ruleBean.selectedBuildTypes}" var="item">
                multiselect.checkedItems.push({"id":"${item.entityId.externalId}", "internalId":"${item.entityId.internalId}", "nodeType": "bt", "isChecked": "true"});
                </c:forEach>
                <c:forEach items="${ruleBean.selectedProjects}" var="item">
                multiselect.checkedItems.push({"id":"${item.id.externalId}", "internalId":"${item.id.internalId}", "nodeType": "project", "isChecked": "true"});
                </c:forEach>
                multiselect.settings = {
                  "quickNavigation": false,
                  "editMode": false,
                  "source": "global",
                  "baseUri": base_uri,
                  "currentServer": base_uri,
                  "height": "230px",
                  "hideFirstServerHeader": true,
                  "includeRoot": true
                };
                $j('#selectorWrapper').html('');
                $j('#selectorWrapper').append(multiselect);
                $j('#selectorWrapper').on('checked-items-changed', function (e) {
                  $j('#selectorResult').html("");
                  var selectedObjects = e.detail;
                  if (selectedObjects != undefined) {
                    selectedObjects.forEach(function (object) {
                      var name = undefined;
                      if (object.nodeType == 'project' && !object.isDisabled){
                        name = "projectId";
                      }else if (object.nodeType == 'rootProject' && !object.isDisabled){
                        name = "projectId";
                      } else if (object.nodeType == 'bt' && !object.isDisabled){
                        name = "buildTypeId";
                      }
                      if (name != undefined) {
                        var chb = document.createElement('input');
                        chb.type = "checkbox";
                        chb.checked = true;
                        chb.value = object.id;
                        chb.name = name;
                        $j('#selectorResult').append(chb);
                      }
                    })
                  }
                });
                multiselect.loadData();
              });
            </script>
          </c:when>
          <c:otherwise>
            <bs:projectHierarchySelect containerId="configurations"
                                       buildTypesHierarchy="${notificationRulesForm.allBuildTypes}"
                                       selectedBuildTypesMap="${ruleBean.selectedBuildTypesMap}"
                                       selectedProjects="${ruleBean.selectedProjects}"
                                       disableChildren="${true}"
                                       rootProjectSelected="${ruleBean.rootProjectIncluded}"
                                       includeRootProject="${true}">
                <jsp:attribute name="onChange_function_body">
                    BS.NotificationRuleForm.switchToWatchTypeBuildConfigurations();
                </jsp:attribute>
                        <jsp:attribute name="additional_body">
                  <input type="hidden" name="_buildTypeId" value=""/>
                  <input type="hidden" id="watchType" name="watchType" value="${ruleBean.watchType}"/>
                  <span class="error" style="margin-left: 0" id="errorBuildType"></span>
                </jsp:attribute>
             </bs:projectHierarchySelect>
          </c:otherwise>
        </c:choose>
        <c:set var="branchFilter" value="${ruleBean.branchFilter}"/>
        <c:set var="defaultBranchFilter" value="${ruleBean.userChangesFilter ? '+:*' : ruleBean.defaultBranchFilters[SPECIFIC_PROJECT_BUILD_TYPES]}"/>
        <c:set var="userChangesFilter" value="${ruleBean.selectedBuildTypesRule ? ruleBean.userChangesFilter : true}"/>
        <c:set var="favoriteBuildsFilter"
               value="${ruleBean.selectedBuildTypesRule ? ruleBean.favoriteBuildsFilter : ruleBean.defaultFavoriteBuildsFilters[SPECIFIC_PROJECT_BUILD_TYPES]}"/>
        <div class="tc-icon_before icon16 tc-icon_branch branchFilter">
          <bs:help file="Configuring+VCS+Triggers" anchor="BranchFilter"/>
          <props:textarea name="buildTypeBranchFilter" textAreaName="buildTypeBranchFilter" linkTitle="Edit Branch Filter" cols="35" rows="3" placeholder="${defaultBranchFilter}"
                          value="${branchFilter}" expanded="${not empty ruleBean.branchFilter}"/>
          <span class="error" style="margin-left: 0" id="buildTypeBranchFilterError"></span>
          <script type="text/javascript">
            BS.BranchesPopup.attachBuildTypesHandler(function () {
              var ids = [];
              $j("#watchTypeBuildTypeSettings input[name='buildTypeId']").each(function () {
                if (this.checked) {
                  ids.push(this.value);
                }
              });
              return ids;
            }, 'buildTypeBranchFilter', 'branchFilter', 'ALL_BRANCHES');
          </script>
        </div>
        <div class="userChangesFilter" style="padding-left: 20px;">
          <forms:checkbox name="userChangesFilterCB" value="${userChangesFilter}" checked="${userChangesFilter}"></forms:checkbox><label for="userChangesFilterCB">Builds with my
          changes only</label>
          <div class="smallNote">You will be notified for each "incomplete" build after your change</div>
        </div>
        <div class="favoriteBuildsFilter" style="padding-left: 20px;">
          <forms:checkbox name="buildTypeFavoriteBuildsFilter" value="${favoriteBuildsFilter}" checked="${favoriteBuildsFilter}"></forms:checkbox><label
            for="buildTypeFavoriteBuildsFilter">My favorite builds only</label>
        </div>
      </div>
      <div class="watchTypeSystemWide">
        <input type="radio" name="watchType1" id="watchTypeSystemWide"
               <c:if test="${ruleBean.systemWideRule}">checked</c:if> onclick="{BS.NotificationRuleForm.switchToWatchTypeSystemWide();}"><label for="watchTypeSystemWide">System wide events</label>
      </div>
    </div>

    <div class="rightPanel">
      <h3>Send notification when:</h3>

      <table class="eventsTable" id="non-system-events">
        <tr>
          <td class="buildFailed"><forms:checkbox name="editingEvents['BUILD_FINISHED_FAILURE']" checked="${ruleBean.editingEvents['BUILD_FINISHED_FAILURE']}"
                                                  onclick="if (!this.checked) { BS.NotificationRuleForm.uncheckFailureEvents(); }"/><label
              for="editingEvents['BUILD_FINISHED_FAILURE']">Build fails</label></td>
        </tr>
        <c:if test="${notificationRulesForm.BFNFEnabled}">
          <tr>
            <td class="eventOption"><forms:checkbox name="editingEvents['BUILD_FINISHED_NEW_FAILURE']"
                                                    checked="${ruleBean.editingEvents['BUILD_FINISHED_NEW_FAILURE']}"
                                                    disabled="${not ruleBean.committerRule}"
                                                    onclick="if (this.checked) BS.NotificationRuleForm.checkEvent('BUILD_FINISHED_FAILURE');"/><label
                for="editingEvents['BUILD_FINISHED_NEW_FAILURE']">Keep notifying until build is complete (even without my changes)</label></td>
          </tr>
        </c:if>
        <tr>
          <td class="eventOption"><forms:checkbox name="editingEvents['FIRST_FAILURE_AFTER_SUCCESS']"
                                                  checked="${ruleBean.editingEvents['FIRST_FAILURE_AFTER_SUCCESS']}"
                                                  onclick="if (this.checked) BS.NotificationRuleForm.checkEvent('BUILD_FINISHED_FAILURE');"/><label
              for="editingEvents['FIRST_FAILURE_AFTER_SUCCESS']">Only notify on the first failed build after successful</label></td>
        </tr>
        <tr>
          <td class="eventOption"><forms:checkbox name="editingEvents['NEW_BUILD_PROBLEM_OCCURRED']"
                                                  checked="${ruleBean.editingEvents['NEW_BUILD_PROBLEM_OCCURRED']}"
                                                  onclick="if (this.checked) BS.NotificationRuleForm.checkEvent('BUILD_FINISHED_FAILURE');"/><label
              for="editingEvents['NEW_BUILD_PROBLEM_OCCURRED']">Only notify on new build problem or new failed test</label></td>
        </tr>
        <tr>
          <td><forms:checkbox name="editingEvents['BUILD_FINISHED_SUCCESS']" checked="${ruleBean.editingEvents['BUILD_FINISHED_SUCCESS']}"
                              onclick="if (!this.checked) BS.NotificationRuleForm.uncheckEvent('FIRST_SUCCESS_AFTER_FAILURE');"/><label
              for="editingEvents['BUILD_FINISHED_SUCCESS']">Build is successful</label></td>
        </tr>
        <tr>
          <td class="eventOption"><forms:checkbox name="editingEvents['FIRST_SUCCESS_AFTER_FAILURE']"
                                                  checked="${ruleBean.editingEvents['FIRST_SUCCESS_AFTER_FAILURE']}"
                                                  onclick="if (this.checked) BS.NotificationRuleForm.checkEvent('BUILD_FINISHED_SUCCESS');"/><label
              for="editingEvents['FIRST_SUCCESS_AFTER_FAILURE']">Only notify on the first successful build after failed</label></td>
        </tr>
        <tr>
          <td class="startOfGroup"><forms:checkbox name="editingEvents['BUILD_FAILING']" checked="${ruleBean.editingEvents['BUILD_FAILING']}"/><label
              for="editingEvents['BUILD_FAILING']">The first build error occurs</label></td>
        </tr>
        <tr>
          <td><forms:checkbox name="editingEvents['BUILD_STARTED']" checked="${ruleBean.editingEvents['BUILD_STARTED']}"/><label for="editingEvents['BUILD_STARTED']">Build
            starts</label></td>
        </tr>
        <tr>
          <td><forms:checkbox name="editingEvents['BUILD_FAILED_TO_START']" checked="${ruleBean.editingEvents['BUILD_FAILED_TO_START']}"
          /><label for="editingEvents['BUILD_FAILED_TO_START']">Build fails to start</label></td>
        </tr>
        <tr>
          <td><forms:checkbox name="editingEvents['BUILD_PROBABLY_HANGING']" checked="${ruleBean.editingEvents['BUILD_PROBABLY_HANGING']}"/><label
              for="editingEvents['BUILD_PROBABLY_HANGING']">Build is probably hanging</label></td>
        </tr>
        <tr>
          <td class="startOfGroup"><forms:checkbox name="editingEvents['RESPONSIBILITY_CHANGES']" checked="${ruleBean.editingEvents['RESPONSIBILITY_CHANGES']}"/><label
              for="editingEvents['RESPONSIBILITY_CHANGES']">Investigation is updated</label></td>
        </tr>
        <tr>
          <td class="startOfGroup"><forms:checkbox name="editingEvents['MUTE_UPDATED']" checked="${ruleBean.editingEvents['MUTE_UPDATED']}"/><label
              for="editingEvents['MUTE_UPDATED']">Tests are muted or unmuted</label></td>
        </tr>
      </table>

      <table class="eventsTable" id="system-wide-events" style="display: none;">
        <tr>
          <td><forms:checkbox name="editingEvents['RESPONSIBILITY_ASSIGNED']" checked="${ruleBean.editingEvents['RESPONSIBILITY_ASSIGNED']}"/><label
              for="editingEvents['RESPONSIBILITY_ASSIGNED']">Investigation assigned to me</label></td>
        </tr>
      </table>
    </div>
  </div>

  <div class="saveButtonsBlock">
    <forms:submit label="Save"/>
    <forms:cancel onclick="BS.NotificationRuleForm.cancelEditing()"/>
    <forms:saving/>
  </div>

  <input type="hidden" name="id" value="${ruleBean.id}"/>
  <input type="hidden" name="branchFilter" value=""/>
  <input type="hidden" name="favoriteBuildsFilter" value=""/>
  <input type="hidden" name="userChangesFilter" value=""/>
  <input type="hidden" name="notificatorType" value="${notificationRulesForm.notificatorType}"/>
  <input type="hidden" name="holderId" value="${notificationRulesForm.editeeId}"/>
  <input type="hidden" name="submitRule" value="save"/>
</form>
