<%@
    include file="include-internal.jsp" %><%@
    taglib prefix="resp" tagdir="/WEB-INF/tags/responsible"%><%@
    taglib prefix="responsible" uri="/WEB-INF/functions/resp" %><%@
    taglib prefix="admin" tagdir="/WEB-INF/tags/admin"%><%@
    taglib prefix="user" tagdir="/WEB-INF/tags/userProfile"%><%@
    taglib prefix="t" tagdir="/WEB-INF/tags/tags"

%><jsp:useBean id="buildType" type="jetbrains.buildServer.serverSide.SBuildType" scope="request"
/><jsp:useBean id="currentUser" type="jetbrains.buildServer.users.SUser" scope="request"
/><jsp:useBean id="pinnedBuild" type="jetbrains.buildServer.controllers.buildType.BuildTypeController.PinnedBuildBean" scope="request"
/><jsp:useBean id="shortHistory" type="java.util.List" scope="request"
/><jsp:useBean id="hasCompatibleAgentsOrTypesToRun" type="java.lang.Boolean" scope="request"
/><jsp:useBean id="historyForm" type="jetbrains.buildServer.controllers.buildType.tabs.HistorySearchBean" scope="request"
/><jsp:useBean id="showHistoryLink" type="java.lang.Boolean" scope="request"
/><jsp:useBean id="runningAndQueuedBuilds" type="jetbrains.buildServer.controllers.RunningAndQueuedBuildsBean" scope="request"
/><c:set var="buildTypeId" value="${buildType.buildTypeId}"
/><c:set var="externalId" value="${buildType.externalId}"
/><%@ include file="_subscribeToCommonBuildTypeEvents.jspf"
%><et:subscribeOnBuildTypeEvents buildTypeId="${buildType.buildTypeId}">
    <jsp:attribute name="eventNames">
      BUILD_STARTED
      BUILD_CHANGES_LOADED
      BUILD_FINISHED
      BUILD_INTERRUPTED
      BUILD_DEPENDENCY_STARTED
      BUILD_DEPENDENCY_FINISHED
      BUILD_DEPENDENCY_INTERRUPTED
      BUILD_TYPE_ACTIVE_STATUS_CHANGED
      BUILD_TYPE_ADDED_TO_QUEUE
      BUILD_TYPE_REMOVED_FROM_QUEUE
      CHANGE_ADDED
    </jsp:attribute>
    <jsp:attribute name="eventHandler">
      BS.BuildType.updateView();
    </jsp:attribute>
