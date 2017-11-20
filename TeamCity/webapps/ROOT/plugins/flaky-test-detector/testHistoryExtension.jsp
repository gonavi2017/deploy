<%-- Referenced from jetbrains.buildServer.serverSide.flaky.web.TestHistoryExtension --%>
<%@ include file="/include-internal.jsp"%>
<%@ include file="timeStatisticsBegin.jspf"%>
<%@ include file="flipHelpPopup.jspf"%>
<%@ taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %>
<jsp:useBean id="constants" class="jetbrains.buildServer.serverSide.flakyTestDetector.web.Constants"/>
<jsp:useBean id="vcsBranchManager" class="jetbrains.buildServer.serverSide.flakyTestDetector.opendata.VcsBranchManager"/>

<%--@elvariable id="statistics" type="jetbrains.buildServer.serverSide.flakyTestDetector.StatisticsEx"--%>
<%--@elvariable id="test" type="jetbrains.buildServer.serverSide.STest"--%>
<%--@elvariable id="flakyTest" type="jetbrains.buildServer.serverSide.flakyTestDetector.opendata.TestInfo"--%>

<%-- If "ftdDebug" request parameter is present, statistics is shown even for
     non-flaky tests. --%>
<c:if test="${statistics.monitoringEnabled
              and not empty test
              and not empty flakyTest
              and (flakyTest.flaky or param[constants.paramUiDebug] ne null)}">
  <c:set var="blockContentId" value="flakyTestContent"/>

  <c:set var="defaultOrder" value="${constants.orderByFlipRateDesc}"/>
  <%-- Client-side ordering and visibility stores. Needed when refreshing the page on timer or event. --%>
  <%--@elvariable id="perBuildTypeStatisticsOrder" type="java.lang.String"--%>
  <span id="perBuildTypeStatisticsOrder" class="hidden">${not empty perBuildTypeStatisticsOrder ? perBuildTypeStatisticsOrder : defaultOrder}</span>
  <%--@elvariable id="perBuildTypeStatisticsVisible" type="java.lang.Boolean"--%>
  <span id="perBuildTypeStatisticsVisible" class="hidden">${not empty perBuildTypeStatisticsVisible && perBuildTypeStatisticsVisible}</span>
  <%--@elvariable id="perAgentStatisticsOrder" type="java.lang.String"--%>
  <span id="perAgentStatisticsOrder" class="hidden">${not empty perAgentStatisticsOrder ? perAgentStatisticsOrder : defaultOrder}</span>
  <%--@elvariable id="perAgentStatisticsVisible" type="java.lang.Boolean"--%>
  <span id="perAgentStatisticsVisible" class="hidden">${not empty perAgentStatisticsVisible && perAgentStatisticsVisible}</span>

  <script type="application/javascript">
    BS.FlakyTestDetector = $j.extend({}, BS.FlakyTestDetector, {
      refreshSortablesNoArgs: function() {
        var /**String*/ perBuildTypeStatisticsOrder = $j("#perBuildTypeStatisticsOrder").text();
        var /**String*/ perBuildTypeStatisticsVisible = $j("#perBuildTypeStatisticsVisible").text();
        var /**String*/ perAgentStatisticsOrder = $j("#perAgentStatisticsOrder").text();
        var /**String*/ perAgentStatisticsVisible = $j("#perAgentStatisticsVisible").text();
        var /**Object*/ httpRequestParameters = {
          perBuildTypeStatisticsOrder: perBuildTypeStatisticsOrder,
          perBuildTypeStatisticsVisible: perBuildTypeStatisticsVisible,
          perAgentStatisticsOrder: perAgentStatisticsOrder,
          perAgentStatisticsVisible: perAgentStatisticsVisible
        };
        this.refreshSortables("${blockContentId}", httpRequestParameters);
        BS.Log.info("Test analysis refreshed; ordering is " + JSON.stringify(httpRequestParameters));
      }
    });
  </script>

  <c:set var="blockTitle"><a name="analysis">Test analysis</a></c:set>
  <bs:_collapsibleBlock
      tag="div"
      id="flakyTestHeader"
      headerClass="testDetailsHeader"
      title="${blockTitle}"
      collapsedByDefault="${false}">
    <%--@elvariable id="pageUrl" type="java.lang.String"--%>
    <bs:refreshable containerId="${blockContentId}" pageUrl="${pageUrl}">
      <table class="analysis">
        <tbody>
          <tr>
            <td class="testName">
              <table class="testName">
                <tr>
                  <td colspan="2" class="flakyReason">
                    <%@ include file="flakyReasons.jspf" %>
                  </td>
                </tr>
                <jsp:useBean id="settings" class="jetbrains.buildServer.serverSide.flakyTestDetector.web.Settings"/>
                <c:if test="${settings.reportEnvironmentDependentTests
                              or param[constants.paramUiDebug] ne null}">
                  <c:set var="environmentDetails">
                    <%@ include file="environmentDetails.jspf"%>
                  </c:set>
                  <c:if test="${not empty fn:trim(environmentDetails)}">
                    <tr class="testName">
                      <td colspan="2" class="testName">${environmentDetails}</td>
                    </tr>
                  </c:if>
                </c:if>
                <tr>
                  <td class="statistics">
                    <div class="dark thin statistics">
                      <c:set var="title">Statistics by all build configurations since <bs:date value="${statistics.lowerHistoryBound}"/></c:set>
                      <bs:_collapsibleBlock
                          tag="div"
                          id="${util:uniqueId()}"
                          handleClass="light"
                          headerClass="innerHeader title"
                          title="${title}"
                          collapsedByDefault="${not perBuildTypeStatisticsVisible}">
                        <div class="content">
                          <table id="perBuildTypeStatistics" class="dark borderBottom sortable">
                            <tr>
                              <th class="sortable"><span id="${constants.orderByBuildTypeNameAsc}">Configuration</span></th>
                              <th class="sortable numeric"><span id="${constants.orderByFlipRateDesc}" ${flipHelpPopup}>Flips</span></th>
                              <th class="sortable numeric"><span id="${constants.orderByFailureRateDesc}">Failures</span></th>
                              <th class="sortable numeric"><span id="${constants.orderByInvocationCountDesc}">Invocations</span></th>
                            </tr>
                            <%--@elvariable id="flakyBuildsOrdered" type="java.util.SortedSet<jetbrains.buildServer.serverSide.flakyTestDetector.opendata.BuildInfo>"--%>
                            <c:forEach var="build" items="${flakyBuildsOrdered}">
                              <c:set var="flipRate" value="${build.flipRate}"/>
                              <c:set var="failureRate" value="${build.failureRate}"/>
                              <tr class="${flipRate.value eq 0 and failureRate.value eq 0 ? "zero" : ""}">
                                <c:set var="buildTypeId" value="${build.buildTypeId}"/>
                                <c:set var="branchDisplayName" value="${build.branchDisplayName}"/>
                                <td>
                                  <%@ include file="buildTypeLink.jspf"%>
                                </td>
                                <c:set var="eventRate" value="${flipRate}"/>
                                <%@ include file="eventRate.jspf"%>
                                <c:set var="eventRate" value="${failureRate}"/>
                                <%@ include file="eventRate.jspf"%>
                                <td class="numeric">
                                    ${build.invocationCount}
                                </td>
                              </tr>
                            </c:forEach>
                            <c:set var="flipRate" value="${flakyTest.buildTypeEventRates.averageFlipRate}"/>
                            <c:set var="failureRate" value="${flakyTest.averageFailureRate}"/>
                            <tr class="footer ${flipRate.value eq 0 and failureRate.value eq 0 ? "zero" : ""}">
                              <td>
                                <span>Total</span>
                              </td>
                              <c:set var="eventRate" value="${flipRate}"/>
                              <%@ include file="eventRate.jspf"%>
                              <c:set var="eventRate" value="${failureRate}"/>
                              <%@ include file="eventRate.jspf"%>
                              <td class="numeric">
                                ${flakyTest.invocationCount}
                              </td>
                            </tr>
                          </table>
                        </div>
                      </bs:_collapsibleBlock>
                    </div>
                  </td>
                  <td class="statistics">
                    <div class="dark thin statistics">
                      <c:set var="title">Statistics by all agents since <bs:date value="${statistics.lowerHistoryBound}"/>
                      </c:set>
                      <bs:_collapsibleBlock
                          tag="div"
                          id="${util:uniqueId()}"
                          handleClass="light"
                          headerClass="innerHeader title"
                          title="${title}"
                          collapsedByDefault="${not perAgentStatisticsVisible}">
                        <div class="content">
                          <table id="perAgentStatistics" class="dark borderBottom sortable">
                            <tr>
                              <th class="sortable"><span class="icon icon16 os-icon"></span><span id="${constants.orderByAgentNameAsc}">Agent</span></th>
                              <th class="sortable numeric"><span id="${constants.orderByFlipRateDesc}" ${flipHelpPopup}>Flips</span></th>
                              <th class="sortable numeric"><span id="${constants.orderByFailureRateDesc}">Failures</span></th>
                              <th class="sortable numeric"><span id="${constants.orderByInvocationCountDesc}">Invocations</span></th>
                            </tr>
                            <%--@elvariable id="flakyAgentsOrdered" type="java.util.Map<jetbrains.buildServer.serverSide.flakyTestDetector.opendata.AgentWithRate, java.util.Collection<jetbrains.buildServer.serverSide.flakyTestDetector.opendata.AgentWithRate>>"--%>
                            <c:forEach var="agentGroup" items="${flakyAgentsOrdered}">
                              <c:set var="agents" value="${agentGroup.value}"/>
                              <c:choose>
                                <c:when test="${fn:length(agents) == 1}">
                                  <%-- Regular agents --%>
                                  <c:set var="agent" value="${agents[0]}"/>
                                  <c:set var="agentType" value="${false}"/>
                                  <c:set var="indent" value="${false}"/>
                                  <%@ include file="agentStatistics.jspf"%>
                                </c:when>
                                <c:otherwise>
                                  <%-- Cloud agent image --%>
                                  <c:set var="agent" value="${agentGroup.key}"/>
                                  <c:set var="agentType" value="${true}"/>
                                  <c:set var="indent" value="${false}"/>
                                  <%@ include file="agentStatistics.jspf"%>

                                  <c:forEach var="agent" items="${agents}">
                                    <%-- Cloud agent instance --%>
                                    <c:set var="agentType" value="${false}"/>
                                    <c:set var="indent" value="${true}"/>
                                    <%@ include file="agentStatistics.jspf"%>
                                  </c:forEach>
                                </c:otherwise>
                              </c:choose>
                            </c:forEach>
                            <c:set var="flipRate" value="${flakyTest.agentEventRates.averageFlipRate}"/>
                            <c:set var="failureRate" value="${flakyTest.averageFailureRate}"/>
                            <tr class="footer ${flipRate.value eq 0 and failureRate.value eq 0 ? "zero" : ""}">
                              <td>
                                <span class="icon icon16 os-icon"></span><span>Total</span>
                              </td>
                              <c:set var="eventRate" value="${flipRate}"/>
                              <%@ include file="eventRate.jspf"%>
                              <c:set var="eventRate" value="${failureRate}"/>
                              <%@ include file="eventRate.jspf"%>
                              <td class="numeric">
                                ${flakyTest.invocationCount}
                              </td>
                            </tr>
                          </table>
                        </div>
                      </bs:_collapsibleBlock>
                    </div>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </tbody>
      </table>
      <script type="application/javascript">
        (function() {
          "use strict";

          /*
           * Make tables sortable.
           */
          var /**BS.FlakyTestDetector.TableDescriptor*/ perBuildTypeStatistics = new BS.FlakyTestDetector.TableDescriptor(
              "perBuildTypeStatistics",
              "perBuildTypeStatisticsOrder",
              "${constants.paramPerBuildTypeStatisticsOrder}",
              ["${constants.orderByBuildTypeNameAsc}", "${constants.orderByFlipRateDesc}", "${constants.orderByFailureRateDesc}", "${constants.orderByInvocationCountDesc}"]);
          var /**BS.FlakyTestDetector.TableDescriptor*/ perAgentStatistics = new BS.FlakyTestDetector.TableDescriptor(
              "perAgentStatistics",
              "perAgentStatisticsOrder",
              "${constants.paramPerAgentStatisticsOrder}",
              ["${constants.orderByAgentNameAsc}", "${constants.orderByFlipRateDesc}", "${constants.orderByFailureRateDesc}", "${constants.orderByInvocationCountDesc}"]);
          BS.FlakyTestDetector.makeSortable("${blockContentId}",
                                            [perBuildTypeStatistics, perAgentStatistics],
                                            {
                                              perBuildTypeStatisticsVisible: "perBuildTypeStatisticsVisible",
                                              perAgentStatisticsVisible: "perAgentStatisticsVisible"
                                            });

          /*
           * Listen for expanded/collapsed events and store
           * the block status locally, to be used upon the
           * next refresh.
           *
           * WebKit doesn't support DOMAttrModified (see
           * https://bugs.webkit.org/show_bug.cgi?id=8191), nor does it appear
           * to support DOMSubtreeModified or DOMAttrChangeRequest, so this is
           * implemented using a MutationObserver.
           *
           * Unfortunately, Safari 5.1.7 (7534.57.2) for Windows
           * (AppleWebKit/534.57.2 (KHTML, like Gecko) Version/5.1.7 Safari/534.57.2)
           * is too old to support MutationObserver's, either (Safari 6 is the
           * required minimum).
           */
          var /**Object*/ observerConfig = {
            attributes: true,
            attributeFilter: ["style"]
          };

          new MutationObserver(function(/**Array.<MutationRecord>*/ mutations) {
            mutations.forEach(function(/**MutationRecord*/ mutation) {
              if (mutation.type === "attributes"
                  && mutation.attributeName === "style") {
                var /**HTMLDivElement*/ element = mutation.target;
                $j("#perBuildTypeStatisticsVisible").text($j(element).is(":visible"));
              }
            });
          }).observe($j("#perBuildTypeStatistics").closest("div.collapsibleBlock")[0], observerConfig);

          new MutationObserver(function(/**Array.<MutationRecord>*/ mutations) {
            mutations.forEach(function(/**MutationRecord*/ mutation) {
              if (mutation.type === "attributes"
                  && mutation.attributeName === "style") {
                var /**HTMLDivElement*/ element = mutation.target;
                $j("#perAgentStatisticsVisible").text($j(element).is(":visible"));
              }
            });
          }).observe($j("#perAgentStatistics").closest("div.collapsibleBlock")[0], observerConfig);

          /*
           * In case the user has no VIEW_AGENT_DETAILS privilege, and the dummy
           * OS icon is displayed, collapse the white space between the icon and
           * the agent name (unachievable via CSS).
           */
          $j("#perAgentStatistics td:first-child").contents().filter(function() {
            return this.nodeType === 3;
          }).remove();
        })();
      </script>
    </bs:refreshable>
  </bs:_collapsibleBlock>

  <et:subscribeOnEvents>
    <jsp:attribute name="eventNames">
      BUILD_FINISHED
      TEST_MUTE_UPDATED
    </jsp:attribute>
    <jsp:attribute name="eventHandler">
      BS.reload(false, function() {
        BS.FlakyTestDetector.refreshSortablesNoArgs();
        BS.Log.info("Flaky tests refreshed");
      });
    </jsp:attribute>
  </et:subscribeOnEvents>
</c:if>

<%@ include file="timeStatisticsEnd.jspf"%>
