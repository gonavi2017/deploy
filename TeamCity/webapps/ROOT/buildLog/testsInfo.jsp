<%@ include file="../include-internal.jsp"
  %><%@ taglib prefix="props" tagdir="/WEB-INF/tags/props"
  %><%@ taglib prefix="tt" tagdir="/WEB-INF/tags/tests"
  %>

<!-- SEE css/buildLog/testsInfo.css for styles -->

<div id="testsInfo">
  <%@ include file="testInfoRefreshableInner.jsp" %>
</div>

<script>
  $j(function() {
    if (!BS.GraphPopup) {
      BS.GraphPopup = new BS.Popup(
          'testsDurationGraph', {
            delay: 0,
            hideDelay: -1,
            url: '<c:url value="/buildGraph.html?jsp=buildLog/testDuration.jsp&buildTypeId=${buildData.buildTypeExternalId}"/>',
            shift: {
              x: -100,
              y: 15
            },
            backgroundColor: 'white',
            loadingText: 'Loading chart...'
          });
      $('filterText').focus();
      enablePeriodicalRefresh();
    }
  })
</script>
