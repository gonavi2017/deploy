<%@ include file="../include-internal.jsp" %><%@
    taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags/tags" %><%@
    page import="jetbrains.buildServer.serverSide.Branch" %>
<%@ page import="jetbrains.buildServer.web.openapi.PlaceId" %>
<%@ taglib prefix="labels" tagdir="/WEB-INF/tags/labels" %>
<%@ taglib prefix="merge" tagdir="/WEB-INF/tags/merge" %>

<jsp:useBean id="buildData" type="jetbrains.buildServer.serverSide.SBuild" scope="request"
/><c:set var="no_refresh" scope="request" value="true"
/><c:set var="buildType" value="${buildData.buildType}" scope="request"
/><c:set var="defaultBranch" value="<%=Branch.DEFAULT_BRANCH_NAME%>"
/><jsp:useBean id="buildType" type="jetbrains.buildServer.serverSide.SBuildType" scope="request"
/><jsp:useBean id="revisionsBean" type="jetbrains.buildServer.controllers.RevisionsBean" scope="request"
/><ext:defineExtensionTab placeId="<%=PlaceId.BUILD_RESULTS_TAB%>"/>
<%--@elvariable id="extensionTab" type="jetbrains.buildServer.web.openapi.CustomTab"--%>
<c:set var="isBuildOverview" value="${extensionTab.tabId == 'buildResultsDiv'}"
/><c:set var="currentTabCaption" value=" > ${extensionTab.tabTitle}"
/><c:set var="startDate"><bs:date value="${buildData.startDate}" pattern="dd MMM yy HH:mm" no_span="true"/></c:set
 ><c:set var="pageTitle" scope="request">${buildType.fullName} > #${buildData.buildNumber} (${startDate})${currentTabCaption}</c:set>
