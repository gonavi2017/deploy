<%@ page import="jetbrains.buildServer.artifacts.RevisionRules" %>
<%@ include file="/include-internal.jsp" %>

<jsp:useBean id="artifactDependenciesBean" type="jetbrains.buildServer.controllers.admin.projects.EditableArtifactDependenciesBean" scope="request"/>
<jsp:useBean id="credentialsBean" type="jetbrains.buildServer.controllers.admin.projects.CredentialsBean" scope="request"/>
<c:set var="sourceDepsMap" value="${sourceDependenciesBean.dependOnIdsMap}"/>
<bs:webComponentsSettings/>

<form action="#" class="section">
  <h2 class="noBorder">Artifact Dependencies</h2>

  <bs:smallNote>
    Artifact dependency allows using artifacts produced by another build.<bs:help file="Dependent+Build" anchor="ArtifactDependency"/>
  </bs:smallNote>

  <c:if test="${not buildForm.readOnly}">
  <div>
    <forms:addButton onclick="BS.ArtifactDependencyForm.addDependency(event); return false" showdiscardchangesmessage="false">Add new artifact dependency</forms:addButton>

    <c:if test="${not empty artifactDependenciesBean.dependencies}">
      <c:url value='/admin/editDependencies.html?id=${buildForm.settingsId}' var="url"/>
      <c:set var="canCheck" value="${artifactDependenciesBean.allDependenciesAccessible}"/>
      <forms:button onclick="BS.ArtifactDependencyVerificationForm.verifyDependencies('${url}');"
                    title="${canCheck ? 'Click to validate the specified artifact dependencies' : 'Can not check, not all dependencies are accessible' }"
                    disabled="${not canCheck}">Check artifact dependencies</forms:button>
    </c:if>
  </div>
  </c:if>

  <c:if test="${not empty artifactDependenciesBean.dependencies}">
    <l:tableWithHighlighting highlightImmediately="true" id="artifactDeps" className="parametersTable">
      <tr>
        <th class="checkbox">
          <forms:checkbox name="selectAll"
                          onmouseover="BS.Tooltip.showMessage(this, {shift: {x: 10, y: 20}, delay: 600}, 'Click to select / unselect all dependencies')"
                          onmouseout="BS.Tooltip.hidePopup()"
                          onclick="if (this.checked) BS.Util.selectAll($('artifactDeps'), 'depId'); else BS.Util.unselectAll($('artifactDeps'), 'depId')"
                          disabled="${buildForm.readOnly}"/>
        </th>
        <th class="artifactsSource">Artifacts Source</th>
        <th class="artifactsPaths" colspan="3">Artifacts Paths</th>
      </tr>
      <c:set var="cleanDestPaths" value="${artifactDependenciesBean.cleanDestinationPaths}" />
      <c:forEach items="${artifactDependenciesBean.dependencies}" var="dependency" varStatus="pos">
        <c:set var="highlight" value='${not dependency.inherited and not buildForm.readOnly and dependency.sourceBuildTypeAccessible ? "highlight" : ""}'/>
        <c:set var="onclick"><c:if test="${(dependency.sourceBuildTypeAccessible or not dependency.sourceBuildTypeExists) and not buildForm.readOnly}">BS.ArtifactDependencyForm.editDependency(event, '${dependency.id}')</c:if></c:set>
        <tr>
          <td class="checkbox">
            <forms:checkbox name="depId" value="${dependency.id}" disabled="${dependency.inherited or buildForm.readOnly}"/>
          </td>
          <td class="${highlight}${not dependency.enabled ? ' contentDisabled' : ''}" onclick="${onclick}">
            <c:choose>
              <c:when test="${dependency.sourceBuildTypeAccessible}">
                <c:set var="sourceBuildType" value="${dependency.sourceBuildType}"/>
                <strong>
                  <c:choose>
                    <c:when test="${sourceBuildType != null}">
                      <bs:buildTypeLinkFull buildType="${sourceBuildType}" contextProject="${contextProject}"/>
                    </c:when>
                    <c:otherwise>
                      <c:out value="${dependency.sourceName}"/>
                    </c:otherwise>
                  </c:choose>
                </strong>
              </c:when>
              <c:when test="${not dependency.sourceBuildTypeExists}"><em title="Build configuration with ID &quot;${dependency.sourceBuildTypeExternalId}&quot; does not exist">&laquo;build configuration with ID "${dependency.sourceBuildTypeExternalId}" does not exist&raquo;</em></c:when>
              <c:otherwise><em title="You do not have enough permissions for this build configuration">&laquo;inaccessible build configuration&raquo;</em></c:otherwise>
            </c:choose>
            <admin:buildTypeSettingStatusDescription inherited="${dependency.inherited}" disabled="${not dependency.enabled}" overridden="${dependency.overridden}" />
            <br/>
            <c:if test="${dependency.enabled}">
              <c:set var="artDepWarning" />
              <c:if test="${dependency.revisionRuleIsLastFinishedSameChainRule and not sourceDepsMap[dependency.sourceBuildTypeId]}">
                <c:set var="artDepWarning"><b>Build from the same chain</b> artifact dependency is configured, but there is no snapshot dependency for the selected build configuration.</c:set>
              </c:if>
              <c:if test="${not dependency.revisionRuleIsLastFinishedSameChainRule and sourceDepsMap[dependency.sourceBuildTypeId]}">
                <c:set var="artDepWarning">You have snapshot dependency (possibly transitive) configured for the selected build configuration.
                            <br/>To obtain artifacts from a build with the same sources, select <b>Build from the same chain</b>.</c:set>
              </c:if>
              <c:if test="${not empty artDepWarning}">
                <span class="icon icon16 yellowTriangle" <bs:tooltipAttrs text="${artDepWarning}"/> ></span>
              </c:if>
            </c:if><bs:_artifactDependencyLink dependency="${dependency}"/>
          </td>
          <td class="${highlight}${not dependency.enabled ? ' contentDisabled' : ''}" onclick="${onclick}">
            <ul class="artifactsPaths">
              <c:set var="path"><bs:out value="${dependency.artifactsPaths}" multilineOnly="true"/></c:set>
              <li><bs:makeBreakable text="${path}" regex=";" escape="false"/></li>
              <c:choose>
                <c:when test="${dependency.cleanDestination}"><br><i>Destinations will be cleaned</i></c:when>
                <c:when test="${dependency.containsTargetPaths(cleanDestPaths)}">
                  <br/><i>Destinations to be cleaned due to other artifact dependencies:
                  <c:set var="delim" value="" />
                  <c:forEach items="${dependency.targetPaths}" var="target" varStatus="status"><c:if test="${cleanDestPaths.contains(target)}"><c:out value="${delim}" /><c:set var="delim" value=", " />
                      <c:choose><c:when test="${target.length() == 0}">[root]</c:when><c:otherwise><c:out value="${target}" /></c:otherwise></c:choose></c:if></c:forEach></i>
                </c:when>
              </c:choose>
            </ul>
          </td>
          <c:choose>
            <c:when test="${buildForm.readOnly or (dependency.sourceBuildTypeExists and not dependency.sourceBuildTypeAccessible)}">
              <td colspan="2" class="edit${not dependency.enabled ? ' contentDisabled' : ''}">
                cannot be edited
              </td>
            </c:when>
            <c:otherwise>
              <td class="edit"  onclick="${onclick}">
                  <a href="#" onclick="${onclick}; Event.stop(event)" showdiscardchangesmessage="false">Edit</a>
              </td>
              <td class="edit">
                <c:set var="depId" value="${dependency.id}"/>
                <bs:actionsPopup controlId="artdepActions${depId}"
                                 popup_options="shift: {x: -150, y: 20}, className: 'quickLinksMenuPopup'">
                  <jsp:attribute name="content">
                    <div>
                      <ul class="menuList">
                        <c:if test="${dependency.enabled}">
                          <l:li>
                            <a href="#" onclick="BS.AdminActions.setParametersDescriptorEnabled('${buildForm.settingsId}', '${dependency.id}', false, 'Artifact Dependency'); return false">Disable dependency</a>
                          </l:li>
                        </c:if>
                        <c:if test="${not dependency.enabled}">
                          <l:li>
                            <a href="#" onclick="BS.AdminActions.setParametersDescriptorEnabled('${buildForm.settingsId}', '${dependency.id}', true, 'Artifact Dependency'); return false">Enable dependency</a>
                          </l:li>
                        </c:if>
                        <c:if test="${dependency.overridden}">
                          <l:li>
                            <a href="#" onclick="BS.ArtifactDependencyForm.resetDependency('${dependency.id}'); return false">Reset</a>
                          </l:li>
                        </c:if>
                        <c:if test="${not dependency.inherited}">
                          <l:li>
                            <a href="#" onclick="BS.ArtifactDependencyForm.removeDependencies(['${dependency.id}']); return false">Delete</a>
                          </l:li>
                        </c:if>
                      </ul>
                    </div>
                  </jsp:attribute>
                  <jsp:body></jsp:body>
                </bs:actionsPopup>
              </td>
            </c:otherwise>
          </c:choose>
        </tr>
      </c:forEach>
    </l:tableWithHighlighting>
    <script type="text/javascript">
      BS.ArtifactDependencyForm.showOrHideActionsOnSelect();
    </script>
  </c:if>
