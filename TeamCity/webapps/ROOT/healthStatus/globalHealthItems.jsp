<%@ page import="jetbrains.buildServer.controllers.admin.healthStatus.HealthStatusTab" %>
<%@ page import="jetbrains.buildServer.serverSide.healthStatus.ItemSeverity" %>
<%@ page import="jetbrains.buildServer.web.openapi.healthStatus.HealthStatusItemDisplayMode" %>
<%@ include file="/include-internal.jsp"%>
<jsp:useBean id="results" type="java.util.List" scope="request"/>
<c:set var="error" value="<%=ItemSeverity.ERROR%>"/>
<bs:refreshable containerId="globalHealthItems" pageUrl="${pageUrl}">
  <c:forEach items="${results}" var="res">
    <div class="icon_before icon16 ${res.severity.error ? 'attentionRed' : 'attentionComment'} clearfix">
      <c:if test="${not res.severity.error and afn:permissionGrantedGlobally('CHANGE_SERVER_SETTINGS')}">
        <a href="#" class="attentionDismiss"
           onclick="return BS.AdminActions.setHealthItemVisibility('${res.extension.type}', '<bs:escapeForJs text="${res.category.id}"/>', '<bs:escapeForJs text="${res.identity}"/>', false, function() { $('globalHealthItems').refresh(); })"
           onmouseover="BS.Tooltip.showMessageFromContainer(this, {}, 'popup_hid_<bs:escapeForJs text="${res.identity}"/>')" onmouseout="BS.Tooltip.hidePopup()">
          Hide
        </a>
        <div id="popup_hid_${res.identity}" class="grayNote" style="display: none">
          Click to hide this server health item.
          <div style="font-style: italic; white-space: nowrap">Hidden items can be viewed at <admin:healthStatusReportLink>Server Health</admin:healthStatusReportLink> page.</div>
        </div>
      </c:if>
      <c:set var="extensionType" scope="request" value="${res.extension.type}"/>
      <c:set var="healthStatusItem" scope="request" value="${res}"/>
      <c:set var="showMode" scope="request" value="<%=HealthStatusItemDisplayMode.IN_PLACE%>"/>
      <c:set var="healthStatusReportUrl" scope="request" value="<%=HealthStatusTab.URL%>"/>
      <div class="global-health-item__content"><jsp:include page="/showHealthStatusItem.html"/></div>
    </div>
  </c:forEach>
</bs:refreshable>
