<%@ page import="jetbrains.buildServer.serverSide.healthStatus.SuggestionCategory" %>
<%@ page import="jetbrains.buildServer.web.openapi.PlaceId" %>
<%--@elvariable id="currentProject" type="jetbrains.buildServer.serverSide.impl.ProjectEx"--%>
<%--@elvariable id="serverSummary" type="jetbrains.buildServer.web.openapi.ServerSummary"--%>
<%@
    include file="/include-internal.jsp" %><%@
    taglib prefix="admin" tagdir="/WEB-INF/tags/admin"
%><jsp:useBean id="currentProject" type="jetbrains.buildServer.serverSide.impl.ProjectEx" scope="request"
/><jsp:useBean id="pageUrl" type="java.lang.String" scope="request"
/><c:set var="pageTitle" value="${currentProject.name} Project" scope="request"
/><c:set var="originalExternalId" value="${currentProject.externalId}"
/><c:set var="ownBuildTypes" value="${currentProject.ownBuildTypes}"
/><c:set var="ownSubprojects" value="${currentProject.ownProjects}"
/><bs:page>
  <jsp:attribute name="head_include">
    <bs:linkCSS>
      /css/project.css
      /css/admin/adminMain.css
      /css/admin/projectForm.css
      /healthStatus/css/healthStatus.css
    </bs:linkCSS>
    <bs:linkScript>
      /js/bs/blocks.js
      /js/bs/blocksWithHeader.js
      /js/bs/copyProject.js
      /js/bs/moveBuildType.js
      /js/bs/editProject.js
      /js/bs/testConnection.js
      /js/bs/pauseProject.js
    </bs:linkScript>
    <script type="text/javascript">
      <bs:trimWhitespace>
        BS.Navigation.items = [];

        BS.Navigation.items.push({
          title: "Administration",
          url: '<c:url value="/admin/admin.html"/>'
        });

        <c:set var="curId" value="${currentProject.externalId}"/>
        <c:forEach var="p" items="${currentProject.projectPath}" varStatus="status">
          BS.Navigation.items.push({
            title: "<bs:escapeForJs text="${p.name}" forHTMLAttribute="true"/>",
            url: BS.Navigation.fromUrl("${curId}", "${p.externalId}", null, ${status.last}),
            selected: ${status.last ? 'true' : 'false'},
            itemClass: "project",
            projectId: "${p.externalId}",
            siblingsTree: {
              parentId: "${p.parentProjectExternalId}",
              projectUrlFormat: BS.Navigation.fromUrl("${curId}"),
              buildTypeUrlFormat: '<admin:editBuildTypeLink buildTypeId="{id}" withoutLink="true"/>'
            }
          });
        </c:forEach>
      </bs:trimWhitespace>
    </script>
  </jsp:attribute>

  <jsp:attribute name="quickLinks_include">
    <div class="toolbarItem">
      <admin:projectActions project="${currentProject}" caption="Actions"/>
    </div>
    <div class="toolbarItem">
      <bs:projectLink project="${currentProject}">Project Home</bs:projectLink>
    </div>
    <div class="healthItemIndicatorContainer">
      <bs:changeRequest key="project" value="${currentProject}">
        <bs:changeRequest key="onlyCategoryId" value="<%=SuggestionCategory.CATEGORY_ID%>">
          <jsp:include page="/admin/projectSuggestedItems.html">
            <jsp:param name="originUrl" value="${pageUrl}"/>
          </jsp:include>
        </bs:changeRequest>
        <bs:changeRequest key="excludeCategoryId" value="<%=SuggestionCategory.CATEGORY_ID%>">
          <jsp:include page="/admin/projectHealthStatusItems.html">
            <jsp:param name="originUrl" value="${pageUrl}"/>
          </jsp:include>
        </bs:changeRequest>
      </bs:changeRequest>
    </div>
  </jsp:attribute>

  <jsp:attribute name="body_include">
    <table id="admin-container">
      <tr>
        <td class="admin-sidebar compact">
          <div class="category">
            <bs:projectOrBuildTypeIcon type="project"/>
            Project Settings
          </div>
          <div id="projectTabsContainer" class="simpleTabs clearfix"></div>

          <c:if test="${serverSummary.perProjectPermissionsEnabled}">
            <c:if test="${afn:permissionGrantedForProject(currentProject, 'CHANGE_USER_ROLES_IN_PROJECT') or afn:permissionGrantedGlobally('CHANGE_USER')}">
              <table class="usefulLinks usefulLinks_gray">
                <tr>
                  <td>
                    Configure user roles in this project on the
                    <strong><a href="<c:url value='/admin/admin.html?item=users&projectId=${originalExternalId}'/>">user accounts</a></strong> page.
                  </td>
                </tr>
              </table>
            </c:if>
          </c:if>
          <admin:configModificationInfo auditLogAction="${currentProject.lastConfigModificationAction}" project="${currentProject}"/>
        </td>
        <td class="admin-content projectContent">
          <bs:projectArchived project="${currentProject}"/>
          <bs:projectReadOnly project="${currentProject}"/>
          <ext:showTabs placeId="<%=PlaceId.EDIT_PROJECT_PAGE_TAB%>"
                        urlPrefix="/admin/editProject.html?projectId=${currentProject.externalId}" tabContainerId="projectTabsContainer"/>
        </td>
      </tr>
    </table>
    <bs:executeOnce id="archiveProjectDialog"><bs:archiveProjectDialog/></bs:executeOnce>
  </jsp:attribute>
</bs:page>
