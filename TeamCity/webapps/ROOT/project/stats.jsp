<%@ page import="jetbrains.buildServer.web.openapi.PlaceId" %><%@
  taglib prefix="ext" tagdir="/WEB-INF/tags/ext"%><%@
  taglib prefix="bs" tagdir="/WEB-INF/tags"%>

<ext:includeExtensions placeId="<%=PlaceId.PROJECT_STATS_FRAGMENT%>"/>

<div id="nothingMessage" style="display: none; margin-bottom: 16px">
  There are no available charts for this project. Please read the <bs:helpLink file="Custom+Chart" anchor="AddingCustomCharts">documentation</bs:helpLink> on adding custom project charts.
</div>

<script type="text/javascript">
  $j(function() {
    if ($j("div.GraphContainer").length == 0) {
      $j('#nothingMessage').show();
    }
  });
</script>