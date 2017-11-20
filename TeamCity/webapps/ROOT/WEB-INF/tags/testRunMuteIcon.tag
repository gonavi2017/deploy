<%@ taglib prefix="util" uri="/WEB-INF/functions/util" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ attribute name="testRun" type="jetbrains.buildServer.serverSide.TestRunEx" required="true" %>
<%@ attribute name="test" type="jetbrains.buildServer.serverSide.STest" %>
<%@ attribute name="btScope" type="jetbrains.buildServer.serverSide.SBuildType" required="false" %>
<%@ attribute name="ignoreMuteScope" type="java.lang.Boolean" required="false" %>
<%@ attribute name="showMuteFromTestRun" type="java.lang.Boolean" required="false" %>
<%@ attribute name="showNew" type="java.lang.Boolean" required="false" %>
<%@ variable name-given="shownNewMute" variable-class="java.lang.Boolean" scope="AT_END"%>
<c:set var="shownNewMute" value="${false}"/>
<c:set var="test" value="${not empty test ? test : not empty testRun ? testRun.test : null}"/>
<%--@elvariable id="test" type="jetbrains.buildServer.serverSide.STest"--%>
<c:if test="${not empty test}">
  <c:set var="currentMuteInfo" value="${test.currentMuteInfo}"/>
  <c:set var="showCurrentMuteInfo" value="${util:shouldShowCurrentMuteInfo(currentMuteInfo, ignoreMuteScope, btScope)}"/>
  <c:set var="showBuildMuteInfo" value="${showMuteFromTestRun and not empty testRun and testRun.muted}" />
  <c:if test="${showCurrentMuteInfo or showBuildMuteInfo}">
    <c:if test="${showNew}"><c:set var="newIconClass" value="new"/><c:set var="shownNewMute" value="${true}"/></c:if>
    <c:set var="tooltip">
      <bs:muteInfoTooltip test="${showCurrentMuteInfo ? test : null}" testRun="${showBuildMuteInfo ? testRun : null}" showActions="true"/>
    </c:set>
    <span class="icon icon16 bp muted ${newIconClass}" <bs:tooltipAttrs text="${tooltip}" className="name-value-popup"/>></span>
  </c:if>
</c:if>
