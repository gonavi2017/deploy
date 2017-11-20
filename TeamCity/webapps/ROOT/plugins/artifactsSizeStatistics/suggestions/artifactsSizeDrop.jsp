<%@ include file="/include-internal.jsp"%>
<jsp:useBean id="buildType" type="jetbrains.buildServer.serverSide.SBuildType" scope="request"/>
<div class="suggestionItem">
  Builds of <admin:viewOrEditBuildTypeLinkFull buildType="${buildType}"/> publish artifacts.
  You can fail a build if <strong>artifacts size</strong> decreases or changes significantly.<bs:help file="Build+Failure+Conditions"/>

  <div class="suggestionAction">
    <c:set var="failureConditionsUrl"><admin:editBuildTypeLink buildTypeId="${buildType.externalId}" withoutLink="true" step="buildFailureConditions"/></c:set>
    <forms:addLink href="${failureConditionsUrl}&metricKey=VisibleArtifactsSize&moreOrLess=less#addFeature=BuildFailureOnMetric">Add Failure Condition</forms:addLink>
  </div>
</div>

