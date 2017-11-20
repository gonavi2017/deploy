<%@ include file="/include-internal.jsp" %>

<script type="text/javascript">
  releaseWaitingThreads = function(taskId) {
    if (!confirm('Are you sure you want to release threads waiting for completion of the task ' + taskId + ' ?'))
      return;
    BS.ajaxRequest(BS.AdminActions.url, {
      method: "post",
      parameters: "action=releaseWaitingThreads&taskId=" + taskId,
      onComplete: function() {
        BS.reload(true);
      }
    });
  }
</script>
<bs:refreshable containerId="persistQueue" pageUrl="${pageUrl}">
  <style type="text/css">
    div.header {
      margin-top: 1em;
      font-weight: bold;
    }

    div.queueItem {
      margin-top: 1em;
      margin-left: 1em;
    }

    div.releaseThreads {
      margin-left: 1em;
    }

    span.user {
      font-weight: bold;
      margin-left: 1em;
    }

    span.description {
      margin-left: 1em;
    }
  </style>

  <div>
    <div class="header">Persist Queue</div>
    <c:choose>
      <c:when test="${empty tasks}">
        <div class="queueItem">Empty</div>
      </c:when>
      <c:otherwise>
        <c:forEach var="task" items="${tasks}" varStatus="i">
          <div class="queueItem">
            ${i.count}.&nbsp;<c:out value="${task.description}"/>&nbsp;(${task.stage})
            <c:if test="${afn:permissionGrantedGlobally('CHANGE_SERVER_SETTINGS') && param['showReleaseThreads'] == 'true'}">
              <div class="releaseThreads"><a href="javascript:releaseWaitingThreads(${task.id})">release waiting threads</a></div>
            </c:if>
          </div>
        </c:forEach>
      </c:otherwise>
    </c:choose>
  </div>

  <script type="text/javascript">
    setTimeout(function() {
      $j("#persistQueue").get(0).refresh();
    }, 5000);
  </script>
</bs:refreshable>
