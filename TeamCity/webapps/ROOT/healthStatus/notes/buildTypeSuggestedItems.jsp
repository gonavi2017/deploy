<%@ include file="/include-internal.jsp"%>

<jsp:useBean id="buildType" type="jetbrains.buildServer.serverSide.SBuildType" scope="request"/>
<c:set var="containerId" value="container_si_${buildType.externalId}"
/><c:set var="ajax" value="${param.ajax == '1'}"
/><c:if test="${not ajax}"><span id="${containerId}"></c:if
><c:if test="${results != null and not empty results}">
    <c:set var="pageUrl" scope="request" value="${param.originUrl}"/>
    <bs:healthReportsPopup controlId="si_${buildType.externalId}" items="${results}" project="${buildType.project}" title="Suggested Settings">
      <div class="healthItemIndicator" title="View suggested settings">
        <i class="itemSeverity icon-lightbulb"></i>
      </div>
    </bs:healthReportsPopup>
  </c:if><c:if test="${not ajax}"></span></c:if
>
<c:if test="${results == null}">
  <script type="text/javascript">
    window.setTimeout(function() {
      BS.ajaxUpdater($('${containerId}'), window['base_uri'] + '/admin/buildTypeSuggestedItems.html?buildTypeId=${buildType.externalId}&onlyCategoryId=${onlyCategoryId}&compute=true&ajax=1&originUrl=${util:urlEscape(param.originUrl)}', {evalScripts: true});
    }, 300);
  </script>
</c:if>
