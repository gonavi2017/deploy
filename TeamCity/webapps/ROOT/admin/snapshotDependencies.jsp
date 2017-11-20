<%@ page import="jetbrains.buildServer.serverSide.dependency.DependencyOptions" %>
<%@ include file="/include-internal.jsp" %>

<jsp:useBean id="sourceDependenciesBean" type="jetbrains.buildServer.controllers.admin.projects.EditableSourceDependenciesBean" scope="request"/>
<c:set var="takeStartedBuildOption"><%=DependencyOptions.TAKE_STARTED_BUILD_WITH_SAME_REVISIONS.getKey()%></c:set>
<c:set var="takeSuccessfulBuildsOnlyOption"><%=DependencyOptions.TAKE_SUCCESSFUL_BUILDS_ONLY.getKey()%></c:set>
<c:set var="runBuildOnTheSameAget"><%=DependencyOptions.RUN_BUILD_ON_THE_SAME_AGENT.getKey()%></c:set>
<c:set var="runBuildIfDependencyFailedOption"><%=DependencyOptions.RUN_BUILD_IF_DEPENDENCY_FAILED.getKey()%></c:set>
<c:set var="runBuildIfDependencyFailedToStartOption"><%=DependencyOptions.RUN_BUILD_IF_DEPENDENCY_FAILED_TO_START.getKey()%></c:set>
<c:set var="continuationMode_fail_to_start"><%=DependencyOptions.BuildContinuationMode.MAKE_FAILED_TO_START.name()%></c:set>
<c:set var="continuationMode_add_problem"><%=DependencyOptions.BuildContinuationMode.RUN_ADD_PROBLEM.name()%></c:set>
<c:set var="continuationMode_run"><%=DependencyOptions.BuildContinuationMode.RUN.name()%></c:set>
<c:set var="continuationMode_cancel"><%=DependencyOptions.BuildContinuationMode.CANCEL.name()%></c:set>
<bs:webComponentsSettings/>
<form action="#" class="section noMargin">
  <h2 class="noBorder">Snapshot Dependencies</h2>

  <bs:smallNote>
    Build configurations linked by a snapshot dependency will use the same snapshot of the sources.
    The build of this configuration will run after all the dependencies are built.
    If necessary, the dependencies will be triggered automatically.
    <bs:help file="Dependent+Build" anchor="SnapshotDependency"/>
  </bs:smallNote>

  <c:set var="chainId" value="${sourceDependenciesBean.buildChainId}"/>
  <c:if test="${not empty chainId}">
    <c:set value='/viewChain.html?chainId=${chainId}&selectedBuildTypeId=${buildForm.settingsBuildType.buildTypeId}&contextProjectId=${buildForm.settingsBuildType.projectExternalId}' var="relativeViewChainUrl"/>
    <c:url value='${relativeViewChainUrl}' var="viewChainUrl"/>
    <p>This build configuration is a part of a&nbsp;&nbsp;<a href="${viewChainUrl}" target="_blank" onclick="BS.stopPropagation(event);" title="Open build chain in a new window"><i class="tc-icon icon16 tc-icon_build-chain"></i>build chain</a></p>
  </c:if>

  <c:set var="buildTypesForAddDependency" value="${sourceDependenciesBean.buildTypesForAddDependency}"/>
  <c:if test="${not buildForm.readOnly and not empty buildTypesForAddDependency}">
    <div>
      <forms:addButton onclick="BS.SourceDependencyForm.addDependency(event); return false" showdiscardchangesmessage="false">Add new snapshot dependency</forms:addButton>
    </div>
  </c:if>

  <c:if test="${not empty sourceDependenciesBean.dependencies}">
    <l:tableWithHighlighting highlightImmediately="true" id="snapshotDeps" className="parametersTable">
      <tr>
        <th class="checkbox">
          <forms:checkbox name="selectAll"
                          onmouseover="BS.Tooltip.showMessage(this, {shift: {x: 10, y: 20}, delay: 600}, 'Click to select / unselect all dependencies')"
                          onmouseout="BS.Tooltip.hidePopup()"
                          onclick="if (this.checked) BS.Util.selectAll($('snapshotDeps'), 'snDepChkbox'); else BS.Util.unselectAll($('snapshotDeps'), 'snDepChkbox')"
                          disabled="${buildForm.readOnly}"/>
        </th>
        <th class="sourceBuildType">Depends On</th>
        <th colspan="3" class="dependencyOptions">Dependency Options</th>
      </tr>
      <c:forEach items="${sourceDependenciesBean.dependencies}" var="dependency" varStatus="pos">
        <c:set var="canBeEdited" value="${(dependency.sourceBuildTypeAccessible or not dependency.sourceBuildTypeExists) and not dependency.inherited and not buildForm.readOnly}"/>
        <c:set var="highlight" value='${canBeEdited ? "highlight" : ""}'/>
        <c:set var="onclick"><c:if test="${canBeEdited}">BS.SourceDependencyForm.editDependency(event, '${dependency.sourceBuildTypeId}')</c:if></c:set>
        <tr>
          <td class="checkbox">
            <forms:checkbox name="snDepChkbox" value="${dependency.sourceBuildTypeId}" disabled="${not dependency.sourceBuildTypeAccessible or not canBeEdited}"/>
          </td>
          <td class="${highlight}" onclick="${onclick}">
            <c:choose>
              <c:when test="${dependency.sourceBuildTypeAccessible}">
                <c:set var="dependOn" value="${dependency.sourceBuildType}"/>
                <strong>
                  <bs:buildTypeLinkFull buildType="${dependOn}"/>
                </strong>
              </c:when>
              <c:when test="${not dependency.sourceBuildTypeExists}"><em title="Build configuration with ID &quot;${dependency.sourceBuildTypeExternalId}&quot; does not exist">&laquo;build configuration with ID "${dependency.sourceBuildTypeExternalId}" does not exist&raquo;</em></c:when>
              <c:otherwise><em title="You do not have enough permissions for this build configuration">&laquo;inaccessible build configuration&raquo;</em></c:otherwise>
            </c:choose>
            <c:if test="${dependency.inherited}"><span class="inheritedParam">(inherited)</span></c:if>
          </td>
          <td class="dependencyOptions ${highlight}" onclick="${onclick}">
            <bs:_dependencyDescription dependency="${dependency}"/>
          </td>
          <c:choose>
            <c:when test="${not canBeEdited}">
              <c:set var="title" value="${dependency.inherited ? 'Inherited dependencies cannot be edited' : ''}"/>
              <td class="edit" colspan="2" title="${title}">cannot be edited</td>
            </c:when>
            <c:otherwise>
              <td class="edit ${highlight}" onclick="${onclick}">
                <a href="#" onclick="BS.SourceDependencyForm.editDependency(event, '${dependency.sourceBuildTypeId}'); Event.stop(event)" showdiscardchangesmessage="false">Edit</a>
              </td>
              <td class="edit">
                <a href="#"
                   onclick="BS.SourceDependencyForm.removeDependencies(['${dependency.sourceBuildTypeId}'], 'remove'); return false" showdiscardchangesmessage="false">Delete</a>
              </td>
            </c:otherwise>
          </c:choose>
        </tr>
      </c:forEach>
    </l:tableWithHighlighting>

    <script type="text/javascript">
      BS.SourceDependencyForm.showOrHideActionsOnSelect();
    </script>
  </c:if>
