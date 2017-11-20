<%@ include file="/include.jsp" %>
<c:set var="pageTitle" value="Search Results" scope="request"/>
<bs:page>
<jsp:attribute name="head_include">
  <bs:linkCSS>
    /css/buildTypeSettings.css
    /css/filePopup.css
    /css/viewType.css
    /css/historyTable.css
    /css/agentsInfoPopup.css
    /css/pager.css
  </bs:linkCSS>
  <bs:linkScript>
    /js/bs/blocks.js
    /js/bs/blocksWithHeader.js
    /js/bs/blockWithHandle.js
    /js/bs/changesBlock.js
    /js/bs/collapseExpand.js
    /js/bs/pin.js

    /js/bs/runningBuilds.js
    /js/bs/testGroup.js

    /js/bs/systemProblemsMonitor.js
  </bs:linkScript>
  <script type="text/javascript">
    BS.Navigation.items = [
      {title: "Search Results", selected:true}
    ];
  </script>
</jsp:attribute>
<jsp:attribute name="body_include">
  <jsp:include page="searchResult.jsp"/>
</jsp:attribute>
</bs:page>