</form>

<bs:refreshable containerId="dependencyResolverMessages" pageUrl="${pageUrl}">
  <c:if test="${artifactDependenciesBean.showVerificationLog}">
    <div class="dependencyResolverMessagesLog mono">
      <c:forEach items="${artifactDependenciesBean.dependencyResolverMessages}" var="message">
        ${message}<br/>
      </c:forEach>
    </div>
    <div class="downloadStats">
      <c:if test="${artifactDependenciesBean.numberOfDownloadedArtifacts > 0}">
        Number of downloaded artifacts: <strong>${artifactDependenciesBean.numberOfDownloadedArtifacts}</strong><br/>
      </c:if>
      <c:if test="${artifactDependenciesBean.numberOfErrors > 0}">
        Number of errors: <a href="#errorNum:1" onclick="window.focus($('errorNum:1'))" showdiscardchangesmessage="false"><span
          class="errorMessage"><strong>${artifactDependenciesBean.numberOfErrors}</strong></span></a> (<a href="#errorNum:1" onclick="window.focus($('errorNum:1'))" showdiscardchangesmessage="false">navigate</a> to the first error)<br/>
      </c:if>
    </div>
    <script type="text/javascript">
      <c:choose>
      <c:when test="${not artifactDependenciesBean.resolvingFinished}">
      window.setTimeout(function () {
        $('dependencyResolverMessages').refresh()
      }, 500);
      </c:when>
      <c:otherwise>
      BS.ArtifactDependencyVerificationForm.verificationFinished();
      </c:otherwise>
      </c:choose>
    </script>
  </c:if>