</form>

<bs:refreshable containerId="sourceEditingDependencyDialog" pageUrl="${pageUrl}&snapshotDepsDialog=true">
  <c:url var="action" value='/admin/editDependencies.html?id=${buildForm.settingsId}'/>
  <c:set var="takeStartedBuildOptionParam">option:${takeStartedBuildOption}</c:set>
  <c:set var="takeSuccessfulBuildsOnlyOptionParam">option:${takeSuccessfulBuildsOnlyOption}</c:set>
  <c:set var="runBuildIfDependencyFailedOptionParam">option:${runBuildIfDependencyFailedOption}</c:set>
  <c:set var="runBuildIfDependencyFailedToStartOptionParam">option:${runBuildIfDependencyFailedToStartOption}</c:set>
  <c:set var="runBuildOnTheSameAgetOptionParam">option:${runBuildOnTheSameAget}</c:set>
  <c:set var="selectedBuildTypes" value="${sourceDependenciesBean.selectedBuildTypes}"/>
  <c:set var="dialogTitle">
    <c:choose>
      <c:when test="${sourceDependenciesBean.addDependencyMode and empty selectedBuildTypes}">Add New Snapshot Dependency</c:when>
      <c:when test="${sourceDependenciesBean.addDependencyMode and not empty selectedBuildTypes}">Set Dependencies Options</c:when>
      <c:when test="${sourceDependenciesBean.editDependencyMode}">Edit Snapshot Dependency</c:when>
    </c:choose>
  </c:set>
  <c:set var="editingDep" value="${sourceDependenciesBean.editingDependency}"/>
  <bs:modalDialog formId="sourceDependencies"
                  action="${action}"
                  title="${dialogTitle}"
                  closeCommand="BS.SourceDependencyForm.close()"
                  saveCommand="BS.SourceDependencyForm.saveDependency()">
    <table style="width: 100%;">
      <tr>
        <c:choose>
          <c:when test="${not empty selectedBuildTypes}">
            <th style="width: 20%">
              <label for="srcDependOn">Dependencies:</label>
            </th>
          </c:when>
          <c:otherwise>
            <th style="width: 20%">
              <label for="srcDependOn">Depend on:</label>
            </th>
          </c:otherwise>
        </c:choose>
        <td>
          <c:choose>
            <c:when test="${sourceDependenciesBean.addDependencyMode}">
              <c:choose>
                <c:when test="${not empty selectedBuildTypes}">
                  <c:forEach items="${selectedBuildTypes}" var="bt">
                    <bs:buildTypeLinkFull buildType="${bt}"/><br/>
                    <input type="hidden" name="srcDependOn" value="${bt.buildTypeId}"/>
                  </c:forEach>
                </c:when>
                <c:otherwise>
                  <c:choose>
                    <c:when test="${!restSelectorsDisabled}">
                      <div id="sbtSelector" style="width: 385px;"></div>
                      <div id="buildTypeSelectorResult" style="visibility: hidden; height: 0px;"></div>
                      <style>
                        #sbtSelector .dropdown-content{
                          width: 383px;
                          border-top: none !important;
                        }
                        #sbtSelector #searchResults{
                          width: 383px;
                        }
                        #sbtSelector .ironListClass{
                          overflow-x: auto;
                        }
                      </style>
                      <script type="javascript">
                        BS.RestProjectsPopup.componentPlaceholder('#sbtSelector', 'buildtype-multiselect', function(){
                          var bdd2 = document.createElement('buildtype-multiselect');
                          bdd2.server = base_uri;
                          var excludes = ['${buildForm.settingsBuildType.internalId}'];
                          <c:forEach items="${sourceDependenciesBean.dependOnIds}" var="id">
                            excludes.push('${id}');
                          </c:forEach>
                          bdd2.excludedBuildtypes = excludes;
                          bdd2.settings = {"quickNavigation":false,
                            "editMode":false,
                            "source":"global",
                            "baseUri":base_uri,
                            "currentServer":base_uri,
                            "height":"230px",
                            "hideFirstServerHeader":true};
                          $j('#sbtSelector').append(bdd2);
                          $j('#sbtSelector').on('checked-items-changed', function(e){
                            $j('#buildTypeSelectorResult').html("");
                            var selectedBuildTypes = e.detail;
                            if (selectedBuildTypes != undefined){
                              selectedBuildTypes.forEach(function (bt){
                                var chb = document.createElement('input');
                                chb.type = "checkbox";
                                chb.checked = true;
                                chb.value = bt.internalId;
                                chb.name="srcDependOn";
                                $j('#buildTypeSelectorResult').append(chb);
                              })
                            }
                            $j('#sbtSelector .fastSearchInput').focus();
                          });
                          bdd2.loadData();
                        });
                      </script>
                    </c:when>
                    <c:otherwise>
                      <bs:inplaceFilter containerId="srcDependOn" activate="false" filterText="&lt;filter build configurations>"
                                        afterApplyFunc="function(filterField) {BS.MultiSelect.update('#srcDependOn', filterField);}"/>
                      <div id="srcDependOn" class="multi-select" style="height: 20em;">
                        <c:forEach items="${buildTypesForAddDependency}" var="bean">
                          <c:set var="project" value="${bean.project}"/>
                          <div class="inplaceFiltered user-depth-${bean.limitedDepth} disabled group" data-depth="${bean.limitedDepth}">
                            <label>
                              <input type="checkbox" class="group">
                              <c:out value="${project.name}"/> <c:if test="${project.archived}">(archived)</c:if>
                            </label>
                          </div>
                          <c:forEach var="buildType" items="${bean.buildTypes}"
                          ><c:if test="${buildForm.template or (not buildForm.template and buildForm.settingsBuildType.buildTypeId != buildType.buildTypeId)}"
                          >
                            <div class="inplaceFiltered user-depth-${bean.limitedDepth + 1}" data-title="<c:out value='${buildType.fullName}'/>" data-depth="${bean.limitedDepth + 1}">
                              <label>
                                <input type="checkbox" name="srcDependOn" value="${buildType.buildTypeId}">
                                <c:out value="${buildType.name}"/>
                              </label>
                            </div>
                          </c:if>
                          </c:forEach>
                        </c:forEach>
                      </div>
                      <script>
                        jQuery(function ($) {
                          BS.MultiSelect.init("#srcDependOn");
                          setTimeout(function () {
                            $("#srcDependOn_filter").focus();    // TW-28898.
                          }, 100);
                        });
                      </script>
                    </c:otherwise>
                  </c:choose>
                </c:otherwise>
              </c:choose>
            </c:when>
            <c:otherwise>
              <c:choose>
              <c:when test="${restSelectorsDisabled}">
                <forms:select name="srcDependOn" id="srcDependOn" disabled="${editingDep.inherited}" enableFilter="true">
                  <c:if test="${param['snapshotDepsDialog'] == 'true'}">
                    <c:if test="${not editingDep.sourceBuildTypeExists}">
                      <forms:option value="" selected="true" disabled="true">-- Please select a build configuration --</forms:option>
                    </c:if>
                    <c:forEach items="${sourceDependenciesBean.availableBuildTypes}" var="bean">
                      <forms:projectOptGroup project="${bean.project}" classes="user-depth-${bean.limitedDepth}" inplaceFiltered="true">
                        <c:forEach var="buildType" items="${bean.buildTypes}">
                          <forms:option value="${buildType.buildTypeId}"
                                        title="${buildType.fullName}"
                                        className="inplaceFiltered user-depth-${bean.limitedDepth + 1}"
                                        selected="${editingDep.sourceBuildTypeId == buildType.buildTypeId}"><c:out value="${buildType.name}"/></forms:option>
                        </c:forEach>
                        <c:if test="${empty bean.buildTypes}"><forms:option value="" className="user-delete" disabled="true">&nbsp;</forms:option></c:if>
                      </forms:projectOptGroup>
                    </c:forEach>
                  </c:if>
                </forms:select>
              </c:when>
                <c:otherwise>
                  <c:set var="editedInternalId" value="${not empty editingDep ? editingDep.sourceBuildTypeId : ''}"/>
                  <c:set var="editedExternalId" value="${not empty editingDep && not empty editingDep.sourceBuildType ? editingDep.sourceBuildType.externalId : ''}"/>
                  <input name="srcDependOn" id="srcDependOn" value="${editedInternalId}"
                         data-filter-data="${editedExternalId}" type="hidden"/>
                  <div id="sbtSelector" style="width: 385px;"></div>
                  <style>
                    #sbtSelector .dropdown-content{
                      width: 383px !important;
                    }
                  </style>
                  <script type="javascript">
                    BS.RestProjectsPopup.componentPlaceholder('#sbtSelector', 'buildtype-dropdown', function(){
                      var sbd = document.createElement('buildtype-dropdown');
                      sbd.server = base_uri;
                      var excludes = ['${buildForm.settingsBuildType.internalId}'];
                      <c:forEach items="${sourceDependenciesBean.dependOnIds}" var="id">
                        <c:if test="${!editingDep.sourceBuildTypeExists || (editingDep.sourceBuildTypeExists && id != editingDep.sourceBuildType.internalId)}">
                          excludes.push('${id}');
                        </c:if>
                      </c:forEach>
                      sbd.excludedBuildtypes = excludes;
                      sbd.settings = {"quickNavigation":false,
                        "editMode":false,
                        "source":"global",
                        "baseUri":base_uri,
                        "currentServer":base_uri,
                        "height":"200px",
                        "hideFirstServerHeader":true};
                      <c:if test="${editingDep.sourceBuildTypeExists}">
                      sbd.selected = {
                        fullPath: "<bs:escapeForJs text="${editingDep.sourceBuildType.fullName}"/>",
                        name: "<bs:escapeForJs text="${editingDep.sourceBuildType.name}"/>",
                        id: "${editingDep.sourceBuildType.externalId}",
                        internalId: "${editingDep.sourceBuildType.internalId}",
                        webUrl: "<bs:escapeForJs text="${editingDep.sourceBuildType.fullName}"/>"
                      };
                      </c:if>
                      $j('#sbtSelector').append(sbd);
                      $j('#sbtSelector').on('buildtype-changed', function(e){
                        $j('#srcDependOn').val(e.detail.internalId);
                        $j('#srcDependOn').attr('data-filter-data', e.detail.id);
                      });
                      sbd.loadData();
                    });
                  </script>
                </c:otherwise>
              </c:choose>
              <c:if test="${editingDep.inherited}"><span class="grayNote">Build configuration of the inherited dependency can be changed in template only.</span></c:if>
            </c:otherwise>
          </c:choose>
        </td>
      </tr>
      <tr>
        <th class="optionsCell">Options:</th>
        <td class="optionsCell">
          <div>
            <forms:checkbox name="${takeStartedBuildOptionParam}" checked="${editingDep.setOptions[takeStartedBuildOption]}"
                            onclick="if (!this.checked) $('${takeSuccessfulBuildsOnlyOptionParam}').checked = false;"/>
            <label for="${takeStartedBuildOptionParam}">Do not run new build if there is a suitable one</label>
          </div>
          <div style="margin-left: 1.5em">
            <forms:checkbox name="${takeSuccessfulBuildsOnlyOptionParam}" checked="${editingDep.setOptions[takeSuccessfulBuildsOnlyOption]}"
                            onclick="if (this.checked && !$('${takeStartedBuildOptionParam}').checked) $('${takeStartedBuildOptionParam}').click();"/>
            <label for="${takeSuccessfulBuildsOnlyOptionParam}">Only use successful builds from suitable ones</label>
          </div>
          <div>
            <forms:checkbox name="${runBuildOnTheSameAgetOptionParam}" checked="${editingDep.setOptions[runBuildOnTheSameAget]}"/>
            <label for="${runBuildOnTheSameAgetOptionParam}">Run build on the same agent</label>
          </div>
          <div class="failedDependencyOption">
            <label for="${runBuildIfDependencyFailedOptionParam}">On failed dependency:</label>
            <forms:select name="${runBuildIfDependencyFailedOptionParam}">
              <forms:option value="${continuationMode_add_problem}" selected="${continuationMode_add_problem == editingDep.setOptions[runBuildIfDependencyFailedOption]}">Run build, but add problem</forms:option>
              <forms:option value="${continuationMode_run}" selected="${continuationMode_run == editingDep.setOptions[runBuildIfDependencyFailedOption]}">Run build, do not add problem</forms:option>
              <forms:option value="${continuationMode_fail_to_start}" selected="${empty editingDep.setOptions[runBuildIfDependencyFailedOption]}">Make build failed to start</forms:option>
              <forms:option value="${continuationMode_cancel}" selected="${continuationMode_cancel == editingDep.setOptions[runBuildIfDependencyFailedOption]}">Cancel build</forms:option>
            </forms:select>
          </div>
          <div class="failedDependencyOption">
            <label for="${runBuildIfDependencyFailedToStartOptionParam}">On failed to start/canceled dependency:</label>
            <forms:select name="${runBuildIfDependencyFailedToStartOptionParam}">
              <forms:option value="${continuationMode_add_problem}" selected="${continuationMode_add_problem == editingDep.setOptions[runBuildIfDependencyFailedToStartOption]}">Run build, but add problem</forms:option>
              <forms:option value="${continuationMode_run}" selected="${continuationMode_run == editingDep.setOptions[runBuildIfDependencyFailedToStartOption]}">Run build, do not add problem</forms:option>
              <forms:option value="${continuationMode_fail_to_start}" selected="${empty editingDep.setOptions[runBuildIfDependencyFailedToStartOption]}">Make build failed to start</forms:option>
              <forms:option value="${continuationMode_cancel}" selected="${continuationMode_cancel == editingDep.setOptions[runBuildIfDependencyFailedToStartOption]}">Cancel build</forms:option>
            </forms:select>
          </div>
        </td>
      </tr>
    </table>

    <div class="popupSaveButtonsBlock">
      <forms:submit label="Save"/>
      <forms:cancel onclick="BS.SourceDependencyForm.close()"/>
      <forms:saving id="addSourceDependencyProgress"/>
    </div>
    <c:choose>
      <c:when test="${artifactDependenciesBean.addDependencyMode}">
        <input type="hidden" name="saveSourceDependency" value="add"/>
      </c:when>
      <c:otherwise>
        <input type="hidden" name="saveSourceDependency" value="edit:${editingDep.sourceBuildTypeId}"/>
      </c:otherwise>
    </c:choose>
  </bs:modalDialog>
</bs:refreshable>

<forms:modified id="snapshot-actions-docked">
  <jsp:body>
    <div class="bulk-operations-toolbar fixedWidth">
      <span class="users-operations">
        <a href="#" class="btn btn_primary submitButton" onclick="BS.SourceDependencyForm.addDependency(event, BS.SourceDependencyForm.getSelectedDeps()); return false">Set dependencies options...</a>
        <a href="#" class="btn btn_primary submitButton" onclick="BS.SourceDependencyForm.removeDependencies(BS.SourceDependencyForm.getSelectedDeps(), ${buildForm.templateBased ? '\'remove / reset\'' : '\'remove\''}); return false">
          Remove${buildForm.templateBased ? ' / Reset' : ''} selected dependencies...
        </a>
      </span>
    </div>
  </jsp:body>
</forms:modified>