<bs:page>
<jsp:attribute name="quickLinks_include">
  <authz:authorize projectId="${buildType.projectId}" allPermissions="RUN_BUILD">
    <div class="toolbarItem">
      <bs:runBuild buildType="${buildType}"
                   redirectTo="viewType.html?buildTypeId=${buildType.externalId}"
                   redirectToQueuedBuild="true"
                   hideEnviroments="true"
                   userBranch="${buildData.branch.name}"/>
    </div>
  </authz:authorize>
  <authz:authorize projectId="${buildType.projectId}" anyPermission="COMMENT_BUILD,PIN_UNPIN_BUILD,TAG_BUILD">
    <div class="toolbarItem">
      <bs:actionsPopup controlId="bdActions"
                       popup_options="shift: {x: -100, y: 20}, width: '10em', className: 'quickLinksMenuPopup'">
        <jsp:attribute name="content">
          <div id="bdDetails">
            <ul class="menuList">
              <tags:favoriteBuildAuth buildPromotion="${buildData.buildPromotion}">
                  <l:li><tags:favoriteBuild removeCssClass="true" buildPromotion="${buildData.buildPromotion}"  showActionText="true"/></l:li>
              </tags:favoriteBuildAuth>
              <authz:authorize projectId="${buildType.projectId}" allPermissions="COMMENT_BUILD">
                <l:li><bs:buildCommentLink promotionId="${buildData.buildPromotion.id}"
                                           oldComment="${buildData.buildComment.comment}">Comment...</bs:buildCommentLink></l:li>
              </authz:authorize>
              <c:if test="${buildData.finished}">
              <authz:authorize projectId="${buildType.projectId}" allPermissions="PIN_UNPIN_BUILD">
                  <c:set var="pinLinkText">Pin...</c:set>
                  <c:if test="${buildData.pinned}">
                    <c:set var="pinLinkText">Unpin...</c:set>
                  </c:if>
                  <l:li><bs:pinLink build="${buildData}" pin="${not buildData.pinned}" onBuildPage="true">${pinLinkText}</bs:pinLink></l:li>
              </authz:authorize>
              </c:if>
              <authz:authorize projectId="${buildType.projectId}" allPermissions="TAG_BUILD">
                <l:li><tags:editTagsLink buildPromotion="${buildData.buildPromotion}">Tag...</tags:editTagsLink></l:li>
              </authz:authorize>
              <c:if test="${not buildData.personal &&
                            (buildData.buildType.numberOfArtifactReferences > 0 || buildData.buildType.numberOfDependencyReferences > 0)}">
                <l:li>
                  <a onclick="BS.PromoteBuildDialog.showDialog(${buildData.buildId}); return false" href="#">Promote...</a>
                </l:li>
              </c:if>

              <c:if test="${not buildData.internalError}">
                <c:if test="${empty buildData.canceledInfo}"> <%-- Do not allow to change status of canceled builds: --%>
                  <authz:authorize projectId="${buildData.projectId}" allPermissions="MANAGE_BUILD_PROBLEM_INSTANCES">
                    <l:li>
                      <bs:changeBuildStatusLink build="${buildData}"/>
                    </l:li>
                  </authz:authorize>
                </c:if>
              </c:if>

              <c:if test="${not buildData.finished}">
                <bs:canStopBuild build="${buildData}">
                  <jsp:attribute name="ifAccessGranted">
                    <l:li>
                      <a onclick="BS.StopBuildDialog.showStopBuildDialog([${buildData.buildPromotion.id}], '', 2, null)">Stop...</a>
                    </l:li>
                  </jsp:attribute>
                </bs:canStopBuild>
              </c:if>

              <authz:authorize projectId="${buildType.projectId}" allPermissions="LABEL_BUILD">
              <c:if test="${revisionsBean.buildFinished and not empty revisionsBean.availableRootsToLabel}">
                <l:li>
                  <a class="setLabelLink" href="#" onclick="BS.Label.showEditDialog(${buildData.buildId}); return false">Label this build sources...</a>
                </l:li>
              </c:if>

              <%--TODO: add separate permissions for merge or rename LABEL_BUILD --%>
              <c:if test="${revisionsBean.buildFinished and not empty revisionsBean.availableRootsToMerge}">
                <l:li>
                  <a href="#" onclick="BS.Merge.showEditDialog(${buildData.buildId}, '${buildData.branch.displayName}'); return false">Merge this build sources...</a>
                </l:li>
              </c:if>
              </authz:authorize>

              <authz:authorize projectId="${buildType.projectId}" allPermissions="RUN_BUILD">
              <c:if test="${not buildData.personal && buildData.finished}">
                <l:li>
                  <c:set var="startOpt">redirectToQueuedBuild: true</c:set>
                  <c:choose>
                    <c:when test="${not empty buildData.buildPromotion.chainModificationId}">
                      <c:set var="startOpt">${startOpt}, modificationId: ${buildData.buildPromotion.chainModificationId}</c:set>
                    </c:when>
                    <c:otherwise>
                      <c:if test="${buildData.buildPromotion.lastModificationId > 0}"><c:set var="startOpt">${startOpt}, modificationId: ${buildData.buildPromotion.lastModificationId}</c:set></c:if>
                    </c:otherwise>
                  </c:choose>

                  <c:choose>
                    <c:when test="${not empty buildData.branch}"><c:set var="startOpt">${startOpt}, branchName: '<bs:escapeForJs text="${buildData.branch.name}"/>'</c:set></c:when>
                    <c:otherwise><c:set var="startOpt">${startOpt}, branchName: '<bs:escapeForJs text="${defaultBranch}"/>'</c:set></c:otherwise>
                  </c:choose>
                  <c:set var="dependsOn" value=""/>
                  <c:forEach items="${buildData.buildPromotion.dependencies}" var="dep">
                    <c:set var="dependsOn" value="${dependsOn},${dep.dependOn.id}"/>
                  </c:forEach>
                  <c:set var="startOpt">${startOpt}, dependOnPromotionIds: '${dependsOn}'</c:set>
                  <a class="noUnderline" href="#" onclick="Event.stop(event); BS.RunBuild.runCustomBuild('${buildData.buildType.externalId}', { ${startOpt} }); return false">Re-run with the same revisions...</a>
                </l:li>
              </c:if>
              </authz:authorize>

              <c:if test="${buildData.finished and afn:canRemoveBuild(buildData)}">
                <l:li>
                  <a onclick="BS.StopBuildDialog.showStopBuildDialog([${buildData.buildPromotion.id}], '', 3, null);" href="#">Remove...</a>
                </l:li>
              </c:if>
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
    /css/filePopup.css
    /css/buildTypeSettings.css
    /css/labels.css
    /css/viewModification.css
    /css/pager.css
    /css/progress.css
    /css/tags.css
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
    /js/bs/merge.js
    /js/bs/overflower.js
    /js/bs/testDetails.js
    /js/bs/testGroup.js

    /js/bs/locationHash.js
    /js/bs/buildLogTree.js
  </bs:linkScript>

  <!-- ===== JS files, provided by plugins: ==== -->
  <c:set var="historyBuildText"><c:if test="${buildData.outOfChangesSequence}">History build&nbsp;</c:if></c:set>
  <c:set var="title">#${buildData.buildNumber} (${startDate})</c:set>
  <c:if test="${'N/A' == buildData.buildNumber}">
    <c:set var="title" value="${startDate}"/>
  </c:if>
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
        buildTypeId: "${buildType.externalId}",
        siblingsTree: {
          parentId: "${buildType.projectExternalId}"
        }
      });

      <c:set var="branchParam" value=""/>
      <c:if test="${not empty buildData.branch}"><c:set var="branchParam">&branch_${buildType.externalId}=<c:out value="${buildData.branch.name}"/></c:set></c:if>

      BS.Navigation.items.push({
        title: "<bs:forJs><bs:buildDataIcon buildData="${buildData}"
                                            simpleTitle="${true}"/></bs:forJs>${historyBuildText}<bs:escapeForJs text="${title}" forHTMLAttribute="true"/>",
        url: "viewLog.html?buildTypeId=${buildType.externalId}&buildId=${buildData.buildId}${branchParam}",
        selected: true
      });

      var enablePeriodicalRefresh = _.once(function() {
        <c:if test="${not buildData.finished}">
          $j(function() {
            BS.PeriodicalRefresh.start(5, function() {
              return $('buildResults').refresh(null, "runningBuildRefresh=1");
            });
          });
        </c:if>
      });

      <c:if test="${not isBuildOverview}">
        $j(document).on("bs.navigationRendered", function() {
          BS.BuildResults.installBuildDetailsPopup(${buildData.buildId});
        });
      </c:if>

    </bs:trimWhitespace>
  </script>
