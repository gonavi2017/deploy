<%@ include file="/include-internal.jsp"
%><jsp:useBean id="build" type="jetbrains.buildServer.serverSide.SBuild" scope="request"/>
<c:set var="url" value='${pageUrl}'/>
<div>
  <div>Choose the artifacts of build <bs:buildLinkFull build="${build}"/>:</div>
  <div id="artifactsTree"></div>
  <br/>
  <div id="hideNote" class="grayNote" style="display: none;">
    Hidden artifacts from the .teamcity directory are displayed. <a href="#" onclick="return showTree(false)">Hide</a>
  </div>
  <div id="showNote" class="grayNote">
    There are also hidden artifacts. <a href="#" onclick="return showTree(true)">Show</a>
  </div>
  <script type="text/javascript">
    window.showTree = function(showHidden) {
      if (showHidden) {
        BS.LazyTree.treeUrl = "${url}&showAll=true";
        BS.Util.show('hideNote');
        BS.Util.hide('showNote');
      } else {
        BS.LazyTree.treeUrl = "${url}";
        BS.Util.hide('hideNote');
        BS.Util.show('showNote');
      }
      BS.LazyTree.loadTree('artifactsTree');
      return false;
    };

    showTree(false);
  </script>
</div>