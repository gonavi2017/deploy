<%@ include file="/include-internal.jsp"%>
<jsp:useBean id="buildType" type="jetbrains.buildServer.serverSide.SBuildType" scope="request"/>
<div class="suggestionItem">
  Builds of <admin:editBuildTypeLinkFull buildType="${buildType}"/> produce inspection reports.
  You can fail a build if number of <strong>inspection errors</strong> reaches some threshold. <bs:help file="Build+Failure+Conditions"/>

  <div class="suggestionAction">
    <c:set var="failureConditionsUrl"><admin:editBuildTypeLink buildTypeId="${buildType.externalId}" withoutLink="true" step="buildFailureConditions"/></c:set>
    <forms:addLink href="${failureConditionsUrl}&metricKey=InspectionStatsE#addFeature=BuildFailureOnMetric">Add Failure Condition</forms:addLink>
  </div>
</div>

