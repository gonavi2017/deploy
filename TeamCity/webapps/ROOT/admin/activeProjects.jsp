<%--@elvariable id="projectBeans" type="jetbrains.buildServer.web.util.ProjectHierarchyTreeBean"--%>
<%@ page import="jetbrains.buildServer.BuildProject" %><%@
    page import="jetbrains.buildServer.web.util.WebUtil" %><%@
    include file="/include-internal.jsp" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="admin" tagdir="/WEB-INF/tags/admin"

%><jsp:useBean id="adminOverviewForm" type="jetbrains.buildServer.controllers.admin.AdminOverviewBean" scope="request"
/><jsp:useBean id="showProjects" type="java.lang.Boolean" scope="request"
/><jsp:useBean id="pageUrl" type="java.lang.String" scope="request"

/><c:set var="encodedCameFrom" value="<%=WebUtil.encode(pageUrl)%>"
/><c:set var="activeProjectsNum" value="${adminOverviewForm.totalNumberOfProjects - adminOverviewForm.numberOfArchivedProjects}"
/><c:set var="archivedProjectsNum" value="${adminOverviewForm.numberOfArchivedProjects}"
/><c:set var="rootProjectId" value="<%=BuildProject.ROOT_PROJECT_ID%>"

/><div id="container" class="clearfix">
  <c:set var="editableProjects" value="${adminOverviewForm.allActiveProjects}"/>

  <c:if test="${activeProjectsNum > 0 and not adminOverviewForm.rootProject.readOnly}">
  <authz:authorize allPermissions="CREATE_SUB_PROJECT" projectId="${rootProjectId}">
    <p class="createProject">
      <admin:createProjectButtons parentProject="${adminOverviewForm.rootProject}" cameFromUrl="${pageUrl}"/>
    </p>
  </authz:authorize>
  </c:if>

  <c:if test="${activeProjectsNum > 0}">
    <c:set var="activeBuildConfsNum" value="${adminOverviewForm.totalNumberOfBuildConfigurations - adminOverviewForm.numberOfArchivedConfigurations}"/>
    <div class="descr">
      You have <strong>${activeProjectsNum}</strong> active project<bs:s val="${activeProjectsNum}"/>
      with <strong>${activeBuildConfsNum}</strong> build configuration<bs:s val="${activeBuildConfsNum}"
      /><c:set var="archivedNum" value="${adminOverviewForm.numberOfArchivedConfigurations}"
      /><c:if test="${archivedNum > 0}"
       > (plus <strong>${archivedNum}</strong> archived build configuration<bs:s val="${archivedNum}"/>)</c:if>.
      <bs:professionalFeature>
        <span>
          <%--@elvariable id="serverTC" type="jetbrains.buildServer.serverSide.SBuildServer"--%>
          You can have a maximum of <strong>${serverTC.licensingPolicy.maxNumberOfBuildTypes}</strong> build configurations (active and archived).
        </span>
        <bs:help file="Licensing Policy" anchor="editions"/>
      </bs:professionalFeature>
    </div>
  </c:if>
  <c:if test="${activeProjectsNum == 0}">
    <div class="descr">There are no active projects.</div>
    <authz:authorize allPermissions="CREATE_SUB_PROJECT" projectId="${rootProjectId}">
      <c:url value='/admin/createProject.html?init=1' var="createUrl"/>
      <p><forms:addButton href="${createUrl}">Create project</forms:addButton></p>
    </authz:authorize>
  </c:if>

  <bs:messages key="projectRemoved" style="text-align: left;"/>
  <bs:messages key="buildTypeRemoved" style="text-align: left;"/>
  <bs:messages key="buildTypeNotFound" style="text-align: left;"/>
  <bs:messages key="projectNotFound" style="text-align: left;"/>

  <c:if test="${adminOverviewForm.totalNumberOfProjects > 0}">
    <admin:adminProjectsSearchField adminOverviewForm="${adminOverviewForm}"/>
    <div id="all-projects">
      <c:if test="${showProjects}">
        <c:set var="keyword" value="${adminOverviewForm.keyword}"/>
        <c:choose>
          <c:when test="${not empty projectBeans}">
            <div class="expand_collapse">
              <bs:collapseExpand collapseAction="BS.CollapsableBlocks.collapseAll(true, 'projectHierarchy'); return false"
                                 expandAction="BS.ProjectHierarchyTree.expandAll(); return false"/>
            </div>
            <bs:projectHierarchy rootProjects="${projectBeans}" collapsible="true" treeId="adminOverview" subprojectsPreceed="true" autoSetupHandlers="${false}"
                                 collapsedByDefault="${empty adminOverviewForm.keyword}" ajaxControllerUrl="admin/admin.html?item=projects">
              <jsp:attribute name="afterProjectNameHTML">
                <c:set var="project" value="${projectBean.project}"/>
                <c:if test="${not adminOverviewForm.includeArchived and project.archived}"><span class="archived_project">(has active subprojects)</span></c:if>
              </jsp:attribute>
              <jsp:attribute name="projectHTML">
                <c:set var="project" value="${projectBean.project}"/>
                <td class="edit highlight">
                  <authz:authorize allPermissions="EDIT_PROJECT" projectId="${project.projectId}">
                    <jsp:attribute name="ifAccessGranted">
                      <admin:editProjectLink projectId="${project.externalId}">Edit</admin:editProjectLink>
                    </jsp:attribute>
                    <jsp:attribute name="ifAccessDenied">
                      <admin:editProjectLink projectId="${project.externalId}">View</admin:editProjectLink>
                    </jsp:attribute>
                  </authz:authorize>
                </td>
                <td class="edit" style="vertical-align: top;">
                  <c:if test="${not project.rootProject}">
                    <admin:projectActions project="${project}" autoSetupPopup="${false}"/>
                  </c:if>
                </td>
              </jsp:attribute>
              <jsp:attribute name="buildTypeNameHTML">
                <authz:authorize allPermissions="EDIT_PROJECT" projectId="${buildType.project.projectId}">
                  <jsp:attribute name="ifAccessGranted">
                    <admin:editBuildTypeLink classes="icon_before icon16 buildType-icon" buildTypeId="${buildType.externalId}" cameFromUrl="${encodedCameFrom}"
                        ><c:out value="${buildType.name}"
                    /></admin:editBuildTypeLink>
                  </jsp:attribute>
                  <jsp:attribute name="ifAccessDenied">
                    <bs:buildTypeLink buildType="${buildType}" classes="icon_before icon16 buildType-icon"/>
                  </jsp:attribute>
                </authz:authorize>
                <span class="build_type_description"><bs:out value="${buildType.description}"/></span>
              </jsp:attribute>
              <jsp:attribute name="buildTypeHTML">
                <authz:authorize allPermissions="EDIT_PROJECT" projectId="${buildType.project.projectId}">
                  <jsp:attribute name="ifAccessGranted">
                    <td class="edit highlight" style="vertical-align: top;">
                      <admin:editBuildTypeMenu buildType="${buildType}" cameFromUrl="${encodedCameFrom}">Edit</admin:editBuildTypeMenu>
                    </td>
                    <td class="edit" style="vertical-align: top;">
                      <admin:buildTypeActions buildType="${buildType}" editableProjects="${editableProjects}" autoSetupPopup="${false}"/>
                    </td>
                  </jsp:attribute>
                  <jsp:attribute name="ifAccessDenied">
                    <td class="edit highlight" style="vertical-align: top;"><bs:buildTypeLink buildType="${buildType}">View</bs:buildTypeLink></td>
                    <td class="edit" style="vertical-align: top;">&nbsp;</td>
                  </jsp:attribute>
                </authz:authorize>
              </jsp:attribute>
              <jsp:attribute name="customEmptyProjectMessage">
                No build configurations match the query.
              </jsp:attribute>
            </bs:projectHierarchy>
            <c:if test="${not empty keyword}">
              <c:if test="${not adminOverviewForm.includeArchived}">
                <div style="margin-top: 1em;">
                  The search was performed in <i>active</i> projects only.
                  <a href="#" onclick="$j('#includeArchived').trigger('click'); return false;">Include archived projects</a>
                </div>
              </c:if>
              <script type="text/javascript">
                jQuery(function($) {
                  /* Highlight the matches */
                  var keyword = '${util:forJS(keyword, true, false)}',
                      regex = new RegExp(keyword.replace(/([().?*])/g, "\\$1"), "gi");

                  var highlight = function() {
                    var el = $(this);
                    el.html(el.html().replace(regex, function (m) {
                      return "<span class='hl'>" + m + "</span>";
                    }));
                  };

                  $(".project_name, .build_type_name").find("a").each(highlight);
                  $(".build_type_description, .project_description").each(highlight);
                });
              </script>
            </c:if>
          </c:when>
          <c:when test="${not empty keyword}">
            No <c:if test="${not adminOverviewForm.includeArchived}"><i>active</i></c:if> projects and build configurations match the query.
            <c:if test="${not adminOverviewForm.includeArchived}">
              <a href="#" onclick="$j('#includeArchived').trigger('click'); return false;">Search in archived projects</a>
            </c:if>
          </c:when>
        </c:choose>
      </c:if>
      <c:if test="${not showProjects}">
        <forms:progressRing className="progressRingInline"/> Loading projects...
        <script type="text/javascript">
          jQuery(function($) {
            $.get('<c:url value="/admin/admin.html"/>', {showProjects:true,includeArchived:${adminOverviewForm.includeArchived}}, function(response) {
              var content = $(response).find("#all-projects");
              $("#all-projects").replaceWith(content);
            });
          });
        </script>
      </c:if>
    </div>
  </c:if>
</div>

<script type="text/javascript">
  $j(document).on('click', '#adminOverview .nonInitializedActionPopup', function(event) {
    var elt = event.currentTarget;
    elt.removeClassName('nonInitializedActionPopup');

    BS.install_simple_popup('sp_span_' + elt.getAttribute('data_non_initialized_actions_popup_id'), elt.getAttribute('data_popup_options'));
    elt.removeAttribute('data_non_initialized_actions_popup_id');
    elt.removeAttribute('data_popup_options');

    $j(elt).trigger('click');
  });

  jQuery(function($) {
    var link = $("<a href='#'>Install Build Agents</a>").addClass("quickLinksControlLink").click(function() {
      BS.InstallAgentsPopup.showNearElement(this);
      return false;
    });
    $("#topWrapper div.quickLinks").append(link);
  });
</script>
<l:popupWithTitle id="installAgents" title="Install Build Agents">
  <%@ include file="../installLinks.jspf" %>
</l:popupWithTitle>
<bs:executeOnce id="archiveProjectDialog"><bs:archiveProjectDialog/></bs:executeOnce>
