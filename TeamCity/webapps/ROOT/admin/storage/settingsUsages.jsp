<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include-internal.jsp" %>
<%--@elvariable id="rootProjects" type="java.util.List"--%>
<%--@elvariable id="totalUsagesCount" type="java.lang.Integer"--%>
<%--@elvariable id="shownUsagesCount" type="java.lang.Integer"--%>

<div>
  Artifacts storage has been used in <strong>${totalUsagesCount}</strong> build<bs:s val="${totalUsagesCount}"/>.
  <c:if test="${shownUsagesCount ne totalUsagesCount}">
    Showing <strong>${shownUsagesCount}</strong> latest build<bs:s val="${shownUsagesCount}"/>.
  </c:if>
</div>

<bs:projectHierarchy treeId="settingsUsages_tree" rootProjects="${projectHierarchyTreeBeans}"
                     rootNotCollapsible="false" persistBlocksState="true"
                     tableClass="modificationBuilds" tableBuildTypeClass="buildTypeProblem"
                     linksToAdminPage="false" showResponsibilityInfo="true" collapsible="true" collapsedByDefault="true" showCounters="false">
  <jsp:attribute name="projectHTML"/>
  <jsp:attribute name="buildTypeHTML"/>
  <jsp:attribute name="afterBuildTypeNameHTML">
    <%--@elvariable id="buildTypeUsages" type="java.util.Map<jetbrains.buildServer.BuildType,java.util.List"--%>
    <c:set var="usagesList" value="${buildTypeUsages[buildType]}"/>
    <table id="settingsUsagesBuilds">
      <c:forEach var="build" items="${usagesList}">
        <tr><bs:buildRow build="${build}" showBuildNumber="true" showStatus="true" showStartDate="false"/></tr>
      </c:forEach>
    </table>
  </jsp:attribute>
</bs:projectHierarchy>
