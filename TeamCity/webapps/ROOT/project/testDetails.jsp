<%--@elvariable id="buildType" type="jetbrains.buildServer.serverSide.SBuildType"--%>
<%--@elvariable id="error" type="java.lang.String"--%>
<%@ page import="java.util.Map" %><%@
    page import="jetbrains.buildServer.web.openapi.PlaceId" %><%@
    page import="jetbrains.buildServer.web.util.WebUtil" %><%@
    include file="/include-internal.jsp"%><%@
    taglib prefix="stats" tagdir="/WEB-INF/tags/graph" %><%@
    taglib prefix="props" tagdir="/WEB-INF/tags/props" %><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests"

%><c:if test="${not empty error}">${error}</c:if
><c:if test="${empty error}">
<div class="testDetails">

<jsp:useBean id="historyPager" type="jetbrains.buildServer.util.Pager" scope="request"/>
<jsp:useBean id="project" type="jetbrains.buildServer.serverSide.SProject" scope="request" />
<jsp:useBean id="buildTypes" type="java.util.Collection<jetbrains.buildServer.web.util.BuildTypesHierarchyBean>" scope="request" />
<jsp:useBean id="test" type="jetbrains.buildServer.serverSide.STest" scope="request"/>
<jsp:useBean id="summary" type="jetbrains.buildServer.controllers.buildType.TestSummaryBean" scope="request"/>
<jsp:useBean id="order" type="jetbrains.buildServer.controllers.TestHistoryOrder" scope="request"/>
<jsp:useBean id="historyRecords" type="java.util.Collection<jetbrains.buildServer.serverSide.STestRun>" scope="request"/>

<c:set var="packageString" value="${empty test.name.packageName ? 'no package' : test.name.packageName}"/>
<c:set var="allResp" value="${test.allResponsibilities}"/>
<c:set var="resp" value="${not empty allResp ? allResp[0] : null}"/>

<script type="text/javascript">
  BS.Util.setTitle("<bs:escapeForJs text="${project.name} > Test History of ${test.name.shortName}"/>");
</script>

<table class="mainHeader">
  <tr>
    <td width="65%">
      <div class="testHeader">
        <bs:popup_static controlId="test-${test.testNameId}"
                        controlClass="testNamePopup"
                        popup_options="shift: {x: -30, y: 15}">
          <jsp:attribute name="content">
            <authz:authorize projectId="${test.projectId}" anyPermission="ASSIGN_INVESTIGATION,MANAGE_BUILD_PROBLEMS">
              <jsp:attribute name="ifAccessGranted">
                <span class="icon icon16 bp taken"></span>
                <tt:testInvestigationLinks test="${test}" buildId="" withFix="${not empty resp && resp.state.active}"/>
              </jsp:attribute>
              <jsp:attribute name="ifAccessDenied">
                Not enough permissions to assign investigation / mute
              </jsp:attribute>
            </authz:authorize>
          </jsp:attribute>
          <jsp:body>
            <span class="testHeaderName"><tt:testName testBean="${test}" trimTestName="false" showPackage="true"/></span>
          </jsp:body>
        </bs:popup_static>
      </div>
    </td>
    <td>
      <div class="buildTypeSelector actionBar">
        <form action="#" name="fake">
          <span class="nowrap">
            <label class="firstLabel" for="buildTypeId">Filter by:</label>

            <c:set var="selectedBuildTypeId" value="${empty buildType ? '' : buildType.externalId}"/>
            <forms:select name="buildType" enableFilter="true" style="min-width: 16em"
              ><c:forEach items="${buildTypes}" var="bean"
                ><forms:option value="${bean.project.externalId}"
                               title="${bean.project.fullName}"
                               className="inplaceFiltered optgroup user-depth-${bean.limitedDepth} user-project"
                               selected="${not selectedBuildTypeId and bean.project.projectId == project.projectId}">${bean.project.name}</forms:option>
                ><c:forEach var="buildType" items="${bean.buildTypes}"
                  ><forms:option value="projectId=${buildType.project.externalId}&buildTypeId=${buildType.externalId}"
                                 title="${buildType.fullName}"
                                 className="user-depth-${bean.limitedDepth + 1}"
                                 selected="${buildType.externalId == selectedBuildTypeId}"
                    ><c:out value="${buildType.name}"
                  /></forms:option
                ></c:forEach
                ><c:if test="${empty bean.buildTypes}"><forms:option value="" className="user-delete" disabled="true">&nbsp;</forms:option></c:if
              ></c:forEach
            ></forms:select>

            <c:url var="url" value="/project.html?tab=testDetails&testNameId=${test.testNameId}"/>
            <script type="text/javascript">
              $j("#buildType").change(function(e) {
                var selected = $j(this).find("option:selected");
                var order = location.search.toQueryParams()['order'];
                var url;
                if (selected.hasClass("user-project")) {
                  url = '${url}' + '&projectId=' + selected.val();
                } else {
                  url = '${url}' + '&' + selected.val();
                }
                if (order) {
                  url += '&order=' + order;
                }
                BS.openUrl(e, url);
                return false;
              });
            </script>
          </span>
        </form>
      </div>
    </td>
  </tr>
