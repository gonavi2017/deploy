<%@ tag import="jetbrains.buildServer.controllers.BranchUtil" %>
<%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="util" uri="/WEB-INF/functions/util" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="l" tagdir="/WEB-INF/tags/layout" %><%@
    taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %><%@
    taglib prefix="resp" tagdir="/WEB-INF/tags/responsible" %><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %><%@
    taglib prefix="branchfn" uri="/WEB-INF/functions/branch" %><%@

    attribute name="currentUser" required="true" type="jetbrains.buildServer.users.SUser" %><%@
    attribute name="buildType" type="jetbrains.buildServer.serverSide.BuildTypeEx" required="true"%><%@
    attribute name="branch" type="jetbrains.buildServer.serverSide.BranchEx" required="false"%><%@
    attribute name="runningAndQueuedBuilds" required="true" type="jetbrains.buildServer.controllers.RunningAndQueuedBuildsBean" %><%@
    attribute name="problemsCounters" required="true" type="java.lang.Object" %><%@
    attribute name="shouldShowHideBuildTypeIcon" required="true" type="java.lang.Boolean"

%><%--@elvariable id="problemsCounters" type="jetbrains.buildServer.serverSide.ProblemsSummary.Counters"--%>
  <c:if test="${empty branch}">
    <c:set var="theRunningBuilds" value="${runningAndQueuedBuilds.runningBuildsMap[buildType.buildTypeId]}"/>
    <c:set var="limitedPendingChanges" value="<%=BranchUtil.getLimitedPendingChangesInAllBranches(buildType, true)%>"/>
    <c:set var="activeBuilds" value="<%=BranchUtil.getLastFinishedBuilds(buildType.getActiveBranches())%>"/>
    <c:set var="hasBuilds" value="${(not empty buildType.lastChangesFinished && not buildType.defaultBranchExcluded) or not empty theRunningBuilds or fn:length(activeBuilds) > 0}" scope="request"/>
    <c:set var="queuedBuilds" value="${runningAndQueuedBuilds.queuedBuildsMap[buildType.buildTypeId]}"/>
    <c:set var="status" value="${buildType.status}"/>
    <c:set var="showEmptyBranchAsDefault" value="${branchfn:hasNonDefaultBranchBuilds(theRunningBuilds) or branchfn:hasNonDefaultBranchBuilds(activeBuilds)}"/>
  </c:if>
  <c:if test="${not empty branch}">
    <c:set var="limitedPendingChanges" value="<%=BranchUtil.getLimitedPendingChangesInBranch(branch, true)%>"/>
    <c:set var="theRunningBuilds" value="<%=runningAndQueuedBuilds.getRunningBuildsMap(buildType, branch)%>"/>
    <c:set var="hasBuilds" value="${not empty branch.lastChangesFinished or not empty theRunningBuilds}" scope="request"/>
    <c:set var="queuedBuilds" value="<%=runningAndQueuedBuilds.getQueuedBuildsMap(buildType, branch)%>"/>
    <c:set var="status" value="${branch.status}"/>
    <c:set var="showEmptyBranchAsDefault" value="${branchfn:hasNonDefaultBranchBuilds(theRunningBuilds)}"/>
  </c:if>

  <div class="tableCaption" id="${buildType.buildTypeId}-div">
    <c:if test="${shouldShowHideBuildTypeIcon && !isSpecialUser}">
      <authz:authorize allPermissions="CHANGE_OWN_PROFILE">
        <div class="relative">
          <a href="#" onclick="return BS.hideBuildType('${buildType.projectId}', '${buildType.projectExternalId}', '${buildType.buildTypeId}');"
             class="close-bt" title="Hide this configuration">&#xd7;</a>
        </div>
      </authz:authorize>
    </c:if>
    <table class="runTable">
      <tr>
        <c:if test="${limitedPendingChanges.containsChanges}">
          <td class="pendingMessage"><bs:limitedPendingChangesLink buildType="${buildType}"
                                                                   pendingChanges="${limitedPendingChanges}"
                                                                   branch="${branch}"
                                                                   showForAllBranches="${empty branch}"/></td>
        </c:if>
        <td class="runningStatus">
            <span class="runningStatus">
              <c:choose
                ><c:when test="${empty theRunningBuilds}"><span class="build-status-icon build-status-icon_empty" title="${alt}"></span></c:when
                ><c:otherwise><bs:runningMultipleBuildIcon currentStatuses="${theRunningBuilds}"/></c:otherwise
              ></c:choose>
            </span>
          <bs:buildTypeStatusText theRunningBuilds="${theRunningBuilds}"
                                  queuedBuilds="${queuedBuilds}"
                                  branch="${branch}"
                                  buildType="${buildType}"/>
        </td>
        <td class="runButton">
          <authz:authorize projectId="${buildType.projectId}" anyPermission="RUN_BUILD">
            <bs:runBuild buildType="${buildType}"
                         hideEnviroments="true"
                         redirectTo=""
                         userBranch="${not empty branch ? branch.name : ''}"/>
          </authz:authorize>
        </td>
      </tr>
    </table>

    <c:set var="handle">
      <bs:handle handleId="${buildType.buildTypeId}"/>
    </c:set>
    <c:choose>
      <c:when test="${hasBuilds}">${handle}</c:when>
      <c:otherwise><span style="visibility:hidden;">${handle}</span></c:otherwise>
    </c:choose>

    <bs:projectOrBuildTypeIcon type="buildType" className="${status.failed ? 'buildType-icon_failing' :
                                    status.successful ? 'buildType-icon_successful' : ''}"/>

    <c:set var="title">Click to open &quot;<c:out value="${buildType.name}"/>&quot; home page</c:set>
    <c:if test="${buildType.paused}">
      <c:set var="title" value="Build configuration is paused. ${title}"/>
    </c:if>
    <c:if test="${not buildType.paused and status.failed}">
      <c:set var="title" value="Build configuration is failing. ${title}"/>
    </c:if>

    <bs:buildTypeLinkFull buildType="${buildType}" popupMode="true" popupNoProject="true">
      <bs:buildTypeLink buildType="${buildType}" style="padding-left:0px;" title="${title}"/>
    </bs:buildTypeLinkFull>

    <span class="addMessage lastBuilt"><c:if test="${not hasBuilds}">No builds to display</c:if></span>

    <bs:systemProblemMarker buildTypeId="${buildType.buildTypeId}" branch="${branch}"/>

    <c:if test="${buildType.paused}">
      <c:set var="pausedLink">
        <bs:togglePopup linkText="Paused">
          <jsp:attribute name="content">
            <c:set var="pauseComment" value="${buildType.pauseComment}"/>
            <c:if test="${not empty pauseComment}">
              <div class="name-value"><table>
                <c:if test="${not empty pauseComment.user}">
                  <tr>
                    <th><div>Paused by:</div></th>
                    <td><c:out value="${pauseComment.user.descriptiveName}"/></td>
                  </tr>
                </c:if>
                <tr>
                  <th>Time:</th>
                  <td><bs:date value="${pauseComment.timestamp}"/></td>
                </tr>
                <c:if test="${not empty pauseComment.comment}">
                  <tr>
                    <th>Comment:</th>
                    <td class="resp-comment"><bs:out value="${pauseComment.comment}"/></td>
                  </tr>
                </c:if>
              </table></div>
            </c:if>
            <authz:authorize projectId="${buildType.projectId}" allPermissions="PAUSE_ACTIVATE_BUILD_CONFIGURATION">
              <div class="actions">
                <a href="#" onclick="<bs:_pauseBuildTypeLinkOnClick buildType="${buildType}" pause="false"/>; return false;">Activate...</a>
              </div>
            </authz:authorize>
          </jsp:attribute>
        </bs:togglePopup>
      </c:set>
      <span class="addMessage paused"><span class="icon build-status-icon build-status-icon_paused"></span>${pausedLink}</span>
    </c:if>

    <c:if test="${empty branch or branch.defaultBranch}">
      <c:set var="resp" value="${buildType.responsibilityInfo}"/>
      <c:if test="${not empty resp and (resp.state.active or resp.state.fixed)}">
        <c:set var="responsibilityIcon" value="/img/investigate.png"/>
        <c:if test="${resp.state.active}">
          <c:set var="responsibleUser" value="${resp.responsibleUser}"/>
          <c:if test="${responsibleUser == currentUser}">
            <c:set var="responsibilityNote"><span class="${currentUser.highlightRelatedDataInUI ? 'highlightChanges' : ''}">You are assigned to investigate the build configuration</span></c:set>
          </c:if>
          <c:if test="${responsibleUser != currentUser}">
            <c:set var="responsibilityNote"><c:out value="${responsibleUser.descriptiveName}"/> is assigned to investigate the build configuration</c:set>
          </c:if>
        </c:if>
        <c:if test="${resp.state.fixed}">
          <c:set var="responsibilityNote">Fixed by <c:out value="${resp.responsibleUser == currentUser ? 'you' : resp.responsibleUser.descriptiveName}"/></c:set>
          <c:set var="responsibilityIcon" value="/img/buildStates/fixedTestResp.png"/>
        </c:if>
        <c:set var="responsibilityNote">
          <span class="icon icon16 bp taken"></span> <span class="text">${responsibilityNote}</span>
        </c:set>

          <span class="addMessage responsibility" title="Click to view details or update investigation">
            <bs:togglePopup linkText="${responsibilityNote}">
              <jsp:attribute name="content">
                <bs:responsibleTooltip responsibility="${resp}" buildTypeRef="${buildType}"/>
              </jsp:attribute>
            </bs:togglePopup>
          </span>
      </c:if>
    </c:if>

    <c:if test="${not empty problemsCounters and problemsCounters.hasData}">
      <c:set var="failedNum" value="${problemsCounters.failedTests}"/>
      <c:set var="investNum" value="${problemsCounters.investigatedTests}"/>
      <c:set var="fixedNum" value="${problemsCounters.markedAsFixedTests}"/>
      <c:set var="mutedNum" value="${problemsCounters.mutedTests}"/>
      <span class="problemsSummary" title="View problems summary for this build configuration">
        <a class="summaryLink" href="<c:url value="project.html?projectId=${buildType.projectExternalId}&tab=problems&buildTypeId=${buildType.buildTypeId}"/>">
          <span>Test<span class="problemDetails"> failure</span>s:</span>
          <c:if test="${failedNum > 0}">
            <span>
              <span class="icon icon16 bp"></span><span class="bp-number">${failedNum}</span>
              <span class="problemDetails">not investigated<c:if test="${investNum + fixedNum + mutedNum > 0}">,</c:if></span>
            </span>
          </c:if>
          <c:if test="${investNum > 0}">
            <span>
              <span class="icon icon16 bp taken"></span><span class="bp-number">${investNum}<span>
              <span class="problemDetails">under investigation<c:if test="${fixedNum + mutedNum > 0}">,</c:if></span>
            </span>
          </c:if>
          <c:if test="${fixedNum > 0}">
            <span>
              <span class="icon icon16 bp fixed"></span><span class="bp-number">${fixedNum}</span>
              <span class="problemDetails">marked as fixed<c:if test="${mutedNum > 0}">,</c:if></span>
            </span>
          </c:if>
          <c:if test="${mutedNum > 0}">
            <span>
              <span class="icon icon16 bp muted red"></span><span class="bp-number">${mutedNum}</span>
              <span class="problemDetails">muted</span>
            </span>
          </c:if>
        </a>
      </span>
    </c:if>
  </div>

  <c:set var="blockTypeId" value="bt${buildType.buildTypeId}"/>
  <div class="overviewTypeTableContainer" id="btb${buildType.buildTypeId}" style="${util:blockHiddenCss(pageContext.request, blockTypeId, false)}">
    <c:if test="${hasBuilds}">
      <div class="bt-separator"></div>

      <table class="overviewTypeTable">
        <c:forEach items="${theRunningBuilds}" var="buildData">
          <tr>
            <bs:buildRow build="${buildData}"
                         showBranchName="true"
                         showBuildNumber="true"
                         showStatus="true"
                         showArtifacts="true"
                         showCompactArtifacts="false"
                         showChanges="true"
                         showProgress="true"
                         showStop="true"
                         showEmptyBranchAsDefault="${showEmptyBranchAsDefault}"/>
          </tr>
        </c:forEach>
        <c:if test="${empty branch}">
          <c:forEach var="build" items="${activeBuilds}">
            <tr class="lastFinished">
              <bs:buildRow build="${build}"
                           showBranchName="true"
                           showBuildNumber="true"
                           showStatus="true"
                           showArtifacts="true"
                           showCompactArtifacts="false"
                           showChanges="true"
                           showProgress="true"
                           showStop="true"
                           showEmptyBranchAsDefault="${showEmptyBranchAsDefault}"/>
            </tr>
          </c:forEach>
        </c:if>
        <c:if test="${not empty branch}">
          <c:set var="build" value="${branch.lastChangesFinished}"/>
          <c:if test="${build != null}">
            <tr class="lastFinished"><bs:buildRow build="${build}"
                                                  showBranchName="true"
                                                  showBuildNumber="true"
                                                  showStatus="true"
                                                  showArtifacts="true"
                                                  showCompactArtifacts="false"
                                                  showChanges="true"
                                                  showProgress="true"
                                                  showStop="true"
                                                  showEmptyBranchAsDefault="${showEmptyBranchAsDefault}"/></tr>
          </c:if>
        </c:if>
      </table>

      <script type="text/javascript">
        <l:blockState blocksType="${blockTypeId}" />
        BS.CollapsableBlocks.registerBlock(new BS.BuildTypeBlock("bt", '${buildType.buildTypeId}'));
      </script>
    </c:if>
  </div>
