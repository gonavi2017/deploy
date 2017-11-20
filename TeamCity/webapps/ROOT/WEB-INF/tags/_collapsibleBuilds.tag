<%@ tag import="jetbrains.buildServer.web.util.ProjectHierarchyTreeBean" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="l" tagdir="/WEB-INF/tags/layout" %><%@
    attribute name="title" type="java.lang.String" required="true" %><%@
    attribute name="id" type="java.lang.String" required="true" %><%@
    attribute name="builds" type="java.util.List" required="true" %><%@
    attribute name="project" type="jetbrains.buildServer.serverSide.SProject" required="false"

%><c:set var="buildTypesMap" value="<%=ProjectHierarchyTreeBean.getBuildTypesMap(builds)%>"
/><c:set var="beans" value="<%=ProjectHierarchyTreeBean.getForBuilds(project, builds)%>"
/><bs:_collapsibleBlock title="${title}" id="${id}">
  <c:if test="${not empty beans}">
    <div class="action-bar expand_collapse">
      <bs:collapseExpand collapseAction="BS.CollapsableBlocks.collapseAll(true, 'projectHierarchy'); return false"
                         expandAction="BS.CollapsableBlocks.expandAll(true, 'projectHierarchy'); return false"/>
    </div>
  </c:if>
  <bs:projectHierarchy treeId="${id}_tree" rootProjects="${beans}"
                       rootNotCollapsible="false" persistBlocksState="true"
                       tableClass="modificationBuilds" tableBuildTypeClass="buildTypeProblem"
                       linksToAdminPage="false" showResponsibilityInfo="true" collapsible="true" collapsedByDefault="true" showCounters="true">
    <jsp:attribute name="projectHTML">
      <td class="details"></td>
    </jsp:attribute>
    <jsp:attribute name="buildTypeHTML">
        <c:set var="build" value="${buildTypesMap[buildType]}"/>
        <bs:buildRow build="${build}" showBuildNumber="true" showStatus="true" showChanges="true" showStartDate="true"/>
    </jsp:attribute>
  </bs:projectHierarchy>
</bs:_collapsibleBlock>