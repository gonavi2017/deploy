<%@ tag import="java.util.Collections" %><%@
    tag import="jetbrains.buildServer.BuildType" %><%@
    tag import="jetbrains.buildServer.web.openapi.PlaceId" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %><%@
    taglib prefix="resp" tagdir="/WEB-INF/tags/responsible" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags/tags" %><%@
    taglib prefix="ext" tagdir="/WEB-INF/tags/ext" %><%@
    attribute name="buildData" fragment="false" required="true" type="jetbrains.buildServer.serverSide.SBuild" %><%@
    attribute name="buildStatusText" fragment="false" required="false" type="java.lang.String" %><%@
    attribute name="showAlsoRunning" fragment="false" required="true" type="java.lang.Boolean"
%><jsp:useBean id="currentUser" type="jetbrains.buildServer.users.User" scope="request"/>
<c:if test="${empty buildStatusText}"><c:set var="buildStatusText" value="${buildData.statusDescriptor.text}"/></c:if>
<c:set var="buildStatusText"><bs:trim maxlength="100">${buildStatusText}</bs:trim></c:set>
<c:set var="branchRow">
  <c:set var="branch" value="${buildData.branch}"/>
  <c:if test="${not empty branch}">
    <tr>
      <td class="st labels">Branch:</td>
      <td colspan="3" class="st">
        <span class="branch hasBranch ${branch.defaultBranch ? 'default' : ''}"><bs:branchLink branch="${branch}" build="${buildData}" noLink="${false}"><c:out value="${branch.displayName}"/></bs:branchLink></span>
      </td>
    </tr>
  </c:if>
</c:set>

