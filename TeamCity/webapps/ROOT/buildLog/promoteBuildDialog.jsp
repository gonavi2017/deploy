<%@ page import="jetbrains.buildServer.serverSide.Branch" %>
<%@ taglib prefix="util" uri="/WEB-INF/functions/util" %>
<%@ include file="/include-internal.jsp" %>
<jsp:useBean id="build" type="jetbrains.buildServer.serverSide.SBuild" scope="request"/>
<jsp:useBean id="dependencyRefs" type="java.util.List" scope="request"/>
<jsp:useBean id="environments" type="java.util.List" scope="request"/>
<jsp:useBean id="modificationIdsMap" type="java.util.Map" scope="request"/>
<jsp:useBean id="totalNumberOfRefs" type="java.lang.Integer" scope="request"/>
<jsp:useBean id="numArchivedEnvs" type="java.lang.Integer" scope="request"/>
<jsp:useBean id="numArchivedOther" type="java.lang.Integer" scope="request"/>

<c:set var="defaultBranchName" value="<%=Branch.DEFAULT_BRANCH_NAME%>"/>
<c:set var="buildType" value="${build.buildType}"/>

<c:set value="${build.buildId}" var="id"/>
<c:set value="${build.branch}" var="branch"/>
<c:set var="branchOpts"><c:if test="${not empty branch}"> , branchName: '<bs:escapeForJs text="${branch.name}"/>'</c:if><c:if test="${empty branch}"> , branchName: '<bs:escapeForJs text="${defaultBranchName}"/>'</c:if></c:set>
<c:if test="${fn:length(dependencyRefs) > 0 or fn:length(environments) > 0}">
<div style="display:none" id="newPromoteDialogTitle">Promote Build <strong><bs:buildNumber buildData="${build}" maxLength="50"/></strong></div>
<script type="text/javascript">
  $j('#promoteBuildTitle').html($j('#newPromoteDialogTitle').html());
</script>
<c:if test="${fn:length(dependencyRefs) + fn:length(environments) > 10}">
<div class="filter">
  <bs:inplaceFilter containerId="dependencyRefs" activate="true" filterText="&lt;filter build configurations>" style="margin-bottom: 0.5em"/>
</div>
</c:if>
<div class="promoteBuildContainer">
  <table class="promoteBuild borderBottom" id="dependencyRefs">
    <c:if test="${fn:length(environments) gt 0}">
      <tr class="${fn:length(environments) == numArchivedEnvs ? 'archived' : ''}"><td colspan="2" class="groupName">Environments:</td></tr>
      <c:set var="refs" value="${environments}"/>
      <%@include file="_promoteRows.jsp"%>
    </c:if>

    <c:if test="${fn:length(environments) gt 0 and fn:length(dependencyRefs) gt 0}">
      <tr class="${fn:length(dependencyRefs) == numArchivedOther ? 'archived' : ''}"><td colspan="2" class="groupName" style="padding-top: 1em">Other build configurations:</td></tr>
    </c:if>

    <c:set var="refs" value="${dependencyRefs}"/>
    <%@include file="_promoteRows.jsp"%>
  </table>
</div>
<c:if test="${numArchivedEnvs + numArchivedOther > 0}">
<div class="showArchived">
  <forms:checkbox name="showArchived" value="" onclick="{
     $j('#promoteBuildDialogContent tr.archived').toggleClass('inplaceFiltered');
     if (this.checked) {
        $j('#promoteBuildDialogContent tr.archived').show();
     } else {
        $j('#promoteBuildDialogContent tr.archived').hide();
     }
   }"/> <label for="showArchived">Show archived build configurations (${numArchivedEnvs + numArchivedOther})</label>
</div>
</c:if>
</c:if>
<c:if test="${fn:length(dependencyRefs) == 0 and fn:length(environments) == 0 and totalNumberOfRefs == 0}">
  <div>Cannot find build configurations depending on <strong><c:out value="${buildType.fullName}"/></strong> by snapshot or artifact dependency.</div>
</c:if>
<c:if test="${fn:length(dependencyRefs) == 0 and fn:length(environments) == 0 and totalNumberOfRefs > 0}">
  <div>You do not have enough permissions to run builds in build configurations depending on <strong><c:out value="${buildType.fullName}"/></strong>.</div>
</c:if>