</table>

<c:set var="successRate">
  <span class="successRate successRate0${summary.successRateIdx}">
    <div class="success-rate__icon"></div>
    Success rate:
    <strong>
      <c:choose>
        <c:when test="${summary.successRate < 0}">--</c:when>
        <c:otherwise><fmt:formatNumber value="${summary.successRate * 100}"
                                       minFractionDigits="1"
                                       maxFractionDigits="1"/>%</c:otherwise>
      </c:choose>
    </strong>
  </span>
</c:set>
<c:set var="duration">
  <span class="duration tc-icon_before icon16 tc-icon_graph">
    Test duration:
    <span class="avg"><bs:millis value="${summary.avgDur}"/></span>
    <span class="min"><bs:millis value="${summary.minDur}"/></span>
    <span class="max"><bs:millis value="${summary.maxDur}"/></span>
  </span>
</c:set>
<c:set var="statsId" value="testStats"/>
<l:blockStateCss blocksType="Block_${statsId}" collapsedByDefault="false" id="${statsId}Dl"/>
<div class="testDetailsHeader tc-icon_before icon16 blockHeader expanded" id="${statsId}">${successRate}${duration}</div>
<table cellpadding="5px" class="topTable" id="${statsId}Dl">
  <tr>
    <td>
      <div class="testSummaryPane">
      <span class="shortStat">
        <c:set var="failureStyle" value=""/>
        <c:if test="${summary.failures > 0}"><c:set var="failureStyle" value="color:#ED2C10"/></c:if>
        <strong>${summary.totalRuns}</strong> runs / <strong style="${failureStyle}">${summary.failures}</strong> failures / <strong>${summary.timesIgnored}</strong> ignored
      </span>

      <span class="successRate">
        Success rate: <strong><c:choose><c:when test="${summary.successRate < 0}">--</c:when><c:otherwise><fmt:formatNumber value="${summary.successRate * 100}"
                                                                                                                            minFractionDigits="1"
                                                                                                                            maxFractionDigits="1"/>%</c:otherwise></c:choose></strong>
      </span>
      </div>
      <table class="durationTable">
        <tr>
          <td colspan="3" class="midHeader">Duration</td>
        </tr>
        <tr class="headerRow">
          <td>Average</td>
          <td>Minimum</td>
          <td>Maximum</td>
        </tr>
        <tr class="valueRow">
          <td><bs:millis value="${summary.avgDur}"/></td>
          <td><bs:millis value="${summary.minDur}"/></td>
          <td><bs:millis value="${summary.maxDur}"/></td>
        </tr>
        <tr>
          <td colspan="3" class="midHeader">Success duration</td>
        </tr>
        <tr class="headerRow">
          <td>Average</td>
          <td>Minimum</td>
          <td>Maximum</td>
        </tr>
        <tr class="valueRow">
          <td><bs:millis value="${summary.avgSuccessDur}"/></td>
          <td><bs:millis value="${summary.minSuccessDur}"/></td>
          <td><bs:millis value="${summary.maxSuccessDur}"/></td>
        </tr>
        <tr>
          <td colspan="3" class="midHeader">Failure duration</td>
        </tr>
        <tr class="headerRow">
          <td>Average</td>
          <td>Minimum</td>
          <td>Maximum</td>
        </tr>
        <tr class="valueRow">
          <td><bs:millis value="${not empty summary.avgFailureDur ? summary.avgFailureDur : 919191}"/></td>
          <td><bs:millis value="${summary.minFailureDur}"/></td>
          <td><bs:millis value="${summary.maxFailureDur}"/></td>
        </tr>
      </table>
    </td>
    <td>
      <div class="testDurationContents">
        <c:set var="graphUrl" value="/tests/testDurGraph.jsp"/>
        <c:import url="${graphUrl}">
          <c:param name="jsp">${graphUrl}</c:param>
        </c:import>
      </div>
    </td>
  </tr>
</table>

<ext:includeExtensions placeId = "<%= PlaceId.TEST_HISTORY %>"/>

<c:if test="${not empty resp and (resp.state.active or resp.state.fixed)}">
  <c:if test="${resp.state.active}">
    <c:set var="investigationNote">Investigator:
      <c:if test="${resp.responsibleUser == currentUser}">you</c:if>
      <c:if test="${resp.responsibleUser != currentUser}"><c:out value="${resp.responsibleUser.descriptiveName}"/></c:if>
    </c:set>
  </c:if>
  <c:if test="${resp.state.fixed}">
    <c:set var="investigationNote">Fixed by
      <c:out value="${resp.responsibleUser == currentUser ? 'you' : resp.responsibleUser.descriptiveName}"/>
    </c:set>
  </c:if>
  <c:set var="investigationNote"><span class="investigation"><bs:responsibleIcon responsibility="${resp}"/>${investigationNote}</span></c:set
