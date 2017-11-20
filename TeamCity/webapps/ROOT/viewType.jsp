<%@ page import="jetbrains.buildServer.controllers.BranchUtil" %><%@
    page import="jetbrains.buildServer.serverSide.healthStatus.SuggestionCategory" %>
<%@ page import="jetbrains.buildServer.web.openapi.PlaceId" %>
<%@
    include file="include-internal.jsp" %><%@
    taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %><%@
    taglib prefix="resp" tagdir="/WEB-INF/tags/responsible" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags/tags"

%><jsp:useBean id="buildType" type="jetbrains.buildServer.serverSide.BuildTypeEx" scope="request"
/><jsp:useBean id="pinnedBuild" type="jetbrains.buildServer.controllers.buildType.BuildTypeController.PinnedBuildBean" scope="request"
/><jsp:useBean id="currentUser" type="jetbrains.buildServer.users.User" scope="request"
/><jsp:useBean id="branchBean" type="jetbrains.buildServer.controllers.BranchBean" scope="request"

/><c:set var="fullname" value="${buildType.fullName}"
/><ext:defineExtensionTab placeId="<%=PlaceId.BUILD_CONF_TAB%>"/><bs:webComponentsSettings/>
<%--@elvariable id="extensionTab" type="jetbrains.buildServer.web.openapi.CustomTab"--%>
<c:set var='currentTabTitle' value=" > ${extensionTab.tabTitle}"
/><c:set var="pageTitle" value="${fullname}${currentTabTitle}" scope="request"
/><c:set var="pendingChanges" value="<%=BranchUtil.getPendingChangesInBranch(buildType, branchBean.getUserBranch())%>" scope="request"
/><c:set var="projectId" value="${buildType.projectId}"
/><bs:page disableScrollingRestore="${extensionTab.tabId eq 'buildTypeChains'}">
  <jsp:attribute name="quickLinks_include">
    <authz:authorize projectId="${projectId}" allPermissions="RUN_BUILD">
      <div class="toolbarItem">
        <bs:runBuild buildType="${buildType}" redirectTo="" hideEnviroments="true"/>
      </div>
    </authz:authorize>
    <authz:authorize projectId="${projectId}"
                     anyPermission="PAUSE_ACTIVATE_BUILD_CONFIGURATION, CLEAN_BUILD_CONFIGURATION_SOURCES, RUN_BUILD, ASSIGN_INVESTIGATION">
      <div class="toolbarItem">
        <bs:actionsPopup controlId="bcActions"
                         popup_options="shift: {x: -150, y: 20}, className: 'quickLinksMenuPopup'">
          <jsp:attribute name="content">
            <div id="btDetails">
              <ul class="menuList">
                <authz:authorize projectId="${projectId}" allPermissions="PAUSE_ACTIVATE_BUILD_CONFIGURATION">
                  <c:if test="${buildType.paused and not buildType.project.archived}">
                    <l:li>
                      <a href="#" onclick="<bs:_pauseBuildTypeLinkOnClick buildType="${buildType}" pause="false"/>; return false">
                        Activate triggers...
                      </a>
                    </l:li>
                  </c:if>
                  <c:if test="${not buildType.paused and not buildType.readOnly}">
                    <l:li>
                      <a href="#" onclick="<bs:_pauseBuildTypeLinkOnClick buildType="${buildType}" pause="true"/>; return false">
                        Pause triggers...
                      </a>
                    </l:li>
                  </c:if>
                </authz:authorize>
                <authz:authorize projectId="${projectId}" allPermissions="RUN_BUILD">
                  <l:li>
                    <form class="pauseResume" action="<c:url value='/action.html'/>" method="post" id="checkForChangesBuildTypeForm">
                      <input type="hidden" name="checkForChangesBuildType" value="${buildType.buildTypeId}"/>
                      <input type="hidden" name="tc-csrf-token" value="${sessionScope['tc-csrf-token']}"/>
                    </form>
                    <a href="#" onclick="$('checkForChangesBuildTypeForm').submit(); return false;">Check for pending changes</a>
                  </l:li>
                </authz:authorize>
                <c:if test="${afn:permissionGrantedForBuildType(buildType, 'CLEAN_BUILD_CONFIGURATION_SOURCES') or
                              afn:permissionGrantedGlobally('CLEAN_AGENT_SOURCES')}">
                  <l:li>
                    <a href="#" onclick="BS.BuildTypeResetSources.showResetSourcesDialog(); return false">Enforce clean checkout...</a>
                  </l:li>
                </c:if>
                <authz:authorize projectId="${projectId}" allPermissions="ASSIGN_INVESTIGATION">
                  <l:li>
                    <c:set var="name"><bs:escapeForJs text="${buildType.name}" forHTMLAttribute="true"/></c:set>
                    <a href="#" onclick="return BS.ResponsibilityDialog.showDialog('${buildType.externalId}', '${name}')">Investigate...</a>
                  </l:li>
                </authz:authorize>
              </ul>
            </div>
          </jsp:attribute>
          <jsp:body>Actions</jsp:body>
        </bs:actionsPopup>
      </div>
    </authz:authorize>
    <authz:editBuildTypeGranted buildType="${buildType}">
      <admin:editBuildTypeMenu buildType="${buildType}">Edit Configuration Settings</admin:editBuildTypeMenu>
    </authz:editBuildTypeGranted>
  </jsp:attribute>
  <jsp:attribute name="head_include">
    <bs:linkCSS>
      /css/pager.css
      /css/progress.css
      /css/modificationListTable.css
      /css/compatibilityList.css
      /css/buildTypeSettings.css
      /css/filePopup.css
      /css/viewType.css
      /css/overviewTable.css
      /css/buildQueue.css
      /css/historyTable.css
      /css/agentsInfoPopup.css
      /css/buildChains.css
      /healthStatus/css/healthStatus.css
    </bs:linkCSS>
    <bs:linkScript>
      /js/bs/blocks.js
      /js/bs/blocksWithHeader.js
      /js/bs/blockWithHandle.js
      /js/bs/changesBlock.js
      /js/bs/collapseExpand.js
      /js/bs/pin.js
      /js/bs/buildComment.js

      /js/bs/runningBuilds.js

      /js/bs/systemProblemsMonitor.js
      /js/bs/overflower.js
      /js/bs/queueLikeSorter.js
      /js/bs/buildQueue.js
      /js/bs/historyTable.js
      /js/bs/buildType.js
      /js/bs/testGroup.js
    </bs:linkScript>
    <c:if test="${not empty buildType.description}">
      <c:set var="buildTypeDescription"><bs:out value="${buildType.description}" resolverContext="${buildType}" /></c:set>
      <c:set var="buildTypeDescription">(<bs:escapeForJs text="${buildTypeDescription}" forHTMLAttribute="false"/>)</c:set>
    </c:if>

    <script type="text/javascript">
      <bs:trimWhitespace>
        BS.Navigation.items = [];

        <c:forEach var="p" items="${buildType.project.projectPath}" varStatus="status">
          <c:if test="${not status.first}">
            BS.Navigation.items.push({
              title: "<bs:escapeForJs text="${p.name}" forHTMLAttribute="true"/>",
              url: "project.html?projectId=${p.externalId}",
              selected: false,
              itemClass: "project",
              projectId: "${p.externalId}",
              siblingsTree: {
                parentId: "${p.parentProjectExternalId}",
                buildTypeUrlFormat: BS.Navigation.fromUrl("${buildType.externalId}", "{id}")
              }
            });
          </c:if>
        </c:forEach>

        BS.Navigation.items.push({
          title: "<bs:escapeForJs text="${buildType.name}" forHTMLAttribute="true"/><c:if test="${not empty buildTypeDescription}"> <small>${buildTypeDescription}</small></c:if>",
          url: BS.Navigation.fromUrl("${buildType.externalId}", "${buildType.externalId}", null, true),
          selected: true,
          itemClass: "buildType ${buildType.status.failed ? 'failed' : buildType.status.successful ? 'successful' : ''}",
          buildTypeId: "${buildType.externalId}",
          siblingsTree: {
            parentId: "${buildType.projectExternalId}",
            buildTypeUrlFormat: BS.Navigation.fromUrl("${buildType.externalId}", "{id}")
          }
        });
      </bs:trimWhitespace>
    </script>
  </jsp:attribute>
  <jsp:attribute name="toolbar_include">
    <div class="healthItemIndicatorContainer" style="display: none;">
      <c:set var="buildTypeId" scope="request" value="${buildType.buildTypeId}"/>
      <c:set var="excludeCategoryId" scope="request" value="<%=SuggestionCategory.CATEGORY_ID%>"/>
      <jsp:include page="/buildTypeHealthStatusItems.html">
        <jsp:param name="originUrl" value="${pageUrl}"/>
      </jsp:include>
    </div>
  </jsp:attribute>
  <jsp:attribute name="body_include">
    <bs:refreshable containerId="buildConfigurationContainer" pageUrl="${pageUrl}">
      <script type="text/javascript">
        BS.BuildType.updateStatus(${buildType.status.failed});

        <c:if test="${branchBean.hasBranches}"><%--@elvariable id="includeSnapshots" type="java.lang.Boolean"--%>
          <c:set var="restBranchSelectorEnabled" value="${!restSelectorsDisabled}"/>
          var options = {buildTypeId:"${buildType.externalId}",
                        projectId: "${projectId}",
                        projectExternalId: "${buildType.projectExternalId}",
                        tab: "${extensionTab.tabId}", wildcardDisplayName: "${wildcardBranchDisplayName}",
                        excludeDefaultBranch: ${buildType.defaultBranchExcluded},
                        includeSnapshots: ${includeSnapshots}};

        // This could be an AJAX refresh - remove stale handlers
        $j(document).off("bs.breadcrumbRendered");

        <c:choose>
          <c:when test="${restBranchSelectorEnabled}">
            $j(document).on("bs.breadcrumbRendered", function() {
              BS.Branch.installRestDropdownToBreadcrumb("<bs:escapeForJs text="${branchBean.userBranch}"/>", options);
              BS.Branch.injectBranchParamToLinks($j("#restNavigation"), "${buildType.projectExternalId}");
            });
          </c:when>
          <c:otherwise>
            $j(document).on("bs.breadcrumbRendered", function() {
              BS.Branch.installDropdownToBreadcrumb("<bs:escapeForJs text="${branchBean.userBranch}"/>", ${branchSelectorEnabled ? 1 : 0},
                                                    <bs:_branchesListJs branches="${branchBean.activeBranches}"/>,
                                                    <bs:_branchesListJs branches="${branchBean.otherBranches}"/>,
                                                    options);
              BS.Branch.injectBranchParamToLinks($j("#mainNavigation"), "${buildType.projectExternalId}");
            });
          </c:otherwise>
        </c:choose>
        </c:if>

      </script>

      <ext:showTabs placeId="<%=PlaceId.BUILD_CONF_TAB%>"
                    urlPrefix="viewType.html?buildTypeId=${buildType.externalId}">
        <div style="padding-top: 3px" id="messagesDiv">
           <bs:messages key="sourcesCleanedMessage"/>
           <bs:messages key="buildHasBeenRemoved"/>
        </div>
        <bs:buildTypePaused buildType="${buildType}" style="margin-top: 6px;"/>
      </ext:showTabs>
    </bs:refreshable>

    <bs:valuePopup buildType="${buildType}"/>

    <c:url value='/ajax.html' var="actionUrl"/>
    <bs:modalDialog formId="resetSources"
                    title="Enforce clean checkout on agents"
                    action="${actionUrl}"
                    closeCommand="BS.BuildTypeResetSources.close()"
                    saveCommand="BS.BuildTypeResetSources.submitResetSources()">

      <forms:saving id="cleanSourcesProgress" className="progressRingInline"/>

      <bs:refreshable containerId="cleanSourcesDialogContent" pageUrl="${pageUrl}">
        <c:if test="${param['showCleanSourcesDialog'] != null}">
        <div>Choose agents to enforce clean checkout<bs:help file="Clean+Checkout"/> for:</div>
        <bs:inplaceFilter containerId="resetSourcesAgentId" activate="true" filterText="&lt;filter agents>" afterApplyFunc="function(){BS.expandMultiSelect($j('#resetSourcesAgentId'))}"/>
        <forms:selectMultipleHScroll name="agentId" id="resetSourcesAgentId">
          <option value="">&lt;All agents&gt;</option>
        <c:forEach items="${buildType.agentsWhereBuildConfigurationBuilt}" var="agent">
          <option class="inplaceFiltered" value="${agent.id}"><c:out value="${agent.name}"/></option>
        </c:forEach>
        </forms:selectMultipleHScroll>

        <input type="hidden" name="resetBuildConfigurationSources" value="${buildType.buildTypeId}"/>
        </c:if>
      </bs:refreshable>

      <div class="popupSaveButtonsBlock">
        <forms:submit label="Clean sources" id="resetSourcesSubmitButton"/>
        <forms:cancel onclick="BS.BuildTypeResetSources.close()"/>
        <forms:saving id="resetSourcesProgress"/>
      </div>
    </bs:modalDialog>

    <authz:authorize projectId="${projectId}" allPermissions="PAUSE_ACTIVATE_BUILD_CONFIGURATION">
      <jsp:attribute name="ifAccessGranted">
        <bs:pauseBuildTypeDialog/>
      </jsp:attribute>
    </authz:authorize>
  </jsp:attribute>
</bs:page>
