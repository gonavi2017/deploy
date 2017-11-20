<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="tt" tagdir="/WEB-INF/tags/tests"
  %><%@ taglib prefix="t" tagdir="/WEB-INF/tags/tags"
  %><%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz"
  %><%@attribute name="historyRecords" required="true" rtexprvalue="true" type="java.util.Collection"
  %><%@attribute name="updateFormId" required="true" rtexprvalue="true" type="java.lang.String"
  %><%@attribute name="showBuildTypes" required="false" rtexprvalue="true" type="java.lang.Boolean"
  %>

<jsp:useBean id="order" type="jetbrains.buildServer.controllers.TestHistoryOrder" scope="request"/>
<c:set var="statusStyle"><%=order.getStyleClass("TEST_STATUS")%></c:set>
<c:set var="changeStyle"><%=order.getStyleClass("CHANGE")%></c:set>
<c:set var="startDateStyle"><%=order.getStyleClass("START_DATE")%></c:set>
<c:set var="agentStyle"><%=order.getStyleClass("AGENT")%></c:set>
<c:set var="orderingComment"><%=order.getComment()%></c:set>
<c:set var="dX" value="15"/>

<c:if test="${empty historyRecords}">
  <p>No builds available</p>
</c:if>

<c:if test="${not empty historyRecords}">
  <div class="clr"></div>

  <c:set var="buildInfoWidth">
    <c:if test="${showBuildTypes}">4</c:if>
    <c:if test="${not showBuildTypes}">3</c:if>
  </c:set>

  <div class="successMessage" id="successMessage" style="display: none; background-color: #fff;">&nbsp;</div>
  <table class="testList historyList sortable dark borderBottom">
    <thead>
      <tr>
        <c:set var="tooltip"><bs:tooltipAttrs deltaX="${dX}" text="${orderingComment}"/></c:set>
        <th class="test-status thFirstCell sortable" id="H_TEST_STATUS">
          <span class="${statusStyle}" <c:if test="${not empty statusStyle}">${tooltip}</c:if> >Test status</span>
        </th>
        <th class="duration">Duration</th>
        <th class="emptyCell">&nbsp;</th>
        <th class="buildInfoHeader" colspan="${buildInfoWidth}">Build Info</th>
        <th class="sortable" id="H_CHANGE">
          <span class="${changeStyle}" <c:if test="${not empty changeStyle}">${tooltip}</c:if> >Changes</span>
        </th>
        <th class="sortable" id="H_START_DATE">
          <span class="${startDateStyle}" <c:if test="${not empty startDateStyle}">${tooltip}</c:if> >Started</span>
        </th>
        <th class="sortable" id="H_AGENT">
          <span class="${agentStyle}" <c:if test="${not empty agentStyle}">${tooltip}</c:if> >Agent</span>
        </th>
      </tr>
    </thead>

    <c:forEach var="test" items="${historyRecords}" varStatus="recordStatus">
      <c:set var="buildHistoryEntry" value="${test.build}"/>
      <%--@elvariable id="test" type="jetbrains.buildServer.serverSide.STestRun"--%>

      <c:set var="buildId" value="${buildHistoryEntry.buildId}"/>
      <c:set var="rowClass" value="${not empty buildHistoryEntry.canceledInfo ? 'cancelledBuild' : ''}"/>
      <c:set var="rowClass" value="${rowClass} ${buildHistoryEntry.outOfChangesSequence ? 'outOfSequence ' : ''}"/>
      <c:set var="rowClass" value="${rowClass} ${buildHistoryEntry.internalError ? 'internalError ' : ''}"/>

      <c:choose>
        <c:when test="${test.muted}">
          <c:url var="testIconClasses" value="icon icon16 bp muted red"/>
        </c:when>
        <c:when test="${test.status.failed}">
          <c:url var="testIconClasses" value="icon icon16 bp"/>
        </c:when>
        <c:when test="${test.status.ignored}">
          <c:url var="testIconClasses" value="build-status-icon build-status-icon_cancelled"/>
        </c:when>
        <c:otherwise>
          <c:url var="testIconClasses" value="build-status-icon build-status-icon_success-small"/>
        </c:otherwise>
      </c:choose>

      <tr>
        <td class="test-status">
          <c:set var="tooltip" value=""/>
          <c:if test="${test.muted}">
            <c:set var="tooltip"><bs:muteInfoTooltip testRun="${test}" test="${test.test}"/></c:set>
          </c:if>
          <span class="${testIconClasses}" <c:if test="${not empty tooltip}"><bs:tooltipAttrs text="${tooltip}"/></c:if>></span>
          <tt:testStatus testRun="${test}"/>
        </td>
        <td class="duration" style="${test.status.failed ? 'color:red' : ''}">
          <bs:millis value="${test.duration}"/>
        </td>

        <td style="border:none;"></td>

        <c:if test="${showBuildTypes}"><td><bs:buildTypeLinkFull buildType="${buildHistoryEntry.buildType}"/></td></c:if>
        <bs:buildRow build="${buildHistoryEntry}" rowClass="${rowClass}"
                     showBranchName="true"
                     showBuildNumber="true"
                     showStatus="true"
                     showChanges="true"
                     showStartDate="true"
                     showAgent="true"/>
      </tr>
    </c:forEach>
  </table>

  <script type="text/javascript">
    (function() {
      function resort(code) {
        var form = document.forms['${updateFormId}'];
        var postfix = "<%=order.name()%>".startsWith(code) ? "<%=order.name().endsWith("ASC") ? "_DESC" : "_ASC"%>" : "_DESC";
        form.order.value = code+postfix;
        var queryParams = location.search.toQueryParams();
        if (queryParams.buildTypeId) {
          delete form.projectId.value;
          form.buildTypeId.value = queryParams.buildTypeId;
        } else if (queryParams.projectId) {
          form.projectId.value = queryParams.projectId;
          delete form.buildTypeId.value;
        }

        form.submit();
      }

      function install_resort(code) {
        var el = $('H_' + code);
        if (el) {
          el.on("click", function() { resort(code) });
        }
      }

      install_resort('TEST_STATUS');
      install_resort('CHANGE');
      install_resort('START_DATE');
      install_resort('AGENT');
    })();
  </script>
</c:if>