</bs:refreshable>

<bs:refreshable containerId="artifactDependencyDialog" pageUrl="${pageUrl}&artDepsDialog=true">
  <c:set var="title"><c:choose><c:when test="${artifactDependenciesBean.addDependencyMode}">Add New Artifact Dependency</c:when><c:when
      test="${artifactDependenciesBean.editDependencyMode}">Edit Artifact Dependency</c:when></c:choose></c:set>
  <c:url value='/admin/editDependencies.html?id=${buildForm.settingsId}' var="action"/>
  <script type="text/javascript">
    var sourceDepsMap = {};
    var artDepsMap = {};
    <c:forEach items="${sourceDependenciesBean.visibleDependencies}" var="dep">
    <c:if test="${dep.sourceBuildTypeAccessible}">
    sourceDepsMap['${dep.sourceBuildTypeId}'] = true;
    </c:if>
    </c:forEach>
    <c:forEach items="${artifactDependenciesBean.dependencies}" var="artdep">
    artDepsMap['${artdep.sourceBuildTypeId}'] = true;
    </c:forEach>
  </script>

  <bs:modalDialog formId="artifactDependencyForm"
                  action="${action}"
                  closeCommand="BS.ArtifactDependencyForm.close()"
                  saveCommand="BS.ArtifactDependencyForm.saveDependency()"
                  title="${title}">
    <div class="error" id="errorSimilarDependencyExists" style="margin-left: 0;"></div>
    <c:set var="editingDependency" value="${artifactDependenciesBean.editingDependency}"/>
    <table class="artifactDependencyFormTable">
      <tr>
        <td class="header"><label for="sourceBuildTypeId">Depend on:</label></td>
        <td>
          <c:if test="${restSelectorsDisabled}">
            <forms:select name="sourceBuildTypeId" id="sourceBuildTypeId" style="width: 25em;"
                          onchange="BS.EditArtifactDependencies.checkRelatedSnapshotDependency(true, false);
                                BS.EditArtifactDependencies.updateBuildTypeTagsList();
                                BS.EditArtifactDependencies.updateBranchField();" enableFilter="true">
            <c:if test="${param['artDepsDialog'] == 'true'}">
              <c:if test="${not editingDependency.sourceBuildTypeExists}">
                <forms:option value="" selected="true" disabled="true">-- Please select a build configuration --</forms:option>
              </c:if>
              <c:forEach items="${artifactDependenciesBean.buildTypes}" var="bean">
                <forms:projectOptGroup project="${bean.project}" classes="user-depth-${bean.limitedDepth}">
                  <c:forEach var="buildType" items="${bean.buildTypes}">
                      <c:set var="alwaysShowBranch">${buildType.buildTypeId == editingDependency.sourceBuildTypeId and editingDependency.branchConfigured ? 'alwaysShowBranch' : ''}</c:set>
                      <c:set var="defaultBranchExcluded" value="${buildType.defaultBranchExcluded ? 'defaultBranchExcluded' : ''}"/>
                      <forms:option value="${buildType.buildTypeId}"
                                    title="${buildType.fullName}"
                                    data="${buildType.externalId}"
                                    selected="${buildType.buildTypeId == editingDependency.sourceBuildTypeId}"
                                    className="user-depth-${bean.limitedDepth + 1} ${alwaysShowBranch} ${defaultBranchExcluded}"><c:out value="${buildType.name}"/></forms:option>
                  </c:forEach>
                  <c:if test="${empty bean.buildTypes}"><forms:option value="" className="user-delete" disabled="true">&nbsp;</forms:option></c:if>
                </forms:projectOptGroup>
              </c:forEach>
            </c:if>
          </forms:select>
          </c:if>
          <c:if test="${!restSelectorsDisabled}">
            <c:set var="editedInternalId" value="${not empty editingDependency ? editingDependency.sourceBuildTypeId : ''}"/>
            <c:set var="editedExternalId" value="${not empty editingDependency && not empty editingDependency.sourceBuildType ? editingDependency.sourceBuildType.externalId : ''}"/>
            <input name="sourceBuildTypeId" id="sourceBuildTypeId" value="${editedInternalId}"
                   data-filter-data="${editedExternalId}" type="hidden"/>
            <input name="defaultBranchExcluded" id="defaultBranchExcluded" value="" type="hidden"/>
            <div id="buildTypeSelector" style="width: 330px;"></div>
            <script type="javascript">
              BS.RestProjectsPopup.componentPlaceholder('#buildTypeSelector', 'buildtype-dropdown', function(){
                var bdd = document.createElement('buildtype-dropdown');
                bdd.server = base_uri;
                bdd.excludedBuildtypes = [];
                bdd.settings = {"quickNavigation":false,
                  "editMode":false,
                  "source":"global",
                  "baseUri":base_uri,
                  "currentServer":base_uri,
                  "height":"230px",
                  "hideFirstServerHeader":true};
                var alwaysShowBranches = "";
                <c:if test="${editingDependency.sourceBuildTypeExists}">
                  bdd.selected = {
                    fullPath: "<bs:escapeForJs text="${editingDependency.sourceBuildType.fullName}"/>",
                    name: "<bs:escapeForJs text="${editingDependency.sourceBuildType.name}"/>",
                    id: "${editingDependency.sourceBuildType.externalId}",
                    internalId: "${editingDependency.sourceBuildType.internalId}",
                    webUrl: '<bs:escapeForJs text="${editingDependency.sourceBuildType.fullName}"/>'
                };
                </c:if>
                <c:if test="${editingDependency.branchConfigured}">
                   alwaysShowBranches = "${editingDependency.sourceBuildTypeId}";
                </c:if>
                $j('#buildTypeSelector').append(bdd);
                $j('#buildTypeSelector').on('buildtype-changed', function(e){
                  $j('#sourceBuildTypeId').val(e.detail.internalId);
                  $j('#sourceBuildTypeId').attr('data-filter-data', e.detail.id);
                  BS.EditArtifactDependencies.checkRelatedSnapshotDependency(true, false);
                  BS.EditArtifactDependencies.updateBuildTypeTagsList();
                  BS.EditArtifactDependencies.clearBranchField();
                  bdd.checkDefaultExcluded();
                  bdd.ensureClose();
                });
                $j('#buildTypeSelector').on('default-excluded-loaded', function(e){
                  $j('#defaultBranchExcluded').val(e.detail.defaultExcluded);
                  BS.EditArtifactDependencies.updateBranchField(alwaysShowBranches, e.detail.defaultExcluded);
                });
                bdd.loadData();
              });
            </script>
          </c:if>
          <span class="error" id="errorSourceBuildTypeNotExists" style="margin-left: 0;"></span>
        </td>
      </tr>
      <tr>
        <td class="header" style="vertical-align: top;"><label for="revisionRules">Get artifacts from:</label></td>
        <td>

          <forms:select id="revisionRules" name="revisionRules" style="width: 25em;"
                        onchange="BS.EditArtifactDependencies.showHideValueFields(); BS.EditArtifactDependencies.checkRelatedSnapshotDependency(false, false); BS.EditArtifactDependencies.updateBranchField(${editingDependency.sourceBuildTypeId});" enableFilter="${true}">
            <forms:buildAnchorOptions selected="${editingDependency.revisionRuleName}" withChainOption="${buildForm.template or (not buildForm.template and buildForm.settingsBuildType.buildTypeId != buildType.id)}"/>
          </forms:select>
          <div id="lastFinishedNote" class="icon_before icon16 attentionComment" style="display: none;">
            A snapshot dependency is configured for the selected build configuration.
            To obtain artifacts from a build with the same sources, select <b>Build from the same chain</b> above.
          </div>

          <c:set var="buildNumber" value="<%=RevisionRules.BUILD_NUMBER_NAME%>"/>
          <c:set var="buildTag" value="<%=RevisionRules.BUILD_TAG_NAME%>"/>
          <div id="buildNumberField" class="buildNumberPattern">
            <label for="buildNumberPattern">Build number:</label>
            <forms:textField className="buildTypeParams" disabled="${editingDependency.revisionRuleName != buildNumber}" name="buildNumberPattern"
                             maxlength="100" style="width: 25em" value="${editingDependency.revisionRuleName == buildNumber ? editingDependency.revisionRuleValue : ''}"/><bs:help
              file="Build+Number"/>
            <span class="error" id="errorBuildNumberPattern" style="margin-left: 0;"></span>
          </div>
          <div id="buildTagField" class="buildNumberPattern">
            <label for="buildTag">Build tag:</label>
            <forms:textField className="buildTypeParams" disabled="${editingDependency.revisionRuleName != buildTag}" name="buildTag"
                             maxlength="60" style="width: 25em" value="${editingDependency.revisionRuleName == buildTag ? editingDependency.revisionRuleValue : ''}"/>
            <div id="buildTagList">Available tags: <span id="buildTagListSpan"></span></div>
            <span class="error" id="errorBuildTag" style="margin-left: 0;"></span>
          </div>
          <div id="buildBranchField" class="buildNumberPattern">
            <label for="buildBranch">Build branch:</label>
            <forms:textField className="buildTypeParams" name="buildBranch" maxlength="100" style="width: 25em" value="${editingDependency.buildBranch}"/>
            <bs:smallNote>
              A logical branch name<bs:help file="Working+with+Feature+Branches#WorkingwithFeatureBranches-Logicalbranchname"/>
            </bs:smallNote>
            <span class="error" id="errorBuildBranch" style="margin-left: 0;"></span>
          </div>
          <script type="text/javascript">
            var alwaysShowBranches = "";
            <c:if test="${editingDependency.branchConfigured}">
             alwaysShowBranches = "${editingDependency.sourceBuildTypeId}";
            </c:if>
            BS.EditArtifactDependencies.showHideValueFields(alwaysShowBranches);
            BS.EditArtifactDependencies.checkRelatedSnapshotDependency(${artifactDependenciesBean.addDependencyMode}, ${artifactDependenciesBean.addDependencyMode});
            BS.EditArtifactDependencies.updateBuildTypeTagsList();
          </script>
        </td>
      </tr>
      <tr>
        <td class="header" style="vertical-align: top;">
          <label onclick="$('artifactsPaths').getElementsByTagName('input')[0].focus()">Artifacts rules: <l:star/></label>
        </td>
        <td>
          <ul class="artifactsPaths" id="artifactsPaths">
            <li>
              <textarea rows="4" cols="30" style="width: 25em; resize: vertical;" class="buildTypeParams" name="artifactPath" id="artifactPaths" wrap="soft"><c:out
                  value="${editingDependency.artifactsPaths}"/></textarea>
            </li>
          </ul>
          <span class="error" id="errorArtifactsPaths" style="margin-left: 0;"></span>

          <bs:smallNote>Provide a newline-delimited set of rules in the form of<br/>[+:|-:]SourcePath[!ArchivePath][=>DestinationPath]<bs:help file="Artifact+Dependencies" width="1220"/></bs:smallNote>
        </td>
      </tr>
      <tr>
        <td></td>
        <td style="padding: 0;">
          <div>
          <forms:checkbox name="cleanDestination" checked="${editingDependency.cleanDestination}"/>
          <label for="cleanDestination" class="rightLabel">Clean destination paths before downloading artifacts</label>
          </div>
        </td>
      </tr>
    </table>

    <div class="popupSaveButtonsBlock">
      <forms:submit label="Save"/>
      <forms:cancel onclick="BS.ArtifactDependencyForm.close()" showdiscardchangesmessage="false"/>
      <forms:saving id="saveArtifactDependencyProgress"/>
    </div>

    <input type="hidden" name="revisionRuleName" value="${editingDependency.revisionRuleName}"/>
    <input type="hidden" name="revisionRuleValue" value="<c:out value="${editingDependency.revisionRuleValue}"/>"/>
    <c:choose>
      <c:when test="${artifactDependenciesBean.addDependencyMode}">
        <input type="hidden" name="saveArtifactDependency" value="add"/>
      </c:when>
      <c:otherwise>
        <input type="hidden" name="saveArtifactDependency" value="edit:${artifactDependenciesBean.selectedDependencyId}"/>
      </c:otherwise>
    </c:choose>

    <div id="artifactsTreePopup" class="popupDiv"></div>
  </bs:modalDialog>

  <script type="text/javascript">
    BS.AvailableParams.attachPopups('settingsId=${buildForm.settingsId}', 'buildTypeParams');
    BS.EditArtifactDependencies.attachPopups('buildTypeParams', 'artifactPaths', 'artifactDependencyDialog');
  </script>
