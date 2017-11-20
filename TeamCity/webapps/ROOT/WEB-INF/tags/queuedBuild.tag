<%@ tag import="jetbrains.buildServer.serverSide.TimePoint" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags/tags" %><%@
    taglib prefix="q" tagdir="/WEB-INF/tags/queue" %><%@
    attribute name="queuedBuild" type="jetbrains.buildServer.serverSide.SQueuedBuild" %><%@
    attribute name="showBuildType" type="java.lang.Boolean"%><%@
    attribute name="showBranches" type="java.lang.Boolean"%><%@
    attribute name="showNumber" type="java.lang.Boolean"%><%@
    attribute name="hideNumberPopup" type="java.lang.Boolean"%><%@
    attribute name="estimateColspan" type="java.lang.Integer"%><%@
    attribute name="hideIcon" type="java.lang.Boolean"
    %><c:set var="neverInterval" value="<%= TimePoint.NEVER%>"

    /><bs:linkCSS>/css/buildQueue.css</bs:linkCSS>
<c:if test="${empty hideIcon}">
  <c:set var="hideIcon" value="false"/>
</c:if>
<c:if test="${empty estimateColspan || estimateColspan==0}">
  <c:set var="estimateColspan" value="1"/>
</c:if>
<c:if test="${not empty queuedBuild}">
  <c:set var="promotion" value="${queuedBuild.buildPromotion}"/>
  <c:set var="promoId" value="${promotion.id}"/>
  <c:set var="branch" value="${promotion.branch}"/>
  <c:if test="${showBuildType}">
    <td class="buildTypeName">
      <bs:buildTypeLinkFull buildType="${queuedBuild.buildType}"/>
    </td>
  </c:if>
  <c:if test="${showBranches}">
    <td class="branch ${not empty branch ? 'hasBranch' : ''} ${not empty branch and branch.defaultBranch ? 'default' : ''}">
      <bs:branchLink branch="${branch}" buildPromotion="${promotion}"><bs:trimBranch branch="${branch}"/></bs:branchLink>
      <script type="text/javascript">$j("#changeblock${promoId}").parents(".promotions").addClass("hasBranches");</script>
    </td>
  </c:if>
  <c:if test="${showNumber}">
    <td class="buildNumber">
      <c:set var="number">${queuedBuild.orderNumber}<tags:favoriteBuildAuth buildPromotion="${queuedBuild.buildPromotion}">
        <tags:favoriteBuild buildPromotion="${queuedBuild.buildPromotion}" showOnlyIfFavorite="true"/>
      </tags:favoriteBuildAuth>
      </c:set>
      <span class="label">order:&nbsp;</span>
      <c:if test="${!hideNumberPopup}">
        <q:queueLink queuedBuild="${queuedBuild}">${number}</q:queueLink>
      </c:if>
      <c:if test="${hideNumberPopup}">
        ${number}
      </c:if>
    </td>
  </c:if>
  <td colspan="${estimateColspan}" class="estimate">
    <bs:queuedBuildIcon queuedBuild="${queuedBuild}"/>
    <c:set var="estimates" value="${queuedBuild.buildEstimates}"/>
    <c:choose>
      <c:when test="${not empty estimates}">
        <c:set var="estimatedStart"><c:if test="${not empty estimates.timeInterval && estimates.timeInterval.startPoint != neverInterval}">
          ${estimates.timeInterval.startPoint.relativeSeconds > 0 ? "Will start" : "Should have started"}
          <bs:date value="${estimates.timeInterval.startPoint.absoluteTime}" smart="true"/>
          ${estimates.delayed ? "<em>(delayed)</em>" : ""}
        </c:if>
        </c:set>
        <q:queueLink queuedBuild="${queuedBuild}">${not empty estimatedStart? estimatedStart : 'Start time unknown'}</q:queueLink>
        <em>${not empty estimates.waitReason ? estimates.waitReason.description : ""}</em>
      </c:when>
      <c:otherwise>
        <q:queueLink queuedBuild="${queuedBuild}">No estimate yet</q:queueLink>
      </c:otherwise>
    </c:choose>
  </td>
</c:if>



