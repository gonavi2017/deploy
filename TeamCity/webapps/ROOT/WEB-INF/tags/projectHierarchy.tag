<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
%><%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout"
%><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
%><%@ taglib prefix="util" uri="/WEB-INF/functions/util"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ attribute name="rootProjects"               required="true"  type="java.util.List"    description="Projects to show at the upper level (root project for the tree root)"
%><%@ attribute name="subprojectsPreceed"         required="false" type="java.lang.Boolean" description="Subprojects would be shown firstly when 'true', own configurations otherwise"
%><%@ attribute name="collapsible"                required="false" type="java.lang.Boolean" description="Collapsible blocks will be used for all projects if 'true'"
%><%@ attribute name="autoSetupHandlers"          required="false" type="java.lang.Boolean" description="Collapsible blocks will be initialized automatically if 'true' or empty"
%><%@ attribute name="persistBlocksState"         required="false" type="java.lang.Boolean" description="Collapsible blocks will persist their states. Works partially with AJAX and expand/collapse all actions. Default is 'false'"
%><%@ attribute name="showRootProjects"           required="false" type="java.lang.Boolean" description="When 'false' - projects form rootProjects will not be shown. Default is 'true'"
%><%@ attribute name="showProjectDescriptions"    required="false" type="java.lang.Boolean" description="When 'false' - projects description will not be shown. Default is 'true'"
%><%@ attribute name="showBuildTypeDescriptions"  required="false" type="java.lang.Boolean" description="When 'false' - build type description will not be shown. Default is 'true'"
%><%@ attribute name="showResponsibilityInfo"     required="false" type="java.lang.Boolean" description="When 'true'  - build type responsibility will be shown. Default is 'false'"
%><%@ attribute name="linksToAdminPage"           required="false" type="java.lang.Boolean" description="All links will lead to project overview page when 'false'. Default is 'true'"
%><%@ attribute name="rootNotCollapsible"         required="false" type="java.lang.Boolean" description="Root elements will not be collapsible when 'true'. Default is 'true'"
%><%@ attribute name="collapsedByDefault"         required="false" type="java.lang.Boolean" description="Default blocks state. Default is 'true' - everything is collapsed"
%><%@ attribute name="showCounters"               required="false" type="java.lang.Boolean" description="When 'true' - shows the counters corresponding to rows."
%><%@ attribute name="addLevelToConfigurations"   required="false" type="java.lang.Boolean" description="When 'true' - configurations will be moved right 1 level comparing to sibling projects."
%><%@ attribute name="_showPostProject"           required="false" type="java.lang.Boolean" description="Automatic property"
%><%@ attribute name="_showPreProjectContent"     required="false" type="java.lang.Boolean" description="Automatic property"
%><%@ attribute name="_showPostBuildType"         required="false" type="java.lang.Boolean" description="Automatic property"
%><%@ attribute name="_defaultNameColumn"         required="false" type="java.lang.Boolean" description="Automatic property"
%><%@ attribute name="_defaultBTNameColumn"       required="false" type="java.lang.Boolean" description="Automatic property"
%><%@ attribute name="treeId"                     required="true"  type="java.lang.String"  description="ID of the tree to distinguish them"
%><%@ attribute name="ajaxControllerUrl"          required="false" type="java.lang.String"  description="Url for ajax controller"
%><%@ attribute name="customEmptyProjectMessage"  required="false" type="java.lang.String"  description="Message for beans with no subprojects, template, vcs roots, and build types (Bean.getSize() == 0)"
%><%@ attribute name="tableClass"                 required="false" type="java.lang.String"
%><%@ attribute name="tableHeaderClass"           required="false" type="java.lang.String"
%><%@ attribute name="tablePostHeaderClass"       required="false" type="java.lang.String"
%><%@ attribute name="tableFooterClass"           required="false" type="java.lang.String"
%><%@ attribute name="tablePreFooterClass"        required="false" type="java.lang.String"
%><%@ attribute name="tableBuildTypeClass"        required="false" type="java.lang.String"
%><%@ attribute name="tableProjectClass"          required="false" type="java.lang.String"
%><%@ attribute name="tableSubProjectClass"       required="false" type="java.lang.String"
%><%@ attribute name="_innerDepth"                required="false" type="java.lang.Integer" description="Automatic property"
%><%@ attribute name="projectHTML"                required="true"  fragment="true"
%><%@ attribute name="projectNameHTML"            required="false" fragment="true"
%><%@ attribute name="afterProjectNameHTML"       required="false" fragment="true"
%><%@ attribute name="buildTypeHTML"              required="true"  fragment="true"
%><%@ attribute name="buildTypeNameHTML"          required="false" fragment="true"
%><%@ attribute name="afterBuildTypeNameHTML"     required="false" fragment="true"
%><%@ attribute name="templateHTML"               required="false" fragment="true"
%><%@ attribute name="afterTemplateNameHTML"      required="false" fragment="true"
%><%@ attribute name="vcsRootHTML"                required="false" fragment="true"
%><%@ attribute name="afterVcsRootNameHTML"       required="false" fragment="true"
%><%@ attribute name="tableHeader"                required="false" fragment="true"
%><%@ attribute name="postHeader"                 required="false" fragment="true"
%><%@ attribute name="postProject"                required="false" fragment="true"
%><%@ attribute name="preProjectContent"          required="false" fragment="true"
%><%@ attribute name="tableFooter"                required="false" fragment="true"
%><%@ attribute name="preFooter"                  required="false" fragment="true"
%><%@ attribute name="initScript"                 required="false" fragment="true" description="A html fragment which will be added after the hierarchy for the first level only. Useful for init scripts when the hierarchy is AJAX compatible. "

