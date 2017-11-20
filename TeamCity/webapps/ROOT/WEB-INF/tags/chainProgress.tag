<%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@
  attribute name="chainEstimates" type="jetbrains.buildServer.controllers.viewLog.ChainEstimatesBean"%>
<c:choose>
  <c:when test="${chainEstimates.available and chainEstimates.estimateTimeLeft > 0}">
    <c:set var="remaining">&nbsp;<bs:printTime time="${chainEstimates.estimateTimeLeft}"/>&nbsp;left</c:set>
    <div id="progress:${chainEstimates.promotionId}" class="progress long chain">${remaining}<div class="progressInner long  ${chainEstimates.isFailing ? 'progressInnerFailed' : 'progressInnerSuccessful'} " style="width: ${chainEstimates.completedPercent}%;">${remaining}</div></div>
    <script type="text/javascript">BS.QueuedBuilds.addTooltip('progress:${chainEstimates.promotionId}', '<bs:date value="${chainEstimates.started}"/>', '<bs:printTime time="${chainEstimates.timePassed}"/>', '<bs:printTime time="${chainEstimates.estimateTimeLeft}"/>');</script>
  </c:when>
  <c:when test="${chainEstimates.available and chainEstimates.estimateTimeLeft == 0}">
    <c:set var="overtime">&nbsp;overtime&nbsp;<bs:printTime time="${chainEstimates.durationOvertime}"/>&nbsp;</c:set>
    <div id="overtime:${chainEstimates.promotionId}" class="progress long chain"><div class="progressInner long  ${chainEstimates.isFailing ? 'progressInnerFailed' : 'progressInnerSuccessful'} " style="width: 100%;">${overtime}</div></div>
  </c:when>
  <c:otherwise>
    <c:out value="${chainEstimates.availabilityReason}"/>
  </c:otherwise>
</c:choose>
