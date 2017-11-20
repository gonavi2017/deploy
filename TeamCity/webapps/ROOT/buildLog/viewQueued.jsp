<%@ include file="../include-internal.jsp" %><%@
    taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags/tags" %><%@
    page import="jetbrains.buildServer.web.openapi.PlaceId" %>
<jsp:useBean id="queuedBuild" type="jetbrains.buildServer.serverSide.QueuedBuildEx" scope="request"
/><c:set var="no_refresh" scope="request" value="true"
/><c:set var="buildType" value="${queuedBuild.buildType}" scope="request"
/><jsp:useBean id="buildType" type="jetbrains.buildServer.serverSide.BuildTypeEx" scope="request"

/><ext:defineExtensionTab placeId="<%=PlaceId.BUILD_RESULTS_TAB%>"/>
<%--@elvariable id="extensionTab" type="jetbrains.buildServer.web.openapi.CustomTab"--%>
<c:set var="isBuildOverview" value="${extensionTab.tabId == 'buildResultsDiv'}"
/><c:set var="currentTabCaption" value=" > ${extensionTab.tabTitle}"
/><c:set var="whenQueuedStr"><bs:date value="${queuedBuild.whenQueued}" pattern="dd MMM yy HH:mm" no_span="true"/></c:set
 ><c:set var="pageTitle" scope="request">${buildType.fullName} > Queued ${whenQueuedStr}${currentTabCaption}</c:set>
