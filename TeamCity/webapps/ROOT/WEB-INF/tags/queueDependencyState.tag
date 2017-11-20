<%@ tag import="jetbrains.buildServer.serverSide.TimePoint" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
    %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
    %><%@ taglib prefix="queue" tagdir="/WEB-INF/tags/queue"%>
<%@attribute name="dependency" type="jetbrains.buildServer.serverSide.BuildPromotion" required="true" %>
<c:set var="neverInterval" value="<%= TimePoint.NEVER%>"/>
<c:set var="buildData" value="${dependency.associatedBuild}"/>
<c:set var="queuedBuild" value="${dependency.queuedBuild}"/>
<c:if test="${empty buildData}">
  <c:choose>
    <c:when test="${dependency.personal}"><span class="build-status-icon build-status-icon_personal-pending"></span></c:when>
    <c:otherwise><span class="build-status-icon build-status-icon_pending"></span></c:otherwise>
  </c:choose>
</c:if>
<c:if test="${not empty buildData}">
  <bs:buildDataIcon buildData="${buildData}"/>
</c:if>

<label for="bi${dependency.id}"><c:out value="${dependency.buildType.fullName}"/></label>

<c:if test="${not empty buildData}">
  <span class="separator">|</span>
  <c:set var="branch" value="${buildData.branch}"/>
  <c:if test="${not empty branch}">
    <span class="branch hasBranch ${branch.defaultBranch ? 'default' : ''}">
      <span class="branchName"><bs:trimBranch branch="${branch}"/></span>
    </span>
  </c:if>
  <bs:resultsLink build="${buildData}" noTitle="true" noPopup="true"><bs:buildNumber buildData="${buildData}"/></bs:resultsLink>
</c:if>

<div class="estimateDetails">
  <c:if test="${not empty buildData and not buildData.finished}">
    Completed: ${buildData.completedPercent}%
  </c:if>

  <c:if test="${not empty queuedBuild}">
    <c:set var="est" value="${queuedBuild.buildEstimates.timeInterval}"/>
    <c:if test="${not empty est and not empty est.startPoint}">
      <c:choose>
        <c:when test="${est.startPoint == neverInterval}">
          Will <bs:_viewQueued queuedBuild="${queuedBuild}">never start</bs:_viewQueued>
        </c:when>
        <c:otherwise>
          Time to start: <bs:_viewQueued queuedBuild="${queuedBuild}"><bs:printTime time="${est.startPoint.relativeSeconds}"/></bs:_viewQueued>
        </c:otherwise>
      </c:choose>
    </c:if>
  </c:if>
</div>
