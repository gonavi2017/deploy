<%@ include file="../include-internal.jsp" %><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@
    taglib prefix="l" tagdir="/WEB-INF/tags/layout" %><%@
    taglib prefix="problems" tagdir="/WEB-INF/tags/problems"

%><jsp:useBean id="bean" type="jetbrains.buildServer.controllers.project.MutedProblemsBean" scope="request"

/><c:if test="${bean.hasMutedTests or bean.hasMutedBuildProblems}">
 <%--@elvariable id="contextProject" type="jetbrains.buildServer.serverSide.SProject"--%>
<div id="muted-problems">
  <div class="actionBar">
    <label class="firstLabel" for="buildType">Filter by build configuration:</label>
    <c:url var="url" value='/project.html?projectId=${project.externalId}&tab=mutedProblems'/>
    <bs:buildTypesFilter buildTypes="${bean.buildTypes}" selectedBuildTypeId="${bean.buildTypeId}" url="${url}" className="actionInput"/>
  </div>

  <c:if test="${bean.hasMutedTests}">
    <c:set var="title"><bs:icon icon="../muted.png"/> Muted tests: ${bean.groupedTestsBean.testsNumber}</c:set>
    <bs:_collapsibleBlock title="${title}" id="mutedProblemsTab">
    <tt:testGroupWithActions groupedTestsBean="${bean.groupedTestsBean}" defaultOption="package"
                             groupSelector="true"
                             ignoreMuteScope="true" id="muted_tab">
      <jsp:attribute name="afterToolbar">
        <td class="mute-scope">Scope</td>
        <td class="mute-time">Mute date</td>
        <td>&nbsp;</td>
      </jsp:attribute>
      <jsp:attribute name="testAfterName">
        <c:set var='test' value="${testBean.test}"/>
        <%--@elvariable id="test" type="jetbrains.buildServer.serverSide.TestEx"--%>
        <c:set var="currentMuteInfo" value="${test.currentMuteInfo}"/>
        <c:set var="projectMuteInfo" value="${currentMuteInfo.projectMuteInfo}"/>
        <c:set var="groups" value="${currentMuteInfo.muteInfoGroups}"/>

        <%--
          HTML structure below uses the fact how the tests view is organized.
          The code below *should* be inside a test name TD, but we insert several TDs in the same table.
        --%>
        </td>
        <td class="mute-scope">
          <c:choose>
            <c:when test="${not empty projectMuteInfo}">
              <bs:projectOrBuildTypeIcon/>
              <bs:projectLinkFull project="${projectMuteInfo.project}" contextProject="${contextProject}"/>
              <c:set var="time" value="${projectMuteInfo.mutingTime}"/>
              <c:set var="comment" value="${projectMuteInfo.mutingComment}"/>
            </c:when>
            <c:otherwise>
              <c:set var="btNum" value="${fn:length(currentMuteInfo.buildTypeMuteInfo)}"/>
              <c:choose>
                <c:when test="${btNum == 1}">
                  <c:forEach items="${currentMuteInfo.buildTypeMuteInfo}" var="entry">
                    <bs:projectOrBuildTypeIcon type="buildType"/>
                    <bs:buildTypeLinkFull buildType="${entry.key}" contextProject="${contextProject}"/>
                    <c:set var="time" value="${entry.value.mutingTime}"/>
                    <c:set var="comment" value="${entry.value.mutingComment}"/>
                  </c:forEach>
                </c:when>
                <c:otherwise>
                  <bs:popup_static controlId="popup${testBean.run.testRunId}" linkOpensPopup="true"
                                  popup_options="shift: {x: -140, y: 20}">
                    <jsp:attribute name="content">
                      <c:forEach items="${currentMuteInfo.buildTypeMuteInfo}" var="entry">
                        <div>
                          <bs:buildTypeLinkFull buildType="${entry.key}" contextProject="${contextProject}"/>
                        </div>
                        <c:set var="time" value="${entry.value.mutingTime}"/>
                        <c:set var="comment" value="${entry.value.mutingComment}"/>
                      </c:forEach>
                    </jsp:attribute>
                    <jsp:body>
                      <bs:projectOrBuildTypeIcon type="buildType"/> ${btNum} build configurations
                    </jsp:body>
                  </bs:popup_static>
                </c:otherwise>
              </c:choose>
            </c:otherwise>
          </c:choose>
        </td>
        <td class="mute-time">
          <c:if test="${not empty time}"
              ><bs:elapsedTime time="${time}"
          /></c:if
          ><c:if test="${not empty comment}">:
            <bs:trimWithTooltip maxlength="40">${comment}</bs:trimWithTooltip>
          </c:if>
        </td>
        <td>
      </jsp:attribute>
    </tt:testGroupWithActions>
    </bs:_collapsibleBlock>
  </c:if>

  <c:if test="${bean.hasMutedBuildProblems}"><problems:buildProblemMuteList projectBuildProblemsBean="${bean.buildProblemsBean}"/></c:if>
</div>
</c:if>

<c:if test="${not bean.hasMutedTests and not bean.hasMutedBuildProblems}">
  <p>No muted problems found.</p>
</c:if>
