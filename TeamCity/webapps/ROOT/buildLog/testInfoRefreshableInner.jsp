<%@ page import="jetbrains.buildServer.web.util.WebUtil" %>
<%@ include file="../include-internal.jsp" %><%@
    taglib prefix="props" tagdir="/WEB-INF/tags/props" %><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests"
%><jsp:useBean id="buildStatistics" type="jetbrains.buildServer.serverSide.BuildStatistics" scope="request"
/><jsp:useBean id="buildData" type="jetbrains.buildServer.serverSide.SBuild" scope="request"
/><jsp:useBean id="testsForm" type="jetbrains.buildServer.controllers.viewLog.TestsTabForm" scope="request"
/><jsp:useBean id="oldForm" type="jetbrains.buildServer.controllers.viewLog.TestsTabForm" scope="request"
/><jsp:useBean id="tests" type="jetbrains.buildServer.controllers.viewLog.TestsTabData" scope="request"/>

<tt:setSelfLink buildData="${buildData}"/>

<div class="testsGeneral">
  <c:url var="grp_link" value="${selfLink}" scope="request">
    <c:param name="order" value="${testsForm.order}"/>
    <c:param name="recordsPerPage" value="${testsForm.recordsPerPage}"/>
    <c:param name="filterText" value="${testsForm.filterText}"/>
    <c:param name="status" value="${testsForm.status}"/>
  </c:url>

  <tt:setMyLink buildData="${buildData}" testsForm="${testsForm}"/>
  <a href="${myLink}" class="permaLink">Permalink</a>
  
  <c:set var="csv_filename"><%= WebUtil.getFilename(buildData)%>-tests.csv</c:set>
  <a class="downloadLink tc-icon_before icon16 tc-icon_download" href="<c:url value="/get/tests/buildId/${buildData.buildId}/${csv_filename}"/>"
     title="Download full list of all tests in CSV format">Download all tests in CSV</a>

  Total test count: <strong>${buildStatistics.allTestCount}</strong><tt:failedIgnored valFailed="${buildStatistics.failedTestCount}"
                                                                                      valIgnored="${buildStatistics.ignoredTestCount}"/>;
  total duration: <strong><bs:printTime time="${buildStatistics.totalDuration/1000}" showIfNotPositiveTime="&lt; 1s"/></strong>
</div>

<form onsubmit="updateTestInfo(); return false;" id="testFilter" name="testFilter" action="${selfLink}" method="POST">
  <div class="actionBar">
    <c:if test="${testsForm.pager.totalRecords > 20}">
      <span class="actionBarRight">
        <label for="recordsPerPage1">Show:</label>
        <select id="recordsPerPage1">
          <props:option value="20" currValue="${testsForm.recordsPerPage}">20</props:option>
          <props:option value="50" currValue="${testsForm.recordsPerPage}">50</props:option>
          <props:option value="100"  currValue="${testsForm.recordsPerPage}">100</props:option>
          <props:option value="500"  currValue="${testsForm.recordsPerPage}">500</props:option>
          <props:option value="1000" currValue="${testsForm.recordsPerPage}">1000</props:option>
          <props:option value="-1"  currValue="${testsForm.recordsPerPage}">All</props:option>
        </select> items
      </span>

      <script>
        $('recordsPerPage1').on("change", function() {
          document.forms.testFilter.recordsPerPage.value = $F('recordsPerPage1');
          updateTestInfo();
        });
      </script>
    </c:if>

    <span class="testFormFields">
      <span class="nowrap">
        <label class="firstLabel" for="currentGroup1">View: </label>
        <select id="currentGroup1" class="actionInput">
          <c:forEach items="${testsForm.availableGroups}" var="grp" >
            <props:option value="${grp.code}" currValue="${testsForm.currentGroup}">${grp.description}</props:option>
          </c:forEach>
        </select>
      </span>

      <span class="nowrap">
        <label for="filterText">containing: </label>
        <input class="actionInput" name="filterText" id="filterText" value="<c:out value="${testsForm.filterText}"/>"/>
      </span>

      <span class="nowrap">
        <label for="statusSelect">with: </label>
        <select id="statusSelect" name="status" onchange="updateTestInfo(); ">
          <props:option value="" selected="${empty testsForm.status}">any</props:option>
          <props:option value="FAILURE" currValue="${testsForm.status}">failed</props:option>
          <props:option value="FAILURE_NEW" currValue="${testsForm.status}">failed (only new)</props:option>
          <props:option value="UNKNOWN" currValue="${testsForm.status}">ignored</props:option>
          <props:option value="NORMAL" currValue="${testsForm.status}">successful</props:option>
        </select>
        <span class="actionInput">status</span>
      </span>

    </span>

    <forms:filterButton/>
    <c:if test="${testsForm.filtered}"><forms:resetFilter resetHandler="$('filterText').value='';$('statusSelect').selectedIndex=0;updateTestInfo();return false;"/></c:if>

    <forms:saving savingTitle="Updating tests table ..." className="progressRingInline" id="progressSave" />

    <input type="hidden" name="order" id="order" value="${testsForm.order}"/>
    <input type="hidden" name="recordsPerPage" value="${testsForm.recordsPerPage}"/>
    <input type="hidden" name="currentGroup" id="currentGroup" value="${testsForm.currentGroup}"/>
    <input type="hidden" name="scope" id="scope" value="${testsForm.scope}"/>
  </div>
