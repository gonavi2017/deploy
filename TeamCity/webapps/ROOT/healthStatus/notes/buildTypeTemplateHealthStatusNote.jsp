<%@ include file="/include-internal.jsp"
%><jsp:useBean id="template" type="jetbrains.buildServer.serverSide.BuildTypeTemplate" scope="request"
/><c:set var="containerId" value="container_hi_${template.externalId}"
/><span id="${containerId}">
  <c:if test="${results != null and not empty results}">
    <c:set var="pageUrl" scope="request" value="${param.originUrl}"/>
    <bs:healthReportIcon items="${results}" currentEntity="${template}" project="${template.project}"/>
  </c:if>
</span>
<c:if test="${results == null}">
  <script type="text/javascript">
    window.setTimeout(function() {
      BS.ajaxUpdater($('${containerId}'), window['base_uri'] + '/admin/buildTypeTemplateHealthStatusItems.html?templateId=${template.externalId}&excludeCategoryId=${excludeCategoryId}&compute=true&originUrl=${util:urlEscape(param.originUrl)}', {evalScripts: true});
    }, 300);
  </script>
</c:if>
