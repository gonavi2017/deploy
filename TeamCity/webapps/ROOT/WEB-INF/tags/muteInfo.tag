<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>

<%@ attribute name="currentMuteInfo" type="jetbrains.buildServer.serverSide.mute.CurrentMuteInfo" required="true" %>
<%@ attribute name="buildMuteInfo" type="jetbrains.buildServer.serverSide.mute.MuteInfo" required="true" %>
<%@ attribute name="project" type="jetbrains.buildServer.serverSide.SProject" required="true" %>

<div class="name-value">
  <c:if test="${not empty buildMuteInfo}">
    <c:choose>
      <c:when test="${empty currentMuteInfo}">
        <bs:_muteInfoTable muteInfo="${buildMuteInfo}" isCurrentMuteInfo="false" isCurrentlyMuted="true"/>
      </c:when>
      <c:otherwise>
        <table class="mutePopup">
          <tr>
            <td>This failure was muted</td>
          </tr>
        </table>
      </c:otherwise>
    </c:choose>
  </c:if>

  <c:if test="${not empty currentMuteInfo}">
    <c:forEach items="${currentMuteInfo.projectsMuteInfo}" var="entry">
      <c:set var="description"><bs:projectLinkFull project="${entry.key}"/></c:set>
      <bs:_muteInfoTable muteInfo="${entry.value}" isCurrentMuteInfo="true" currentMuteScopeDescription="${description}"/>
    </c:forEach>

    <c:if test="${not empty currentMuteInfo.buildTypeMuteInfo}">
      <c:forEach items="${currentMuteInfo.muteInfoGroups}" var="entry">
        <c:set var="btMuteInfo" value="${entry.key}"/>
        <c:set var="description"></c:set>

        <c:forEach items="${entry.value}" var="bt" varStatus="status">
          <c:set var="description">${description} <bs:buildTypeLinkFull buildType="${bt}"/><c:if test="${not status.last}">, </c:if></c:set>
        </c:forEach>

        <bs:_muteInfoTable muteInfo="${btMuteInfo}" isCurrentMuteInfo="true" currentMuteScopeDescription="${description}"/>
      </c:forEach>
    </c:if>
  </c:if>
</div>