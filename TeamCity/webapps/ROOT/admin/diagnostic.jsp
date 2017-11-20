<%--@elvariable id="threadDumpSuffix" type="java.lang.String"--%>
<%--@elvariable id="nodesDiagnostics" type="java.util.List<jetbrains.buildServer.diagnostic.web.NodeDiagnosticsDetails>"--%>
<%--@elvariable id="localServerId" type="java.lang.String"--%>
<%--@elvariable id="nodes" type="java.util.List<jetbrains.buildServer.serverSide.TeamCityNode>"--%>
<%@include file="/include-internal.jsp"%>
<style type="text/css">
  .btn-group .btn_append {
    margin-left: -5px;
    padding-top: 5px;
    padding-bottom: 6px;
    border-radius: 0px 4px 4px 0px;
  }

  .runnerFormTable td {
    padding: 15px 0 15px 4px;
  }

  .memoryUsageType {
    margin-left: 15px;
  }

  .chartCell {
    vertical-align: top;
  }

  .chartLegend {
    margin-left: 15px;
  }

  .chartLegend table {
    font-size: inherit !important;
    color: inherit !important;
  }

  .chartLegend table td {
    padding-top: 0;
    padding-bottom: 0;
  }

  .chartTitle {
    padding-bottom: 8px;
  }

  .chart {
    padding-bottom: 20px;
  }

  .threadDumpAdvancedDialog {
    width: 25em;
  }

  .threadDumpAdvancedDialog .pathField input {
    width: 100%;
  }

  .threadDumpAdvancedDialog .pathField .smallNote {
    margin-left: 11.5em;
  }

  .threadDumpAdvancedDialog .error {
    margin-left: 4em;
  }

  .chartHolder .no_data_label {
    text-align: center;
    position: relative;
    top: 46%;
    margin-left: 27px;
    z-index: 1;
  }

  table.nodeDiagnosticInfo {
    width: 100%;
  }

  table.nodeDiagnosticInfo td table.runnerFormTable, table.nodeDiagnosticInfo td table.chartsContainer {
    margin-top: 0.5em;
  }

  div.diagnosticDetails {
    padding: 1em 1em 1em 1em;
    width: 100%;
    border-left: 1px solid #CECECE;
    border-bottom: 1px solid #CECECE;
    margin-bottom: 1em;
    margin-top: -1em;
  }

  div.diagnosticDetails.singleNode {
    border: none;
    padding: 1em 0;
  }

  div.diagnosticDetails h2 {
    border: none;
  }

  .blockHeader  {
    background-color: #F3F5F7;
  }

  .loadingNodeDetails {
    float: none
  }
</style>

<bs:linkScript>
  /js/bs/blocks.js
  /js/bs/blocksWithHeader.js
  /js/bs/jvmStatusForm.js
  /js/bs/chart.js
  /js/flot/jquery.flot.js
  /js/flot/excanvas.min.js
  /js/flot/jquery.flot.selection.min.js
  /js/flot/jquery.flot.time.min.js
</bs:linkScript>

<form action="<c:url value='/admin/diagnostic.html'/>" method="post" id="jvmStatusForm" style="padding:0; margin: 0.5em 0">
    <jsp:include page="/admin/nodeDiagnostic.html">
      <jsp:param name="serverId" value="${localServerId}"/>
      <jsp:param name="oneNodeMode" value="${empty nodes}"/>
    </jsp:include>

    <c:forEach items="${nodes}" var="node">
      <c:set var="blockId" value="node${node.id}Details"/>
      <div id="${blockId}" data-server-id="${node.id}" class="remoteNodeDetailBlock">
        <div class="diagnosticDetails ${node.current ? 'currentNode' : ''}" >
          <h2 style="border: none">${node.mode.displayName} (<a href='<c:out value="${node.url}"/>' target="_blank"><c:out value="${node.url}"/></a>)</h2>
          <forms:progressRing className="loadingNodeDetails"/> Loading details...
        </div>
      </div>
    </c:forEach>

  <input type="hidden" name="actionName" value=""/>
</form>
<bs:dialog dialogId="takeThreadDumpPopup" title="Save Thread Dump" closeCommand="BS.ThreadDumpAdvanced.close()" dialogClass="threadDumpAdvancedDialog">
  <form action="<c:url value='/admin/diagnostic.html'/>" id="threadDumpAdvancedForm">
    <div>
      <label for="threadDumpPath">Suffix: </label>
      <div class="pathField">
        <forms:textField name="threadDumpPath" value="${threadDumpSuffix}"/>
        <span class="smallNote" style="margin-left: 0">thread dump will be saved with name "&lt;current time&gt;-&lt;suffix&gt;.txt"</span>
      </div>
    </div>
    <div class="error" id="errorsHolder"></div>
    <div>
      <div class="popupSaveButtonsBlock">
        <button onclick="BS.ThreadDumpAdvanced.takeThreadDump(); return false;" id="threadDumpAdvanced" class="btn btn_primary submitButton submitChartXml">Save</button>
        <button onclick="return false;" class="btn cancel closeAdvancedThreadDump">Cancel</button>
      </div>
      <input type="hidden" name="actionName" value="threadDump"/>
    </div>
  </form>
</bs:dialog>
<script>
  $j(function() {
    $j(".closeAdvancedThreadDump").click(function() {
      BS.ThreadDumpAdvanced.close();
      return false;
    });
    $j("#threadDumpMoreOptions").click(function() {
      BS.ThreadDumpAdvanced.showNear(this);
      return false;
    });
    $j(BS.AdminDiagnostics.installNodeDiagnostics);
  });
</script>
