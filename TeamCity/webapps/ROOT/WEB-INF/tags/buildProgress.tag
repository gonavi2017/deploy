<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@
    attribute name="buildData" required="true" rtexprvalue="true" type="jetbrains.buildServer.serverSide.SBuild" %><%@
    attribute name="classname" required="false" type="java.lang.String" %><%@
    attribute name="showOvertimeIcon" required="false" type="java.lang.Boolean" %><%@
    attribute name="installPopup" required="false" type="java.lang.Boolean"

%><c:if test="${not empty buildData.agent}"><p class="hidden" id="aLink:${buildData.buildId}"><bs:agentDetailsFullLink agent="${buildData.agent}"/></p></c:if><div class="progress_holder" id="build:${buildData.buildId}">
<c:if test="${buildData.finished}"
    ><bs:date value="${buildData.finishDate}" smart="true" no_smart_title="true"
   /> <bs:duration buildData="${buildData}"
/></c:if
 ><c:if test="${not buildData.finished}"
    ><c:set var="remainingTime" value="${buildData.estimationForTimeLeft}"
    /><c:if test="${remainingTime < 0}"
      ><div id="build:${buildData.buildId}:progress">
        <bs:date value="${buildData.startDate}"
      /> <bs:duration buildData="${buildData}"
      /></div></c:if
    ><c:if test="${remainingTime >= 0}"
      ><c:set var="elapsedTime" value="${buildData.elapsedTime}"
      /><c:set var="overtimeTime" value="${buildData.durationOvertime}"
      /><%-- The following logic should be repeated in runningBuilds.js:
      --%><c:set var="shouldShowOvertimeIcon" value="${overtimeTime > 60 and overtimeTime > elapsedTime * 0.01}"
      /><c:set var="shouldShowOvertimeInBar" value="${shouldShowOvertimeIcon and remainingTime < elapsedTime * 0.1}"
      /><c:set var="showTimeLeft" value="${remainingTime > 60 or not shouldShowOvertimeInBar}"
      /><c:set var="remaining"><bs:printTime time="${remainingTime}"/></c:set
      ><c:set var="overtime"><bs:printTime time="${overtimeTime}"/></c:set
      ><c:set var="totalEstimateText"><bs:printTime time="${buildData.durationEstimate}"/></c:set
      ><c:set var="progressText">&nbsp;&nbsp;<c:choose><c:when test="${shouldShowOvertimeInBar}">overtime:&nbsp;<c:out value="${fn:replace(overtime, ' ', '&nbsp;')}"
        /></c:when><c:otherwise>${fn:replace(remaining, ' ', '&nbsp;')}&nbsp;left</c:otherwise></c:choose></c:set
      ><div class="progress ${classname}" id="build:${buildData.buildId}:progress">${progressText}<bs:progress classname="${classname}" buildData="${buildData}">${progressText}</bs:progress
      ></div><c:if test="${(empty showOvertimeIcon or showOvertimeIcon)}"><span class="progressOvertime icon icon16 yellowTriangle" id="build:${buildData.buildId}:overtime_icon" style="display: ${shouldShowOvertimeIcon ? 'inline-block' : 'none'}"></span></c:if
      ><div class="hidden start_date"><bs:date value="${buildData.startDate}"/></div
      ><c:if test="${installPopup}"
        ><c:set var="elapsed"><bs:printTime time="${elapsedTime}"/></c:set
        ><script type="text/javascript">BS.RunningBuilds.doUpdateProgress(${buildData.buildId}, false, '<bs:escapeForJs text="${elapsed}"/>', '<bs:escapeForJs text="${totalEstimateText}"/>', '<bs:escapeForJs text="${remaining}"/>', '<bs:escapeForJs text="${overtime}"/>', ${shouldShowOvertimeIcon}, ${shouldShowOvertimeInBar}, '${showTimeLeft}');</script></c:if
    ></c:if
></c:if></div>