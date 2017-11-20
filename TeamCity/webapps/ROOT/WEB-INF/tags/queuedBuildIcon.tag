<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@attribute name="queuedBuild" type="jetbrains.buildServer.serverSide.SQueuedBuild" required="true" %>
<c:set var="promotion" value="${queuedBuild.buildPromotion}"/>
<c:choose>
  <c:when test="${not promotion.personal}">
    <span class="icon build-status-icon build-status-icon_pending" title="Waiting in the queue"></span>
  </c:when>
  <c:when test="${promotion.personal}">
    <%--@elvariable id="currentUser" type="jetbrains.buildServer.users.SUser"--%>
    <c:set var="my" value="${promotion.owner == currentUser ? 'my' : 'personal'}"/>
    <c:set var="text">
      <bs:personalBuildPrefix buildPromotion="${promotion}"/> waiting in the queue
      <br/>Personal change:<bs:out resolverContext="${promotion}"> <bs:personalBuildComment buildPromotion="${promotion}"/> </bs:out>
    </c:set>
    <span class="icon build-status-icon build-status-icon_${my}-pending" <bs:tooltipAttrs text="${text}"/>></span>
  </c:when>
</c:choose>
