<%@ include file="/include-internal.jsp"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin"
%><%@ taglib prefix="tags" tagdir="/WEB-INF/tags/tags"
%><jsp:useBean id="healthStatusItem" type="jetbrains.buildServer.serverSide.healthStatus.HealthStatusItem" scope="request"
/><c:set var="data" value="${healthStatusItem.additionalData}"
/>
<c:choose>
  <c:when test="${data.gcOverheadWarning}">
    TeamCity server is suffering from low memory problems. More than <strong>${util:formatPercent(data.gcOverhead, 1)}</strong> of CPU time was spent in memory cleaning.
    ${util:formatFileSize(data.heap.used, 0)} used of ${util:formatFileSize(data.heap.max, 0)} total heap available. See the TeamCity
    <bs:helpLink file="Installing+and+Configuring+the+TeamCity+Server" anchor="SettingUpMemorysettingsforTeamCityServer">documentation</bs:helpLink> for possible solutions.
  </c:when>
  <c:when test="${data.singlePoolUsage}">
    TeamCity server memory usage for <strong>${data.poolName}</strong> pool exceeded <strong>${util:formatPercent(data.averageMemoryUsagePercent, 100)}</strong> of
    <strong>${util:formatFileSize(data.maxSize, 0)}</strong> maximum available. ${util:formatFileSize(data.heap.used, 0)} used of ${util:formatFileSize(data.heap.max, 0)} total heap available.
    See the TeamCity <bs:helpLink file="Installing+and+Configuring+the+TeamCity+Server" anchor="SettingUpMemorysettingsforTeamCityServer">documentation</bs:helpLink> for possible solutions.
  </c:when>
  <c:when test="${data.permGenUsage}">
    TeamCity server memory usage for <strong>PermGen</strong> pool exceeded <strong>${util:formatPercent(data.averageMemoryUsagePercent, 100)}</strong> of
    <strong>${util:formatFileSize(data.maxSize, 0)}</strong> maximum available. It's recommended to increase maximum PermGen pool size as described in
    <bs:helpLink file="Installing+and+Configuring+the+TeamCity+Server" anchor="SettingUpMemorysettingsforTeamCityServer">documentation</bs:helpLink>.
  </c:when>
  <c:when test="${data.totalMemoryUsage}">
    Average TeamCity server memory usage during the last <strong>${data.statisticCalculationTimeMinutes}</strong> minutes exceeded
    <strong>${util:formatPercent(data.averageMemoryUsagePercent, 100)}</strong> of <strong>${util:formatFileSize(data.maxSize, 0)}</strong> total heap available.
    This can cause significant server slowdown.
    See the TeamCity <bs:helpLink file="Installing+and+Configuring+the+TeamCity+Server" anchor="SettingUpMemorysettingsforTeamCityServer">documentation</bs:helpLink> for possible solutions.
  </c:when>
</c:choose>