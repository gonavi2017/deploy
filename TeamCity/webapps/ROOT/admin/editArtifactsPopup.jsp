<%@ include file="/include-internal.jsp"%>
<jsp:useBean id="build" type="jetbrains.buildServer.serverSide.SBuild" scope="request"/>

<div>
  The latest finished build is
  <bs:buildTypeLink buildType="${build.buildType}">${build.buildType.fullName}</bs:buildTypeLink>
  <bs:buildLink build="${build}">#${build.buildNumber}</bs:buildLink><br>
  Select files to be published as artifacts from its checkout directory:
</div>

<div id="agentTree"></div>

<script type="text/javascript">
  BS.LazyTree.ignoreHashes = true;
  BS.LazyTree.treeUrl = window['base_uri'] + "/agent/tree.html?buildTypeId=${build.buildType.externalId}&buildId=${build.buildId}";
  BS.LazyTree.loadTree("agentTree");
</script>