</form>

<c:if test="${testsForm.filtered || !testsForm.testCurrentLevel || !testsForm.currentScope.empty1}">
  <div class="beforeTable">
    <div class="foundText">
      Found
      <c:if test="${!testsForm.testCurrentLevel}">
        <strong>${tests.foundGroupCount}</strong>
        <c:if test="${testsForm.filtered}">matching</c:if>
        <span style="text-transform: lowercase;"><bs:plural txt="${testsForm.currentLevel.description}"
                                                            val="${tests.foundGroupCount}"/></span>
        with
      </c:if>
      <strong>${tests.testCount}</strong>

      <c:if test="${testsForm.filtered and testsForm.testCurrentLevel}">matching</c:if>

      test<bs:s val="${tests.testCount}"/><tt:failedIgnored valFailed="${tests.failedTestCount}"
                                                            valIgnored="${tests.ignoredTestCount}"
      /><c:if test="${tests.testCount > 0}">; duration: <strong><bs:printTime time="${tests.foundDuration/1000}"
                                                                              showIfNotPositiveTime="&lt; 1s"/></strong></c:if>
    </div>

  <c:if test="${not testsForm.currentScope.empty1}">
    <div class="divSection">
      <span class="labelBlock">Current scope:</span>
      <tt:scopeCrumbs group="${testsForm.currentScope}" levelToSet="${testsForm.currentGroup}"/>
    </div>
  </c:if>
  </div> <!-- beforeTable -->
  <div class="clr"></div>
</c:if>

<script type="text/javascript">
(function () {
  window.onpopstate = function(event) {
    if (event.state) {
      updateTestInfo(event.state.levelToSet, event.state.scope);
    }
  };

  window.updateTestInfo = function updateTestInfo(levelToSet, scope) {
    if (levelToSet) {
      $('currentGroup').value = levelToSet;
    }

    if (scope) {
      $('scope').value = scope;
    }

    $('buildResults').refresh('progressSave', Form.serialize('testFilter')).
      then(function() {
        initUpdatePreventer();
      });
  };

  if ($('currentGroup1')) {
    $('currentGroup1').on("change", function() {
      document.forms.testFilter.currentGroup.value = $F('currentGroup1');
      updateTestInfo();
    });
  }

  $('filterText').activate();


  var $container;
  var inputs;
  var values;

  function initUpdatePreventer () {
    BS.unblockRefresh('actionBarInFocus');
    BS.unblockRefresh('valuesChanged');

    $container = $j('.actionBar');
    inputs = $container.find('input:not([type]), input[type="text"], select');
    values = {};

    inputs.each(function (i, input) {
      var $input = $j(input);
      values[$input.attr('id')] = $input.val();
    });
  }

  var valuesChanged = function () {
    return Object.keys(values).some(function (key) {
      return $container.find(BS.Util.escapeId(key)).val() != values[key];
    });
  };

  initUpdatePreventer();

  inputs.on('focus', function () {
    BS.blockRefreshPermanently('actionBarInFocus');
  });

  inputs.on('blur', function () {
    BS.unblockRefresh('actionBarInFocus');
  });

  inputs.on('input', function () {
    BS[valuesChanged() ? 'blockRefreshPermanently' : 'unblockRefresh']('valuesChanged');
  });
})()
</script>

