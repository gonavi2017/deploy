<%@ tag import="jetbrains.buildServer.serverSide.impl.problems.BuildProblemImpl" %>
<%@ tag import="jetbrains.buildServer.web.functions.MuteWebUtil" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="problems" tagdir="/WEB-INF/tags/problems" %>

<%@ attribute name="buildProblem" type="jetbrains.buildServer.serverSide.problems.BuildProblem" required="true" %>
<%@ attribute name="showBuildSpecificInfo" type="java.lang.Boolean" required="false" %>
<%@ attribute name="currentMuteInfo" type="jetbrains.buildServer.serverSide.mute.CurrentMuteInfo" required="true" %>
<c:set var="muteInBuildInfo" value="${buildProblem.muteInBuildInfo}"
/><c:set var="project" value="${buildProblem.buildPromotion.buildType.project}"
/><c:set var="showCurrentMuteInfo" value="<%=MuteWebUtil.shouldShowCurrentMuteInfo(currentMuteInfo, false, buildProblem.getBuildPromotion().getBuildType())%>"
/><c:set var="isNew" value="<%=Boolean.TRUE.equals(((BuildProblemImpl)buildProblem).isNew())%>"
/><c:set var="responsibility" value="${buildProblem.responsibility}"
/><c:set var="errorClass" value="icon icon16 bp"
/><c:set var="tooltip" value=""

/><c:if test="<%=jetbrains.buildServer.messages.ErrorData.isInternalError(buildProblem.getBuildProblemData().getType())%>"
  ><c:set var="errorClass" value="${errorClass} internal"
/></c:if

><c:if test="${not empty responsibility}"
  ><c:set var="title"
    ><c:forEach var="entry" items="${buildProblem.allResponsibilities}"
      ><bs:responsibilityInfo responsibility="${entry}" respProject="${entry.project}"
    /></c:forEach

    ><problems:buildProblemInvestigationLinks buildProblem="${buildProblem}" responsibility="${responsibility}" showFixLink="true"
  /></c:set>
  <c:set var="tooltip"><bs:tooltipAttrs text="${title}" className="name-value-popup"/></c:set>
  <c:if test="${responsibility.state.fixed}">
    <c:set var="errorClass" value="${errorClass} fixed"/>
  </c:if>
  <c:if test="${responsibility.state.active}">
    <c:set var="errorClass" value="${errorClass} taken"/>
  </c:if>
</c:if>
<c:if test="${showBuildSpecificInfo && isNew}">
  <c:set var="errorClass" value="${errorClass} new"/>
</c:if

><span class="${errorClass}" ${tooltip}></span><c:set var="muteInBuildInfo" value="${buildProblem.muteInBuildInfo}"

/><c:choose
  ><c:when test="${showCurrentMuteInfo}"
    ><c:set var="muteClass" value="bp muted"
    /><c:set var="muteInfo"
      ><bs:muteInfo currentMuteInfo="${currentMuteInfo}" buildMuteInfo="${null}" project="${project}"
    /></c:set
  ></c:when
  ><c:when test="${buildProblem.mutedInBuild and showBuildSpecificInfo}"
    ><c:set var="muteClass" value="bp muted red"
    /><c:set var="muteInfo"><bs:muteInfo currentMuteInfo="${null}" buildMuteInfo="${muteInBuildInfo}" project="${project}"/></c:set
  ></c:when
></c:choose

><c:if test="${not empty muteClass}"
  ><c:set var="tooltip"
    >${muteInfo}<c:if test="${showCurrentMuteInfo}"
      ><problems:buildProblemInvestigationLinks buildProblem="${buildProblem}" showFixLink="false"
    /></c:if
  ></c:set
  ><span class="icon icon16 ${muteClass}" <bs:tooltipAttrs text="${tooltip}" className="name-value-popup"/> style="margin-left: -2px;"></span></c:if>