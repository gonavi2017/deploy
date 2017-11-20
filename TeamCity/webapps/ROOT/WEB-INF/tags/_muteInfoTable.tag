<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="muteInfo" type="jetbrains.buildServer.serverSide.mute.MuteInfo" required="true" %>
<%@ attribute name="isCurrentMuteInfo" type="java.lang.Boolean" required="true" %>
<%@ attribute name="currentMuteScopeDescription" type="java.lang.String" required="false" %>
<%@ attribute name="isCurrentlyMuted" type="java.lang.Boolean" required="false" %>

<table>
  <c:choose>
    <c:when test="${isCurrentMuteInfo}">
      <tr>
        <th>Currently muted in:</th>
        <td>${currentMuteScopeDescription}</td>
      </tr>
    </c:when>
    <c:otherwise>
      <tr>
        <th colspan="2">
          This failure was muted<c:if test="${empty isCurrentlyMuted}">, but currently it is not muted</c:if>
        </th>
      </tr>
    </c:otherwise>
  </c:choose>

  <c:if test="${not empty muteInfo.mutingUser}">
    <tr>
      <th>Muted by:</th>
      <td><c:out value="${muteInfo.mutingUser.descriptiveName}"/></td>
    </tr>
  </c:if>

  <tr>
    <th>Since:</th>
    <td><bs:date value="${muteInfo.mutingTime}"/></td>
  </tr>

  <c:set var="autoUnmute" value="${muteInfo.autoUnmuteOptions}"/>
  <c:if test="${isCurrentMuteInfo}">
    <tr>
      <th>Unmute:</th>
      <c:choose>
        <c:when test="${autoUnmute.unmuteManually}">
          <td>manually</td>
        </c:when>
        <c:when test="${autoUnmute.unmuteWhenFixed}">
          <td>automatically when fixed</td>
        </c:when>
        <c:when test="${not empty autoUnmute.unmuteByTime}">
          <td>automatically on <bs:date value="${autoUnmute.unmuteByTime}"/></td>
        </c:when>
      </c:choose>
    </tr>
  </c:if>

  <c:if test="${not empty muteInfo.mutingComment}">
    <tr>
      <th>Comment:</th>
      <td class="mute-comment"><bs:out value="${muteInfo.mutingComment}"/></td>
    </tr>
  </c:if>
</table>