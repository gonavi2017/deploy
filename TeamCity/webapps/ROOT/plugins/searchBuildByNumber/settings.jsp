<%--@elvariable id="service" type="jetbrains.buildServer.serverSide.search.SearchService"--%>
<%@ include file="/include.jsp" %>
<script type="text/javascript">
  function startOptimize() {
    BS.ajaxRequest(window['base_uri'] + '/search/settings.html', {
      method: "post",
      parameters: "optimizeIndex=true",
      onComplete: function() {
        BS.reload(true)
      }
    });
  }
</script>
<div>
  <dl>
    <dt>Index Status
    <dd>Version tag: ${service.indexVersion}
    <dd>Disk size: ${service.diskSize}
    <dd>
      <c:choose>
        <c:when test="${service.optimizationInProgress}">
          Index optimization is in progress...
        </c:when>
        <c:otherwise>
          <a href="#" title="Optimize index" onclick="startOptimize(); return false">Optimize index</a>
        </c:otherwise>
      </c:choose>
    </dd>
  </dl>
  <dl>
    <dt>Service Status
    <dd>Builds Indexed: ${service.indexSize}
    <dd>Builds Queued: ${service.indexingQueueSize}
  </dl>
  <%--
  <dl>
    <dt>Available fields
    <dd class="short" title="Click to expand" onclick="this.hide(); $$('dd.long').each(Element.show);">
    <a href="javascript:;">
    <c:forEach items="${service.indexMap}" var="field">${field.key} </c:forEach></a>
    </dd>
    <c:forEach items="${service.indexMap}" var="field">
      <dd class="long" style="display:none;"><strong>${field.key}</strong> ~${field.value}</dd>
    </c:forEach>
  </dl>
  --%>
</div>
