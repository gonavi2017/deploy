<%@ tag import="com.intellij.util.text.DateFormatUtil" %>
<%@ tag import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@attribute name="agent" required="true" rtexprvalue="true" type="jetbrains.buildServer.serverSide.SBuildAgent"
  %><%@attribute name="showRunningStatus" required="false" type="java.lang.Boolean"
  %><%@attribute name="showUnavailable" required="false" type="java.lang.Boolean"
  %><%@attribute name="showCommentsAsIcon" required="false" type="java.lang.Boolean"
  %><c:set var="disabledStatus"><c:if test="${not agent.enabled}"><span class="agent unavailable red-text" title="<c:out value="${!showCommentsAsIcon ? agent.statusComment.comment : ''}"/>">disabled<c:if test="${not empty showCommentsAsIcon && showCommentsAsIcon}"><bs:agentComment agent="${agent}"/></c:if></span></c:if></c:set>
<c:set var="disconnectedStatus"><c:if test="${showUnavailable and not agent.registered}"><span class="agent unavailable red-text">disconnected</span></c:if></c:set>
<c:set var="statusWarningText">${disabledStatus}<c:if test="${not empty disabledStatus and not empty disconnectedStatus}">, </c:if>${disconnectedStatus}</c:set>
<c:set var="runningBuild" value="${agent.runningBuild}"/>
<c:choose>
  <c:when test="${showRunningStatus}">(${statusWarningText}<c:if test="${not empty statusWarningText}">, </c:if><c:if test="${not empty agent.runningBuild}">now building, time left: <bs:printTime time="${agent.runningBuild.estimationForTimeLeft}"/></c:if><c:if test="${empty agent.runningBuild}" >idle<c:if test="${agent.outdated}" >, waiting for upgrade</c:if></c:if>)
  </c:when>
  <c:otherwise><c:if test="${not empty statusWarningText}">(${statusWarningText})</c:if></c:otherwise>
</c:choose>
