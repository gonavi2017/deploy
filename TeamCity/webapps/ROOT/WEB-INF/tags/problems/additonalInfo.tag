<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="problems" tagdir="/WEB-INF/tags/problems" %>
<%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="resp" tagdir="/WEB-INF/tags/responsible"%>
<%@ attribute name="currentBuildProblemBean" type="jetbrains.buildServer.web.problems.BuildTypeBuildProblemsBean" required="false" %>
<%@ attribute name="buildProblem" type="jetbrains.buildServer.serverSide.problems.BuildProblem" required="true" %>
<%@ attribute name="compactMode" type="java.lang.Boolean" required="true" %>
<%@ attribute name="inlineMuteInfo" type="java.lang.Boolean" required="true" %>
<%@ attribute name="inlineResponsibilty" type="java.lang.Boolean" required="true" %>
<c:if test="${empty inlineMuteInfo}">
  <c:set var="inlineMuteInfo" value="${false}"/>
</c:if>
<c:if test="${empty inlineResponsibilty}">
  <c:set var="inlineResponsibilty" value="${false}"/>
</c:if>
<c:if test="${!compactMode && ((not empty currentBuildProblemBean && not empty currentBuildProblemBean.currentBuildProblems[buildProblem.id]) || inlineResponsibilty || inlineMuteInfo)}">
  <div class="additionalInfo testFailedInPart single">
    <c:if test="${inlineMuteInfo && not empty buildProblem.muteInBuildInfo}">
      <bs:inlineMuteInfo muteInfo="${buildProblem.muteInBuildInfo}" currentMuteInfo="${buildProblem.currentMuteInfo}"/>
    </c:if>
    <c:if test="${not empty currentBuildProblemBean && not empty currentBuildProblemBean.currentBuildProblems[buildProblem.id]}">
      <div class="buildTypes noBorder">
        <c:set var="cbp" value="${currentBuildProblemBean.currentBuildProblems[buildProblem.id]}"/>
        <problems:currentProblem currentProblem="${cbp}"
                                 currentBuildType="${currentBuildProblemBean.buildType}"/>
      </div>
    </c:if>
  </div>
</c:if>

