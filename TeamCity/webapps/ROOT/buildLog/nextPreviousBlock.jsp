<%@ include file="../include-internal.jsp" %>
<c:set var="encodedLogTab"><c:if test="${not empty logTab}"><c:out value="${logTab}"/></c:if></c:set>
<table class="logPaging">
  <tr>
    <td>
      <c:if test="${not empty previousBuild}">
        <c:set var="startDate"><bs:date value="${previousBuild.startDate}" pattern="dd MMM yy HH:mm" no_span="true"/></c:set>
        <bs:_viewLog build="${previousBuild}" title="Previous build || ${startDate}" tab="${extensionTab.tabId}" urlAddOn="&logTab=${encodedLogTab}"><strong>&laquo;</strong>
        <bs:buildDataIcon buildData="${previousBuild}" alt="Previous build || ${startDate}" simpleTitle="true"/> <bs:buildNumber buildData="${previousBuild}"/>
        </bs:_viewLog>
      </c:if>
      <c:if test="${empty previousBuild}">
        <p class="logPagingEmpty">First recorded build</p>
      </c:if>
    </td>
    <td style="padding: 0">
      <div class="separator">&nbsp;</div>
    </td>
    <td>
      <a href="<c:url value="/viewType.html?buildTypeId=${buildData.buildType.externalId}&tab=buildTypeHistoryList"/>">All history</a>
    </td>
    <td style="padding: 0">
      <div class="separator">&nbsp;</div>
    </td>
    <td>
      <c:if test="${not empty nextBuild}">
        <c:set var="startDate"><bs:date value="${nextBuild.startDate}" pattern="dd MMM yy HH:mm" no_span="true"/></c:set>
        <bs:_viewLog build="${nextBuild}" title="Next build || ${startDate}" tab="${extensionTab.tabId}" urlAddOn="&logTab=${encodedLogTab}">
          <bs:buildNumber buildData="${nextBuild}"/> <bs:buildDataIcon buildData="${nextBuild}" alt="Next build || ${startDate}" simpleTitle="true"/>
          <strong>&raquo;</strong></bs:_viewLog>
      </c:if>
      <c:if test="${empty nextBuild}">
        <p class="logPagingEmpty">Last recorded build</p>
      </c:if>
    </td>
  </tr>
</table>


