<%@ include file="/include-internal.jsp" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<jsp:useBean id="now" class="java.util.Date"/>
<jsp:useBean id="cleanupPoliciesForm"
             type="jetbrains.buildServer.controllers.admin.cleanup.CleanupPoliciesForm" scope="request"/>

<h2>Clean-up settings <bs:help file="Clean-Up"/></h2>

<table class="runnerFormTable">
  <tr>
    <th>Periodical clean-up:</th>
    <td>
      <%@ include file="_cleanupEnableDisable.jspf" %>
    </td>
  </tr>
</table>

<%@ include file="_cleanupPoliciesForm.jspf" %>

<h2 class="cleanUp">Disk usage</h2>

<table class="runnerFormTable">
  <tr>
    <td>
      <div>
        <span id="freeSpaceHolder">
          Updating... <forms:progressRing className=" "/>
        </span>
        <a href="<c:url value='admin.html?item=diskUsage'/>">View disk usage report &raquo;</a>
      </div>
    </td>
  </tr>
</table>
<script type="text/javascript">
  $j(BS.Cleanup.updateOverallDiskUsage);
</script>