<c:choose>
  <c:when test="${testsForm.testCurrentLevel}">
    <table class="testList dark sortable borderBottom">
      <thead>
        <tr>
          <th class="test-status firstCell sortable"><span id="STATUS_IMPORTANCE_ASC">Status</span></th>
          <th class="sortable"><span id="NAME_ASC">Test</span></th>
          <th class="duration sortable"><span id="DURATION_DESC">Duration</span></th>
          <th class="orderNum lastCell sortable"><span id="NATURAL_ASC" style="padding-right: 0;">Order#</span></th>
        </tr>
      </thead>
      <tt:testGroup testItems="${tests.testRuns}" buildData="${buildData}" levelToSet="${testsForm.currentGroup}" maxTestNameLength="120"/>
    </table>
  </c:when>
  <c:otherwise>
    <table class="testList dark sortable borderBottom">
      <thead>
        <tr>
          <th class="sortable"><span id="NAME_ASC">Name</span></th>
          <th class="duration sortable"><span id="DURATION_DESC">Duration</span></th>
          <th class="tests lastCell sortable"><span id="TESTS_DESC">Tests</span></th>
        </tr>
      </thead>
      <c:forEach items="${tests.groups}" var="group">
        <tr>
          <td class="nameT">
            <tt:groupName group="${group.groupName}" currLevel="${testsForm.currentGroup}" prevLevel="${testsForm.prevGroup}"/>
          </td>
          <td class="duration"><tt:duration duration="${group.duration}"/></td>
          <td class="tests"><c:out value="${group.testCount}"
              /><c:if test="${empty testsForm.status}"><tt:failedIgnored valFailed="${group.failedTestCount}"
                                                                         valIgnored="${group.ignoredTestCount}"
                                                                         noText="true"/></c:if></td>
        </tr>
      </c:forEach>
    </table>
  </c:otherwise>
</c:choose>

<bs:pager place="bottom" pager="${testsForm.pager}" urlPattern="${selfLink}&pager.currentPage=[page]" />

<script type="text/javascript">
  $('STATUS_IMPORTANCE_ASC', 'NAME_ASC', 'DURATION_DESC', 'NATURAL_ASC', 'TESTS_DESC').each(function(col) {
    if (!col) return;
    var newOrder = col.id;
    var colId = col.id;

    if ('${testsForm.order}'.replace(/ASC/, 'DESC') == colId.replace(/ASC/, 'DESC')) {
      if (colId.startsWith('NATURAL')) {
        col.innerHTML += "&nbsp;&nbsp;&nbsp;&nbsp;";
      }
      $(col).addClassName('${testsForm.order}'.indexOf('DESC') > 0 ? "sortedDesc" : "sortedAsc");
      $('order').value = '${testsForm.order}';

      // Change order direction for currently sorted column:
      newOrder = '${testsForm.order}';
      if (newOrder.indexOf('DESC') > 0) {
        newOrder = newOrder.replace(/DESC/, 'ASC');
      }
      else {
        newOrder = newOrder.replace(/ASC/, 'DESC');
      }
    }

    col.parentNode.onclick = function() {
      $('buildResults').refresh('progressSave', 'order=' + newOrder);
    }
  });

<c:if test="${testsForm.testCurrentLevel}">
  (function() {
  var testGraphData = [
<c:forEach items="${tests.testRuns}" var="testRun" varStatus="count" end="1000">
    {id: ${testRun.testRunId}, nameId: '${testRun.test.testNameId}', name: '<bs:forJs>${testRun.test.name.asString}</bs:forJs>'}<c:if test="${!count.last}">, </c:if></c:forEach>
  ];

  for(var i = 0; i < testGraphData.length; i++) {
    var data = testGraphData[i];
    var el = $('trends' + data.id);
    if (el) {
      el.graph_data = data;
      el.on("click", function() {
        BS.GraphPopup.showPopupNearElement(this, {
          parameters: 'testNameId=' + this.graph_data.nameId + '&testName=' + encodeURIComponent(this.graph_data.name) + '&buildId=${buildData.buildId}'
        });
        return false;
      }.bind(el));
    }
  }
  })();
</c:if>

</script>