</jsp:attribute>

<jsp:attribute name="besideTabs_include">
  <c:if test="${not empty buildData.finishDate}">
    <span class="shortHistory"><jsp:include page="nextPreviousBlock.jsp"/></span>
  </c:if>
</jsp:attribute>

<jsp:attribute name="body_include">
  <c:set var="buildData" value="${buildData}" scope="request"/>
  <div class="messagesHolder">
    <bs:messages key="vcsLabelingSuccessful"/>
    <bs:messages key="vcsLabelingFailed" className="error" style="margin-left: 0"/>
    <bs:messages key="vcsMergingSuccessful"/>
    <bs:messages key="vcsMergingFailed" className="error" style="margin-left: 0"/>
  </div>

  <%@ include file="buildRowPopupTemplate.jspf" %>

  <div id="container" class="clearfix">
    <bs:refreshable containerId="buildResults" pageUrl="${pageUrl}">
    <c:if test="${buildData.finished and not empty param['runningBuildRefresh']}">
    <script type="text/javascript">
      BS.reload(true);
    </script>
    </c:if>
    <c:if test="${not buildData.finished or empty param['runningBuildRefresh']}">
      <ext:showTabs placeId="<%=PlaceId.BUILD_RESULTS_TAB%>"
                    urlPrefix="viewLog.html?buildId=${buildData.buildId}&buildTypeId=${buildData.buildTypeExternalId}">
        <c:if test="${isBuildOverview}"><%--@elvariable id="buildResultsBean" type="jetbrains.buildServer.controllers.viewLog.BuildResultsBean"--%>
        <bs:buildDataStatus buildData="${buildData}" showAlsoRunning="true" buildStatusText="${buildResultsBean.statusText}"/></c:if>
      </ext:showTabs>
    </c:if>
    <c:if test="${not buildData.finished and not empty param['runningBuildRefresh']}">
      <div style="display: none;">
        <bs:buildDataIcon buildData="${buildData}" imgId="buildDataIcon"/>
        <script type="text/javascript">
          BS.BuildResults.updateStateIcon();
        </script>
      </div>
    </c:if>
    </bs:refreshable>
  </div>

  <bs:valuePopup buildType="${buildType}"/>

  <bs:pinBuildDialog onBuildPage="${true}" build="${buildData}" buildType="${buildData.buildType}"/>
  <bs:buildCommentDialog />
  <bs:promoteBuildDialog />
  <authz:authorize projectId="${buildType.projectId}" allPermissions="LABEL_BUILD">
    <labels:form vcsRootsBean="${revisionsBean}" buildId="${buildData.buildId}"/>
    <merge:form vcsRootsBean="${revisionsBean}" buildId="${buildData.buildId}"/>
  </authz:authorize>

</jsp:attribute>
</bs:page>
