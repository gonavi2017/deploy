<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="queue" tagdir="/WEB-INF/tags/queue"
%><%@attribute name="buildQueue" type="jetbrains.buildServer.controllers.queue.BuildQueueForm" required="false"
%><%@attribute name="queuedBuild" type="jetbrains.buildServer.serverSide.SQueuedBuild" required="false"
%><script type="text/javascript">
  <bs:executeOnce id="queueEstimates">
  BS.QueueEstimates._estimates = {};
  </bs:executeOnce>
<c:choose
><c:when test="${not empty buildQueue}"
><c:forEach var="queuedBuild" items="${buildQueue.items}"><queue:_queuedBuildEstimate queuedBuild="${queuedBuild}"/></c:forEach
></c:when
><c:otherwise
><queue:_queuedBuildEstimate queuedBuild="${queuedBuild}"
/></c:otherwise
></c:choose>
</script>  