</bs:refreshable>

<bs:modalDialog formId="enterCredentials"
                title="Check Artifact Dependencies"
                action="#"
                closeCommand="BS.EnterCredentialsDialog.close()"
                saveCommand="BS.EnterCredentialsDialog.submit()">
  <bs:smallNote>Since access to the artifacts requires authorization, provide valid user credentials to download artifacts from the server and perform the verification.</bs:smallNote>

  <table>
    <tr>
      <td><label for="username1">Username:</label></td>
      <td>
        <forms:textField name="username1" value="${credentialsBean.username}"/>
      </td>
    </tr>
    <tr>
      <td><label for="password1">Password:</label></td>
      <td>
        <forms:passwordField name="password1"
                             encryptedPassword="${credentialsBean.encryptedPassword}"
                             publicKey="${credentialsBean.hexEncodedPublicKey}"/>
        <span class="error" id="invalidCredentials" style="margin: 0;"></span>
      </td>
    </tr>
  </table>

  <div class="popupSaveButtonsBlock">
    <forms:submit label="Start"/>
    <forms:cancel onclick="BS.EnterCredentialsDialog.close()" showdiscardchangesmessage="false"/>
    <forms:saving id="submitCredentials"/>
  </div>
</bs:modalDialog>

<forms:modified id="artifact-actions-docked">
  <jsp:body>
    <div class="bulk-operations-toolbar fixedWidth">
      <span class="users-operations">
        <a href="#" id="deleteAllSelected" class="btn btn_primary submitButton"
           onclick="BS.ArtifactDependencyForm.removeDependencies(BS.ArtifactDependencyForm.getSelectedDeps()); return false">Remove selected dependencies</a>
      </span>
    </div>
  </jsp:body>
</forms:modified>