></c:if
><c:if test="${test.muted}">
  <c:set var="muteNote">
    <c:set var="currentMuteInfo" value="${test.currentMuteInfo}"/>
    <c:set var="projectsMuteInfo" value="${currentMuteInfo.projectsMuteInfo}"/>
    <c:set var="inScope"
      ><c:choose>
        <c:when test="${not empty projectsMuteInfo}">
          <c:set var="num" value="${fn:length(projectsMuteInfo)}"
          />in <c:out value="${num}"/> project<bs:s val="${num}"/>
        </c:when>
        <c:otherwise>
          <c:set var="num" value="${fn:length(currentMuteInfo.buildTypeMuteInfo)}"
          />in <c:out value="${num}"/> build configuration<bs:s val="${num}"/>
        </c:otherwise>
      </c:choose
      ></c:set
    ><span class="mute"><span class="icon icon16 bp muted"></span>Muted ${inScope}</span>
  </c:set>
</c:if>

<c:if test="${not empty investigationNote or not empty muteNote}">
  <c:set var="investId" value="testInvest"/>
  <l:blockStateCss blocksType="Block_${investId}" collapsedByDefault="false" id="${investId}Dl"/>
  <div class="testDetailsHeader tc-icon_before icon16 blockHeader expanded" id="${investId}">${investigationNote}${muteNote}</div>
  <div id="${investId}Dl">
    <table id="investigation-section">
      <tr>
        <c:if test="${not empty investigationNote}">
          <td class="half">
            <bs:responsibleTooltip responsibilities="${allResp}" test="${test}" noActions="true"/>
          </td>
        </c:if>
        <c:if test="${not empty muteNote}">
          <td class="half">
            <bs:muteInfoTooltip test="${test}"/>
          </td>
        </c:if>
        <c:if test="${empty muteNote or empty investigationNote}">
          <td class="half">&nbsp;</td>
        </c:if>
      </tr>
    </table>
    <authz:authorize projectId="${test.projectId}" anyPermission="ASSIGN_INVESTIGATION,MANAGE_BUILD_PROBLEMS">
      <div class="actions">
        <tt:testInvestigationLinks test="${test}" buildId="" withFix="${not empty resp && resp.state.active}"/>
      </div>
    </authz:authorize>
  </div>
</c:if>

<c:url var="actionUrl" value="project.html"/>

<div id="testsInfo">
  <form id="testFilter" action="${actionUrl}" method="GET">

    <input type="hidden" name="projectId" value="${project.externalId}"/>
    <c:set var="bt"><c:if test="${not empty buildType}">${buildType.buildTypeId}</c:if></c:set>
    <input type="hidden" name="buildTypeId" value="${bt}"/>
    <input type="hidden" name="tab" value="testDetails"/>
    <input type="hidden" name="testNameId" value="${test.testNameId}"/>
    <input type="hidden" name="order" value="<%=order.name()%>">

    <%--@elvariable id="branchBean" type="jetbrains.buildServer.controllers.BranchBean"--%>
    <c:if test="${not empty branchBean}">
      <input type="hidden" name="branch_${project.externalId}" value="${branchBean.userBranch}"/>
    </c:if>

    <div class="testCountBlock">
      <label for="itemsCount">Builds to show:</label>
      <select name="itemsCount" id="itemsCount" onchange="$('testFilter').submit(); return true;">
        <c:set var="selectedValue" scope="request" value="${itemsCount}"/>

        <props:option value="50">50</props:option>
        <props:option value="100">100</props:option>
        <props:option value="500">500</props:option>
        <props:option value="-1">All</props:option>
      </select>
    </div>
    <strong>Test History</strong>
  </form>
</div>

<tt:testHistoryTable historyRecords="${historyRecords}" updateFormId="testFilter" showBuildTypes="${empty buildType}"/>

<c:set var="pagerUrlPattern">
  project.html?<c:forEach items="${param}" var="entry"
    ><c:if test="${entry.key != 'page'}">${entry.key}=<%=WebUtil.encode((String)((Map.Entry)pageContext.getAttribute("entry")).getValue())%>&</c:if
    ></c:forEach>page=[page]
</c:set>

<bs:pager place="bottom" urlPattern="${pagerUrlPattern}" pager="${historyPager}"/>

</div>

<script type="text/javascript">
  (function() {
    <l:blockState blocksType="Block_${statsId}"/>
    new BS.BlocksWithHeader('${statsId}');

    <c:if test="${not empty investId}">
      <l:blockState blocksType="Block_${investId}"/>
      new BS.BlocksWithHeader('${investId}');
    </c:if>

    BS.Branch.injectBranchParamToLinks($j("a.buildTypeName").parent(), "${project.externalId}");
    BS.Branch.baseUrl = "<c:url value="/project.html?projectId=${project.externalId}&tab=testDetails&testNameId=${test.testNameId}"/>";
  })();
</script>
</c:if>
