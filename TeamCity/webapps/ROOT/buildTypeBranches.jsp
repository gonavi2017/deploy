<%@ include file="include-internal.jsp" %><%@
    taglib prefix="resp" tagdir="/WEB-INF/tags/responsible"%><%@
    taglib prefix="admin" tagdir="/WEB-INF/tags/admin"%><%@
    taglib prefix="user" tagdir="/WEB-INF/tags/userProfile"%><%@
    taglib prefix="t" tagdir="/WEB-INF/tags/tags"
%><jsp:useBean id="buildType" type="jetbrains.buildServer.serverSide.SBuildType" scope="request"
/><jsp:useBean id="currentUser" type="jetbrains.buildServer.users.SUser" scope="request"
/><jsp:useBean id="buildTypeBranches" type="java.util.List" scope="request"
/><jsp:useBean id="runningAndQueuedBuilds" type="jetbrains.buildServer.controllers.RunningAndQueuedBuildsBean" scope="request"
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
</et:subscribeOnBuildTypeEvents>
<div class="buildTypeBranchesHeader">
  <c:set var="activeNum" value="${fn:length(buildTypeBranches)}"/>
  <c:set var="otherNum" value="${fn:length(branchBean.otherBranches)}"/>
  There ${activeNum > 1 ? 'are' : 'is'} <b>${activeNum}</b> active branch${activeNum > 1 ? 'es' : ''} in this configuration.
  <c:if test="${otherNum > 0}"><b>${otherNum}</b> inactive branch${otherNum > 1 ? 'es' : ''} ${otherNum > 1 ? 'are' : 'is'} not displayed.</c:if>
</div>
<bs:messages key="buildNotFound"/>
<div class="clearfix buildTypeBranches">
  <bs:_branchesTable currentUser="${currentUser}"
                     buildType="${buildType}"
                     buildTypeBranches="${buildTypeBranches}"
                     runningAndQueuedBuilds="${runningAndQueuedBuilds}"/>
</div>
