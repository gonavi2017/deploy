<%@ include file="include-internal.jsp"
%><jsp:useBean id="archivedBeans" type="java.util.List" scope="request"

/><l:tableWithHighlighting highlightImmediately="true" id="archivedProjectsPopupTable" className="projectsPopupTable all-filtered">
  <c:forEach items="${archivedBeans}" var="bean">
    <%--@elvariable id="bean" type="jetbrains.buildServer.web.util.ProjectHierarchyBean"--%>
    <c:set var="project" value="${bean.project}"/>
    <tr class="">
      <c:set var="projectUrl"><bs:projectUrl projectId="${project.externalId}"/></c:set>
      <td class="projectName highlight depth-${bean.depth <= 10 ? bean.depth : 10}" title="<c:out value='${project.description}'/>">
        <a href="${projectUrl}" class="projectLink projectIcon project-icon" title="Open project page" showdiscardchangesmessage="false">
          <c:out value="${project.name}"/>
        </a>
        <c:if test="${project.archived}"><i style="color: #888">archived</i></c:if>
      </td>
    </tr>
  </c:forEach>
</l:tableWithHighlighting>
<script type="text/javascript">
  BS.ArchivedProjectsPopup.highlightMatchIfNeeded();
</script>
