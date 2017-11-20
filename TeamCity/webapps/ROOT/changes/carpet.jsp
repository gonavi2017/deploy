<%@ include file="../include-internal.jsp"%>
<c:if test="${changeDetailsBean.problemsSectionNeeded}">
  <c:set var="problemText"><%@ include file="_changeProblemSummary.jspf" %></c:set>
  <jsp:useBean id="cachedChangeStatus" type="jetbrains.buildServer.controllers.changes.OneChangeStatus" scope="request"/>
  <jsp:setProperty name="cachedChangeStatus" property="statusText" value="${problemText}"/>
</c:if>

<script type="text/javascript">
  (function() {

    // Array of  objects, where firt element is build type json object, and the second element is status string:
    // [{buildType: {id: "bt3", name: "some name", fullName: "some full name"}, statusText: "successful", (optional)branch: "branch_name"}]

    var node = BS.changeTree.getNode('ct_node_${carpetId}');
    if (node) {
      node.updateCarpetAndStatusText(${configurationStatusMapJson},
        ${changeDetailsBean.bigProblem}, '<bs:forJs>${problemText}</bs:forJs>');
    }

  })();
</script>
