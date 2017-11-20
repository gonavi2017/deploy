<%@ page import="jetbrains.buildServer.artifacts.RevisionRules" %>
<%@ page import="jetbrains.buildServer.serverSide.Branch" %>
<%@ include file="/include-internal.jsp" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<jsp:useBean id="dependencyTriggerBean" type="jetbrains.buildServer.controllers.admin.projects.triggers.DependencyBuildTriggerBean" scope="request"/>
<jsp:useBean id="buildForm" type="jetbrains.buildServer.controllers.admin.projects.EditableBuildTypeSettingsForm" scope="request"/>
<jsp:useBean id="propertiesBean" type="jetbrains.buildServer.controllers.BasePropertiesBean" scope="request"/>
<c:set var="curDeps" value="${dependencyTriggerBean.currentSnapshotDependencies}"/>
<c:set var="buildDependencyFieldsStyle" value="${propertiesBean.properties['triggerBuildIfWatchedBuildChanges'] == null ? 'display:none' : '' }"/>
<c:set var="branchesConfigured" value="${buildForm.template or buildForm.branchesConfigured}"/>
<bs:webComponentsSettings/>
<script type="text/javascript">

  window.ScheduledBuildTrigger = {};

  window.ScheduledBuildTrigger.chbxOnUpdate = function(chbx){
    if (chbx.checked) {
      $j('.buildDependencyFields').show();
      $j('#promoteWatchedBuild').prop('checked', true);
    } else {
      $j('.buildDependencyFields').hide();
    }

    BS.VisibilityHandlers.updateVisibility('buildTagField');
    BS.VisibilityHandlers.updateVisibility('buildBranchField');
  };
  window.ScheduledBuildTrigger.dependsOnUpdate = function(select){
    window.ScheduledBuildTrigger.updates(select.options[select.selectedIndex].value);
  };
  window.ScheduledBuildTrigger.updates = function(selectedId){
    var branchesConfigured = ${branchesConfigured};

    if (selectedId == undefined){
      return;
    }

    var showBranchField = function(names) {
      if (names.length > 1 || (branchesConfigured && window._curDeps[selectedId])) {
        // if selected build configuration has more than one branch or
        // branches configured in current build configuration and there is a snapshot dependency on the selected one
        $j('#buildBranchField').show();
        BS.BranchesPopup.attachBuildTypeHandler(selectedId, 'revisionRuleBuildBranch', 'singleBranch', 'ALL_BRANCHES');
      } else {
        $j('#buildBranchField').hide();
      }

      BS.VisibilityHandlers.updateVisibility('buildBranchField');
      BS.MultilineProperties.updateVisible();
    };

    BS.AdminActions.listBranches(selectedId, showBranchField);

    BS.MultilineProperties.updateVisible();
  };
  window.ScheduledBuildTrigger.restDependsOnUpdate = function(){
    window.ScheduledBuildTrigger.updates($j('#dependsOn').val());
  }
</script>
<tr class="advancedSetting">
  <td colspan="2">
    <props:checkboxProperty name="triggerBuildIfWatchedBuildChanges" onclick="window.ScheduledBuildTrigger.chbxOnUpdate(this);"/>
    <label for="triggerBuildIfWatchedBuildChanges">Trigger only if watched build changes</label> <bs:help file="Configuring+Schedule+Triggers" anchor="BuildChanges"/>
  </td>
</tr>
<tr class="buildDependencyFields advancedSetting" style="${buildDependencyFieldsStyle}">
  <td class="_top _label"><label for="revisionRuleDependsOn">Watch for:</label></td>
  <td>
    <c:choose>
      <c:when test="${restSelectorsDisabled}">
        <props:selectProperty name="revisionRuleDependsOn" style="width: 100%;" enableFilter="true" onchange="window.ScheduledBuildTrigger.dependsOnUpdate(this);">
          <props:option value="">-- Choose a build configuration --</props:option>
          <c:forEach items="${dependencyTriggerBean.buildTypes}" var="bean">
            <forms:projectOptGroup project="${bean.project}" classes="user-depth-${bean.limitedDepth}">
              <c:forEach items="${bean.buildTypes}" var="buildType"
              ><props:option value="${buildType.externalId}"
                             title="${buildType.fullName}"
                             className="inplaceFiltered user-depth-${bean.limitedDepth + 1}"><c:out value="${buildType.name}"/></props:option
              ></c:forEach>
              <c:if test="${empty bean.buildTypes}"><forms:option value="" className="user-delete" disabled="true">&nbsp;</forms:option></c:if>
            </forms:projectOptGroup>
          </c:forEach>
        </props:selectProperty>
      </c:when>
      <c:otherwise>
        <input type="hidden" id="dependsOn" name="prop:revisionRuleDependsOn" value="${propertiesBean.properties['revisionRuleDependsOn']}"/>
        <input type="hidden" id="dependsOnDefaultBranchExcluded"  value=""/>
        <input type="hidden" id="dependsOnHasBranches"  value=""/>
        <div id="dependsOnSelectorWrapper"></div>
        <script type="text/javascript">
          BS.RestProjectsPopup.componentPlaceholder('#dependsOnSelectorWrapper', 'buildtype-dropdown', function(){
            var strigger = document.createElement('buildtype-dropdown');
            strigger.server = base_uri;
            var excludes = [];
            <c:forEach items="${dependencyTriggerBean.excludedBuildTypesIds}" var="bt">
            excludes.push('${bt.internalId}');
            </c:forEach>
            strigger.excludedBuildtypes = excludes;
            strigger.settings = {"quickNavigation":false,
              "editMode":false,
              "source":"global",
              "baseUri":base_uri,
              "currentServer":base_uri,
              "height":"230px",
              "hideFirstServerHeader":true};
            <c:if test="${not empty dependencyTriggerBean.selectedBuildType}">
            strigger.selected = {
              name: "<bs:escapeForJs text="${dependencyTriggerBean.selectedBuildType.name}"/>",
              fullPath: "<bs:escapeForJs text="${dependencyTriggerBean.selectedBuildType.fullName}"/>",
              id: "${dependencyTriggerBean.selectedBuildType.externalId}",
              internalId: "${dependencyTriggerBean.selectedBuildType.internalId}",
              webUrl: "${propertiesBean.properties['dependsOn']}"
            };
            </c:if>
            <c:if test="${empty dependencyTriggerBean.selectedBuildType && not empty propertiesBean.properties['dependsOn']}">
            strigger.selected = {
              name: "-- non-existent (deleted) build configuration --",
              fullPath: "-- non-existent (deleted) build configuration --",
              id: "${propertiesBean.properties['dependsOn']}",
              internalId: "",
              webUrl: "${propertiesBean.properties['dependsOn']}"
            };
            </c:if>
            $j('#dependsOnSelectorWrapper').append(strigger);
            $j('#dependsOnSelectorWrapper').on('buildtype-changed', function(e){
              $j('#dependsOn').val(e.detail.id);
              strigger.checkDefaultExcluded();
            });
            $j('#dependsOnSelectorWrapper').on('default-excluded-loaded', function(e){
              $j('#dependsOnDefaultBranchExcluded').val(e.detail.defaultExcluded);
              $j('#dependsOnHasBranches').val(e.detail.hasBranches);
              window.ScheduledBuildTrigger.restDependsOnUpdate();
            });
            strigger.loadData();
          });
        </script>
      </c:otherwise>
    </c:choose>

    <span class="error" id="error_revisionRuleDependsOn"></span>
  </td>
