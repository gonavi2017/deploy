<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="afn" uri="/WEB-INF/functions/authz"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz"
  %><%@ attribute name="build" fragment="false" required="true" type="jetbrains.buildServer.serverSide.SRunningBuild"
  %><%@ attribute name="message" fragment="false" required="false" type="java.lang.String"%>
<span id="stopBuild:${build.buildPromotion.id}" style="white-space: nowrap;">
  <c:set var="stopMessageContainer" value="null"/>
  <c:set var="actualStopFailedTitle">TeamCity cannot stop this build. Please log in to the build agent ${build.agentName} and resolve the situation manually.</c:set>
  <c:set var="actualStopStatus">
    <c:choose>
      <c:when test="${build.interrupted and not build.canceledInfo.outdated}"><span class="stopping">Stopping</span></c:when>
      <c:when test="${build.interrupted and build.canceledInfo.outdated}"><span class="stopping" title="${actualStopFailedTitle}">Cannot stop</span></c:when>
    </c:choose>
  </c:set>
  <c:set var="stopMessage" value="${message}"/>
  <c:if test="${build.interrupted and (not empty build.canceledInfo) and (not empty build.canceledInfo)}">
    <c:if test="${not empty build.canceledInfo.comment}">
      <c:set var="stopMessage" value="${build.canceledInfo.comment}"/>
      <c:set var="stopMessageContainer" value="'stopBuild:${build.buildPromotion.id}:message'"/>
    </c:if>
    <span id="${stopMessageContainer}" style="display: none;">
      This build has already been stopped
      <c:choose>
        <c:when test="${currentUser.id eq build.canceledInfo.userId}">by <em>you</em></c:when>
        <c:when test="${not empty build.canceledInfo.userId}">by <em><bs:userName server="${serverTC}" userId="${build.canceledInfo.userId}"/></em></c:when>
      </c:choose>
      <c:if test="${not empty build.canceledInfo.comment}">
        with message <em><c:out value="${stopMessage}"/></em>
      </c:if>
    </span>
  </c:if>
  <c:set var="actualStopMessage"><bs:escapeForJs text="${not empty stopMessage ? stopMessage : ''}"/></c:set>
  <c:set var="actualStopTitle">Stop build on <c:out value="${build.agent.name}"/></c:set>

  <c:set var="stopLinkClass">
    <c:choose>
      <c:when test="${not build.interrupted}">actionLink</c:when>
      <c:otherwise>actionLink stopping</c:otherwise>
    </c:choose>
  </c:set>

  <bs:canStopBuild build="${build}">
    <jsp:attribute name="ifAccessGranted">
      <a id="stopBuild:${build.buildPromotion.id}:link" href="#" onclick="BS.StopBuildDialog.showStopBuildDialog([${build.buildPromotion.id}], '${actualStopMessage}', 2, ${stopMessageContainer}); return false" class="${stopLinkClass}">
        <c:choose>
          <c:when test="${not build.interrupted}"><span title="${actualStopTitle}">Stop</span></c:when>
          <c:otherwise>${actualStopStatus}</c:otherwise>
        </c:choose>
      </a>
    </jsp:attribute>
    <jsp:attribute name="ifAccessDenied">
      <c:choose>
        <c:when test="${not build.interrupted}"><span class="hidden">.</span></c:when>
        <c:otherwise>${actualStopStatus}</c:otherwise>
      </c:choose>
    </jsp:attribute>
  </bs:canStopBuild>
</span>