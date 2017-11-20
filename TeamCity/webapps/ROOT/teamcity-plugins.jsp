<%@ include file="/include-internal.jsp" %>
<jsp:useBean id="bundledPlugins" type="java.util.Collection<jetbrains.buildServer.web.plugins.web.PluginModelBean>" scope="request"/>
<jsp:useBean id="unbundledPlugins" type="java.util.Collection<jetbrains.buildServer.web.plugins.web.PluginModelBean>" scope="request"/>

<div class="plugins">
  <div>
    This TeamCity installation has <strong>${fn:length(bundledPlugins) + fn:length(unbundledPlugins)}</strong>
    plugins<c:if test="${not empty unbundledPlugins}"> (including ${fn:length(unbundledPlugins)} external)</c:if>
    <br />
    <c:url var="url" value="/admin/admin.html?item=diagnostics&tab=dataDir#upload:plugins!:plugins"/>
    <a href="${url}" title="Upload plugin zip to the TeamCity data directory">Upload plugin zip</a>
    &nbsp; | &nbsp;
    <a href="https://plugins.jetbrains.com/?teamcity" target="_blank">Available plugins</a>
  </div>

  <c:if test="${not empty unbundledPlugins}">
    <h2 class="noBorder">External plugins</h2>
    <c:set var="plugins" value="${unbundledPlugins}"/>
    <%@ include file="_pluginsTable.jspf" %>
  </c:if>

  <h2 class="noBorder">Bundled plugins</h2>
  <c:set var="plugins" value="${bundledPlugins}"/>
  <%@ include file="_pluginsTable.jspf" %>
</div>
