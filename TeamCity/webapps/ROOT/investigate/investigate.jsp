<%@ include file="../include-internal.jsp" %><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@
    taglib prefix="l" tagdir="/WEB-INF/tags/layout" %><%@
    taglib prefix="problems" tagdir="/WEB-INF/tags/problems" %><%@
    taglib prefix="resp" tagdir="/WEB-INF/tags/responsible"
%><bs:page>
  <jsp:attribute name="page_title">My Investigations</jsp:attribute>
  <jsp:attribute name="head_include">
    <bs:linkCSS>
      /css/filePopup.css
      /css/changeLog.css
      /css/viewModification.css
    </bs:linkCSS>
    <bs:linkScript>
      /js/bs/blocks.js
      /js/bs/blockWithHandle.js

      /js/bs/testGroup.js

      /js/bs/systemProblemsMonitor.js
      /js/bs/collapseExpand.js
      /js/bs/visibleDialog.js
      /js/bs/overflower.js

      /js/bs/blocksWithHeader.js
      /js/bs/buildResultsDiv.js
      /js/bs/testDetails.js
    </bs:linkScript>
    <script type="text/javascript">
      BS.Navigation.items = [
          {title: "My Investigations", selected:true}
      ];
    </script>
  </jsp:attribute>
  <jsp:attribute name="body_include">
    <script type="application/javascript">BS.Navigation.selectMySettingsTab();</script>
    <c:set var="doNotHighlightMyInvestigation" value="true" scope="request"/>
    <%@ include file="../investigationsList.jspf" %>
  </jsp:attribute>
</bs:page>
