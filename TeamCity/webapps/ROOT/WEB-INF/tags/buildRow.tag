<%@ tag import="jetbrains.buildServer.serverSide.Branch" %><%@
    tag import="jetbrains.buildServer.serverSide.CompositeRunningBuild" %><%@
    tag import="jetbrains.buildServer.serverSide.SFinishedBuild" %><%@
    tag import="jetbrains.buildServer.serverSide.SRunningBuild" %><%@
    tag import="jetbrains.buildServer.serverSide.SBuildType" %><%@
    tag import="jetbrains.buildServer.serverSide.BuildTypeEx" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %><%@
    taglib prefix="t" tagdir="/WEB-INF/tags/tags" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    attribute name="build" required="true" rtexprvalue="true" type="jetbrains.buildServer.serverSide.SBuild" %><%@
    attribute name="rowClass" required="false" %><%@
    attribute name="showBranchName" type="java.lang.Boolean" required="false" %><%@
    attribute name="noLinkBranchForBranchName" type="java.lang.Boolean" required="false" %><%@
    attribute name="maxBranchNameLength" type="java.lang.Integer" required="false" %><%@
    attribute name="showBuildNumber" type="java.lang.Boolean" required="false" %><%@
    attribute name="addLinkToBuildNumber" type="java.lang.Boolean" required="false" %><%@
    attribute name="addLinkToBuildTypeName" type="java.lang.Boolean" required="false" %><%@
    attribute name="showBuildTypeName" type="java.lang.Boolean" required="false" %><%@
    attribute name="showStatus" type="java.lang.Boolean" required="false" %><%@
    attribute name="showArtifacts" type="java.lang.Boolean" required="false" %><%@
    attribute name="showCompactArtifacts" type="java.lang.Boolean" required="false" %><%@
    attribute name="showChanges" type="java.lang.Boolean" required="false" %><%@
    attribute name="showQueuedDate" type="java.lang.Boolean" required="false" %><%@
    attribute name="showStartDate" type="java.lang.Boolean" required="false" %><%@
    attribute name="showProgress" type="java.lang.Boolean" required="false" %><%@
    attribute name="showDuration" type="java.lang.Boolean" required="false" %><%@
    attribute name="showStop" type="java.lang.Boolean" required="false" %><%@
    attribute name="showAgent" type="java.lang.Boolean" required="false" %><%@
    attribute name="showTags" type="java.lang.Boolean" required="false" %><%@
    attribute name="showCompactTags" type="java.lang.Boolean" required="false" %><%@
    attribute name="showUsedByOtherBuildsIcon" type="java.lang.Boolean" required="false" %><%@
    attribute name="showPin" type="java.lang.Boolean" required="false" %><%@
    attribute name="contextProject" type="jetbrains.buildServer.serverSide.SProject" required="false" %><%@
    attribute name="outOfChangesSequence" type="java.lang.Boolean" required="false" %><%@
    attribute name="showEmptyBranchAsDefault" type="java.lang.Boolean" required="false"
              description="Whether the default branch label should be shown when build has no branch, works only when showBranchName is set to true"
%><%
  SFinishedBuild recentlyFinished = build instanceof SRunningBuild ? ((SRunningBuild)build).getRecentlyFinishedBuild() : null;
  if (recentlyFinished != null) {
    request.setAttribute("recentlyFinished", recentlyFinished);
  }
  request.setAttribute("outdated", recentlyFinished != null);
  boolean finishedBuild = build instanceof SFinishedBuild;
  request.setAttribute("finishedBuild", finishedBuild);
  request.setAttribute("compositeBuild", build instanceof CompositeRunningBuild);

  if (showBranchName != null && showBranchName) {
    Branch branch = build.getBranch();
    if (branch == null && showEmptyBranchAsDefault != null && showEmptyBranchAsDefault) {
      SBuildType buildType = build.getBuildType();
      if (buildType instanceof BuildTypeEx) {
        branch = ((BuildTypeEx)buildType).getBranch(Branch.DEFAULT_BRANCH_NAME);
      }
    }
    request.setAttribute("buildBranch", branch);
  }
%>

<c:choose>
  <c:when test="${not build.finished}">
    <script type="text/javascript">
      BS.RunningBuilds.subscribeOnBuild("${build.buildId}")
    </script>
  </c:when>
  <c:otherwise>
    <script type="text/javascript"> //TODO implement unsubscribe method better
      BS.RunningBuilds.unsubscribeFromBuild("${build.buildId}")
    </script>
  </c:otherwise>