%><%@ variable name-given="projectBean" variable-class="jetbrains.buildServer.web.util.ProjectHierarchyTreeBean"
%><%@ variable name-given="buildType" variable-class="jetbrains.buildServer.serverSide.SBuildType"
%><%@ variable name-given="template" variable-class="jetbrains.buildServer.serverSide.BuildTypeTemplate"
%><%@ variable name-given="vcsRoot" variable-class="jetbrains.buildServer.vcs.SVcsRoot"

%><c:if test="${not empty ajaxControllerUrl}"><c:set var="ajaxable" value="${true}"/></c:if
><c:if test="${empty persistBlocksState}"><c:set var="persistBlocksState" value="${false}"/></c:if
><c:if test="${empty showRootProjects}"><c:set var="showRootProjects" value="${true}"/></c:if
><c:if test="${empty showProjectDescriptions}"><c:set var="showProjectDescriptions" value="${true}"/></c:if
><c:if test="${empty showBuildTypeDescriptions}"><c:set var="showBuildTypeDescriptions" value="${true}"/></c:if
><c:if test="${empty showResponsibilityInfo}"><c:set var="showResponsibilityInfo" value="${false}"/></c:if
><c:if test="${empty addLevelToConfigurations}"><c:set var="addLevelToConfigurations" value="${true}"/></c:if
><c:if test="${empty customEmptyProjectMessage}"><c:set var="customEmptyProjectMessage" value="Empty project"/></c:if
><c:if test="${empty _showPostProject}"><c:set var="_showPostProject" value="${not empty postProject}"/></c:if
><c:if test="${empty _showPreProjectContent}"><c:set var="_showPreProjectContent" value="${not empty preProjectContent}"/></c:if
><c:if test="${empty _defaultNameColumn}"><c:set var="_defaultNameColumn" value="${empty projectNameHTML}"/></c:if
><c:if test="${empty _defaultBTNameColumn}"><c:set var="_defaultBTNameColumn" value="${empty buildTypeNameHTML}"/></c:if
><c:if test="${empty _innerDepth}"><c:set var="_innerDepth" value="${0}"/></c:if
><c:if test="${empty linksToAdminPage}"><c:set var="linksToAdminPage" value="${true}"/></c:if
><c:if test="${empty rootNotCollapsible}"><c:set var="rootNotCollapsible" value="${true}"/></c:if
><c:if test="${empty collapsedByDefault}"><c:set var="collapsedByDefault" value="${true}"/></c:if
><c:if test="${empty autoSetupHandlers}"><c:set var="autoSetupHandlers" value="${true}"/></c:if
><c:set var="firstdepth" value="${not empty rootProjects ? rootProjects[0].depth : 0}"
/><c:set var="isRootProject" value="${_innerDepth eq 0}"
/><c:if test="${collapsible}"><c:set var="shouldCollapse">
  ${collapsedByDefault and (not isRootProject or (not rootNotCollapsible and showRootProjects)) and empty param.__openAllProjects}
