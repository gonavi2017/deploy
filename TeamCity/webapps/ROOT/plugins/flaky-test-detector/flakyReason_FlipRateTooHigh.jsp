<%-- referenced from flakyReasons.jspf --%>
<%@ include file="/include.jsp"%>

<%--@elvariable id="flakyReason" type="jetbrains.buildServer.serverSide.flakyTestDetector.opendata.FlipRateTooHigh"--%>

<c:set var="flipRate" value="${flakyReason.flipRate}"/>
<c:set var="flipRateText">Frequent test status changes:
  <span class="counter">${flipRate.flipCount}</span>
  <bs:plural txt="${flipRate.eventName}" val="${flipRate.flipCount}"/> out of
  <span class="counter">${flipRate.invocationCount}</span>
  <bs:plural txt="invocation" val="${flipRate.invocationCount}"/>
</c:set>
<c:set var="buildTypeId" value="${flipRate.buildTypeId}"/>
<c:choose>

  <c:when test="${not empty buildTypeId}">
    ${flipRateText} in <%@ include file="buildTypeLinkFull.jspf"%>
  </c:when>

  <c:otherwise>
    <%-- Never --%>
    ${flipRateText}
  </c:otherwise>

</c:choose>
