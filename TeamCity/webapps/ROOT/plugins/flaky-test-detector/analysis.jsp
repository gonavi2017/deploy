<%@ page import="jetbrains.buildServer.web.util.WebUtil" %>
<%@ include file="/include-internal.jsp"%>
<%@ include file="timeStatisticsBegin.jspf"%>
<%@ include file="flipHelpPopup.jspf"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/functions/user" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %>
<jsp:useBean id="constants" class="jetbrains.buildServer.serverSide.flakyTestDetector.web.Constants"/>
<jsp:useBean id="settings" class="jetbrains.buildServer.serverSide.flakyTestDetector.web.Settings"/>

<%--@elvariable id="pageUrl" type="java.lang.String"--%>
<%--@elvariable id="statistics" type="jetbrains.buildServer.serverSide.flakyTestDetector.StatisticsEx"--%>
<%--@elvariable id="flakyTests" type="java.util.SortedSet<jetbrains.buildServer.serverSide.flakyTestDetector.opendata.TestInfo>"--%>

<c:set var="blockHeaderId" value="flakyTestsHeader"/>
<%--
  This refreshable id is a part of the module's public contract (see
  investigation.js).
  --%>
<c:set var="blockContentId" value="flakyTests"/>
<c:set var="investigationsHiddenPropertyKey" value="hideAssignedProblems"/>

<script type="application/javascript">
  BS.FlakyTestDetector = $j.extend({}, BS.FlakyTestDetector, {
    blockContentId: "${blockContentId}",
    investigationsHiddenId: "${investigationsHiddenPropertyKey}",
    paramOrder: "${constants.paramOrder}",
    orderByTestNameAsc: "${constants.orderByTestNameAsc}",
    orderByFailureRateDesc: "${constants.orderByFailureRateDesc}",
    orderByFlipRateDesc: "${constants.orderByFlipRateDesc}"
  });
</script>

<%--@elvariable id="teamcityPluginResourcesPath" type="java.lang.String"--%>
<bs:linkScript>
  ${teamcityPluginResourcesPath}analysis.js
</bs:linkScript>

<c:set var="defaultOrder" value="${constants.orderByFlipRateDesc}"/>
<%-- Client-side ordering store. Needed when refreshing the page on timer or event. --%>
<%--@elvariable id="order" type="java.lang.String"--%>
<span id="order" class="hidden">${not empty order ? order : defaultOrder}</span>

<%--@elvariable id="project" type="jetbrains.buildServer.BuildProject"--%>

<div class="actionBar">
  <table>
    <tr>
      <td>
        <span class="nowrap">
          <label class="firstLabel" for="buildType">Filter by build configuration:</label>
          <c:url var="url" value="/project.html?projectId=${project.externalId}&tab=${constants.extensionIdFlakyTests}" />
          <%--@elvariable id="flakyBuildTypeHierarchy" type="java.util.List<jetbrains.buildServer.web.util.BuildTypesHierarchyBean>"--%>
          <bs:buildTypesFilter buildTypes="${flakyBuildTypeHierarchy}" selectedBuildTypeId="${param['buildTypeId']}" url="${url}"/>
        </span>
      </td>
      <td>
        <span class="nowrap">
          <profile:booleanPropertyCheckbox
              propertyKey="${investigationsHiddenPropertyKey}"
              labelText="Hide tests under investigation"
              progress="${investigationsHiddenPropertyKey}_progress"
              afterComplete="BS.FlakyTestDetector.setInvestigationsVisible(!$j(BS.Util.escapeId('${investigationsHiddenPropertyKey}')).is(':checked'));"/>
          <forms:saving id="${investigationsHiddenPropertyKey}_progress"
                        className="progressRingInline"/>
        </span>
      </td>
      <c:if test="${param[constants.paramUiDebug] ne null}">
        <td>
          <label><input type="checkbox"
                        disabled="disabled"
            ${settings.autoRefreshEnabled ? "checked=\"checked\"" : ""}>Enable auto-refresh</label>
        </td>
      </c:if>
      <td class="spacer"></td>
      <td>
        <bs:refreshable containerId="${blockHeaderId}" pageUrl="${pageUrl}">
          <c:choose>
            <c:when test="${statistics.monitoringEnabled}">
              <c:choose>
                <c:when test="${empty flakyTests}">
                  No flaky tests detected since <bs:date value="${statistics.lowerHistoryBound}"/>.
                </c:when>
                <c:otherwise>
                  Flaky tests detected since <bs:date value="${statistics.lowerHistoryBound}"/>
                </c:otherwise>
              </c:choose>
            </c:when>
            <c:otherwise>
              Real-time analysis is not enabled.
            </c:otherwise>
          </c:choose>
        </bs:refreshable>
      </td>
    </tr>
  </table>
