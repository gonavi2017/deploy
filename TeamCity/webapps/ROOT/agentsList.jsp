<%@ include file="include-internal.jsp" %>
<%@ page import="jetbrains.buildServer.web.openapi.PlaceId" %>
<bs:refreshable containerId="agentsList" pageUrl="${pageUrl}">

<script type="text/javascript">
  (function() {
    if (BS.agentsTabPane instanceof TabbedPane) {
      BS.agentsTabPane.clearTabs();
    } else {
      BS.agentsTabPane = new TabbedPane();
    }
    <ext:forEachTab placeId="<%=PlaceId.AGENTS_TAB%>">
    // plugin ${extension.tabId}:
    BS.agentsTabPane.addTab('${extension.tabId}', {
      caption: '<bs:forJs>${extension.tabTitle}</bs:forJs>',
      url : '<c:url value="/agents.html?tab=${extension.tabId}"/>'
    });
    </ext:forEachTab>
    BS.agentsTabPane.showIn('tabsContainer3');
    BS.agentsTabPane.setActiveCaption('${myCustomTab.tabId}');
  })();
</script>

<ext:includeExtension extension="${myCustomTab}"/>

</bs:refreshable>

<l:popupWithTitle id="installAgents" title="Install Build Agents">
  <%@ include file="installLinks.jspf" %>
</l:popupWithTitle>

