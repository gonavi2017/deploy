<%@ include file="/include-internal.jsp"%>
<jsp:useBean id="project" type="jetbrains.buildServer.serverSide.SProject" scope="request"/>
<jsp:useBean id="suggestionsMode" type="java.lang.Boolean" scope="request"/>
<%--@elvariable id="project" type="jetbrains.buildServer.serverSide.SProject"--%>
<c:set var="containerId" value="container_hi_${project.externalId}"/>
<c:set var="adminArea" value='<%=request.getRequestURI().indexOf("/admin/") != -1%>'
/><c:set var="ajax" value="${param.ajax == '1'}"
/><c:if test="${not ajax}"><span id="${containerId}"></c:if
><c:if test="${results != null and not empty results}">
  <c:set var="pageUrl" scope="request" value="${param.originUrl}"/>
  <bs:healthReportIcon items="${results}" currentEntity="${project}" project="${project}"/>
</c:if><c:if test="${not ajax}"></span></c:if
><c:if test="${results == null}">
  <script type="text/javascript">
    window.setTimeout(function() {
      BS.ajaxUpdater($('${containerId}'), window['base_uri'] + '${adminArea ? "/admin" : ""}/projectHealthStatusItems.html?projectId=${project.externalId}&compute=true&excludeCategoryId=${excludeCategoryId}&ajax=1&originUrl=${util:urlEscape(param.originUrl)}', {evalScripts: true});
    }, 300);
  </script>
</c:if>
