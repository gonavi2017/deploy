<%--@elvariable id="node" type="jetbrains.buildServer.controllers.graph.GraphNode"--%>
<%--@elvariable id="currentUser" type="SUser"--%>
<%@ tag import="jetbrains.buildServer.serverSide.Branch" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="afn" uri="/WEB-INF/functions/authz" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/functions/user"%>
<%@ taglib prefix="utilfn" uri="/WEB-INF/functions/util"%>
<%@ taglib prefix="up" tagdir="/WEB-INF/tags/userProfile" %>
<%@ taglib prefix="queue" tagdir="/WEB-INF/tags/queue"%>
<%@ taglib prefix="et" tagdir="/WEB-INF/tags/eventTracker"%>
<%@ taglib prefix="changefn" uri="/WEB-INF/functions/change"%>
<%@attribute name="buildChainGraph" type="jetbrains.buildServer.controllers.graph.BuildChainGraph" required="true" %>
<%@attribute name="wrapInRefreshable" type="java.lang.Boolean" required="false" %>
<%@attribute name="autoRefresh" type="java.lang.Boolean" required="false" %>
<%@attribute name="selectedBuildType" type="jetbrains.buildServer.serverSide.SBuildType" required="false" %>
<%@attribute name="ungroupedProjects" type="java.util.List" required="false" %>
<c:set var="graphId" value="graph_${buildChainGraph.buildChain.id}"/>
<c:set var="canStartMap" value="${buildChainGraph.buildChain.canStart}"/>
<c:set var="modificationIdOpt" value="modificationId: ''"/>
<c:set var="chainModId" value="${buildChainGraph.buildChain.chainModificationId}"/>
<c:set var="defaultBranchName" value="<%=Branch.DEFAULT_BRANCH_NAME%>"/>
<c:set var="chainId" value="${buildChainGraph.buildChain.id}"/>
<c:if test="${not empty chainModId and chainModId > 0}">
  <c:set var="modificationIdOpt" value="modificationId: ${chainModId}"/>
</c:if>
<c:set var="detailLevel" value="${ufn:booleanPropertyValue(currentUser, 'buildChainDetailedView') ? 2 : 1}"/>
<c:set var="origContextProject" value="${contextProject}"/>
<c:set var="settingsPreviewMode" value="${fn:length(buildChainGraph.buildChain.allPromotions) eq 0}"/>
<c:set var="ungroupedProjectIds" value="${ufn:getPropertyValue(currentUser, 'buildChains.ungroupedProjectIds')}"/>
<c:set var="graphContent">
<c:if test="${not settingsPreviewMode}"><div id="chainTabs_${chainId}" class="chainTabs simpleTabs simpleTabsWithSelector"></div></c:if>
<div class="chainBuilds">
<div class="chainOptions">
<c:if test="${not settingsPreviewMode}">
  <span class="chainOptions__option"><up:booleanPropertyCheckbox propertyKey="buildChainDetailedView" controlId="buildChainDetailedView_${buildChainGraph.buildChain.id}" labelText="Show details" afterComplete="BS.BuildChains.refreshChain('${chainId}');"/></span>
</c:if>
<span class="chainOptions__option">
  <c:set var="labelText">Group by projects<c:if test="${not empty ungroupedProjects}">, excluding:</c:if></c:set>
  <up:booleanPropertyCheckbox propertyKey="groupBuildChainsByProjects" controlId="groupBuildChainsByProjects_${chainId}" labelText="${labelText}" afterComplete="BS.BuildChains.refreshChain('${chainId}');"/>
  <c:if test="${not empty ungroupedProjects}">
  <c:forEach items="${ungroupedProjects}" var="p" varStatus="pos">
    <span class="excludedProject"><c:out value="${p.fullName}"/> <a class="groupLink" onclick="Event.stop(event); BS.BuildChains.groupProject('${chainId}', '${p.externalId}', '${ungroupedProjectIds}')">&#xd7;</a></span>
  </c:forEach>
  </c:if>
</span>
</div>
<c:set var="reusedBuilds" value="${buildChainGraph.buildChain.reusedBuildPromotions}"/>
<c:if test="${not empty reusedBuilds}">
  <div class="smallNote">
    This build chain reused <a title="Click to highlight reused builds" onclick="$j('div.nodeInfo.reused').toggleClass('highlight')" style="cursor: pointer">${fn:length(reusedBuilds)} build<bs:s val="${fn:length(reusedBuilds)}"/></a> from previous build chains
  </div>