<bs:page>
<jsp:attribute name="quickLinks_include">
  <authz:authorize projectId="${buildType.projectId}" allPermissions="RUN_BUILD">
    <div class="toolbarItem">
      <bs:runBuild buildType="${buildType}"
                   hideEnviroments="true"
                   redirectTo="viewType.html?buildTypeId=${buildType.externalId}"
                   userBranch="${queuedBuild.buildPromotion.branch.name}"/>
    </div>
  </authz:authorize>
  <authz:authorize projectId="${buildType.projectId}" anyPermission="CANCEL_BUILD, REORDER_BUILD_QUEUE">
    <div class="toolbarItem">
      <bs:actionsPopup controlId="bdActions"
                       popup_options="shift: {x: -100, y: 20}, width: '10em', className: 'quickLinksMenuPopup'">
        <jsp:attribute name="content">
          <div id="bdDetails">
            <ul class="menuList">
              <tags:favoriteBuildAuth buildPromotion="${queuedBuild.buildPromotion}">
                <l:li><tags:favoriteBuild removeCssClass="true" buildPromotion="${queuedBuild.buildPromotion}" showActionText="true"/></l:li>
              </tags:favoriteBuildAuth>
              <authz:authorize projectId="${buildType.projectId}" allPermissions="COMMENT_BUILD">
                <l:li><bs:buildCommentLink promotionId="${queuedBuild.buildPromotion.id}"
                                           oldComment="${queuedBuild.buildPromotion.buildComment.comment}">Comment...</bs:buildCommentLink></l:li>
              </authz:authorize>
              <c:if test="${afn:permissionGrantedForAnyProject('REORDER_BUILD_QUEUE')}">
                <l:li>
                  <a onclick="BS.ajaxRequest(window['base_uri'] + '/viewQueued.html', { parameters: { 'moveToTop' : '${queuedBuild.itemId}' }} )">Move to top</a>
                </l:li>
              </c:if>

              <c:if test="${afn:permissionGrantedForAnyProject('TAG_BUILD')}">
                <l:li>
                  <tags:editTagsLink buildPromotion="${queuedBuild.buildPromotion}">Tag...</tags:editTagsLink>
                </l:li>
              </c:if>

              <c:set var="personalBuild" value="${queuedBuild.personal}"/>
              <%--@elvariable id="currentUser" type="jetbrains.buildServer.users.SUser"--%>
              <c:set var="myBuild" value="${personalBuild && currentUser == buildType.user}"/>
              <authz:authorize projectId="${buildType.projectId}" allPermissions="CANCEL_BUILD">
                    <c:if test="${not personalBuild or myBuild or afn:permissionGrantedForBuildType(buildType, 'CANCEL_ANY_PERSONAL_BUILD')}">
                      <c:set var="itemId" value="remove_${queuedBuild.buildPromotion.id}"/>
                      <l:li><a id="${itemId}" class="actionLink" href="#"
                         onclick="BS.StopBuildDialog.showStopBuildDialog([${queuedBuild.buildPromotion.id}], '', 1); return false" title="Cancel queued build">Remove from queue...</a>
                      </l:li>
                    </c:if>
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
    /css/modificationListTable.css
    /css/statusTable.css
    /css/buildDataStatus.css

    /css/buildLog/runningLogStatus.css
    /css/buildLog/buildLog.css
    /css/buildLog/buildLogTree.css
    /css/buildLog/viewLog.css
    /css/agentsInfoPopup.css
    /css/filePopup.css
    /css/buildTypeSettings.css
    /css/labels.css
    /css/viewModification.css
    /css/pager.css
    /css/progress.css
  </bs:linkCSS>
  <bs:linkScript>
    /js/bs/buildResultsDiv.js
    /js/bs/blocks.js
    /js/bs/blocksWithHeader.js
    /js/bs/blockWithHandle.js
    /js/bs/changesBlock.js
    /js/bs/collapseExpand.js

    /js/bs/runningBuilds.js

    /js/bs/pin.js
    /js/bs/buildComment.js
    /js/bs/labels.js
    /js/bs/overflower.js
    /js/bs/testDetails.js
    /js/bs/testGroup.js

    /js/bs/locationHash.js
    /js/bs/buildLogTree.js
    /js/bs/queueLikeSorter.js
    /js/bs/buildQueue.js
  </bs:linkScript>

  <!-- ===== JS files, provided by plugins: ==== -->
  <c:set var="historyBuildText"><c:if test="${queuedBuild.buildPromotion.outOfChangesSequence}">History build&nbsp;</c:if></c:set>
  <c:set var="title" value="Queued ${whenQueuedStr}"/>
  <script type="text/javascript">
    <bs:trimWhitespace>
      BS.Pin.noHover = true;

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
              parentId: "${p.parentProjectExternalId}"
            }
          });
        </c:if>
      </c:forEach>

      BS.Navigation.items.push({
        title: "<bs:escapeForJs text="${buildType.name}" forHTMLAttribute="true"/>",
        url: "viewType.html?buildTypeId=${buildType.externalId}",
        selected: false,
        itemClass: "buildType ${buildType.status.failed ? 'failed' : ''}",
        buildTypeId: "${buildType.buildTypeId}",
        siblingsTree: {
          parentId: "${buildType.projectExternalId}"
        }
      });

      <c:set var="branchParam" value=""/>
      <c:if test="${not empty queuedBuild.buildPromotion.branch}"><c:set var="branchParam">&branch_${buildType.externalId}=<c:out value="${queuedBuild.buildPromotion.branch.name}"/></c:set></c:if>

      BS.Navigation.items.push({
        title: "${historyBuildText}<bs:escapeForJs text="${title}" forHTMLAttribute="true"/>",
        url: "viewQueued.html?itemId=${queuedBuild.itemId}${branchParam}",
        selected: true
       });

      var enablePeriodicalRefresh = _.once(function() {
          $j(function() {
            BS.PeriodicalRefresh.start(5, function() {
              return $('queuedBuildContainer').refresh();
            });
          });
      });
    </bs:trimWhitespace>
  </script>
</jsp:attribute>

<jsp:attribute name="body_include">
  <c:choose>
    <c:when test="${queuedBuild.started}">
      Build has just started, redirecting to running build page.
      <script type="text/javascript">
        BS.reload(true);
      </script>
    </c:when>
    <c:otherwise>
      <bs:valuePopup buildType="${buildType}"/>
      <div  id="container" class="clearfix">
        <bs:refreshable containerId="queuedBuildContainer" pageUrl="${pageUrl}">
          <ext:showTabs placeId="<%=PlaceId.BUILD_RESULTS_TAB%>"
                        urlPrefix="viewQueued.html?itemId=${queuedBuild.itemId}&buildTypeId=${buildType.externalId}"/>
        </bs:refreshable>
      </div>
    </c:otherwise>
  </c:choose>

</jsp:attribute>
</bs:page>
<et:subscribeOnBuildTypeEvents buildTypeId="${queuedBuild.buildTypeId}">
  <jsp:attribute name="eventNames">
    BUILD_STARTED
    BUILD_TYPE_REMOVED_FROM_QUEUE
  </jsp:attribute>
  <jsp:attribute name="eventHandler">
    BS.reload(true)
  </jsp:attribute>
</et:subscribeOnBuildTypeEvents>
