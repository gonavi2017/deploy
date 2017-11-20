<%@ include file="/include-internal.jsp" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<jsp:useBean id="editCleanupRulesForm" type="jetbrains.buildServer.controllers.admin.cleanup.EditCleanupRulesForm" scope="request"/>

<h2 class="noBorder">Clean-up Rules</h2>
<bs:smallNote>A clean-up rule defines when and what data to clean. Clean-up rules can be assigned to a project, template or build configuration. <bs:help file="Clean-Up" anchor="CleanupRules"/></bs:smallNote>

<%--@elvariable id="pageUrl" type="javaUtilString"--%>
<bs:refreshable containerId="cleanupPoliciesTable" pageUrl="${pageUrl}">
  <bs:messages key="policyRemoved"/>
  <bs:messages key="policiesUpdated"/>

  <c:if test="${fn:length(editCleanupRulesForm.parentProject.projects) gt fn:length(editCleanupRulesForm.parentProject.ownProjects)}">
   <div class="actionBar">
      <forms:checkbox name="showSubProjects" checked="${editCleanupRulesForm.showSubProjects}"
                      onclick="BS.Cleanup.submitFilter('${editCleanupRulesForm.parentProject.externalId}', this.checked)"/> <label for="showSubProjects">Show clean-up rules from sub project(s)</label>
    </div>
  </c:if>

  <l:tableWithHighlighting className="settings" highlightImmediately="true">
    <c:if test="${not empty editCleanupRulesForm.projectsToShow}">
      <tr class="tableHead">
        <th class="project">Project</th>
        <th class="buildType">Build configuration or template</th>
        <th class="description" colspan="2">
          What to clean-up<br/>
          <span class="cleanupRuleNote">
            <span class="defaults">Light gray oblique text</span> <span style="color: #888">is used for inherited rules. Customised rules are in</span>
            darker, regular font.
          </span>
        </th>
      </tr>
      <%@ include file="_cleanupProjectsPolicies.jspf" %>
    </c:if>
  </l:tableWithHighlighting>
  <script type="text/javascript">
    $j(function() {BS.Cleanup.updateDiskUsage("${editCleanupRulesForm.projectId}")});
  </script></bs:refreshable>
<%@ include file="_cleanupPolicyDialogForm.jspf" %>