</c:set></c:if><bs:linkScript>/js/bs/projectHierarchy.js</bs:linkScript>

<table class="projectHierarchy ${tableClass}" id="${treeId}">
  <c:if test="${not empty tableHeader and firstdepth eq 0}">
    <tr class="header ${tableHeaderClass}">
      <jsp:invoke fragment="tableHeader"/>
    </tr>
    <c:if test="${not empty postHeader}">
      <tr <c:if test="${not empty tablePostHeaderClass}">class="${tablePostHeaderClass}"</c:if>><jsp:invoke fragment="postHeader"/></tr>
    </c:if>
  </c:if>
  <c:forEach var="projectBean" items="${rootProjects}" varStatus="status"><%--@elvariable id="projectBean" type="jetbrains.buildServer.web.util.ProjectHierarchyTreeBean"--%>
    <c:set var="depth" value="${not showRootProjects ? projectBean.depth - 1 : projectBean.depth}"/>
    <c:set var="id">${treeId}_project_handle_<c:out value="${projectBean.project.projectId}"/></c:set>
    <c:if test="${persistBlocksState}">
      <c:set var="blockType">projectHierarchy${id}</c:set>
      <l:blockStateCss blocksType="${blockType}" collapsedByDefault="${collapsedByDefault}" id="projectHierarchy"/>
    </c:if>

    <c:set var="rowCollapsible" value="${collapsible and (firstdepth ne 0 or not rootNotCollapsible)}"/>
    <c:if test="${showRootProjects or firstdepth ne 0}">
      <tr <c:if test="${shouldCollapse}">id="${id}"</c:if> class="project ${tableProjectClass} tr-depth-${depth}">
        <td class="project_name depth-${depth} <c:if test="${empty projectBean.buildTypes and empty projectBean.subProjects and empty projectBean.templates and empty projectBean.vcsRoots}">emptyProject</c:if>">
          <c:if test="${rowCollapsible}"><bs:handle collapsed="${shouldCollapse}" handleId="${id}"/></c:if>
          <c:if test="${_defaultNameColumn}">
            <c:choose>
              <c:when test="${linksToAdminPage}"><admin:editProjectLink classes="icon_before icon16 project-icon" projectId="${projectBean.project.externalId}"><c:out value="${projectBean.project.name}"/></admin:editProjectLink></c:when>
              <c:otherwise><bs:projectLink classes="icon_before icon16 project-icon" project="${projectBean.project}"/></c:otherwise>
            </c:choose>
            <c:if test="${projectBean.project.archived}"> <span class="archived_project">archived</span></c:if>
            <c:if test="${showCounters}"><span class="counter">(${projectBean.size})</span></c:if>
          </c:if>
          <c:if test="${not _defaultNameColumn}">
            <jsp:invoke fragment="projectNameHTML"/>
          </c:if>
          <jsp:invoke fragment="afterProjectNameHTML"/>
          <c:if test="${showProjectDescriptions}"><span class="project_description"><bs:out value="${projectBean.project.description}"/></span></c:if>
        </td>
        <jsp:invoke fragment="projectHTML"/>
      </tr>
    </c:if>
    <tr>
      <td class="project_content_holder" colspan="10">
        <bs:refreshable containerId="${id}Content" pageUrl="${pageUrl}" deferred="true">
          <c:set var="shouldInitNow" value="${persistBlocksState or autoSetupHandlers}"/>
          <table class="project_content_holder <c:if test="${not shouldInitNow and rowCollapsible}">nonInitializedCollapsible</c:if>" <c:if test="${not shouldInitNow and rowCollapsible}">data-collapsible-id="${id}" data-collapsible-projectId="<c:out value="${projectBean.project.projectId}"/>"</c:if> style="<c:if test="${shouldCollapse and rowCollapsible}">display: none;</c:if>"
                 <c:if test="${collapsible}">id="btb${id}"</c:if>>
            <c:if test="${shouldInitNow and rowCollapsible}">
              <script type="text/javascript">
                <c:if test="${persistBlocksState}"><l:blockState blocksType="${blockType}"/></c:if>
                BS.ProjectHierarchyTree.registerHandle("${id}", ${collapsedByDefault}, ${persistBlocksState}, '<c:out value="${projectBean.project.projectId}"/>');
              </script>
            </c:if>
            <bs:showOrPrepareAjax ajaxControllerUrl="${ajaxControllerUrl}" handleId="${id}" contentContainerId="btb${id}" depth="${depth + 1}" autoSetupHandlers="${autoSetupHandlers}"
                                  ajaxParameters="\"projectId\": \"${projectBean.project.externalId}\", \"depth\": \"${depth}\", \"ajaxPHT\": \"true\", \"__fragmentId\": \"${id}ContentInner\""
                                  showImmideatelly="${not shouldCollapse or (persistBlocksState and not util:isBlockHidden(pageContext.request, blockType, collapsedByDefault)) or empty ajaxControllerUrl or (fn:length(projectBean.project.ownProjects) + fn:length(projectBean.project.ownBuildTypes)) < 10}">

              <c:if test="${_showPreProjectContent}">
                <tr class="pre_project_content">
                  <td class="depth-${depth + 1}">
                    <jsp:invoke fragment="preProjectContent"/>
                  </td>
                </tr>
              </c:if>

              <c:choose>
                <c:when test="${empty projectBean.buildTypes and empty projectBean.subProjects and empty projectBean.templates and empty projectBean.vcsRoots}">
                  <c:if test="${not projectBean.project.rootProject || showRootProjects}">
                    <tr class="build_type ${tableBuildTypeClass} tr-depth-${depth + (addLevelToConfigurations ? 2 : 1)}">
                      <td colspan="10" class="no_build_types depth-${depth + (addLevelToConfigurations ? 2 : 1)}">${customEmptyProjectMessage}</td>
                    </tr>
                  </c:if>
                </c:when>
                <c:otherwise>
                  <%--show buildTypes if buildtypes preceed subprojects--%>
                  <c:if test="${not subprojectsPreceed}">
                    <bs:projectHierarchy_buildtypes projectBean="${projectBean}" depth="${depth + (addLevelToConfigurations ? 2 : 1)}"
                                                    tableBuildTypeClass="${tableBuildTypeClass}"
                                                    linksToAdminPage="${linksToAdminPage}"
                                                    defaultName="${_defaultBTNameColumn}"
                                                    showBuildTypeDescriptions="${showBuildTypeDescriptions}"
                                                    showResponsibilityInfo="${showResponsibilityInfo}">
                      <jsp:attribute name="buildTypeHTML"><jsp:invoke fragment="buildTypeHTML"/></jsp:attribute>
                      <jsp:attribute name="buildTypeNameHTML"><jsp:invoke fragment="buildTypeNameHTML"/></jsp:attribute>
                      <jsp:attribute name="afterBuildTypeNameHTML"><jsp:invoke fragment="afterBuildTypeNameHTML"/></jsp:attribute>
                    </bs:projectHierarchy_buildtypes>
                    <bs:projectHierarchy_templates depth="${depth + (addLevelToConfigurations ? 2 : 1)}" projectBean="${projectBean}" linksToAdminPage="${linksToAdminPage}" tableBuildTypeClass="${tableBuildTypeClass}">
                      <jsp:attribute name="templateHTML"><jsp:invoke fragment="templateHTML"/></jsp:attribute>
                      <jsp:attribute name="afterTemplateNameHTML"><jsp:invoke fragment="afterTemplateNameHTML"/></jsp:attribute>
                    </bs:projectHierarchy_templates>
                    <bs:projectHierarchy_vcsroots depth="${depth + (addLevelToConfigurations ? 2 : 1)}" projectBean="${projectBean}" linksToAdminPage="${linksToAdminPage}" tableBuildTypeClass="${tableBuildTypeClass}">
                      <jsp:attribute name="vcsRootHTML"><jsp:invoke fragment="vcsRootHTML"/></jsp:attribute>
                      <jsp:attribute name="afterVcsRootNameHTML"><jsp:invoke fragment="afterVcsRootNameHTML"/></jsp:attribute>
                    </bs:projectHierarchy_vcsroots>
                  </c:if>
                  <%--show subprojects--%>
                  <c:if test="${not empty projectBean.project.ownProjects}">
                    <bs:projectHierarchy_subprojects id="${id}" tableSubProjectClass="${tableSubProjectClass}" projectBean="${projectBean}">
                      <bs:projectHierarchy rootProjects="${projectBean.subProjects}" tableFooterClass="${tableFooterClass}"
                                           tableClass="${tableClass}" customEmptyProjectMessage="${customEmptyProjectMessage}"
                                           tableSubProjectClass="${tableSubProjectClass}" collapsible="${collapsible}"
                                           collapsedByDefault="${collapsedByDefault}" showCounters="${showCounters}" treeId="${treeId}"
                                           tableBuildTypeClass="${tableBuildTypeClass}" subprojectsPreceed="${subprojectsPreceed}"
                                           ajaxControllerUrl="${ajaxControllerUrl}" tableProjectClass="${tableProjectClass}"
                                           linksToAdminPage="${linksToAdminPage}" _showPostProject="${_showPostProject}" _showPreProjectContent="${_showPreProjectContent}" addLevelToConfigurations="${addLevelToConfigurations}"
                                           tableHeaderClass="${tableHeaderClass}" showRootProjects="${showRootProjects}" showProjectDescriptions="${showProjectDescriptions}"
                                           showBuildTypeDescriptions="${showBuildTypeDescriptions}" showResponsibilityInfo="${showResponsibilityInfo}"
                                           tablePostHeaderClass="${tablePostHeaderClass}" persistBlocksState="${persistBlocksState}"
                                           tablePreFooterClass="${tablePreFooterClass}" _defaultNameColumn="${_defaultNameColumn}"
                                           _defaultBTNameColumn="${_defaultBTNameColumn}" _innerDepth="${_innerDepth + 1}" autoSetupHandlers="${autoSetupHandlers}">
                        <jsp:attribute name="projectHTML"><jsp:invoke fragment="projectHTML"/></jsp:attribute>
                        <jsp:attribute name="buildTypeHTML"><jsp:invoke fragment="buildTypeHTML"/></jsp:attribute>
                        <jsp:attribute name="templateHTML"><jsp:invoke fragment="templateHTML"/></jsp:attribute>
                        <jsp:attribute name="afterTemplateNameHTML"><jsp:invoke fragment="afterTemplateNameHTML"/></jsp:attribute>
                        <jsp:attribute name="vcsRootHTML"><jsp:invoke fragment="vcsRootHTML"/></jsp:attribute>
                        <jsp:attribute name="afterVcsRootNameHTML"><jsp:invoke fragment="afterVcsRootNameHTML"/></jsp:attribute>
                        <jsp:attribute name="postProject"><jsp:invoke fragment="postProject"/></jsp:attribute>
                        <jsp:attribute name="preProjectContent"><jsp:invoke fragment="preProjectContent"/></jsp:attribute>
                        <jsp:attribute name="projectNameHTML"><jsp:invoke fragment="projectNameHTML"/></jsp:attribute>
                        <jsp:attribute name="afterProjectNameHTML"><jsp:invoke fragment="afterProjectNameHTML"/></jsp:attribute>
                        <jsp:attribute name="buildTypeNameHTML"><jsp:invoke fragment="buildTypeNameHTML"/></jsp:attribute>
                        <jsp:attribute name="afterBuildTypeNameHTML"><jsp:invoke fragment="afterBuildTypeNameHTML"/></jsp:attribute>
                      </bs:projectHierarchy>
                    </bs:projectHierarchy_subprojects>
                  </c:if>
                  <%--show buildTypes if subprojects preceed buildtypes--%>
                  <c:if test="${subprojectsPreceed}">
                    <bs:projectHierarchy_buildtypes projectBean="${projectBean}"
                                                    defaultName="${_defaultBTNameColumn}"
                                                    tableBuildTypeClass="${tableBuildTypeClass}"
                                                    linksToAdminPage="${linksToAdminPage}" depth="${depth + (addLevelToConfigurations ? 2 : 1)}"
                                                    showBuildTypeDescriptions="${showBuildTypeDescriptions}"
                                                    showResponsibilityInfo="${showResponsibilityInfo}">
                      <jsp:attribute name="buildTypeHTML"><jsp:invoke fragment="buildTypeHTML"/></jsp:attribute>
                      <jsp:attribute name="buildTypeNameHTML"><jsp:invoke fragment="buildTypeNameHTML"/></jsp:attribute>
                      <jsp:attribute name="afterBuildTypeNameHTML"><jsp:invoke fragment="afterBuildTypeNameHTML"/></jsp:attribute>
                    </bs:projectHierarchy_buildtypes>
                    <bs:projectHierarchy_templates depth="${depth + (addLevelToConfigurations ? 2 : 1)}" projectBean="${projectBean}" tableBuildTypeClass="${tableBuildTypeClass}">
                      <jsp:attribute name="templateHTML"><jsp:invoke fragment="templateHTML"/></jsp:attribute>
                      <jsp:attribute name="afterTemplateNameHTML"><jsp:invoke fragment="afterTemplateNameHTML"/></jsp:attribute>
                    </bs:projectHierarchy_templates>
                    <bs:projectHierarchy_vcsroots depth="${depth + (addLevelToConfigurations ? 2 : 1)}" projectBean="${projectBean}" tableBuildTypeClass="${tableBuildTypeClass}">
                      <jsp:attribute name="vcsRootHTML"><jsp:invoke fragment="vcsRootHTML"/></jsp:attribute>
                      <jsp:attribute name="afterVcsRootNameHTML"><jsp:invoke fragment="afterVcsRootNameHTML"/></jsp:attribute>
                    </bs:projectHierarchy_vcsroots>
                  </c:if>
                </c:otherwise>
              </c:choose>

              <c:if test="${_showPostProject}">
                <tr class="post_project">
                  <jsp:invoke fragment="postProject"/>
                </tr>
              </c:if>
            </bs:showOrPrepareAjax>
          </table>
          <c:if test="${status.last}">
            <script type="text/javascript">
              $j('.projectHierarchy .nonInitializedCollapsible').each(function (idx, elt) {
                elt.removeClassName('nonInitializedCollapsible');
                BS.ProjectHierarchyTree.registerHandle(elt.getAttribute('data-collapsible-id'), true, false, elt.getAttribute('data-collapsible-projectId'));
                elt.removeAttribute('data-collapsible-id');
                elt.removeAttribute('data-collapsible-projectId');
              });
              $j('.projectHierarchy .nonInitializedAjaxHandler').each(function (idx, elt) {
                elt.removeClassName('nonInitializedAjaxHandler');
                BS.ProjectHierarchyTree.patchHandle(BS.ProjectHierarchyTree.findCollapsibleBlock(elt.getAttribute('data-id')),
                                                      'admin/admin.html?item=projects', 'btb' + elt.getAttribute('data-id'),
                                                      $j(elt).data('collapsible-ajax-parameters'));
                elt.removeAttribute('data-collapsible-ajax-parameters');
                elt.removeAttribute('data-id');
              });
            </script>
            <c:if test="${not empty initScript}">
              <jsp:invoke fragment="initScript"/>
            </c:if>
          </c:if>
        </bs:refreshable>
      </td>
    </tr>
  </c:forEach>
  <c:if test="${not empty tableFooter and firstdepth eq 0}">
    <c:if test="${not empty preFooter}">
      <tr <c:if test="${not empty tablePreFooterClass}">class="${tablePreFooterClass}"</c:if>><jsp:invoke fragment="preFooter"/></tr>
    </c:if>
    <tr class="footer ${tableFooterClass}">
      <jsp:invoke fragment="tableFooter"/>
    </tr>
  </c:if>
</table>
