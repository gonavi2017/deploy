<%@ tag import="jetbrains.buildServer.controllers.admin.healthStatus.HealthStatusTab" %><%@
    tag import="jetbrains.buildServer.serverSide.healthStatus.ItemSeverity" %><%@
    tag import="jetbrains.buildServer.web.openapi.healthStatus.HealthStatusItemDisplayMode" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %><%@
    taglib prefix="afn" uri="/WEB-INF/functions/authz" %><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %><%@
    taglib prefix="l" tagdir="/WEB-INF/tags/layout" %><%@
    attribute name="controlId" type="java.lang.String" required="true" %><%@
    attribute name="title" type="java.lang.String" required="false" %><%@
    attribute name="items" type="java.util.List" required="true" %><%@
    attribute name="project" required="true" type="jetbrains.buildServer.serverSide.SProject"

%><c:set var="error" value="<%=ItemSeverity.ERROR%>"
/><c:set var="warn" value="<%=ItemSeverity.WARN%>"
/><c:set var="popupId" value="pc_${controlId}Content"
/><c:set var="title"><c:out value="${empty title ? 'Server Health Items' : title}"/></c:set
><l:popupWithTitle id="${popupId}" title="${title}">
  <div class="inplaceItemsList">
    <c:forEach items="${items}" var="res" varStatus="pos">
      <%--@elvariable id="res" type="jetbrains.buildServer.serverSide.healthStatus.impl.HealthStatusItemEx"--%>
      <div class="inplaceHealthStatusItem ${pos.last ? 'last' : ''}">
        <c:set var="extensionType" scope="request" value="${res.extension.type}"/>
        <c:set var="healthStatusItem" scope="request" value="${res}"/>
        <c:set var="showMode" scope="request" value="<%=HealthStatusItemDisplayMode.IN_PLACE%>"/>
        <c:set var="healthStatusReportUrl" scope="request" value="<%=HealthStatusTab.URL%>"/>
        <bs:itemSeverity severity="${res.category.severity}" suggestion="${res.category.id == 'suggestion'}"/>
        <c:if test="${not res.severity.error and afn:permissionGrantedGlobally('CHANGE_SERVER_SETTINGS')}">
          <a href="#" class="hideLink" title="Hide the health report item for all of the users"
             onclick="return BS.AdminActions.hideHealthItemFromPopup('<bs:escapeForJs text="${extensionType}"/>', '<bs:escapeForJs text="${healthStatusItem.category.id}"/>', '<bs:escapeForJs text="${healthStatusItem.identity}"/>')">hide</a>
        </c:if>
        <jsp:include page="/showHealthStatusItem.html"/>
      </div>
    </c:forEach>
  </div>
  <c:if test="${afn:permissionGrantedForProject(project, 'EDIT_PROJECT')}">
    <div class="viewAll">
      <admin:healthStatusReportLink project="${project}">View all items for <strong><c:out value="${project.fullName}"/></strong> project &raquo;</admin:healthStatusReportLink>
    </div>
  </c:if>
</l:popupWithTitle>
<%--<div id="" class="popupDiv name-value-popup healthItemsPopup">--%>

<span id="pc_${controlId}"><jsp:doBody/></span>
<script type="text/javascript">
  var popup_${popupId} = new BS.Popup("${popupId}", {hideDelay: -1, delay: 0});
  $j('#pc_${controlId}').on("click", "div, i", function() {
    BS.Hider.hideAll();
    popup_${popupId}.showPopupNearElement(this);
  });
</script>
