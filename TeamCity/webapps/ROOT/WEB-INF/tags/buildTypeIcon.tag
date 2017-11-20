<%@ tag import="jetbrains.buildServer.util.StringUtil" %>
<%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="resp" uri="/WEB-INF/functions/resp" %><%@

    attribute name="buildType" rtexprvalue="true" type="jetbrains.buildServer.serverSide.SBuildType" %><%@
    attribute name="style" %><%@
    attribute name="ignorePause" %><%@
    attribute name="simpleTitle" type="java.lang.Boolean"

%><c:set var="buildTypeStatus" value="${buildType.status}"/><c:choose
  ><c:when test="${buildType.paused && empty ignorePause}"
    ><c:set var="icon_class" value="build-status-icon build-status-icon_paused"
    /><c:set var="text"><bs:pauseCommentText buildType="${buildType}" forTooltip="true"/></c:set
    ><c:set var="icon_text" value="${text}"
 /></c:when
    ><c:when test="${buildTypeStatus.successful}"
      ><c:set var="icon_class" value="build-status-icon build-status-icon_successful"
    /><c:set var="icon_text" value="Build configuration is successful"
 /></c:when
  ><c:when test="${buildTypeStatus.failed}"
    ><c:set var="icon_class" value="build-status-icon build-status-icon_failed"
/><c:set var="icon_text" value="Build configuration is failing"
    /><c:set var="responsibility" value="${buildType.responsibilityInfo}"

    /><c:set var="comment"
    /><c:if test="${resp:hasComment(responsibility) and not simpleTitle}"
      ><c:set var="comment"><br/>Comment: <i><bs:out value="${responsibility.comment}"/></i></c:set
    ></c:if
    ><c:if test="${resp:hasReporter(responsibility) and resp:isActive(responsibility) and not simpleTitle}"
      ><c:set var="time"><%=StringUtil.elapsedTimeToString(buildType.getResponsibilityInfo().getTimestamp())%></c:set
      ><c:set var="comment">${comment}<br/>Assigned by ${responsibility.reporterUser.descriptiveName} ${time}</c:set
    ></c:if
    ><c:if test="${resp:hasComment(responsibility) and simpleTitle}"
      ><c:set var="comment">, comment: <bs:out value="${responsibility.comment}"/></c:set
    ></c:if
    ><c:if test="${resp:isActive(responsibility)}"
      ><c:set var="icon_class" value="icon icon16 bp taken"
/><c:set var="icon_text"><c:out value="${responsibility.responsibleUser.descriptiveName}"/> is assigned to investigate the build configuration<bs:_whoSetResponsibility respInfo="${responsibility}" doNotUseAssigned="true"/>${comment}</c:set
    ></c:if
    ><c:if test="${resp:isFixed(responsibility)}"
      ><c:set var="icon_class" value="build-status-icon build-status-icon_fixed-test-resp"
/><c:set var="icon_text"><c:out value="${responsibility.responsibleUser.descriptiveName}"/> marked as fixed<bs:_whoSetResponsibility respInfo="${responsibility}"/>${comment}</c:set
    ></c:if
  ></c:when
  ><c:otherwise
    ><c:set var="icon_class" value="build-status-icon build-status-icon_gray"
/><c:set var="icon_text" value="Unknown status"
 /></c:otherwise
></c:choose

><span class="${icon_class}" style="${style}" <bs:tooltipAttrs text="${icon_text}" useHtmlTitle="${simpleTitle}"/>></span>