</c:choose>
<c:set var="buildId" value="${build.buildId}"
  /><c:set var="promo" value="${build.buildPromotion}"
  /><c:set var="stopMessage" value=""
  /><c:set var="tooltipMessage" value=""
  /><c:set var="buildHangs" value=""
  /><c:set var="tooltipBuild" value="${build}"


  /><c:if test="${not build.finished and buildId > 0}">
  <c:set var="running" value="${build}"/><%--@elvariable id="running" type="jetbrains.buildServer.serverSide.SRunningBuild"--%>
    <c:choose
      ><c:when test="${not empty build.agent and not build.agent.registered}"
        ><c:set var="tooltipMessage">Build agent ${build.agentName} was disconnected while running a build.<br/>
          Please check the agent and network connectivity. Either ensure the agent is connected or stop the build.<br/>
          Last message was received on:
          <bs:date value="${running.lastBuildActivityTimestamp}"/> (<bs:printTime time="${running.timeSpentSinceLastBuildActivity}"/> ago)
        </c:set
        ><c:set var="stopMessage" value="Agent does not respond."
      /></c:when
      ><c:when test="${running.probablyHanging}"
        ><c:set var="buildHangs" value="true"
       /><c:set var="tooltipMessage">This build is probably hanging. <br/>
          Last message was received on: <bs:date value="${running.lastBuildActivityTimestamp}"/>
          (<bs:printTime time="${running.timeSpentSinceLastBuildActivity}"/> ago)
        </c:set
        ><c:set var="stopMessage" value="This build hung."
      /></c:when><c:when test="${outdated}"
        ><c:set var="tooltipBuild" value="${recentlyFinished}"
       /><c:set var="tooltipMessage">This build is outdated (more recent build is already finished).
          Click the icon to check the newer results.<c:if test="${recentlyFinished != null}"> (<c:out value="${tooltipBuild.buildNumber}"/>)</c:if>
        </c:set
        ><c:set var="stopMessage" value="This build is outdated."
      /></c:when
    ></c:choose
  ></c:if

  ><c:if test="${not empty tooltipMessage}"
      ><c:set var="rowClass" value="${rowClass} obsoleteRunningBuild"
  /></c:if
  ><c:if test="${build.outOfChangesSequence or promo.changesDetached}"
      ><c:set var="rowClass" value="${rowClass} detachedChanges"
  /></c:if
  ><c:if test="${compositeBuild}"
      ><c:set var="rowClass" value="${rowClass} compositeBuild"
  /></c:if

  ><c:if test="${showBuildTypeName}">
  <td class="${rowClass} buildTypeName">
    <bs:buildTypeLinkFull buildType="${build.buildType}" contextProject="${contextProject}" popupMode="${addLinkToBuildTypeName}"/>
  </td>
  </c:if

  ><c:if test="${showBranchName}"
    ><c:set var="branch" value="${buildBranch}"
    /><c:set var="doShowBranch" value="${not empty branch}"
    /><c:set var="clazz" value="${branch.defaultBranch ? 'default' : ''}${doShowBranch ? ' hasBranch' : ''}"/>
    <td class="${rowClass} ${clazz} branch">
      <c:if test="${doShowBranch}"
        ><c:set var="trimmedBranch"><bs:trimBranch branch="${branch}" defaultMaxLength="${maxBranchNameLength}"/></c:set
        ><bs:branchLink branch="${branch}" build="${build}" noLink="${noLinkBranchForBranchName}">${trimmedBranch}</bs:branchLink
      ></c:if>
    </td>
  </c:if

  ><c:if test="${showBuildNumber}">
    <td class="${rowClass} buildNumber">
      <span class="buildNumberInner" style="white-space: nowrap;">
        <c:choose><c:when test="${compositeBuild}"><span class="icon icon16 tc-icon_composite-build"></span></c:when><c:otherwise><bs:buildNumber buildData="${build}" withLink="${addLinkToBuildNumber}"/></c:otherwise></c:choose>
        <t:favoriteBuildAuth buildPromotion="${build.buildPromotion}">
          <span><t:favoriteBuild buildPromotion="${build.buildPromotion}" showOnlyIfFavorite="true"/></span>
        </t:favoriteBuildAuth>
        <bs:buildCommentIcon build="${build}"/>
        <c:if test="${not empty tooltipMessage}"
          ><bs:resultsLink build="${tooltipBuild}" noPopup="true" noTitle="true"
          ><span class="icon icon16 yellowTriangle" <bs:tooltipAttrs text="${tooltipMessage}"/>></span></bs:resultsLink
        ></c:if>
      </span>
    </td>
  </c:if



  ><c:if test="${showStatus}">
    <c:set var="resultText"><bs:trim maxlength="100">${build.statusDescriptor.text}</bs:trim></c:set>
    <td class="${rowClass} status">
      <bs:buildDataIcon buildData="${build}"
                        imgId="build:${buildId}:img"/>
      <bs:resultsLink build="${build}"
                      skipChangesArtifacts="true"
          ><span id="build:${buildId}:text"><bs:makeBreakable text="${resultText}" regex="[\.,\\/:;@%^]" escape="${false}"/></span
          ></bs:resultsLink>
      <c:if test="${outOfChangesSequence}">
        <span class="outofseq">(History build)</span>
      </c:if>
    </td>
  </c:if

  ><c:if test="${showArtifacts}"
    ><td class="${rowClass} link artifactsLink">
      <c:if test="${not compositeBuild}"><bs:buildRowArtifactsLink build="${build}" showCompactArtifacts="${showCompactArtifacts}"
    /></c:if></td>
  </c:if

  ><c:if test="${showChanges}">
    <td class="${rowClass} link changesLink"><bs:changesLinkFull build="${build}" noUsername="false"/></td>
  </c:if

  ><c:if test="${showQueuedDate}">
  <td class="${rowClass} addedToQueueDate"><bs:date value="${build.buildPromotion.queuedDate}"/></td>
  </c:if

  ><c:if test="${showStartDate}">
    <td class="${rowClass} startDate"><bs:date value="${build.startDate}" title_prefix="Start date:"/></td>
  </c:if

  ><c:if test="${showDuration}">
    <td class="${rowClass} duration"><span class="buildDuration"><bs:printTime time="${build.duration}" showIfNotPositiveTime="&lt; 1s" alwaysIncludeSeconds="true"/></span></td>
  </c:if

  ><c:if test="${showProgress}">
    <td class="${rowClass} duration"><bs:buildProgress buildData="${build}"/></td>
  </c:if

  ><c:if test="${showAgent}">
    <td class="${rowClass} nowrap agentDetails"><c:choose><c:when test="${not empty build.agent}"><bs:agentDetailsLink agent="${build.agent}"/></c:when><c:otherwise>&nbsp;</c:otherwise></c:choose></td>
  </c:if

  ><c:if test="${showStop}">
  <td class="${rowClass} stopBuild">
    <c:if test="${not build.finished}"><bs:stopBuild build="${build}" message="${stopMessage}"/></c:if>
  </td>
  </c:if

  ><c:if test="${showTags}">
    <td class="${rowClass} tags">
      <t:tagsInfo buildPromotion="${build.buildPromotion}" compactView="${showCompactTags}"/>
    </td>
  </c:if

  ><c:if test="${showUsedByOtherBuildsIcon}">
    <td class="${rowClass}">
      <c:if test="${build.usedByOtherBuilds}"
        ><bs:_viewLog build="${build}"
                      tab="dependencies"
                      title="This build is used by other builds"
            ><span class="icon icon16 icon16_link" title="This build is used by other builds"></span></bs:_viewLog>
      </c:if>&nbsp;
    </td>
  </c:if

  ><c:if test="${showPin && finishedBuild}">
    <td class="${rowClass} pin nowrap" id="pinTd${buildId}">
      <div class="wrapper">
      <authz:authorize projectId="${build.projectId}" allPermissions="PIN_UNPIN_BUILD">
        <jsp:attribute name="ifAccessGranted">
          <forms:saving id="progressIcon${buildId}"/>
          <c:if test="${build.pinned}">
            <bs:pinImg build="${build}"/><bs:pinLink build="${build}" pin="false" onBuildPage="false" className="unpinLink" doNotAddAvailableTags="${true}">Unpin</bs:pinLink>
          </c:if>
          <c:if test="${not build.pinned}">
            <bs:pinLink build="${build}" pin="true" onBuildPage="false" doNotAddAvailableTags="${true}"><span class="pinLinkImage icon icon16 icon16_pinned_no"></span></bs:pinLink>
          </c:if>
        </jsp:attribute>
        <jsp:attribute name="ifAccessDenied">
          <%-- The fix for incorrect rendering in IE: if "td" is empty, no border is displayed. --%>
          <span class="hidden">.</span>
          <c:if test="${build.pinned}">
            <bs:pinImg build="${build}"/>
          </c:if>
        </jsp:attribute>
      </authz:authorize>
      </div>
    </td>
  </c:if
>

