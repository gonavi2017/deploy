<%@ include file="/include-internal.jsp"
%><jsp:useBean id="vcsRoot" type="jetbrains.buildServer.vcs.SVcsRoot" scope="request"
/><c:set var="containerId" value="container_hi_${vcsRoot.externalId}"
/><c:set var="ajax" value="${param.ajax == '1'}"
/><c:if test="${not ajax}"><span id="${containerId}"></c:if
><c:if test="${results != null and not empty results}">
  <c:set var="pageUrl" scope="request" value="${param.originUrl}"/>
  <bs:healthReportIcon items="${results}" currentEntity="${vcsRoot}" project="${vcsRoot.project}"/>
</c:if><c:if test="${not ajax}"></span></c:if>
<c:if test="${results == null}">
  <script type="text/javascript">
    window.setTimeout(function() {
      BS.ajaxUpdater($('${containerId}'), window['base_uri'] + '/admin/vcsRootHealthStatusItems.html?vcsRootId=${vcsRoot.externalId}&compute=true&ajax=1&originUrl=${util:urlEscape(param.originUrl)}', {evalScripts: true});
    }, 300);
  </script>
</c:if>
