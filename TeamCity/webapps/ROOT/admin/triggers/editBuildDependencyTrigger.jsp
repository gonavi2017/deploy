<%@ include file="/include-internal.jsp" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="admfn" uri="/WEB-INF/functions/admin" %>
<jsp:useBean id="dependencyTriggerBean" type="jetbrains.buildServer.controllers.admin.projects.triggers.DependencyBuildTriggerBean" scope="request"/>
<jsp:useBean id="buildForm" type="jetbrains.buildServer.controllers.admin.projects.EditableBuildTypeSettingsForm" scope="request"/>
<jsp:useBean id="propertiesBean" type="jetbrains.buildServer.controllers.BasePropertiesBean" scope="request"/>
<c:set var="curDeps" value="${dependencyTriggerBean.currentSnapshotDependencies}"/>
<bs:webComponentsSettings/>
<tr>
  <td colspan="2"><em>Finished Build Trigger will add a build to the queue after a build finishes in the selected configuration.</em></td>
</tr>
<script type="text/javascript">
  window.FinishBuildTrigger = {
    buildsWithBranches : []
  };
  window.FinishBuildTrigger.dependsOnUpdate = function(select){
    var selectedId = select.options[select.selectedIndex].value;
    if (selectedId == '') {
      return;
    }
    if (!window._curDeps[selectedId]) {
      BS.Util.show('snapshotDepWarn');
    } else {
      BS.Util.hide('snapshotDepWarn');
    }

    if (FinishBuildTrigger.buildsWithBranches && $j.inArray(selectedId, FinishBuildTrigger.buildsWithBranches) != -1) {
      BS.Util.show('finishTriggerBranchFilter');
      BS.MultilineProperties.updateVisible();
      if (window._branchFilter.length == 0) {
        $('branchFilter').value = '+:&lt;default&gt;';
      } else {
        $('branchFilter').value = window._branchFilter;
      }
    } else {
      BS.Util.hide('finishTriggerBranchFilter');
      $('branchFilter').value = '';
    };
  };
  window.FinishBuildTrigger.restDependsOnUpdate = function(selected){
    var selectedId = $j('#dependsOn').val();

    if (selectedId == '') {
      BS.Util.hide('snapshotDepWarn');
      return;
    }
    if (!window._curDeps[selectedId]) {
      BS.Util.show('snapshotDepWarn');
    } else {
      BS.Util.hide('snapshotDepWarn');
    }

    if ($j('#dependsOnHasBranches').val() == 'true' || window._branchFilter){
      BS.Util.show('finishTriggerBranchFilter');
      BS.MultilineProperties.updateVisible();
      if (window._branchFilter.length == 0) {
        $('branchFilter').value = $j('#dependsOnDefaultBranchExcluded').val() == 'false' ? '+:&lt;default&gt;' : "";
      } else {
        $('branchFilter').value = window._branchFilter;
      }
    } else {
      BS.Util.hide('finishTriggerBranchFilter');
      $('branchFilter').value = '';
    }

  }
