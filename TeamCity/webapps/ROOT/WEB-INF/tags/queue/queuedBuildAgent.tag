<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="queue" tagdir="/WEB-INF/tags/queue"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@attribute name="queuedBuild" type="jetbrains.buildServer.serverSide.SQueuedBuild" required="true"
%><c:set var="itemId" value="${queuedBuild.itemId}" scope="request"
/><c:set var="canRunOn" value="${fn:length(queuedBuild.canRunOnAgents)}" scope="request"
/><c:set var="buildTypeId" value="${queuedBuild.buildTypeId}" scope="request"
/><c:if test="${queuedBuild.personal}"
  ><c:set var="buildTypeId" value="${queuedBuild.buildType.sourceBuildType.buildTypeId}" scope="request"
  /></c:if
><c:set var="agentRestrictor" value="${queuedBuild.agentRestrictor}" scope="request"
/><c:choose
  ><c:when test="${agentRestrictor != null}"
    ><jsp:include page="${agentRestrictor.jspPagePath}"
  /></c:when
  ><c:otherwise
  ><queue:queuedBuildAgentsPopup itemId="${itemId}" buildTypeId="${buildTypeId}"
  ><c:choose
    ><c:when test="${canRunOn == 0}"
    ><bs:compatibleAgentsLink queuedBuild="${queuedBuild}">No agents</bs:compatibleAgentsLink
    ></c:when
    ><c:otherwise
    ><bs:compatibleAgentsLink queuedBuild="${queuedBuild}">${canRunOn} agent<bs:s val="${canRunOn}"/></bs:compatibleAgentsLink
    ></c:otherwise
    ></c:choose
    ></queue:queuedBuildAgentsPopup
    ></c:otherwise
  ></c:choose>
