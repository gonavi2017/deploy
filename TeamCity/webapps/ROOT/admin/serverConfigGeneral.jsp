<%--
Uncomment the following code, if the tabs are needed.
Currently there is just one tab, so its content is shown right here.

<%@ page import="jetbrains.buildServer.web.openapi.PlaceId" %>
<%@ taglib prefix="ext" tagdir="/WEB-INF/tags/ext" %>
<ext:showTabs placeId="<%=PlaceId.ADMIN_GLOBAL_SETTINGS_TAB%>"
              urlPrefix="/admin/admin.html?item=serverConfigGeneral"
              tabContainerId="tabsContainer4"/>
--%>

<jsp:include page="generalSettingsTab.jsp"/>