</script>
<tr>
  <td style="vertical-align: top;">
    <label for="dependsOn">Build configuration:</label>
  </td>
  <td style="vertical-align: top;">
    <c:choose>
      <c:when test="${restSelectorsDisabled}">
        <props:selectProperty name="dependsOn" style="width: 100%;" enableFilter="true" onchange="window.FinishBuildTrigger.dependsOnUpdate(this);">
          <props:option value="">-- Choose a build configuration --</props:option>
          <c:forEach items="${dependencyTriggerBean.buildTypes}" var="bean">
            <forms:projectOptGroup project="${bean.project}" classes="user-depth-${bean.limitedDepth}">
              <c:forEach items="${bean.buildTypes}" var="buildType"
              ><props:option value="${buildType.externalId}"
                             title="${buildType.fullName}"
                             className="inplaceFiltered user-depth-${bean.limitedDepth + 1}"><c:out value="${buildType.name}"/></props:option>
                <script type="text/javascript">
                  <c:if test="${admfn:isBranchSpecDefined(buildType)}">
                  window.FinishBuildTrigger.buildsWithBranches.push('${buildType.externalId}');
                  </c:if>
                </script>
              </c:forEach>
              <c:if test="${empty bean.buildTypes}"><forms:option value="" className="user-delete" disabled="true">&nbsp;</forms:option></c:if>
            </forms:projectOptGroup>
          </c:forEach>
        </props:selectProperty>
      </c:when>
      <c:otherwise>
        <input type="hidden" id="dependsOn" name="prop:dependsOn" value="${propertiesBean.properties['dependsOn']}"/>
        <input type="hidden" id="dependsOnDefaultBranchExcluded"  value=""/>
        <input type="hidden" id="dependsOnHasBranches"  value=""/>
        <div id="dependsOnSelectorWrapper" style="width: 330px;"></div>
        <script type="text/javascript">
          BS.RestProjectsPopup.componentPlaceholder('#dependsOnSelectorWrapper', 'buildtype-dropdown', function(){
            var bdtrigger = document.createElement('buildtype-dropdown');
            bdtrigger.server = base_uri;
            var excludes = [];
            <c:forEach items="${dependencyTriggerBean.excludedBuildTypesIds}" var="bt">
            excludes.push('${bt.internalId}');
            </c:forEach>
            bdtrigger.excludedBuildtypes = excludes;
            bdtrigger.settings = {"quickNavigation":false,
              "editMode":false,
              "source":"global",
              "baseUri":base_uri,
              "currentServer":base_uri,
              "height":"230px",
              "hideFirstServerHeader":true};
            <c:if test="${not empty dependencyTriggerBean.selectedBuildType}">
            bdtrigger.selected = {
              name: "<bs:escapeForJs text="${dependencyTriggerBean.selectedBuildType.name}"/>",
              fullPath: "<bs:escapeForJs text="${dependencyTriggerBean.selectedBuildType.fullName}"/>",
              id: "${dependencyTriggerBean.selectedBuildType.externalId}",
              internalId: "${dependencyTriggerBean.selectedBuildType.internalId}",
              webUrl: "${propertiesBean.properties['dependsOn']}"
            };
            </c:if>
            <c:if test="${empty dependencyTriggerBean.selectedBuildType && not empty propertiesBean.properties['dependsOn']}">
            bdtrigger.selected = {
              name: "-- non-existent (deleted) build configuration --",
              fullPath: "-- non-existent (deleted) build configuration --",
              id: "${propertiesBean.properties['dependsOn']}",
              internalId: "",
              webUrl: "${propertiesBean.properties['dependsOn']}"
            };
            </c:if>
            $j('#dependsOnSelectorWrapper').append(bdtrigger);
            $j('#dependsOnSelectorWrapper').on('buildtype-changed', function(e){
              $j('#dependsOn').val(e.detail.id);
              bdtrigger.checkDefaultExcluded();
            });
            $j('#dependsOnSelectorWrapper').on('default-excluded-loaded', function(e){
              $j('#dependsOnDefaultBranchExcluded').val(e.detail.defaultExcluded);
              $j('#dependsOnHasBranches').val(e.detail.hasBranches);
              window.FinishBuildTrigger.restDependsOnUpdate();
            });
            bdtrigger.loadData();
          });
        </script>
      </c:otherwise>
    </c:choose>
    <div id="snapshotDepWarn" style="display: none; margin-top: 0.3em;"><span class="icon icon16 yellowTriangle"></span>
      There is no snapshot dependency on the selected build configuration. <bs:help file="Configuring Finish Build Trigger"/></div>
    <span class="error" id="error_dependsOn"></span>
    <script type="text/javascript">
      window._curDeps = {};
      <c:forEach items="${curDeps}" var="dep">
      window._curDeps['${dep.externalId}'] = true;
      </c:forEach>
      window._dependsOn = "${propertiesBean.properties['dependsOn']}";
      window._branchFilter = "${util:forJS(propertiesBean.properties['branchFilter'], false, false)}";
      if (BS.internalProperty('teamcity.ui.restSelectors.disabled', false)) {
        $('dependsOn').onchange();
      } else {
         window.FinishBuildTrigger.restDependsOnUpdate();
      }
    </script>
  </td>
</tr>
<tr>
  <td class="noBorder">&nbsp;</td>
  <td class="noBorder">
    <props:checkboxProperty name="afterSuccessfulBuildOnly" checked="${propertiesBean.properties['afterSuccessfulBuildOnly']}"/>
    <label for="afterSuccessfulBuildOnly">Trigger after successful build only</label>
  </td>
</tr>
<tbody id="finishTriggerBranchFilter" style="${empty propertiesBean.properties['dependsOn'] ? 'display: none;' : ''}">
  <c:choose>
    <c:when test="${restSelectorsDisabled}">
      <c:set var="buildTypeIdsFunc" scope="request">
        function() {
        var selected = $('dependsOn').selectedIndex;
        return [ $('dependsOn').options[selected].value ];
        }
      </c:set>
    </c:when>
    <c:otherwise>
      <c:set var="buildTypeIdsFunc" scope="request">
        function() {
        return [$j('#dependsOn').val()];
        }
      </c:set>
    </c:otherwise>
  </c:choose>
  <jsp:include page="branchFilter.jsp"/>
</tbody>
