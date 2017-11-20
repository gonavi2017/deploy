<%--jsp:useBean id="stat" type="jetbrains.buildServer.serverSide.RequestStat"/--%>
<%@ include file="/include-internal.jsp" %>
<style type="text/css">
  div.requestStatContainer {
    position: fixed;
    bottom: 1em;
    z-index: 1000;
  }
  .requestStatToggle {
    width: 1em;
    cursor: pointer;
    vertical-align: bottom;
  }
  div.requestStat {
    border: 1px solid gray;
    background-color: #EBEDEF;
    padding-left: 1em;
    padding-right: 1em;
    padding-top: 0.5em;
    padding-bottom: 0.5em;
    display: none;
  }
  div.requestStatSqlDetails {
    height: 20em;
    overflow-y: scroll;
    display: none;
  }
  div.requestStatSqlDetails td {
    border-bottom: 1px gray solid;
  }
</style>
<script type="text/javascript">
  toggleRequestStat = function() {
    $j('#requestStat').toggle();
  };
  toggleSqlDetails = function() {
    $j('#requestStatSqlDetails').toggle();
  }
</script>
<div class="requestStatContainer">
  <table>
    <tr>
      <td class="requestStatToggle" onclick="toggleRequestStat()">
        ...
      </td>
      <td>
        <div class="requestStat" id="requestStat">
          <div>Request duration: ${stat.durationMillis}ms</div>
          <c:set var="spt" value="${stat.safePointTime}"/>
          <c:if test="${spt != -1}">
            <div>SafePoint time: ${spt}ms</div>
          </c:if>
          <c:set var="cpu" value="${stat.cpuTime}"/>
          <c:if test="${cpu != -1}">
            <div>CPU time: ${cpu}ms</div>
          </c:if>
          <c:set var="blockedTime" value="${stat.blockedTime}"/>
          <c:if test="${blockedTime != -1}">
            <div>Blocked time: ${blockedTime}ms</div>
          </c:if>
          <c:if test="${stat.DBRequestsCount > 0}">
            <div>DB requests count: ${stat.DBRequestsCount}, duration: ${stat.DBRequestsDurationMillis}ms <a href="javascript:;" onclick="toggleSqlDetails()">details</a></div>
            <div id="requestStatSqlDetails" class="requestStatSqlDetails">
              <table>
                <c:forEach var="dbReq" items="${stat.DBRequests}">
                  <tr>
                    <td style="width: 50em;"><c:out value="${dbReq.query}"/></td>
                    <td>
                      <c:forEach var="p" items="${dbReq.params}" varStatus="status">
                        '<c:out value="${p}"/>'<c:if test="${not status.last}">,</c:if>
                      </c:forEach>
                    </td>
                    <td style="vertical-align: top;">${dbReq.duration}ms</td>
                  </tr>
                </c:forEach>
              </table>
            </div>
          </c:if>
        </div>
      </td>
    </tr>
  </table>
</div>
