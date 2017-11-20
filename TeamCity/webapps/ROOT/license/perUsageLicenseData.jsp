<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%--@elvariable id="lastDeliveryStatus" type="jetbrains.buildServer.serverSide.impl.serverStatistics.DataDeliveryStatusBean"--%>
<%--@elvariable id="stats" type="java.util.Map<com.intellij.openapi.util.Pair<java.util.Date, java.util.Date>, java.util.Map<java.lang.String, java.lang.String>>"--%>
<style type="text/css">
.notDelivered {
  color: #888888;
}
</style>
<div>
  <div>
    <c:choose>
      <c:when test="${empty lastDeliveryStatus}">
        The server usage data has not been sent to JetBrains Account service yet.
      </c:when>
      <c:when test="${not empty lastDeliveryStatus and lastDeliveryStatus.successful}">
        The server usage data has been successfully sent to JetBrains Account service.
      </c:when>
      <c:when test="${not empty lastDeliveryStatus and not lastDeliveryStatus.successful}">
        Failed to send the server usage data to JetBrains Account service, error: <span class="error" style="margin-left: 0; display: inline"><c:out value="${lastDeliveryStatus.message}"/></span>
      </c:when>
    </c:choose>
    <c:if test="${not empty lastDeliveryStatus}">
      <br/>Last delivery time: <strong><tags:date value="${lastDeliveryStatus.deliveryTime}"/></strong>
      <c:if test="${not empty lastDeliveryStatus.nextDeliveryTime}"><br/>Next scheduled delivery time: <strong><tags:date value="${lastDeliveryStatus.nextDeliveryTime}"/></strong></c:if>
    </c:if>
  </div>

  <div>
    <a href="#" onclick="$j('#perUsageCollectedData').toggle()">Preview usage data for the last day&raquo;</a>
    <table class="settings" style="display: none; width: 50%" id="perUsageCollectedData">
      <tr>
        <th class="name">Time range</th>
        <th class="name">Maximum # of authorized agents</th>
      </tr>
      <c:forEach items="${stats}" var="stat">
        <c:set var="delivered" value="${not empty lastDeliveryStatus and lastDeliveryStatus.deliveredDataSinceTime ge stat.key.second.time}"/>
        <c:set var="className" value="${not delivered ? 'notDelivered' : 'delivered'}"/>
        <tr>
          <td style="white-space: nowrap;}" class="${className}"><tags:date value="${stat.key.first}"/> - <tags:date value="${stat.key.second}"/></td>
          <td class="${className}">${stat.value['agentsUsed']}</td>
        </tr>
      </c:forEach>
    </table>
  </div>
</div>