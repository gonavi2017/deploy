<%@include file="/include.jsp"%>
<%@ page import="jetbrains.buildServer.web.util.TreePrinter" %>
<c:if test="${not empty treePrinter}">
  <div id="depArtifacts" class="artifactsTree">
  <%
    TreePrinter printer = (TreePrinter)request.getAttribute("treePrinter");
    printer.print(out);
  %>
  </div>
<script type="text/javascript">
  autoInit_trees();
</script>
</c:if>
