<%@ page import="jetbrains.buildServer.serverSide.Branch" %>
<%@ include file="/include-internal.jsp"%>
<jsp:useBean id="runBuildBean" type="jetbrains.buildServer.controllers.RunBuildBean" scope="request"/>
<%--@elvariable id="changes" type="java.util.List"--%>
<%--@elvariable id="branches" type="java.util.List"--%>
<%--@elvariable id="hasBranches" type="java.lang.Boolean"--%>
<c:url value="/runCustomBuild.html?buildTypeId=${runBuildBean.buildType.externalId}&stateKey=${param['stateKey']}&customBuildDialog=true&updateChanges=true" var="url"/>
<c:set var="unspecifiedBranch" value="<%=Branch.UNSPECIFIED_BRANCH_NAME%>"/>
<c:set var="defaultBranch" value="<%=Branch.DEFAULT_BRANCH_NAME%>"/>
<bs:webComponentsSettings/>

<authz:authorize projectId="${runBuildBean.buildType.projectId}" allPermissions="CUSTOMIZE_BUILD_REVISIONS">
  <div id="changes-tab" style="display: none;" class="tabContent">
    <bs:refreshable containerId="changesContainer" pageUrl="${url}">
    <table class="runnerFormTable">
      <c:set var="revisionsFragment">
      <c:if test="${runBuildBean.modificationIdSpecified}">
        <c:set var="revisionsInfo" value="${runBuildBean.revisions}"/>
        <c:set var="error" value="${revisionsInfo.error}"/>
        <c:choose>
          <c:when test="${not empty error}">
            <c:out value="${error.message}"/>
          </c:when>
          <c:otherwise>
            <table class="settings" style="margin:10px 0; width:100%;">
            <tr>
              <th>VCS root</th>
              <th>Build configuration</th>
              <th>Revision</th>
            </tr>
            <c:forEach items="${revisionsInfo.vcsRoots}" var="vcsRoot">
              <c:set var="revisionsList" value="${revisionsInfo.revisions[vcsRoot]}"/>
              <c:set var="numRevs" value="${fn:length(revisionsList)}"/>
              <c:forEach items="${revisionsList}" var="revPair" varStatus="pos">
                <c:set var="revision" value="${revPair.second}"/>
                <tr>
                  <c:if test="${pos.first or numRevs < 2}">
                    <td style="width: 40%" <c:if test="${numRevs > 1}">rowspan="${numRevs}"</c:if>>
                      <c:choose>
                        <c:when test="${revision != null and revision.settingsRevision}">
                          <span class="customDialogSettingsRevision">
                            <i class="tc-icon icon16 tc-icon_cog" title="TeamCity settings revision"></i><bs:trimWithTooltip maxlength="45"><c:out value="${vcsRoot.name}"/></bs:trimWithTooltip>
                          </span>
                        </c:when>
                        <c:otherwise>
                          <bs:trimWithTooltip maxlength="45"><c:out value="${vcsRoot.name}"/></bs:trimWithTooltip>
                        </c:otherwise>
                      </c:choose>
                    </td>
                  </c:if>
                  <td style="width: 40%">
                    <c:if test="${not empty revPair.first}">
                      <bs:buildTypeLinkFull buildType="${revPair.first}"/>
                    </c:if>
                  </td>
                  <td>
                  <c:choose>
                    <c:when test="${revision != null}">
                      <c:choose>
                        <c:when test="${revision.settingsRevision}">
                          <span class="customDialogSettingsRevision">
                            <bs:trimWithTooltip maxlength="15">${revision.revisionDisplayName}</bs:trimWithTooltip> <c:if test="${revisionsInfo.vcsSettingsChanged[vcsRoot]}">*</c:if>
                          </span>
                        </c:when>
                        <c:otherwise>
                          <bs:trimWithTooltip maxlength="15">${revision.revisionDisplayName}</bs:trimWithTooltip> <c:if test="${revisionsInfo.vcsSettingsChanged[vcsRoot]}">*</c:if>
                        </c:otherwise>
                      </c:choose>
                    </c:when>
                    <c:otherwise>
                      <em>revision not found, will omit sources</em>
                    </c:otherwise>
                  </c:choose>
                  </td>
                </tr>
              </c:forEach>
            </c:forEach>
            </table>
            <c:if test="${not empty revisionsInfo.vcsSettingsChanged}">
              <div class="note">
              * Note: VCS settings (VCS roots or checkout rules) of the build configuration might have changed since the selected change,
                however TeamCity will use current VCS settings for the build.
              </div>
            </c:if>
          </c:otherwise>
        </c:choose>
      </c:if>
      </c:set>
        <c:if test="${fn:length(changes) > 0 or hasBranches}">
        <c:if test="${hasBranches}">
        <tr <c:if test='${!runBuildBean.defaultChangesSettings}'>class="modifiedParam"</c:if>>
          <td style="vertical-align: top;"><label for="branchFilter" style="white-space: nowrap; width: 8em;">Build branch:</label></td>
          <td style="vertical-align: top;">
            <c:set var="restBranchSelectorEnabled" value="${!restSelectorsDisabled}"/>
            <c:choose>
              <c:when test="${restBranchSelectorEnabled}">
                <input name="branchName" id="branchName_input" value="${runBuildBean.branchName}" type="hidden"/>
                <span id="runBranchSelector_container" style="display: inline-block; width: 350px;"></span>
                <script type="text/javascript">
                  BS.RestProjectsPopup.componentPlaceholder('#runBranchSelector_container', 'branch-search', function(){
                  var options = {buildTypeId:"${runBuildBean.buildType.externalId}",
                    excludeAllBranches: true,
                    excludeDefaultBranch: ${runBuildBean.buildType.defaultBranchExcluded},
                    includeUnspecifiedBranch: ${!runBuildBean.buildType.defaultBranchExcluded}};
                  var name = '${util:forJS(runBuildBean.branchName, true, false)}';
                  var defaultBranch = false;
                  var label = name;
                  if (label == '<unspecified>'){
                    label = '<Unspecified branch>';
                  } else if (label == '<default>'){
                    label = '<Default branch>';
                    defaultBranch = true;
                  }

                  if (defaultBranch && options.excludeDefaultBranch){
                    name = undefined;
                    label = undefined;
                    BS.RunBuildDialog.highlightChanges('#runBranchSelector_container');
                    $j('#runCustomBuildButton').prop('disabled', true);
                  }
                  var dropdown = document.createElement('branch-search');
                  dropdown.id = "runBranchSelector";
                  dropdown.special = true;
                  dropdown.includeBuildTypeDependency=true;
                  dropdown.selected = {name: label, webUrl: name};
                  dropdown.settings = {
                    "hideFirstServerHeader": true, "height" : "200px", "options" : options};
                  dropdown.server = base_uri;
                  dropdown.buildTypeId = options.buildTypeId;

                  $j('#runBranchSelector_container').append(dropdown);
                  $j('#runBranchSelector').on('branch-changed', function(e){
                    var branch = e.detail.branch.webUrl;
                    $j('#branchName_input').val(branch);
                    BS.RunBuildDialog.updateChangesContainer('branchChanged');
                    BS.RunBuildDialog.highlightChanges('#runBranchSelector_container');
                    if (branch != undefined){
                      $j('#runCustomBuildButton').prop('disabled', false);
                    }
                  });
                  });
                </script>
              </c:when>
              <c:otherwise>
                <forms:select name="branchName" enableFilter="true" style="padding-bottom: 0.5em; width: 20em;">
                  <c:if test="${not runBuildBean.buildType.defaultBranchExcluded}">
                    <forms:option value="${unspecifiedBranch}" selected="${runBuildBean.branchName == unspecifiedBranch}">&lt;Unspecified branch&gt;</forms:option>
                    <forms:option value="${defaultBranch}" selected="${empty runBuildBean.branchName or runBuildBean.branchName == defaultBranch}">&lt;Default branch&gt;</forms:option>
                  </c:if>
                  <c:forEach items="${branches}" var="branch">
                    <forms:option value="${branch}" selected="${branch == runBuildBean.branchName}"><c:out value="${branch}"/></forms:option>
                  </c:forEach>
                </forms:select>
              </c:otherwise>
            </c:choose>

            <forms:saving id="changesProgress" className="progressRingInline"/>
            <c:if test="${runBuildBean.showUnspecifiedBranchWarning}">
              <div class="icon_before icon16 attentionComment">TeamCity was not able to determine branch for the selected change. Please choose appropriate branch from the list.</div>
            </c:if>
            <c:if test="${runBuildBean.showIncorrectBranchWarning}">
              <div class="icon_before icon16 attentionComment">The selected branch name does not correspond to the specified change, please check the branch name or change are correct.</div>
            </c:if>
          </td>
        </tr>
        </c:if>
        <tr <c:if test='${!runBuildBean.defaultChangesSettings}'>class="modifiedParam"</c:if>>
          <td class="noBorder"><label for="modificationId" style="white-space: nowrap; width: 8em;">Include changes:</label></td>
          <td class="noBorder <c:if test="${runBuildBean.modificationIdSpecified}">modifiedParam</c:if>" style="padding-bottom: 0.5em;">
            <forms:select name="modificationId"
                          id="modificationId"
                          style="width: 32em;"
                          enableFilter="true" filterOptions="{monospace: true}">
              <forms:option value="">&lt;latest changes at the moment the build is started&gt;</forms:option>
              <c:forEach items="${changes}" var="vcsChange">
                <c:set var="date"><bs:date pattern="dd MMM HH:mm" value="${vcsChange.vcsDate}" no_span="true"/></c:set>
                <c:set var="htmlTitle"><c:out value="${vcsChange.description}"/></c:set>
                <forms:option value="${vcsChange.id}" selected="${runBuildBean.modificationId == vcsChange.id}" htmlTitle="${htmlTitle}">
                  [${date}] <c:if test="${not fn:contains(vcsChange.displayVersion, date)}">(<bs:trim maxlength="15">${vcsChange.displayVersion}</bs:trim>)</c:if>
                  <bs:changeCommitters modification="${vcsChange}" no_tooltip="${true}"/>: <bs:trim maxlength="50">${vcsChange.description}</bs:trim>
                </forms:option>
              </c:forEach>
            </forms:select> <forms:saving id="revisionsProgress" className="progressRingInline"/>

            <c:url var="changelog_url" value="/viewType.html?buildTypeId=${runBuildBean.buildType.externalId}&tab=buildTypeChangeLog"/>
          </td>
        </tr>
        <c:if test="${runBuildBean.freezeSettingsAllowed}">
          <tr>
            <td class="noBorder">
              <label for="buildSettingsMode">Use settings:<bs:help file="Triggering+a+Custom+Build" anchor="UsesettingsfromVCS"/></label>
            </td>
            <td class="noBorder">
              <forms:select name="buildSettingsMode" enableFilter="true" onchange="BS.RunBuildDialog.highlightSettingRevisions();">
                <forms:option value="default" selected="${runBuildBean.buildSettingsMode == 'default'}"><c:out value="${runBuildBean.defaultBuildSettingsModeDescription}"/></forms:option>
                <forms:option value="current" selected="${runBuildBean.buildSettingsMode == 'current'}">current on TeamCity server</forms:option>
                <forms:option value="vcs" selected="${runBuildBean.buildSettingsMode == 'vcs'}">from VCS</forms:option>
              </forms:select>
            </td>
          </tr>
        </c:if>
        <tr>
          <td style="padding-bottom: 0.5em; border: 0;" colspan="2">
            <c:if test="${runBuildBean.modificationIdSpecified}">${revisionsFragment}</c:if>
          </td>
        </tr>
        </c:if>
      <c:if test="${not hasBranches and runBuildBean.buildType.defaultBranchExcluded}">
        <tr>
          <td colspan="2">
            <div class="icon_before icon16 attentionComment">
              Builds in the default branch are disabled and build configuration doesn't have any other branches.
              If you run a build it if will fail.
            </div>
          </td>
        </tr>
      </c:if>
    </table>
    <script type="text/javascript">
      (function($) {

        var controlId = BS.jQueryDropdown.namePrefix + 'modificationId',
            dropdownClass = 'list-wrapper' + controlId,
            dropdownList = $('.' + dropdownClass).find('ul');

        <c:if test="${fn:length(changes) > 0}">
        dropdownList.append('<li class="unfilterable">See <a href="${changelog_url}">Change Log</a> for older changes</li>');
        </c:if>

        <c:if test="${fn:length(branches) > 0}">
         var restSelector = !BS.internalProperty('teamcity.ui.restSelectors.disabled', false);
         if (!restSelector) {
           $('#branchName').change(function () {
             BS.RunBuildDialog.updateChangesContainer('branchChanged');
             BS.RunBuildDialog.highlightChanges(this);
           });
         }
        </c:if>

        $('#modificationId').change(function() {
          BS.RunBuildDialog.updateChangesContainer();
        });

        BS.RunBuildDialog.highlightSettingRevisions();
      })(jQuery);
    </script>
    </bs:refreshable>
  </div>
</authz:authorize>
