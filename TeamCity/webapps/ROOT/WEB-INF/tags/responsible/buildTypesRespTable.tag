<%@ tag import="jetbrains.buildServer.controllers.investigate.InvestigationsBean" %><%@
    tag import="jetbrains.buildServer.web.util.ProjectHierarchyTreeBean" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="resp" tagdir="/WEB-INF/tags/responsible" %><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@
    attribute name="buildTypes" type="java.util.List" required="true"  %><%@
    attribute name="project" type="jetbrains.buildServer.serverSide.SProject" required="false"

%><c:set var="beans" value="<%=ProjectHierarchyTreeBean.getForBuildTypes(project, InvestigationsBean.convertToBuildTypes(buildTypes))%>"
/><c:if test="${not empty beans}">
  <div class="action-bar expand_collapse">
    <bs:collapseExpand collapseAction="BS.CollapsableBlocks.collapseAll(true, 'projectHierarchy'); return false"
                       expandAction="BS.CollapsableBlocks.expandAll(true, 'projectHierarchy'); return false"/>
  </div>
</c:if><bs:projectHierarchy treeId="btRespTree" tableClass="buildTypesRespTable" rootProjects="${beans}"
                       rootNotCollapsible="false" persistBlocksState="true"
                       linksToAdminPage="false" showResponsibilityInfo="true" collapsible="true" collapsedByDefault="true" showCounters="true">
    <jsp:attribute name="projectHTML">
      <td class="details"></td>
      <td class="actions"></td>
    </jsp:attribute>
    <jsp:attribute name="buildTypeHTML">
      <c:set var="entry" value="${buildType.responsibilityInfo}"/>
      <td class="details">
        <resp:investigationDetails entry="${entry}" />
      </td>
      <td class="actions">
        <resp:btResponsibilityActions buildTypeRef="${buildType}" responsibility="${entry}"/>
      </td>
    </jsp:attribute>
</bs:projectHierarchy>