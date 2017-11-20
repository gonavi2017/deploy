<%@ include file="include-internal.jsp" %>
<%--@elvariable id="bean" type="jetbrains.buildServer.controllers.builds.FavoriteBuildsBean"--%>
<jsp:useBean id="currentUser" type="jetbrains.buildServer.users.User" scope="request"/>
<bs:page>
  <jsp:attribute name="page_title">Favorite Builds</jsp:attribute>
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
       /css/agentsInfoPopup.css
       /css/buildQueue.css
       /css/filePopup.css
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
      /js/bs/queueLikeSorter.js
      /js/bs/buildQueue.js
    </bs:linkScript>
    <script type="text/javascript">
      BS.Navigation.items = [
        {title: "Favorite Builds", selected: true}
      ];
    </script>

      <script type="text/javascript">
        window.setTimeout(function(){
          $j(".favoriteBuildsTable tr.recent").removeClass("recent");
        }, 10000)
      </script>
  </jsp:attribute>
  <jsp:attribute name="body_include">
    <div class="favoriteBuildDescription">On this page you can view your favorite builds. <bs:help file="Favorite Build"><bs:helpIcon/></bs:help></div>
    <bs:refreshable containerId="favoriteBuildsContainer" pageUrl="${pageUrl}">
    <div class="favoriteBuildDescription">
      <c:set var="total" value="${bean.queuedBuildCount + bean.runningBuildCount + bean.finishedBuildCount}"/>
      <c:choose>
        <c:when test="${total>0}">
          There <bs:are_is val="${total}"/> <strong>${total}</strong> build<bs:s val="${total}"/> in your favorites (${bean.queuedBuildCount} queued, ${bean.runningBuildCount} running and ${bean.finishedBuildCount} finished).
        </c:when>
        <c:otherwise>
          There are no builds in your favorites.
        </c:otherwise>
      </c:choose>

    </div>

      <table style="width: 100%;" class="favoriteBuildsTable historyTable testList borderBottom dark">
      <thead>
      <tr>
        <th style="width: 200px;">
          Build configuration
        </th>
        <th>
          &nbsp;
        </th>
        <th colspan="3">
          Build details
        </th>
        <th>
          &nbsp;
        </th>
        <th>
          &nbsp;
        </th>
        <th>
          &nbsp;
        </th>
        <th>
          &nbsp;
        </th>
        <th>
          &nbsp;
        </th>

      </tr>
      </thead>
      <tbody>

      <c:forEach items="${bean.builds}" var="favoriteBuild" varStatus="pos">
        <c:set var="build" value="${favoriteBuild.build}"/>
        <c:choose>
          <c:when test="${favoriteBuild.queued}">
            <tr>
             <bs:queuedBuild queuedBuild="${favoriteBuild.build}"  showBuildType="true" showBranches="true" showNumber="true" estimateColspan="7"/>
            </tr>
          </c:when>
          <c:otherwise>
            <c:set var="buildId" value="${build.buildId}"/>
            <c:if test="${buildId==bean.lastBuildInPreviousPortion}">
              <c:set var="recent" value="${pos.index}"/>
            </c:if>
            <tr id="${pos.index}" <c:if test="${not empty recent && recent+1==pos.index}">class="recent"</c:if>   >
            <bs:buildRow build="${build}"
                         showBranchName="true"
                         showBuildTypeName="true"
                         showBuildNumber="true"
                         showStatus="true"
                         showArtifacts="true"
                         showCompactArtifacts="false"
                         showChanges="true"
                         showStartDate="true"
                         showDuration="false"
                         showProgress="true"
                         showStop="false"
                         showAgent="false"
                         showPin="false"
                         showTags="true"
                         showCompactTags="true"
                         showUsedByOtherBuildsIcon="false"/>
              <td>
                <c:if test="${build.finished}">
                  <authz:authorize projectId="${build.projectId}" allPermissions="PIN_UNPIN_BUILD">
                    <bs:pinLink build="${build}" pin="${not build.pinned}" onBuildPage="false">
                      <span class="icon icon16 icon16_pinned_${build.pinned ? 'yes' : 'no'}" title="Pin${build.pinned ? 'ned' : ''}"></span>
                    </bs:pinLink>
                    <bs:pinBuildDialog onBuildPage="${false}" build="${build}" buildType="${build.buildType}"/>
                  </authz:authorize>
                </c:if>
              </td>
            </tr>
          </c:otherwise>
        </c:choose>
      </c:forEach>

   </tbody>
  </table>
  <div class="loadMoreContainer"><c:if test="${bean.hasNext}">
    <form id="favoriteBuildsForm" name="favoriteBuildsForm">
      <input type="hidden" id="lb" name="lb" value="${buildId}"/>
      <input type="hidden" id="count" name="count" value="${bean.visibleBuildsCount}"/>
      <a href="#" class="btn loadMoreBtn" onclick="BS.FavoriteBuilds.loadMore(); return false" >More</a><forms:progressRing id="showMoreFavoriteBuildsProgress" className="showMoreFavoriteBuildsProgress" style="visibility:hidden;"/>
    </form>
    </c:if>
  </div>

    </bs:refreshable>
    <et:subscribeOnEvents>
      <jsp:attribute name="eventNames">
        BUILD_STARTED
        BUILD_CHANGES_LOADED
        BUILD_FINISHED
        BUILD_INTERRUPTED
        BUILD_TYPE_ACTIVE_STATUS_CHANGED
        BUILD_TYPE_ADDED_TO_QUEUE
        BUILD_TYPE_REMOVED_FROM_QUEUE
      </jsp:attribute>
      <jsp:attribute name="eventHandler">
        BS.reload(false, function() {
          $('favoriteBuildsContainer').refresh();
        });
      </jsp:attribute>
    </et:subscribeOnEvents>
    <script type="text/javascript">
      <c:if test="${not empty recent}">
      var recentRow = $j("#${recent}");
      if (recentRow!=undefined) {
        $j('html, body').animate({scrollTop: recentRow.offset().top}, 1000);
      }
      </c:if>
    </script>

  </jsp:attribute>

</bs:page>