</c:if>
<bs:layeredGraph layers="${buildChainGraph.layers}" id="${graphId}">
  <jsp:attribute name="nodeContent">
    <c:set var="promoMap" value="${node.userData.buildPromotionsMap}"/>
    <c:set var="commonProject" value="${node.userData.commonProject}"/>
    <c:set var="contextProject" value="${origContextProject}"/>
    <c:forEach items="${promoMap}" var="entry" varStatus="pos">
    <c:if test="${pos.first and not empty commonProject and fn:length(promoMap) gt 1}">
      <c:set var="contextProject" value="${commonProject}"/>
      <div class="groupTitle">
        <a class="ungroupLink" onclick="Event.stop(event); BS.BuildChains.ungroupProject('${chainId}', '${commonProject.externalId}', '${ungroupedProjectIds}')" title="Un-group builds"><i class="icon icon-unlink"></i></a>
        <bs:projectLinkFull project="${commonProject}" contextProject="${origContextProject}" skipContextProject="${commonProject.projectId == origContextProject.projectId}" tab="projectBuildChains"/>
      </div>
    </c:if>
    <c:set var="buildType" value="${entry.key}"/>
    <c:set var="buildPromotion" value="${entry.value}"/>
    <c:set var="reused" value="${not empty buildPromotion and utilfn:contains(reusedBuilds, buildPromotion)}"/>
    <div class="nodeInfo ${pos.last ? 'last' : ''} ${pos.first ? 'first' : ''} bt_id_${entry.key.externalId} ${reused ? 'reused' : ''}">
      <c:set var="reified" value="${not empty buildPromotion}"/>
      <c:set var="startedBuild" value="${reified ? buildPromotion.associatedBuild : null}"/>
      <c:set var="queuedBuild" value="${startedBuild == null and reified ? buildPromotion.queuedBuild : null}"/>
      <c:set var="branch" value="${reified ? buildPromotion.branch : null}"/>
      <%--@elvariable id="buildPromotion" type="jetbrains.buildServer.serverSide.BuildPromotion"--%>
      <%--@elvariable id="startedBuild" type="jetbrains.buildServer.serverSide.SBuild"--%>
      <%--@elvariable id="queuedBuild" type="jetbrains.buildServer.serverSide.SQueuedBuild"--%>
      <%--@elvariable id="buildType" type="jetbrains.buildServer.serverSide.SBuildType"--%>
      <%--@elvariable id="branch" type="jetbrains.buildServer.serverSide.Branch"--%>
      <c:if test="${not settingsPreviewMode and canStartMap[buildType.buildTypeId] != null}">
        <c:set var="depOnBranchName" value=""/>
        <c:set var="dependOn" value=""/>
        <c:forEach items="${canStartMap[buildType.buildTypeId]}" var="p">
          <%--@elvariable id="p" type="jetbrains.buildServer.serverSide.BuildPromotion"--%>
          <c:set var="dependOn" value="${dependOn},${p.id}"/>
          <c:if test="${fn:length(depOnBranchName) == 0 and not empty p.branch}"><c:set var="depOnBranchName" value="${p.branch.name}"/></c:if>
        </c:forEach>
        <c:set var="startOpt" value="${modificationIdOpt}, dependOnPromotionIds: '${dependOn}', redirectToQueuedBuild: false, init: true, stateKey: 'promote' "/>
        <authz:authorize projectId="${buildType.projectId}" anyPermission="RUN_BUILD">
        <span class="promoteOrRerun" ${not reified ? 'title="Click to continue build chain"' : ''} >
          <c:choose>
            <c:when test="${reified}">
              <c:choose>
                <c:when test="${not empty startedBuild and startedBuild.finished}">
                  <c:choose>
                    <c:when test="${not empty branch}"><c:set var="startOpt">${startOpt}, branchName: '<bs:escapeForJs text="${branch.name}"/>'</c:set></c:when>
                    <c:otherwise><c:set var="startOpt">${startOpt}, branchName: '<bs:escapeForJs text="${defaultBranchName}"/>'</c:set></c:otherwise>
                  </c:choose>
                  <a class="noUnderline" href="#" onclick="Event.stop(event); BS.RunBuild.runCustomBuild('${buildType.externalId}', { ${startOpt} }); return false" title="Run build with the same revisions...">
                    <i class="tc-icon icon16 tc-icon_run-build-changes"></i>
                  </a>
                </c:when>
                <c:when test="${not empty startedBuild and not startedBuild.finished}">
                  <a class="stopBuild" onclick="Event.stop(event); BS.StopBuildDialog.showStopBuildDialog([${buildPromotion.id}], '', 2, null);">&#xd7;</a>
                </c:when>
                <c:when test="${not empty queuedBuild}">
                  <a class="stopBuild" onclick="Event.stop(event); BS.StopBuildDialog.showStopBuildDialog([${buildPromotion.id}], '', 1, null);">&#xd7;</a>
                </c:when>
              </c:choose>
            </c:when>
            <c:otherwise>
              <c:choose>
                <c:when test="${not empty depOnBranchName}"><c:set var="startOpt">${startOpt}, branchName: '<bs:escapeForJs text="${depOnBranchName}"/>'</c:set></c:when>
                <c:otherwise><c:set var="startOpt">${startOpt}, branchName: '<bs:escapeForJs text="${defaultBranchName}"/>'</c:set></c:otherwise>
              </c:choose>
              <bs:runBuild buildType="${buildType}" options="${startOpt}"/>
            </c:otherwise>
          </c:choose>
        </span>
        </authz:authorize>
      </c:if>

      <c:choose>
        <c:when test="${reified}">
          <c:set var="branchContent">
            <c:if test="${not empty branch}">
              <span class="branch hasBranch ${branch.defaultBranch ? 'default' : ''}"><span class="branchName"><bs:trimBranch branch="${branch}"/></span></span>
            </c:if>
          </c:set>
          <c:if test="${detailLevel eq '1'}">
          <div class="buildConf compact">
            <div class="buildChainBuild">
              <c:choose>
                <c:when test="${not empty startedBuild}">
                <div class="status">
                  <bs:buildDataIcon buildData="${startedBuild}" imgId="build:${startedBuild}:img"/>
                  <bs:resultsLink build="${startedBuild}" skipChangesArtifacts="true"><bs:buildTypeFullName buildType="${buildType}" contextProject="${contextProject}"/></bs:resultsLink>
                </div>
                <div class="branch">${branchContent}</div>
                <c:if test="${not startedBuild.finished}">
                  <bs:buildProgress buildData="${startedBuild}" showOvertimeIcon="false"/>
                </c:if>
                </c:when>
                <c:when test="${not empty queuedBuild}">
                  <div class="status">
                    <bs:queuedBuildIcon queuedBuild="${queuedBuild}"/>
                    <queue:queueLink queuedBuild="${queuedBuild}"><bs:buildTypeFullName buildType="${buildType}" contextProject="${contextProject}"/></queue:queueLink>
                  </div>
                  <div class="branch">${branchContent}</div>
                </c:when>
              </c:choose>
            </div>
          </div>
          </c:if>
          <c:if test="${detailLevel ne '1'}">
          <div class="buildConf">
            <bs:buildTypeLinkFull buildType="${buildType}" popupMode="true" contextProject="${contextProject}" additionalUrlParams="&tab=buildTypeChains" projectTab="projectBuildChains"/>
            <c:choose>
              <c:when test="${not empty startedBuild}">
                <div class="buildChainBuild">
                  <div class="branch">${branchContent}</div>
                  <div class="buildNumber"><bs:buildNumber buildData="${startedBuild}"/></div>
                  <div class="status"><bs:buildRow build="${startedBuild}" showStatus="true"/></div>
                  <div class="changes"><bs:changesLinkFull build="${startedBuild}" noUsername="true" className="changesLink icon_before icon16 tc-icon_params"/></div>
                  <c:if test="${not startedBuild.finished}"><bs:buildProgress buildData="${startedBuild}" showOvertimeIcon="false"/></c:if>
                  <c:if test="${startedBuild.artifactsExists}">
                    <div class="artifactsLink"><bs:_artifactsLink build="${startedBuild}"><i class="tc-icon icon16 tc-icon_download"></i> Artifacts</bs:_artifactsLink></div>
                  </c:if>
                </div>
              </c:when>
              <c:when test="${not empty queuedBuild}">
                <div class="buildChainBuild">
                  <div class="branch">${branchContent}</div>
                  <div class="status">
                    <bs:queuedBuildIcon queuedBuild="${queuedBuild}"/>
                    <queue:queueLink queuedBuild="${queuedBuild}">in queue</queue:queueLink>
                  </div>
                  <div class="changes"><bs:changesLinkFull queuedBuild="${queuedBuild}" noUsername="true" className="changesLink icon_before icon16 tc-icon_params"/></div>
                </div>
              </c:when>
              <c:otherwise>
                <div>
                  <i>Deleted build</i><!--build id: ${buildPromotion.id}-->
                </div>
              </c:otherwise>
            </c:choose>
          </div>
          </c:if>
          <c:if test="${not empty startedBuild}">
            <script type="text/javascript">
              <c:if test="${not startedBuild.finished}">BS.RunningBuilds.subscribeOnBuild("${startedBuild.buildId}");</c:if>
              <c:if test="${startedBuild.finished}">BS.RunningBuilds.unsubscribeFromBuild("${startedBuild.buildId}");</c:if>
            </script>
          </c:if>
        </c:when>
        <c:otherwise>
          <c:choose>
            <c:when test="${settingsPreviewMode}">
              <div class="buildConfSettings bt_id_${buildType.externalId}">
                <c:set var="triggers" value="${buildType.resolvedSettings.buildTriggersCollection}"/>
                <c:if test="${not empty triggers}">
                  <i class="tc-icon icon-refresh" style="color: black; padding-right: 2px;" title="Triggered automatically"></i>
                </c:if>
                <admin:editBuildTypeLinkFull buildType="${buildType}" step="dependencies" contextProject="${contextProject}"/>
              </div>
            </c:when>
            <c:otherwise>
              <div class="buildConfRun bt_id_${buildType.externalId}">
                <bs:buildTypeLinkFull buildType="${buildType}" popupMode="true" additionalUrlParams="&tab=buildTypeChains" contextProject="${contextProject}" projectTab="projectBuildChains"/>
              </div>
            </c:otherwise>
          </c:choose>
        </c:otherwise>
      </c:choose>
    </div>
    </c:forEach>

  </jsp:attribute>
