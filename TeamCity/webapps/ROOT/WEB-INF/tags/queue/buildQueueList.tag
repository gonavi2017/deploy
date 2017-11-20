<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="afn" uri="/WEB-INF/functions/authz" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="queue" tagdir="/WEB-INF/tags/queue" %>
<%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags/tags" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ attribute name="hideOrdering" type="java.lang.Boolean" %>
<%@ attribute name="hideActioButton" type="java.lang.Boolean" %>
<%@ attribute name="hideSelection" type="java.lang.Boolean" %>
<jsp:useBean id="buildQueue" type="jetbrains.buildServer.controllers.queue.BuildQueueForm" scope="request"/>
<c:set var="canReorderQueue" value="${afn:permissionGrantedForAnyProject('REORDER_BUILD_QUEUE') && !hideOrdering}"/>
<c:set var="selectedBuildType" value="${param['buildTypeId']}"/> <%--this means externam build type id--%>
<c:set var="selectedItemId" value="${param['itemId']}"/>
<c:set var="canRemoveItems" value="${afn:permissionGrantedForAnyProject('CANCEL_BUILD') or afn:permissionGrantedForAnyProject('CANCEL_ANY_PERSONAL_BUILD')}"/>
<c:set var="draggable" value="${canReorderQueue}"/>
<c:set var="showBranch" value=""/>
<c:set var="showTags" value=""/>
<%--@elvariable id="currentUser" type="jetbrains.buildServer.users.SUser"--%>
<form action="#" id="buildQueueForm">
  <div id="buildQueue">
    <div class="queueWrapper">
      <c:if test="${buildQueue.numberOfItems == 0 && buildQueue.filteredByAgentPoolMode}">
        <div>No builds found for the selected pool in the build queue.</div>
      </c:if>
      <c:if test="${buildQueue.numberOfItems == 0 && !buildQueue.filteredByAgentPoolMode}">
        <div>Build queue is empty.</div>
      </c:if>
      <c:if test="${buildQueue.numberOfItems > 0 and fn:length(buildQueue.items) == 0}">
        <div class="icon_before icon16 attentionComment">You do not have permissions to see all of the items currently in the queue.</div>
      </c:if>
      <c:if test="${fn:length(buildQueue.items) > 0}">
        <c:if test="${!hideActioButton}">
          <c:if test="${buildQueue.numberOfItems > fn:length(buildQueue.items)}">
            <div class="icon_before icon16 attentionComment">You do not have permissions to see all of the <strong>${buildQueue.numberOfItems}</strong> items.</div>
          </c:if>


          <div class="queueActionMessages clearfix">
            <c:if test="${canReorderQueue}">
              <c:if test="${fn:length(buildQueue.items) > 1}">
                <span id="notes"><c:if test="${buildQueue.numberOfItems>0 && buildQueue.filteredByAgentPoolMode}"><strong
                >${buildQueue.numberOfItems}</strong> build<bs:s val="${buildQueue.numberOfItems}"/> found for the selected pool in the build queue.&nbsp;</c:if>Use drag-and-drop to reorder the queue.</span>
              </c:if>
            </c:if>

            <span class="messagesHolder">
              <span id="savingData"><i class="icon-refresh icon-spin"></i> Saving...</span>
              <span id="dataSaved">New build queue order applied</span>
            </span>
          </div>
        </c:if>
        <c:if test="${canRemoveItems && !hideActioButton && !hideSelection}">
          <div class="queueActions" id="queueActionsHolder">
            <bs:actionsPopup controlId="queueActions"
                             popup_options="delay: 0, shift: {x: -80, y: 20}, className: 'quickLinksMenuPopup'">
                <jsp:attribute name="content">
                  <ul class="menuList">
                    <l:li onclick="if ($j('.myPersonalBuild').length == 0) { alert('There are no personal builds of yours in the queue.'); } else { BS.Queue.selectBuilds('.myPersonalBuild'); } ">
                      <a href="#" onclick="return false">Select your personal builds in the queue</a>
                    </l:li>
                  </ul>
                </jsp:attribute>
              <jsp:body>Actions</jsp:body>
            </bs:actionsPopup>
          </div>
        </c:if>

        <div class="clr"></div>
        <queue:queueEstimates buildQueue="${buildQueue}"/>
        <table id="buildQueueTable" class="buildQueueTable">
          <thead>
          <tr class="metrix">
            <th class="canDrag">&nbsp;</th>
            <c:if test="${draggable}">
              <th class="canDrag">&nbsp;</th>
            </c:if>
            <th class="orderNum"></th>
            <th class="branch"></th>
            <c:if test="${not buildQueue.filteredByBuildTypeMode}">
              <th class="configurationName">Build configuration</th>
            </c:if>
            <th class="triggeredBy">Triggered by</th>
            <th class="remaining">Time to start&nbsp;</th>
            <th class="canRunOn">Can run on</th>
            <th class="queuedBuildTags"></th>
            <c:if test="${canRemoveItems}">
              <th class="remove" style="padding-right: 6px; text-align: right;"></th>
              <c:if test="${!hideSelection}">
                <th class="selection">
                  <forms:checkbox name="removeAll"
                                  onclick="if (this.checked) BS.Util.selectAll($('buildQueueForm'), 'removeItem'); else BS.Util.unselectAll($('buildQueueForm'), 'removeItem')"/>
                </th>
              </c:if>
            </c:if>
          </tr>
          </thead>
          <tbody>
          <c:forEach items="${buildQueue.hiddenTopItems}" var="item"><tr style="display: none;" id="queue_${item.itemId}"></tr></c:forEach>
          <c:forEach var="queuedBuild" items="${buildQueue.items}" varStatus="pos">
            <c:set var="rowId" value="queue_${queuedBuild.itemId}"
            /><c:set var="personalBuild" value="${queuedBuild.personal}"
            /><c:set var="parentBuildTypeId" value="${queuedBuild.buildType.externalId}"
            /><c:if test="${personalBuild}"><c:set var="parentBuildTypeId" value="${queuedBuild.buildType.sourceBuildType.buildTypeId}"/></c:if
            ><c:set var="myBuild" value="${personalBuild && currentUser == queuedBuild.buildType.user}"
            /><c:set var="foreignBuild" value="${personalBuild && not myBuild}"
            /><c:set var="draggableClass" value="${draggable ? 'draggable' : 'notDraggable'}"
            /><c:set var="promo" value="${queuedBuild.buildPromotion}"
            /><c:set var="branch" value="${promo.branch}"
            /><c:set var="selectedBuild" value="${selectedBuildType == parentBuildTypeId || selectedItemId == queuedBuild.itemId}"
            /><c:set var="additionalClasses"><c:if test="${selectedBuild}">selected</c:if><c:if test="${myBuild}"> myPersonalBuild</c:if><c:if test="${foreignBuild}"> foreignPersonalBuild</c:if></c:set>
            <tr class="${draggableClass} ${additionalClasses}" id="${rowId}">
              <td class="${draggable ? 'tc-icon_before icon16 tc-icon_draggable' : ''}"><a name="ref${parentBuildTypeId}"></a><a name="itemId${queuedBuild.itemId}"></a></td>
              <c:if test="${draggable}">
                <td><span class="tc-icon icon16 tc-icon_move-top" <c:if test="${draggable}">onclick="BS.Queue.moveToTop('${rowId}')"</c:if> <c:if test="${pos.first and empty buildQueue.hiddenTopItems}">style='visibility:hidden'</c:if>
                       <c:if test="${not pos.first or not empty buildQueue.hiddenTopItems}"> title="Move to top" alt="Move to top"</c:if> ></span></td>
              </c:if>
              <td class="orderNum">
                <a href="viewQueued.html?itemId=${queuedBuild.itemId}">#${buildQueue.orderNumber[queuedBuild]}</a> <bs:promotionCommentIcon promotion="${promo}"/>
                <tags:favoriteBuildAuth buildPromotion="${queuedBuild.buildPromotion}"><tags:favoriteBuild buildPromotion="${queuedBuild.buildPromotion}" showOnlyIfFavorite="true"/></tags:favoriteBuildAuth>
              </td>
              <td class="branch ${not empty branch ? 'hasBranch' : ''} ${not empty branch and branch.defaultBranch ? 'default' : ''}">
                <c:if test="${not empty branch}"
                ><c:set var="showBranch" value="true"
                /><span class="branchName"><bs:trimBranch branch="${branch}"/></span></c:if>
              </td>
              <c:if test="${not buildQueue.filteredByBuildTypeMode}">
                <td class="configurationName"><bs:buildTypeLinkFull buildType="${queuedBuild.buildType}" fullProjectPath="true" skipContextProject="true"/></td>
              </c:if>
              <td class="triggeredBy"><queue:triggeredBy queuedBuild="${queuedBuild}" currentUser="${currentUser}"/></td>
              <td id="estimate${queuedBuild.itemId}" class="remaining">
                <span data-itemId='${queuedBuild.itemId}' class="remaining">
                  <span id="estimate${queuedBuild.itemId}:text" class="tc-icon_after commentIcon comment-icon-mixin_right"></span>
                </span>
              </td>
              <td class="canRunOn"><queue:queuedBuildAgent queuedBuild="${queuedBuild}"/></td>
              <td class="queuedBuildTags"><c:if test="${fn:length(queuedBuild.buildPromotion.tags) > 0}"><c:set var="showTags" value="true"/><tags:tagsInfo buildPromotion="${queuedBuild.buildPromotion}"/></c:if></td>
              <authz:authorize projectId="${queuedBuild.buildType.projectId}" allPermissions="CANCEL_BUILD"
                ><jsp:attribute name="ifAccessGranted">
                  <td class="remove">
                    <c:if test="${not personalBuild or myBuild or afn:permissionGrantedForBuildType(queuedBuild.buildType, 'CANCEL_ANY_PERSONAL_BUILD')}"
                    ><a id="remove_${queuedBuild.buildPromotion.id}" class="actionLink red" href="#" onclick="BS.StopBuildDialog.showStopBuildDialog([${queuedBuild.buildPromotion.id}], '', 1); return false" title="Remove this build only">Remove</a></c:if>
                  </td>
                  <c:if test="${!hideSelection}">
                    <td class="selection">
                      <c:if test="${not personalBuild or myBuild or afn:permissionGrantedForBuildType(queuedBuild.buildType, 'CANCEL_ANY_PERSONAL_BUILD')}"><forms:checkbox name="removeItem" value="${queuedBuild.buildPromotion.id}"/></c:if>
                    </td>
                  </c:if>
                </jsp:attribute
                ><jsp:attribute name="ifAccessDenied">
                  <c:if test="${afn:permissionGrantedForAnyProject('CANCEL_BUILD') or afn:permissionGrantedForAnyProject('CANCEL_ANY_PERSONAL_BUILD')}">
                    <td class="remove" title="You do not have enough permissions to remove this build"></td>
                    <c:if test="${!hideSelection}"><td class="selection"><forms:checkbox name="removeItem" value="${queuedBuild.buildPromotion.id}" disabled="true"/></td></c:if>
                  </c:if>
                </jsp:attribute
              ></authz:authorize>
            </tr>
          </c:forEach>
          </tbody>
        </table>

        <script>
            BS.Queue.updateQueueEstimatesFromData();

            <c:if test="${showBranch}">
                BS.Queue.showBranchColumn();
            </c:if>
            <c:if test="${showTags}">
                BS.Queue.showTagsColumn();
            </c:if>
            <c:if test="${canReorderQueue and fn:length(buildQueue.items) > 0}">
                BS.Queue.initSorting();
            </c:if>
        </script>

      </c:if>
    </div>
  </div>
  <div id="agentsInfoDiv" class="popupDiv"></div>
</form>