</div>

<c:set var="projectId" value="${project.projectId}"/>

<bs:refreshable containerId="${blockContentId}" pageUrl="${pageUrl}">
  <%--

  1. If the actual number of flaky tests is between 0 and the soft limit,
     display all tests and no links at the bottom.

  2. If the number of tests is larger than the soft limit, display
     <soft limit> tests and provide a link to the same page with an extra
     &testLimit=false parameter.

  3. If the testLimit parameter is false and the number of tests doesn't
     exceed the hard limit, display all tests.

  4. If the testLimit parameter is false and the hard limit is exceeded,
     disdplay <hard limit> tests and the warning message at the bottom.

  --%>

  <%--@elvariable id="allTestsRequested" type="boolean"--%>
  <c:set var="allTestsRequested" value="${param[constants.paramTestLimit] == 'false'}"/>
  <c:set var="uiTestHardLimit" value="<%=WebUtil.getMaxUiTestLimit()%>"/>
  <c:set var="uiTestLimit" value="${allTestsRequested ? uiTestHardLimit : settings.uiTestSoftLimit}"/>

  <%--@elvariable id="flakyTestCount" type="java.lang.Integer"--%>
  <c:set var="investigatedTestCount" value="${0}"/>
  <c:if test="${statistics.monitoringEnabled and flakyTestCount gt 0}">
    <%--
      The unique id of a test group. The naming format is arbitrary (there's no
      contract).
      --%>
    <c:set var="groupId">tst_group_<bs:id/></c:set>

    <%-- The 2nd argument to BS.TestGroup.initialize() --%>
    <c:set var="testNameIds" value=""/>

    <div class="tests-group" id="${groupId}">
      <div class="group-div by-nothing">
        <l:tableWithHighlighting id="analysis" className="analysis testList dark borderBottom sortable">
          <thead>
            <tr>
              <th class="select">
                <%--
                  We can't place more than one <span/> into th.sortable,
                  hence a separate <th/>
                  --%>
                <authz:authorize projectId="${projectId}"
                                 anyPermission="ASSIGN_INVESTIGATION,MANAGE_BUILD_PROBLEMS">
                  <div class="select-all">
                    <c:set var="attrs"><bs:tooltipAttrs text="Click to select / unselect all tests"/></c:set>
                    <forms:checkbox name=""
                                    custom="${true}"
                                    id="select-${groupId}"
                                    attrs="${attrs}"/>
                    <span class="chkboxPlace"></span>
                  </div>
                </authz:authorize>
              </th>
              <th class="sortable testName"><span id="${constants.orderByTestNameAsc}">Test</span></th>
              <th class="sortable numeric"><span id="${constants.orderByFailureRateDesc}">Total Failures</span></th>
              <th class="sortable numeric"><span id="${constants.orderByFlipRateDesc}" ${flipHelpPopup}>Flip Rate</span></th>
              <th class="flakyReason">Reasons Why Flaky</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="flakyTest" items="${flakyTests}">
              <%--@elvariable id="flakyTest" type="jetbrains.buildServer.serverSide.flakyTestDetector.opendata.TestInfo"--%>
              <%--@elvariable id="tests" type="java.util.Map<java.lang.Long, jetbrains.buildServer.serverSide.STest>"--%>
              <c:set var="test" value="${tests[flakyTest.testNameId]}"/>

              <c:set var="investigationDisplayClass" value=""/>
              <c:if test="${not empty test}">
                <c:forEach var="responsibility" items="${test.allResponsibilities}">
                  <c:if test="${responsibility.state.active || responsibility.state.fixed}">
                    <c:set var="investigationDisplayClass" value="activeInvestigation"/>
                  </c:if>
                </c:forEach>
              </c:if>
              <c:if test="${not empty investigationDisplayClass}">
                <c:set var="investigatedTestCount" value="${investigatedTestCount + 1}"/>
                <%--
                  Since the "[ ] Hide tests under investigation" checkbox is initially
                  on, hide those tests by default (otherwise, refreshing the
                  page would cause flicker: tests would be rendered and
                  immediately hidden).
                  --%>
                <%--@elvariable id="currentUser" type="jetbrains.buildServer.users.User"--%>
                <c:set var="investigationsInitiallyHidden" value="${ufn:booleanPropertyValue(currentUser, investigationsHiddenPropertyKey)}"/>
                <c:if test="${investigationsInitiallyHidden}">
                  <c:set var="investigationDisplayClass" value="${investigationDisplayClass} hidden"/>
                </c:if>
              </c:if>

              <%--
                "testRowSelected" class is added on selection (see testGroup.js)
                --%>
              <tr id="testNameId${flakyTest.testNameId}" class="analysis ${investigationDisplayClass}">
                <td class="highlight select">
                  <authz:authorize projectId="${projectId}"
                                   anyPermission="ASSIGN_INVESTIGATION,MANAGE_BUILD_PROBLEMS">
                    <%--
                      class="checkbox" here is important: without it,
                      bulk-operations-toolbar doesn't show up on selection (see
                      testGroup.js)
                      --%>
                    <forms:checkbox name=""
                                    custom="${true}"
                                    attrs="data-testId=\"${test.testNameId}\" data-flaky=\"${true}\""
                                    className="checkbox"/>
                    <span class="chkboxPlace"></span>
                  </authz:authorize>
                </td>
                <td class="highlight testName testNamePart">
                  <a name="testNameId${flakyTest.testNameId}"></a>
                  <c:if test="${not empty test}">
                    <tt:testNameWithPopupShort test="${test}"
                                               trimTestName="${true}"
                                               showPackage="${true}"
                                               flakyIconVisible="${false}"
                                               groupIdForBulkMode="${groupId}"
                                               responsibilityRemovalMethod="${'MANUALLY'}"
                                               unmuteOptionType="${'MANUALLY'}"
                                               comment="This test is flaky!"/>
                  </c:if>
                </td>
                <td class="highlight numeric">
                    ${flakyTest.failureCount}
                </td>
                <c:set var="eventRate" value="${flakyTest.buildTypeEventRates.averageFlipRate}"/>
                <td class="highlight numeric" <bs:tooltipAttrs text="${eventRate.description}"/>>
                  <fmt:formatNumber value="${eventRate.value * 100}" maxFractionDigits="0"/>%
                </td>
                <td class="highlight flakyReason">
                  <%@ include file="flakyReasonsShort.jspf" %>
                </td>
              </tr>

              <%-- Populate the multi-map of testNameIds to buildIds --%>
              <c:set var="buildIds" value=""/>
              <c:set var="sendBuildsOnInvestigation" value="${settings.sendBuildsOnInvestigation}"/>
              <c:if test="${sendBuildsOnInvestigation ne 0}">
                <c:forEach var="buildId" items="${sendBuildsOnInvestigation eq 1 ? flakyTest.flakyBuildIds : flakyTest.buildIds}">
                  <c:set var="buildIds" value="${buildIds}${buildId},"/>
                </c:forEach>
              </c:if>
              <c:set var="testNameIds" value="[\"${flakyTest.testNameId}\", \"${buildIds}\"],${testNameIds}"/>
            </c:forEach>
          </tbody>
        </l:tableWithHighlighting>
      </div>
    </div>

    <c:if test="${flakyTestCount > uiTestLimit}">
      <c:choose>
        <c:when test="${allTestsRequested}">
          <div class="viewAllUrl">There are more than ${uiTestLimit} flaky tests, see the corresponding builds for more details</div>
        </c:when>
        <c:otherwise>
          <c:set var="newPageUrl" value="${pageUrl}"/>

          <%-- pageUrl may contain the "order" parameter, which should be
          stripped from it (in order to avoid multiple values of the same URL
          parameter). --%>
          <c:choose>
            <c:when test="${param[constants.paramOrder] != null}">
              <c:set var="oldOrder" value="${constants.paramOrder}=${param[constants.paramOrder]}"/>
              <c:set var="oldOrderWithAmp" value="&${oldOrder}"/>
              <c:set var="newPageUrl" value="${fn:replace(newPageUrl, oldOrderWithAmp, '')}"/>
              <c:set var="newPageUrl" value="${fn:replace(newPageUrl, oldOrder, '')}"/>
            </c:when>
          </c:choose>

          <%-- pageUrl may already contain the "testLimit" parameter, just the
          value may be different from "false". --%>
          <c:set var="newTestLimit" value="${constants.paramTestLimit}=${false}"/>
          <c:choose>
            <c:when test="${param[constants.paramTestLimit] != null}">
              <c:set var="oldTestLimit" value="${constants.paramTestLimit}=${param[constants.paramTestLimit]}"/>
              <c:set var="newPageUrl" value="${fn:replace(newPageUrl, oldTestLimit, newTestLimit)}"/>
            </c:when>
            <c:otherwise>
              <c:set var="newPageUrl" value="${newPageUrl}&${newTestLimit}"/>
            </c:otherwise>
          </c:choose>
          <div class="viewAllUrl"><a href="${newPageUrl}">View all tests &raquo;</a></div>
        </c:otherwise>
      </c:choose>
    </c:if>

    <%-- The id is used by testGroup.js and _bulkOperationsLinks.tag --%>
    <forms:modified id="${groupId}-actions-docked">
      <jsp:body>
        <div class="bulk-operations-toolbar fixedWidth">
          <span class="bulk-operations">
            <tt:_bulkOperationsLinks groupId="${groupId}"
                                     projectId="${projectId}"
                                     noFix="${false}"/>
          </span>
        </div>
      </jsp:body>
    </forms:modified>
  </c:if>

  <%-- Executed during auto-refresh, even if flaky test count is 0. --%>
  <script type="application/javascript">
    BS.FlakyTestDetector.onrefresh(${statistics.monitoringEnabled},
                                   ${flakyTestCount},
                                   ${uiTestLimit},
                                   ${investigatedTestCount},
                                   {
                                     id: "${groupId}",
                                     nameIds: [${testNameIds}],
                                     projectExternalId: "${project.externalId}"
                                   });
  </script>
</bs:refreshable>

<c:if test="${settings.autoRefreshEnabled}">
  <et:subscribeOnEvents>
    <jsp:attribute name="eventNames">
      BUILD_FINISHED
      TEST_MUTE_UPDATED
    </jsp:attribute>
    <jsp:attribute name="eventHandler">
      BS.reload(false, function() {
        $j("#${blockHeaderId}").get(0).refresh();
        BS.FlakyTestDetector.refreshSortablesNoArgs();
      });
    </jsp:attribute>
  </et:subscribeOnEvents>
</c:if>

<%@ include file="timeStatisticsEnd.jspf"%>
