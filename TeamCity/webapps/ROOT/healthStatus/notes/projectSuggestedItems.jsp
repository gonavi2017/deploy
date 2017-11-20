<%@ include file="/include-internal.jsp"%>
<%--@elvariable id="project" type="jetbrains.buildServer.serverSide.SProject"--%>
<%--@elvariable id="results" type="java.util.List<jetbrains.buildServer.serverSide.healthStatus.HealthStatusItem>"--%>
<c:set var="containerId" value="container_si_${project.externalId}"
/><c:set var="ajax" value="${param.ajax == '1'}"
/><c:if test="${not ajax}"><span id="${containerId}"></c:if
><c:if test="${results != null and not empty results}">
  <c:set var="pageUrl" scope="request" value="${param.originUrl}"/>
  <bs:healthReportsPopup controlId="si_${project.externalId}" items="${results}" project="${project}" title="Suggested Settings">
    <div class="healthItemIndicator" title="View suggested settings">
      <i class="itemSeverity icon-lightbulb"></i>
    </div>
  </bs:healthReportsPopup>
</c:if><c:if test="${not ajax}"></span></c:if
><c:if test="${results == null}">
  <script type="text/javascript">
    window.setTimeout(function() {
      BS.ajaxUpdater($('${containerId}'), window['base_uri'] + '/admin/projectSuggestedItems.html?projectId=${project.externalId}&onlyCategoryId=${onlyCategoryId}&compute=true&ajax=1&originUrl=${util:urlEscape(param.originUrl)}', {evalScripts: true});
    }, 300);
  </script>
</c:if>
