<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ attribute name="muteInfo" type="jetbrains.buildServer.serverSide.mute.MuteInfo" required="true"
              description="Main mute info to show information about" %>
<%@ attribute name="currentMuteInfo" type="jetbrains.buildServer.serverSide.mute.CurrentMuteInfo" required="true"
              description="Current mute state which may differ from requested one." %>

<c:if test="${not empty muteInfo}">
  &mdash; Muted by <b><c:out value="${muteInfo.mutingUser.descriptiveName}"/></b> <bs:date value="${muteInfo.mutingTime}" smart="true"/>
  <c:if test="${not empty muteInfo.mutingComment}">
    with comment: <i><bs:out value="${muteInfo.mutingComment}"/></i>
  </c:if>
</c:if>
<c:if test="${empty muteInfo}">
  &mdash; was muted
</c:if>

<%-- Here go details about current mute info, if it differs from the shown --%>
<c:choose>
  <c:when test="${empty currentMuteInfo or (empty currentMuteInfo.projectsMuteInfo and empty currentMuteInfo.buildTypeMuteInfo)}">(currently not muted)</c:when>

  <c:when test="${fn:length(currentMuteInfo.projectsMuteInfo) == 1 and empty currentMuteInfo.buildTypeMuteInfo}">
    <c:set var="currInfo" value="${currentMuteInfo.projectMuteInfo}"/>
    <c:choose>
      <c:when test="${empty muteInfo or currInfo.mutingUser ne muteInfo.mutingUser}">
        (currently muted by <b><c:out value="${currInfo.mutingUser.descriptiveName}"/></b> <bs:date value="${currInfo.mutingTime}" smart="true"/>
        <c:if test="${not empty currInfo.mutingComment}">
          with comment: <i><bs:out value="${currInfo.mutingComment}"/></i>
        </c:if>)
      </c:when>

      <c:when test="${not empty currInfo.mutingComment and currInfo.mutingComment ne muteInfo.mutingComment}">
        (currently muted <bs:date value="${currInfo.mutingTime}" smart="true"/>
        with comment: <i><bs:out value="${currInfo.mutingComment}"/></i>)
      </c:when>
    </c:choose>
  </c:when>

  <c:otherwise>(current mute info differs, use mute icon popup to see all details)</c:otherwise>
</c:choose>