<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="afn" uri="/WEB-INF/functions/authz"
%><%@attribute name="queuedBuild" type="jetbrains.buildServer.serverSide.SQueuedBuild" required="false"
%><c:set var="buildEstimates" value="${queuedBuild.buildEstimates}"
/><c:if test="${not empty buildEstimates}">
  <%--@elvariable id="buildAgent" type="jetbrains.buildServer.serverSide.SBuildAgent"--%>
  <c:set var="buildAgent" value="${buildEstimates.agent}"
  /><c:set var="timeInterval" value="${buildEstimates.timeInterval}"
  /><c:set var="secondsToStart" value="${not empty timeInterval ? timeInterval.startPoint.relativeSeconds : 'null'}"
  /><c:set var="isNeverStarts" value="${(not empty timeInterval) and (timeInterval.startPoint.relativeSeconds > 10000 * 3600)}"/>

  BS.QueueEstimates._estimates['${queuedBuild.itemId}'] = {
    secondsToStart: ${isNeverStarts ? "'never'": secondsToStart},
    secondsToFinish: ${not empty timeInterval.endPoint ? timeInterval.endPoint.relativeSeconds : 'null'},
    isDelayed: ${buildEstimates.delayed},
    durationAsString: <c:choose
                      ><c:when test="${(not empty timeInterval) and (not empty timeInterval.endPoint)}"
                      >'<bs:printTime time="${timeInterval.durationSeconds}"/>',</c:when
                      ><c:otherwise>'???',</c:otherwise
                      ></c:choose>

    timeFrame: <c:choose
              ><c:when test="${empty timeInterval or isNeverStarts}"
              >'unknown',</c:when
              ><c:when test="${empty timeInterval.endPoint}"
              >'<bs:date value="${buildEstimates.timeInterval.startPoint.absoluteTime}" pattern="dd MMM yy HH:mm"/> - ???',</c:when
              ><c:otherwise
              >'<bs:interval from="${buildEstimates.timeInterval.startPoint.absoluteTime}" to="${buildEstimates.timeInterval.endPoint.absoluteTime}"/>',</c:otherwise
              ></c:choose>

    <c:set var="str" value=""
    /><c:if test="${(not empty buildAgent)}"
    ><c:set var="str"><bs:agentDetailsFullLink agent="${buildAgent}"/></c:set
    ></c:if>
    _agentLink: '<bs:escapeForJs text="${str}"/>',

    <c:set var="str" value=""
    /><c:if test="${(not empty timeInterval) and (buildEstimates.delayed) and (not empty buildAgent)}"
    ><c:set var="runningBuild" value="${buildAgent.runningBuild}"/><c:if
        test="${not empty runningBuild and afn:permissionGrantedForBuild(runningBuild, 'VIEW_PROJECT')}"
    ><c:set var="runningBuildType" value="${runningBuild.buildType}"/><c:if test="${not empty runningBuildType}"
    ><c:set var="str"><bs:resultsLink build="${runningBuild}" noPopup="true"><c:out value="${runningBuildType.fullName}"/></bs:resultsLink
  ><c:if test="${runningBuild.probablyHanging}"> (probably hanging)</c:if></c:set
    ></c:if></c:if></c:if>
    _buildLink: '<bs:escapeForJs text="${str}"/>',

    waitReason: <c:choose
      ><c:when test="${not empty buildEstimates and not empty buildEstimates.waitReason}"
      >'<bs:escapeForJs text="${buildEstimates.waitReason.description}"/>',</c:when
      ><c:otherwise
      >null,</c:otherwise
      ></c:choose>

    _f:null
  };
</c:if>