</tr>
<tr class="buildDependencyFields advancedSetting" style="${buildDependencyFieldsStyle}">
  <td class="_label">&nbsp;</td>
  <td>
    <c:set var="lastSuccessful" value="<%=RevisionRules.LAST_SUCCESSFUL_NAME%>"/>
    <c:set var="lastFinished" value="<%=RevisionRules.LAST_FINISHED_NAME%>"/>
    <c:set var="lastPinned" value="<%=RevisionRules.LAST_PINNED_NAME%>"/>
    <c:set var="buildNumber" value="<%=RevisionRules.BUILD_NUMBER_NAME%>"/>
    <c:set var="buildTag" value="<%=RevisionRules.BUILD_TAG_NAME%>"/>

    <props:selectProperty name="revisionRule" style="width: 100%;" enableFilter="true" onchange="{
      if (this.options[this.selectedIndex].value == '${buildTag}') {
        $j('#buildTagField').show();
      } else {
        $j('#buildTagField').hide();
      }
      BS.VisibilityHandlers.updateVisibility('buildTagField');
    }">
      <props:option value="${lastFinished}">Last finished build</props:option>
      <props:option value="${lastSuccessful}">Last successful build</props:option>
      <props:option value="${lastPinned}">Last pinned build</props:option>
      <props:option value="${buildTag}">Last finished build with specified tag</props:option>
    </props:selectProperty>

    <c:set var="buildTag" value="<%=RevisionRules.BUILD_TAG_NAME%>"/>
    <div id="buildTagField" style="padding-top: 0.5em; ${propertiesBean.properties['revisionRule'] != buildTag ? 'display: none;' : ''}">
      <label for="revistionRuleBuildTag">Build tag:</label>
      <props:textProperty name="revistionRuleBuildTag" style="width: 22em;"/>
      <span class="error" id="error_revistionRuleBuildTag"></span>
    </div>

    <c:set var="specifiedBranch" value="${propertiesBean.properties['revisionRuleBuildBranch']}"/>
    <c:set var="defaultBranch" value="<%=Branch.DEFAULT_BRANCH_NAME%>"/>
    <div id="buildBranchField" style="padding-top: 0.5em; ${empty specifiedBranch or specifiedBranch == defaultBranch? 'display: none;' : ''}">
      <label for="revistionRuleBuildBranch">Build branch:</label>
      <props:textProperty name="revisionRuleBuildBranch" style="width: 20.5em;"/>
      <bs:smallNote>
        A logical branch name<bs:help file="Working+with+Feature+Branches" anchor="Logicalbranchname"/>.
        Set to empty value to use the same branch where the build is triggered.
      </bs:smallNote>
    </div>

    <div style="padding-top: 0.5em;">
      <props:checkboxProperty name="promoteWatchedBuild"/>
      <label for="promoteWatchedBuild">Promote watched build if there is a dependency (snapshot or artifact) on its build configuration</label>
    </div>

    <script type="text/javascript">
      window._curDeps = {};
      <c:forEach items="${curDeps}" var="dep">
      window._curDeps['${dep.externalId}'] = true;
      </c:forEach>
      if (BS.internalProperty('teamcity.ui.restSelectors.disabled', false)) {
        $('revisionRuleDependsOn').onchange();
      } else {
        window.ScheduledBuildTrigger.restDependsOnUpdate();
      }
    </script>
  </td>
</tr>
