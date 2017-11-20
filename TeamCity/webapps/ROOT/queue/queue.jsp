<%@ page import="jetbrains.buildServer.controllers.queue.BuildQueueForm" %>
<%@ include file="/include-internal.jsp" %>
<c:set var="pageTitle" value="Build Queue" scope="request"/>
<jsp:useBean id="buildQueue" type="jetbrains.buildServer.controllers.queue.BuildQueueForm" scope="request"/>
<jsp:useBean id="serverSummary" type="jetbrains.buildServer.web.openapi.ServerSummary " scope="request"/>
<bs:page>
  <jsp:attribute name="head_include">
    <bs:linkCSS>
      /css/agentsInfoPopup.css
      /css/buildQueue.css
      /css/filePopup.css
    </bs:linkCSS>
    <bs:linkScript>
      /js/bs/queueLikeSorter.js
      /js/bs/buildQueue.js
    </bs:linkScript>
    <script type="text/javascript">
      BS.Navigation.items = [
          {title: "Build Queue", selected:true}
      ];
      BS.topNavPane.setActiveCaption('queue');
    </script>
  </jsp:attribute>
  <jsp:attribute name="body_include">
    <div id="tabsContainer4" class="simpleTabs clearfix"></div>

    <c:set var="poolKey" value="<%=BuildQueueForm.AGENT_POOL_ID_FILTER_PROPERTY_KEY.getKey()%>"/>
    <bs:refreshable containerId="buildQueueContainer" pageUrl="${pageUrl}">
      <c:if test="${serverSummary.hasSeveralAgentPools}">
        <div class="actionBar" id="queueFilterBar">
          <label class="firstLabel" for="queuePool">Agent pool: </label>
          <forms:select name="queuePool" enableFilter="true" onchange="BS.QueueFilter.filter('${poolKey}');">
            <forms:option value="ALL" selected="${buildQueue.filteredByAgentPoolId == null}">&lt;All&gt;</forms:option>
            <c:forEach items="${buildQueue.allAgentPools}" var="pool">
              <forms:option value="${pool.agentPoolId}" selected="${pool.agentPoolId eq buildQueue.filteredByAgentPoolId}"><c:out value="${pool.name}"/></forms:option>
            </c:forEach>
          </forms:select>
          &nbsp;
          <c:if test="${buildQueue.filteredByAgentPoolMode}"><forms:resetFilter resetHandler="BS.QueueFilter.resetFilter('${poolKey}');"/></c:if>
          <forms:saving id="queueFilterProgress" className="progressRingInline"/>
        </div>
      </c:if>
      <queue:buildQueueList/>

      <script type="text/javascript">
        BS.Queue.initActionsToolbar();
      </script>
    </bs:refreshable>

    <et:subscribeOnEvents>
      <jsp:attribute name="eventNames">
        BUILD_QUEUE_ORDER_CHANGED
        BUILD_TYPE_ADDED_TO_QUEUE
        BUILD_TYPE_REMOVED_FROM_QUEUE
        AGENT_REGISTERED
        AGENT_PARAMETERS_UPDATED
        AGENT_UNREGISTERED
        AGENT_REMOVED
      </jsp:attribute>
      <jsp:attribute name="eventHandler">
        BS.reload(false, function() {
          if ($j("#" + BS.Queue.containerId).length > 0) {
             Sortable.destroy(BS.Queue.containerId);
          }
          $('buildQueueContainer').refresh();
        });
      </jsp:attribute>
    </et:subscribeOnEvents>

    <forms:modified id="queue-actions-docked">
      <jsp:body>
        <div class="bulk-operations-toolbar fixedWidth">
          <span class="queue-operations">
            <a href="#" id="deleteAllSelected" class="btn btn_primary submitButton" onclick="BS.StopBuildDialog.showStopBuildDialog(BS.Util.getSelectedValues($('buildQueueForm'), 'removeItem'), '', 1); return false">Remove selected builds...</a>
            <a href="#" class="bulk-operation-link bulk-operation-cancel btn" onclick="BS.Queue.hideActionsToolbar(); return false;">Cancel</a>
          </span>
        </div>
      </jsp:body>
    </forms:modified>

    <script type="text/javascript">
      BS.Queue.initEstimatesAutoupdate();
    </script>
  </jsp:attribute>
</bs:page>