</bs:layeredGraph>
<script type="text/javascript">
if ($j('#${graphId}')[0]) {

  $j('#${graphId}')[0].graphObject.drawGraph();

  var fixedWidth = $j('.fixedWidth').width();
  if (fixedWidth) {
    // we have fixed width layout, but graphs can be much wider, here we're trying to use as much horizontal space as possible
    var windowWidth = BS.Util.windowSize(window)[0];
    var canvasWidth = $j('#${graphId}').find('svg').width();
    if (canvasWidth > fixedWidth) {
      var leftPaddingSize = (windowWidth - fixedWidth) / 2;
      var leftPos = 0;
      if (canvasWidth < windowWidth) {
        // fits window, try to center it
        leftPos = (windowWidth - canvasWidth) / 2 - leftPaddingSize;
      } else {
        leftPos = 10 - leftPaddingSize;
      }

      $j('#${graphId}').find('svg').css({left: leftPos});
      $j('#${graphId}').find('.layeredGraph').css({left: leftPos});
    }
  }

// restore horizontal scroll position
  var hpos = BS.LocationHash.getHashParameter('hpos');
  var vpos = BS.LocationHash.getHashParameter('vpos');

  <c:if test="${not empty selectedBuildType}">
  var selectedNode = $j('.bt_id_${selectedBuildType.externalId}');
  selectedNode.addClass('selectedNode');
  if (!hpos) {
    // scroll horizontally and vertically so that selected node was near the middle of window
    var pos = selectedNode.parent().position();
    var rightSidePos = pos.left + selectedNode.parent().width();
    var winSize = BS.Util.windowSize();
    if (rightSidePos > winSize[0]) {
      hpos = rightSidePos - winSize[0] / 2;
      BS.LocationHash.setHashParameter('hpos', hpos);
    }
  }
  </c:if>

  if (hpos) {
    $j(window).scrollLeft(hpos);
    BS.BuildChains.shiftChainHorizontally('${chainId}', 0, hpos);
  }

  if (vpos) {
    $j(window).scrollTop(vpos);
  }

  BS.enableDisabled('#${graphId}');

  $j(window).on("scroll", BS.BuildChains._scrollHandler);
  $j(window).on("resize", function() {
    $j(window).scrollLeft(0);
  });
}
</script>
</div>
</c:set>

<c:choose>
  <c:when test="${wrapInRefreshable}">
    <bs:refreshable containerId="chainRefresh_${buildChainGraph.buildChain.id}" pageUrl="${pageUrl}">${graphContent}</bs:refreshable>
  </c:when>
  <c:otherwise>${graphContent}</c:otherwise>
</c:choose>
<c:if test="${not settingsPreviewMode and autoRefresh}">
<c:forEach items="${buildChainGraph.buildChain.notFinishedChainBuildTypes}" var="buildType">
  <et:subscribeOnBuildTypeEvents buildTypeId="${buildType.buildTypeId}">
    <jsp:attribute name="eventNames">
      BUILD_STARTED
      BUILD_FINISHED
      BUILD_INTERRUPTED
      BUILD_TYPE_REMOVED_FROM_QUEUE
    </jsp:attribute>
    <jsp:attribute name="eventHandler">
      BS.BuildChains.scheduleChainRefresh('${buildChainGraph.buildChain.id}');
    </jsp:attribute>
  </et:subscribeOnBuildTypeEvents>
</c:forEach>
</c:if>
