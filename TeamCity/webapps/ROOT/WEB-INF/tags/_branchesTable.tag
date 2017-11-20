<%@ tag import="jetbrains.buildServer.controllers.BranchUtil" %>
<%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="util" uri="/WEB-INF/functions/util" %><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz"%><%@
    attribute name="currentUser" required="true" type="jetbrains.buildServer.users.SUser" %><%@
    attribute name="buildType" type="jetbrains.buildServer.serverSide.SBuildType" required="true"%><%@
    attribute name="runningAndQueuedBuilds" type="jetbrains.buildServer.controllers.RunningAndQueuedBuildsBean" required="true"%><%@
    attribute name="buildTypeBranches" type="java.util.List" required="true"
%><c:forEach var="branch" items="${buildTypeBranches}">
  <jsp:useBean id="branch" type="jetbrains.buildServer.serverSide.BranchEx"/>
  <c:set var="runningBuilds" value="<%=runningAndQueuedBuilds.getRunningBuildsMap(buildType, branch)%>"/>
  <c:set var="queuedBuilds" value="<%=runningAndQueuedBuilds.getQueuedBuildsMap(buildType, branch)%>"/>
  <c:set var="id">branch_<%=branch.getName().hashCode()%></c:set>
  <div data-blockId="${id}" class="tableCaption branch-header">
    <i class="tc-icon icon16 tc-icon_branch"></i>
    <c:set var="isDefault" value="${branch.defaultBranch}"/>
    <span class="branch hasBranch ${isDefault ? 'default' : ''}">
      <bs:branchLink branch="${branch}" buildType="${buildType}"/>
    </span>

    <bs:systemProblemMarker buildTypeId="${buildType.buildTypeId}"
                            branch="${branch}"/>

    <table class="runTable">
      <tr>
        <c:set var="limitedPendingChanges" value="<%=BranchUtil.getLimitedPendingChangesInBranch(branch, true)%>"/>
        <c:if test="${limitedPendingChanges.containsChanges}">
          <td class="pendingMessage"><bs:limitedPendingChangesLink buildType="${buildType}"
                                                                   pendingChanges="${limitedPendingChanges}"
                                                                   branch="${branch}"/></td>
        </c:if>
        <td class="runningStatus">
          <span class="runningStatus">
            <c:choose
              ><c:when test="${empty runningBuilds}"><span class="build-status-icon build-status-icon_empty"></span></c:when
              ><c:otherwise><bs:runningMultipleBuildIcon currentStatuses="${runningBuilds}"/></c:otherwise
            ></c:choose>
          </span>
          <bs:buildTypeStatusText theRunningBuilds="${runningBuilds}"
                                  queuedBuilds="${queuedBuilds}"
                                  branch="${branch}"
                                  buildType="${buildType}"
                                  noPopupForRunning="true"/>
        </td>
        <td class="runButton">
          <authz:authorize projectId="${buildType.projectId}" anyPermission="RUN_BUILD">
            <bs:runBuild buildType="${buildType}" redirectTo="" userBranch="${branch.name}"/>
          </authz:authorize>
        </td>
      </tr>
    </table>
  </div>

  <div class="overviewTypeTableContainer" style="${util:blockHiddenCss(pageContext.request, id, false)}">
    <c:set var="lastChangesFinished" value="${branch.lastChangesFinished}"/>
    <c:if test="${not empty runningBuilds or not empty lastChangesFinished}">
      <div class="bt-separator"></div>
      <table class="overviewTypeTable">
        <c:forEach var="runningBuild" items="${runningBuilds}">
          <tr>
            <td class="branch"></td>
            <bs:buildRow build="${runningBuild}"
                         showBuildNumber="true"
                         showStatus="true"
                         showArtifacts="true"
                         showCompactArtifacts="false"
                         showChanges="true"
                         showProgress="true"
                         showStop="true"/>
          </tr>
        </c:forEach>
        <c:if test="${not empty lastChangesFinished}">
          <tr>
            <td class="branch"></td>
            <bs:buildRow build="${lastChangesFinished}"
                         showBuildNumber="true"
                         showStatus="true"
                         showArtifacts="true"
                         showCompactArtifacts="false"
                         showChanges="true"
                         showProgress="true"
                         showStop="true"/>
          </tr>
        </c:if>
      </table>
    </c:if>
  </div>
  <script type="text/javascript">${util:blockHiddenJs(pageContext.request, id, false)}</script>
</c:forEach>
<script type="text/javascript">
  $j(document).ready(function() {
    BS.SystemProblems.setOptions({
      perBranch: true,
      btId: '${buildType.buildTypeId}'
    });
    BS.SystemProblems.startUpdates();
  });
</script>