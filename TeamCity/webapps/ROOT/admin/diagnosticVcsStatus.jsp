<%@ include file="/include-internal.jsp" %>

<jsp:useBean id="vcsRootStatusBean" type="jetbrains.buildServer.diagnostic.web.DiagnosticVcsStatusBean" scope="request"/>
<c:set var="total" value="${vcsRootStatusBean.totalNumberOfInstances}"/>

<style>
  .operationRequesters {
    margin-left: 10px;
  }
  .operationRequesters td {
    padding: 2px 4px;
  }
</style>

<form action="${pageUrl}" method="get" style="margin-top: 0.5em;">
  <table class="runnerFormTable" style="width: 100%;">
    <tr class="groupingTitle">
      <td>Checking for changes status</td>
    </tr>
    <tr>
      <td>
        <div>
          Number of monitored VCS Roots (after parameters resolution): <strong><c:out value="${total}"/></strong>
        </div>
        <div>
          Number of VCS roots with disabled polling mode (commit hooks): <strong><c:out value="${vcsRootStatusBean.noPollingCount}"/></strong>
        </div>
        <div>
          Waiting in the queue: <strong><c:out value="${vcsRootStatusBean.scheduledInstances}"/></strong>
        </div>
        <div>
          Started checking for changes: <strong><c:out value="${vcsRootStatusBean.checkingForChangesStartedInstances}"/></strong>
        </div>
        <div>
          Latest requestors for changes collecting:
        </div>
        <table class="operationRequesters">
        <c:forEach items="${vcsRootStatusBean.requestors}" var="entry">
            <tr>
              <td>${entry.key.description}:</td>
              <td><strong>${entry.value}</strong></td>
            </tr>
        </c:forEach>
        </table>
      </td>
    </tr>
    <c:if test="${vcsRootStatusBean.totalNumberOfInstances > 0}">
      <tr class="groupingTitle">
        <td>Checking for changes duration</td>
      </tr>
      <tr>
      <td>
      Checking for changes duration threshold: <forms:textField name="durationThresholdSecs" value="${vcsRootStatusBean.durationThresholdSecs}" style="width: 5em;"/> seconds <input type="submit" class="btn btn_mini" value="Find VCS roots"/>

      <c:set var="foundRoots" value="${fn:length(vcsRootStatusBean.slowInstances)}"/>

      <p>Found <strong><c:out value="${foundRoots}"/></strong> VCS Root<bs:s val="${foundRoots}"/> with checking for changes duration &gt; <strong>${vcsRootStatusBean.durationThresholdSecs}</strong> seconds.</p>

      <c:if test="${not empty vcsRootStatusBean.slowInstances}">
        <l:tableWithHighlighting className="settings runnerFormTable" style="width: auto">
          <tr>
            <th class="name">Parent Id - Id</th>
            <th class="name">VCS Root name</th>
            <th class="name" style="width: 10em;">Duration (seconds)</th>
          </tr>
          <c:forEach items="${vcsRootStatusBean.slowInstances}" var="vcsRootStat">
            <c:set var="vri" value="${vcsRootStat.rootInstance}"/>

            <tr>
              <td class="highlight" style="vertical-align: top;"><c:out value="${vri.parent.id}"/> - <c:out value="${vri.id}"/></td>
              <td class="highlight" style="vertical-align: top;">
                <a href="javascript:;" style="float: right" onclick="$('parameters_${vri.id}').toggle(); if (this.innerHTML.indexOf('show') != -1 ) { this.innerHTML = '&laquo; hide details' } else { this.innerHTML = 'show details &raquo;' }">show details &raquo;</a>
                <admin:vcsRootName vcsRoot="${vri.parent}" editingScope="" cameFromUrl="${pageUrl}"/>
                <div id="parameters_${vri.id}" style="display: none;">
                  <c:forEach items="${vcsRootStat.rootInstanceParameters}" var="e">
                    <c:out value="${e.key}"/>: <c:out value="${e.value}"/><br/>
                  </c:forEach>
                  <br/>
                  effective changes checking interval: <bs:printTime time="${vri.effectiveModificationCheckInterval}"/><br/>
                  <c:if test="${not empty vri.lastFinishChangesCollectingTime}">
                    last changes collection finished: <bs:date value="${vri.lastFinishChangesCollectingTime}"/><br/>
                  </c:if>
                  last changes collection requestor: ${vri.lastRequestor}<br/>

                  <br/>

                  <c:set var="progress" value="${vcsRootStat.rootProgressMessages}"/>
                  <c:if test="${not empty progress}">
                    <br/>
                    progress:<br/>
                    <c:forEach items="${progress}" var="msg">
                      <c:out value="${msg}"/><br/>
                    </c:forEach>
                  </c:if>
                </div>
              </td>
              <td class="highlight" style="vertical-align: top;">
                <fmt:formatNumber value="${vcsRootStat.durationMillis / 1000.0}" maxFractionDigits="2"/> <c:if test="${not vcsRootStat.finished}">(in progress)</c:if><c:if
                  test="${not empty vcsRootStat.scheduledMillis}">, <fmt:formatNumber value="${vcsRootStat.scheduledMillis / 1000.0}" maxFractionDigits="2"/> in queue</c:if>
                <c:if test="${vcsRootStat.durationMillis / 1000.0 > vri.effectiveModificationCheckInterval}">
                  <span class="error">checking for changes interval (<strong>${vri.effectiveModificationCheckInterval}</strong> seconds) exceeded</span>
                </c:if>
              </td>
            </tr>
          </c:forEach>
        </l:tableWithHighlighting>
      </c:if>

      <input type="hidden" name="item" value="diagnostics"/>
      <input type="hidden" name="tab" value="vcsStatus"/>
      </td>
      </tr>

    </c:if>
  </table>

</form>
