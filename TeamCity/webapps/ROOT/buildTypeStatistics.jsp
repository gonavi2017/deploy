<%@ page import="jetbrains.buildServer.web.openapi.PlaceId"
  %><%@include file="/include-internal.jsp"
  %><%@taglib prefix="stats" tagdir="/WEB-INF/tags/graph"
  %><%@ include file="_subscribeToCommonBuildTypeEvents.jspf"
%><style type="text/css">
  #agentsFilterTimeToFixStatistics {
    display: none;
  }
  #showFailedTimeToFixStatistics {
    display: none;
  }
</style>
<br />
<stats:buildGraph id="SuccessRate" isPredefined="${true}" valueType="SuccessRate" defaultFilter="showFailed,averaged" hideFilters="showFailed,averaged,forceZero,yAxisType"
                  hints="rendererB,itemLabels"/>
<stats:buildGraph id="BuildDurationNetTimeStatistics" isPredefined="${true}" valueType="BuildDurationNetTime" hideFilters=""/>
<stats:buildGraph id="TimeInQueueStatistics" isPredefined="${true}" valueType="TimeSpentInQueue" defaultFilter="showFailed" hideFilters="series,markers,showFailed"/>
<%--<stats:buildGraph id="TotalBuildDuration" isPredefined="${true}" valueType="BuildDuration"/>--%>
<stats:buildGraph id="TestCount" isPredefined="${true}" valueType="TestCount" defaultFilter="showFailed" hideFilters="averaged"/>

<%--@elvariable id="buildType" type="jetbrains.buildServer.serverSide.SBuildType"--%>

<stats:buildGraph id="TimeToFixStatistics" isPredefined="${true}" valueType="MaxTimeToFixTestGraph" defaultFilter="showFailed" hideFilters=""/>

<ext:includeExtensions placeId="<%=PlaceId.BUILD_CONF_STATISTICS_FRAGMENT%>"/>