<%@ include file="/include-internal.jsp" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/tags" %>

<jsp:useBean id="agentDetailInfo" scope="request" type="jetbrains.buildServer.controllers.agent.AgentDetailInfo"/>
<jsp:useBean id="bean" scope="request" type="jetbrains.buildServer.controllers.agent.AgentHistoryBean"/>
<jsp:useBean id="buildTypeBeans" scope="request" type="java.util.List<jetbrains.buildServer.serverSide.SBuildType>"/>

<c:set var="builds" value="${bean.rows}"/>
<c:url var="pagerUrlPattern"
       value="/agentDetails.html?${agentDetailInfo.urlParameters}&tab=agentHistory&buildTypeId=${bean.buildTypeId}&page=[page]"/>

<div class="clearfix" style="margin-bottom: .5em">
  <c:if test="${bean.totalRowsNumber > 0}">
    <div class="buildTypeSelector actionBar">
      <span class="nowrap">
        <label class="firstLabel" for="buildType">Filter by:</label>
        <c:url value="/agentDetails.html?${agentDetailInfo.urlParameters}&tab=agentHistory&page=1" var="url"/>
        <bs:buildTypesFilter buildTypes="${buildTypeBeans}" selectedBuildTypeId="${bean.buildTypeId}" url="${url}"/>
      </span>
    </div>
  </c:if>

  <p class="note">
    <b>${bean.totalRowsNumber}</b> builds were run <c:if test="${not empty bean.buildTypeId}">in this build configuration</c:if> on this agent.
  </p>
</div>

<c:if test="${bean.totalRowsNumber > 0}">
  <c:set var="showAgent" value="${agentDetailInfo.agentType}"/>
  <table class="historyList dark borderBottom">
    <thead>
      <tr>
        <th class="buildType">Build Configuration</th>
        <th class="branch">Branch</th>
        <th class="buildNumber">#</th>
        <th>Build</th>
        <th>Artifacts</th>
        <th>Changes</th>
        <th>Started</th>
        <th>Duration</th>
        <c:if test="${showAgent}">
          <th>Agent</th>
        </c:if>
      </tr>
    </thead>

    <c:forEach var="entry" items="${builds}" varStatus="recordStatus">
      <jsp:useBean id="entry" type="jetbrains.buildServer.serverSide.SFinishedBuild"/>
      <c:set var="rowClass" value="${not empty entry.canceledInfo ? 'cancelledBuild' : ''}"/>
      <c:set var="rowClass" value="${rowClass} ${entry.outOfChangesSequence ? 'outOfSequence ' : ''}"/>
      <c:set var="rowClass" value="${rowClass} ${entry.internalError ? 'internalError ' : ''}"/>

      <tr class="${rowClass}">
        <bs:buildRow build="${entry}" rowClass="${rowClass}"
                     showBranchName="true"
                     showBuildNumber="true"
                     showBuildTypeName="true"
                     showStatus="true"
                     showArtifacts="true"
                     showCompactArtifacts="true"
                     showChanges="true"
                     showStartDate="true"
                     showDuration="true"
                     showAgent="${showAgent}"/>
      </tr>
    </c:forEach>
  </table>

  <c:if test="${bean.pager.totalRecords > 0}">
    <bs:pager place="bottom" urlPattern="${pagerUrlPattern}" pager="${bean.pager}"/>
  </c:if>
</c:if>

<script type="text/javascript">
  BS.blockRefreshPermanently();
</script>