<c:choose>
  <c:when test="${not buildData.finished}">
    <c:set var="stopMessage" value=""/>
    <% BuildType buildType = buildData.getBuildType(); %>
    <c:set var="runningBuilds" value="<%=buildType != null ? buildType.getRunningBuilds(currentUser) : Collections.emptyList()%>"/>
    <c:set var="alsoRunning" value="${showAlsoRunning and fn:length(runningBuilds) > 1}"/>
    <c:if test="${not alsoRunning}">
      <c:set var="expandStyle" value="float: none; width: auto;"/>
    </c:if>

    <div id="runningLogStatus" class="clearfix">
      <c:if test="${buildData.probablyHanging}">
        <div class="icon_before icon16 attentionComment">
          This build is probably hanging. Last message was received on: <bs:date value="${buildData.lastBuildActivityTimestamp}"/>
          (<bs:printTime time="${buildData.timeSpentSinceLastBuildActivity}"/> ago)
        </div>
        <c:set var="stopMessage" value="This build hung."/>
      </c:if>

      <div class="runningBuildStatus" style="${expandStyle}">
        <table class="statusTable">
          <tr>
            <td class="st labels">Status:</td>
            <td class="st">
              <bs:buildDataIcon buildData="${buildData}"/>
              <bs:makeBreakable text="${buildStatusText}" regex="[\.,\\/:;@%^]" escape="${false}"/>
            </td>
            <td class="st labels">Agent:</td>
            <td class="st fixed">
              <div class="agentDetails">
                <bs:agentDetailsFullLink agent="${buildData.agent}"/>
              </div>
            </td>
          </tr>
          <tr>
            <td class="st labels">Progress:</td>
            <td class="st">
              <div class="duration">
                <bs:buildProgress buildData="${buildData}" classname="long" installPopup="${true}"/>
              </div>
              <div class="stopLink">
                <bs:stopBuild build="${buildData}" message="${stopMessage}"/>
              </div>
            </td>
            <td class="st labels">Triggered by:</td>
            <td class="st">
              <bs:triggeredByText triggeredBy="${buildData.triggeredBy}" showDate="true"/>
            </td>
          </tr>
          ${branchRow}
          <%@ include file="_investigation.jspf" %>
          <ext:includeExtensions placeId="<%=PlaceId.BUILD_SUMMARY%>"/>
          <tr>
            <td class="st labels">Running step:</td>
            <td class="st" colspan="3">
              <c:set var="currentPath"><bs:trim maxlength="200">${buildData.currentPath}</bs:trim></c:set>
              <c:choose>
                <c:when test="${not empty currentPath}">
                  <bs:makeBreakable text="${currentPath}" regex="[\.,\\/:;@%^]" escape="${false}"/>
                </c:when>
                <c:otherwise>&nbsp;</c:otherwise>
              </c:choose>
            </td>
          </tr>
        </table>
      </div>

      <c:if test="${alsoRunning}">
        <div id="alsoRunning">
          <h3>Also Running</h3>
          <ul>
            <c:set var="shown_count" value="0" />
            <c:forEach items="${runningBuilds}" var="buildData1" end="3">
              <c:set var="shown_count" value="${shown_count + 1}"/>
              <c:if test="${buildData1 != buildData}">
                <li>
                  <bs:buildDataIcon buildData="${buildData1}"/>
                  <bs:resultsLink build="${buildData1}">Results</bs:resultsLink>
                  <bs:changesLinkFull build="${buildData1}" noUsername="true"/>
                  <p>
                    <bs:buildNumber buildData="${buildData1}"/> started at <bs:date value="${buildData1.startDate}" pattern="HH:mm"/>
                    on <bs:agentDetailsFullLink agent="${buildData1.agent}"/>
                  </p>
                </li>
              </c:if>
            </c:forEach>
          </ul>
          <c:if test="${shown_count < fn:length(runningBuilds)}">
            <bs:buildTypeLink buildType="${buildType}" >View all ${fn:length(runningBuilds)} running builds</bs:buildTypeLink>
          </c:if>
        </div>
      </c:if>
    </div>
  </c:when>

  <c:otherwise>
    <c:set var="buildId" value="${buildData.buildId}"/>
    <c:set var="colorStyle" value="failureStatusBlock"/>
    <c:if test="${buildData.buildStatus.successful}">
      <c:set var="colorStyle" value="successStatusBlock"/>
    </c:if>
    <div class="${colorStyle} statusBlock">
      <table class="statusTable">
        <tr>
          <td class="st labels">Result:</td>
          <td class="st">
            <bs:buildDataIcon buildData="${buildData}"/>
            <bs:makeBreakable text="${buildStatusText}" regex="[\.,\\/:;@%^]" escape="${false}"/>
            <c:set var="canceledInfo" value="${buildData.canceledInfo}"/>
            <c:if test="${not empty canceledInfo}">
              <div class="cancelledInfo">
                Canceled <c:if test="${canceledInfo.canceledByUser}">by <strong><bs:userName server="${serverTC}"
                                                                                             userId="${canceledInfo.userId}"/></strong></c:if>
                <c:if test="${not empty canceledInfo.comment}">with comment: <i><c:out value="${canceledInfo.comment}"/></i></c:if>
              </div>
            </c:if>
          </td>
          <td class="st labels">Agent:</td>
          <td class="st fixed"><bs:agentDetailsFullLink agent="${buildData.agent}"/></td>
        </tr>
        <tr>
          <td class="st labels">Time:</td>
          <td class="st">
            <c:choose>
              <c:when test="${buildData.duration le 60}">
                <bs:date value="${buildData.startDate}" pattern="dd'&nbsp;'MMM'&nbsp;'yy'&nbsp;'HH:mm:ss"/> -
                <bs:date pattern="HH:mm:ss" value="${buildData.finishDate}"/>
              </c:when>
              <c:otherwise>
                <bs:date value="${buildData.startDate}"/> - <bs:date pattern="HH:mm" value="${buildData.finishDate}"/>
              </c:otherwise>
            </c:choose>

            (<bs:printTime
              time="${buildData.duration}" showIfNotPositiveTime="&lt; 1s"/>)
          </td>
          <td class="st labels">Triggered by:</td>
          <td class="st fixed"><bs:triggeredByText triggeredBy="${buildData.triggeredBy}" showDate="true"/></td>
        </tr>
        ${branchRow}
        <%@ include file="_investigation.jspf" %>
        <ext:includeExtensions placeId="<%=PlaceId.BUILD_SUMMARY%>"/>
      </table>
    </div>
  </c:otherwise>
</c:choose>