</et:subscribeOnBuildTypeEvents><div id="buildTypeStatusDiv">
  <%--@elvariable id="serverTC" type="jetbrains.buildServer.serverSide.BuildServerEx"--%>
  <%--@elvariable id="pendingChanges" type="java.util.Collection"--%>
  <%--@elvariable id="buildTypeBranch" type="jetbrains.buildServer.serverSide.BranchEx"--%>
  <c:choose>
    <c:when test="${not empty buildTypeBranch}">
      <jsp:useBean id="buildTypeBranch" type="jetbrains.buildServer.serverSide.BranchEx" scope="request"/>
      <c:set var="runningBuilds" value="<%=runningAndQueuedBuilds.getRunningBuildsMap(buildType, buildTypeBranch)%>"/>
      <c:set var="queuedBuilds" value="<%=runningAndQueuedBuilds.getQueuedBuildsMap(buildType, buildTypeBranch)%>"/>
      <c:set var="buildBranchName" value="${buildTypeBranch.name}"/>
    </c:when>
    <c:otherwise>
      <c:set var="runningBuilds" value="${runningAndQueuedBuilds.runningBuildsMap[buildType.buildTypeId]}"/>
      <c:set var="queuedBuilds" value="${runningAndQueuedBuilds.queuedBuildsMap[buildType.buildTypeId]}"/>
    </c:otherwise>
  </c:choose>

  <div class="divsWithHeaders">
    <div class="first clearfix" id="pendingChangesDiv">
      <h2>Pending changes</h2>
      <c:if test="${not empty pendingChanges}">
        <bs:pendingChangesLink buildType="${buildType}"
                               pendingChanges="${pendingChanges}"
                               showForAllBranches="${branchBean.wildcardBranch}"
                               branch="${buildTypeBranch}">
          ${fn:length(pendingChanges)} change<bs:s val="${fn:length(pendingChanges)}"/>
        </bs:pendingChangesLink>
      </c:if>
      <c:if test="${empty pendingChanges}">No pending changes</c:if>
    </div>

    <div>
      <h2>Current status</h2>
      <bs:messages key="buildNotFound"/>

      <bs:buildTypeStatusText theRunningBuilds="${runningBuilds}"
                              queuedBuilds="${queuedBuilds}"
                              buildType="${buildType}"
                              branch="${buildTypeBranch}"
                              noPopupForRunning="true"/>
      <c:if test="${not hasCompatibleAgentsOrTypesToRun}">
        &nbsp;
        <a class="noCompatibleAgentsLink" href="viewType.html?tab=compatibilityList&buildTypeId=${externalId}">No suitable agents</a>
      </c:if>
      <bs:systemProblemMarker buildTypeId="${buildTypeId}" branch="${buildTypeBranch}" maxWidth="100"/>
      <c:if test="${not empty runningBuilds}">
        <div class="runningTableContainer">
          <table class="overviewTypeTable running">
            <c:forEach items="${runningBuilds}" var="buildData">
              <tr>
                <bs:buildRow build="${buildData}"
                             showBranchName="true"
                             showBuildNumber="true"
                             showStatus="true"
                             showArtifacts="true"
                             showCompactArtifacts="false"
                             showChanges="true"
                             showProgress="true"
                             showAgent="true"
                             showStop="true"/>
              </tr>
            </c:forEach>
          </table>
        </div>
      </c:if>
    </div>

    <c:if test="${(not buildType.status.successful && buildType.lastChangesFinished != null) or
                   responsible:isActive(buildType.responsibilityInfo) or responsible:isFixed(buildType.responsibilityInfo)}">
      <div>
        <h2>Investigation</h2>
        <resp:responsible buildData="${buildType.lastChangesFinished}" server="${serverTC}" currentUser="${currentUser}"/>
      </div>
    </c:if>

    <div>
      <bs:refreshable containerId="historyTable" pageUrl="${pageUrl}">
        <div>
          <c:set var="tagsFilterBlock">
            <div id="filterByTags">
              <t:showBuildTypeTags buildType="${buildType}" historyForm="${historyForm}" label="Filter by tag:"/>
            </div>
          </c:set>

          <h2 class="recentTitle">Recent history</h2>

            <div id="filterAboveTable">
              <form id="historyFilter" action="<c:url value='/viewType.html'/>" method="post" style="float: right;">
                <input type="hidden" name="buildTypeId" value="${externalId}"/>
                <input type="hidden" name="tab" value="buildTypeStatusDiv"/>
                <input type="hidden" name="tag" value="${historyForm.tag}"/>
                <input type="hidden" name="privateTag" value="${historyForm.privateTag}"/>
                <forms:checkbox name="showAllBuilds" checked="${historyForm.showAllBuilds}" onclick="BS.HistoryTable.doSearch()"/>
                <label for="showAllBuilds">Show canceled and failed to start builds</label>
              </form>

              <div id="savingFilter">
                <forms:progressRing className="progressRingInline"/>
                Updating results...
              </div>
            </div>

            ${tagsFilterBlock}

          <c:if test="${empty shortHistory}"><em>No builds available</em></c:if>
        </div>

        <c:if test="${not empty shortHistory}">
          <bs:historyTable historyRecords="${shortHistory}" buildType="${buildType}"/>
        </c:if>

        <c:if test="${showHistoryLink}">
          <c:url var="history_url" value="/viewType.html?buildTypeId=${externalId}&tab=buildTypeHistoryList"/>
          <div id="showHistory">
            Showing ${fn:length(shortHistory)} build<bs:s val="${fn:length(shortHistory)}"/>, see <a href="${history_url}">entire history</a>
          </div>
        </c:if>
        <c:if test="${pinnedBuild.active}">
          <script type="text/javascript">
            BS.Pin.showSuccessMessage(${pinnedBuild.buildId}, ${pinnedBuild.pinned});
          </script>
        </c:if>
      </bs:refreshable>
    </div>

    <c:if test="${not empty shortHistory}">
      <div>
        <h2>Permalinks</h2>

        <span class="permalinks">
          <span class="icon icon16 build-status-icon build-status-icon_successful"></span>
          <bs:buildLink buildId="lastSuccessful" buildTypeId="${externalId}" buildBranch="${buildBranchName}">Latest successful build</bs:buildLink>
          <span class="icon icon16 build-status-icon icon16_pinned_yes"></span>
          <bs:buildLink buildId="lastPinned" buildTypeId="${externalId}" buildBranch="${buildBranchName}">Latest pinned build</bs:buildLink>
          <span class="icon icon16 build-status-icon icon16_asterisk"></span>
          <bs:buildLink buildId="lastFinished" buildTypeId="${externalId}" buildBranch="${buildBranchName}">Latest finished build</bs:buildLink>
        </span>
      </div>
    </c:if>
  </div>
</div>

<script type="text/javascript">
  $j('.fading').each(function() {
    BS.Highlight(this);
  });
  BS.Branch.injectBranchParamToLinks($j("#pendingChangesDiv, #showHistory"), "${buildType.projectExternalId}");
  $j(document).ready(function() {
    BS.SystemProblems.setOptions({btId:'${buildType.buildTypeId}'});
    BS.SystemProblems.startUpdates();
  });
</script>
