<%@ tag import="jetbrains.buildServer.controllers.admin.projects.AdminEditBuildTypeNavExtensionsController" %>
<%@ tag import="jetbrains.buildServer.serverSide.healthStatus.SuggestionCategory" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %><%@
    taglib prefix="l" tagdir="/WEB-INF/tags/layout" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %><%@
    taglib prefix="ext" tagdir="/WEB-INF/tags/ext" %><%@
    taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %><%@
    taglib prefix="intprop" uri="/WEB-INF/functions/intprop"%><%@
    taglib prefix="ufn" uri="/WEB-INF/functions/user" %><%@
    attribute name="body_include" fragment="true" %><%@
    attribute name="head_include" fragment="true" %><%@
    attribute name="selectedStep" required="true"

%><%@ tag body-content="empty"
%><jsp:useBean id="buildForm" type="jetbrains.buildServer.controllers.admin.projects.EditableBuildTypeSettingsForm" scope="request"
/><bs:page disableScrollingRestore="true">
  <jsp:attribute name="page_title">
    <c:set var="pageTitle">${buildForm.name} <c:choose>
      <c:when test="${buildForm.template}">Template</c:when>
      <c:otherwise>Configuration</c:otherwise>
    </c:choose></c:set><c:out value="${pageTitle}"/>
  </jsp:attribute>

  <jsp:attribute name="head_include">
    <bs:linkCSS>
      /css/admin/adminMain.css
      /css/admin/buildTypeForm.css
      /css/admin/templates.css
      /healthStatus/css/healthStatus.css
    </bs:linkCSS>
    <bs:linkScript>
      /js/bs/blocks.js
      /js/bs/blocksWithHeader.js
      /js/bs/copyProject.js
      /js/bs/testConnection.js
      /js/bs/moveBuildType.js
      /js/bs/editBuildType.js
      /js/bs/buildType.js
    </bs:linkScript>
    <script type="text/javascript">
      <bs:trimWhitespace>
        BS.Navigation.items = [];

        BS.Navigation.items.push({
          title: "Administration",
          url: '<c:url value="/admin/admin.html"/>'
        });

        <c:set var="curId" value="${buildForm.settingsId}"/>
        <c:set var="newId" value="buildType:{id}"/>
        <c:forEach var="p" items="${buildForm.project.projectPath}" varStatus="status">
          BS.Navigation.items.push({
            title: "<bs:escapeForJs text="${p.name}" forHTMLAttribute="true"/>",
            url: '<admin:editProjectLink projectId="${p.externalId}" withoutLink="true"/>',
            selected: false,
            itemClass: "project",
            projectId: "${p.externalId}",
            siblingsTree: {
              parentId: "${p.parentProjectExternalId}",
              projectUrlFormat: '<admin:editProjectLink projectId="{id}" withoutLink="true"/>',
              buildTypeUrlFormat: BS.Navigation.fromUrl("${curId}", "${newId}")
            }
          });
        </c:forEach>

        BS.Navigation.items.push({
          title: "<bs:escapeForJs text="${buildForm.name}" forHTMLAttribute="true"/>",
          url: "<c:url value='/admin/editBuild.html?id=${buildForm.settingsId}'/>",
          selected: true,
          itemClass: "${buildForm.template ? 'buildTypeTemplate' : 'buildType'}",
          buildTypeId: "${buildForm.template ? '-' : buildForm.settingsBuildType.externalId}",
          siblingsTree: {
            parentId: "${buildForm.project.externalId}",
            projectUrlFormat: '<admin:editProjectLink projectId="{id}" withoutLink="true"/>',
            buildTypeUrlFormat: BS.Navigation.fromUrl("${curId}", "${newId}")
          }
        });

        $j(document).ready(function() {
          BS.AvailableParams.attachPopups('settingsId=${buildForm.settingsId}', 'buildTypeParams');
          BS.VisibilityHandlers.updateVisibility('mainContent');

          <c:if test="${not ufn:booleanPropertyValue(currentUser, 'teamcity.ui.runFirstBuild.tooltipShown')}">
            if ($j('.runFirstBuild')[0]) {
              BS.Tooltip.showMessage($j('.runFirstBuild')[0], { shift: { x: -20, y: 20 }, delay: 0, hasTriangle: true, backgroundColor: '#ffc', className: 'firstBuildTooltip', hideOnMouseOut: false },
                "<div>You can now run the first build in this build configuration!" +
                "<div><a href='#' onclick='BS.User.setBooleanProperty(\"teamcity.ui.runFirstBuild.tooltipShown\", true, { afterComplete: function() { BS.Tooltip.hidePopup(); } }); return false;'>Got it</a></div>" +
                "</div>");
            }

          </c:if>
        });
      </bs:trimWhitespace>
    </script>
    <jsp:invoke fragment="head_include"/>
  </jsp:attribute>

  <jsp:attribute name="quickLinks_include">
    <c:if test="${not buildForm.template}">
      <div class="toolbarItem">
        <authz:authorize projectId="${buildForm.project.projectId}" allPermissions="RUN_BUILD">
          <c:url var="buildTypeHome" value="/viewType.html?buildTypeId=${buildForm.settingsBuildType.externalId}"/>
          <c:set var="firstBuildCanBeStarted" value="${buildForm.firstBuildCanBeStarted}"/>
          <bs:runBuild buildType="${buildForm.settingsBuildType}"
                       hideEnviroments="true"
                       title="${firstBuildCanBeStarted ? 'There are no finished builds in this configuration yet. You can now run a build.' : ''}"
                       redirectToQueuedBuild="${firstBuildCanBeStarted}"
                       className="${firstBuildCanBeStarted ? 'runFirstBuild' : ''}"/>
        </authz:authorize>
      </div>
    </c:if>

    <div class="toolbarItem">
      <bs:actionsPopup controlId="btActions"
                       popup_options="shift: {x: -100, y: 20}, width: '10em', className: 'quickLinksMenuPopup'">
        <jsp:attribute name="content">
          <div id="btDetails">
            <ul class="menuList">
              <c:if test="${not buildForm.template and not buildForm.project.archived and not buildForm.readOnly}">
                <authz:authorize projectId="${buildForm.project.projectId}" allPermissions="PAUSE_ACTIVATE_BUILD_CONFIGURATION">
                  <l:li>
                    <c:choose>
                      <c:when test="${buildForm.settingsBuildType.paused}">
                        <a href="#" onclick="<bs:_pauseBuildTypeLinkOnClick buildType="${buildForm.settingsBuildType}" pause="false"/>; return false">Activate triggers...</a>
                      </c:when>
                      <c:otherwise>
                        <a href="#" onclick="<bs:_pauseBuildTypeLinkOnClick buildType="${buildForm.settingsBuildType}" pause="true"/>; return false">Pause triggers...</a>
                      </c:otherwise>
                    </c:choose>
                  </l:li>
                </authz:authorize>
              </c:if>
              <c:if test="${not buildForm.template}">
              <bs:professionalLimited shouldBePositive="${serverSummary.buildConfigurationsLeft}">
                <l:li><a href="#" onclick="return BS.CopyBuildTypeForm.showDialog('${buildForm.settingsBuildType.externalId}')">Copy configuration...</a></l:li>
              </bs:professionalLimited>
              <c:if test="${fn:length(buildForm.editableProjects) > 1 and not buildForm.readOnly}">
                <l:li><a href="#" onclick="return BS.MoveBuildTypeForm.showDialog('${buildForm.settingsBuildType.externalId}')">Move configuration...</a></l:li>
              </c:if>
              </c:if>
              <c:if test="${buildForm.template}">
                <bs:professionalLimited shouldBePositive="${serverSummary.buildConfigurationsLeft}">
                <c:url value="/admin/createObjectMenu.html?init=1&showMode=createBuildTypeMenu&templateId=${buildForm.externalId}&projectId=${buildForm.project.externalId}" var="createUrl"/>
                <c:if test="${not buildForm.readOnly and (not buildForm.project.rootProject or not empty buildForm.project.ownProjects)}">
                  <l:li><a href="${createUrl}">Create build configuration from this template...</a></l:li>
                </c:if>
                </bs:professionalLimited>
                <l:li><a href="#" onclick="return BS.CopyTemplateForm.showDialog('${buildForm.externalId}')">Copy template...</a></l:li>
                <c:if test="${fn:length(buildForm.editableProjects) > 1 and not buildForm.readOnly}">
                  <l:li><a href="#" onclick="return BS.MoveTemplateForm.showDialog('${buildForm.externalId}')">Move template...</a></l:li>
                </c:if>
              </c:if>

              <c:if test="${not buildForm.template}">
                <c:if test="${not buildForm.templateBased and fn:length(buildForm.availableTemplates) > 0 and not buildForm.readOnly}">
                  <l:li><a href="#" onclick="return BS.AttachDetachTemplateAction.showDialog('${buildForm.settingsBuildType.externalId}')">Associate with template...</a></l:li>
                </c:if>
                <c:if test="${not buildForm.templateBased and not buildForm.readOnly}">
                  <l:li><a href="#" onclick="return BS.ExtractTemplateAction.showDialog('${buildForm.settingsBuildType.buildTypeId}')">Extract template...</a></l:li>
                </c:if>
                <c:if test="${buildForm.templateBased and not buildForm.readOnly}">
                  <l:li><a href="#" onclick="return BS.AttachDetachTemplateAction.detachFromTemplate('${buildForm.settingsBuildType.buildTypeId}')">Detach from template...</a></l:li>
                </c:if>
              </c:if>

              <bs:changeRequest key="buildTypeForm" value="${buildForm}">
                <jsp:include page="<%=AdminEditBuildTypeNavExtensionsController.PATH%>"/>
              </bs:changeRequest>

              <c:if test="${buildForm.template and not buildForm.readOnly}">
                <l:li><a href="#" onclick="return BS.AdminActions.deleteBuildTypeTemplate('${buildForm.settings.id}')">Delete this template...</a></l:li>
              </c:if>
              <c:if test="${not buildForm.template and not buildForm.readOnly}">
                <l:li><a href="#" onclick="return BS.AdminActions.deleteBuildType('${buildForm.settingsBuildType.buildTypeId}')">Delete...</a></l:li>
              </c:if>
              <c:if test="${buildForm.readOnly and not buildForm.project.customSettingsFormatUsed}">
                <c:choose>
                  <c:when test="${buildForm.template}">
                    <l:li><a href="#" onclick="return BS.AdminActions.setTemplateEditable('${buildForm.settings.id}', true)">Enable editing</a></l:li>
                  </c:when>
                  <c:otherwise>
                    <l:li><a href="#" onclick="return BS.AdminActions.setBuildTypeEditable('${buildForm.settings.id}', true)">Enable editing</a></l:li>
                  </c:otherwise>
                </c:choose>
              </c:if>
            </ul>
          </div>
        </jsp:attribute>
        <jsp:body>Actions</jsp:body>
      </bs:actionsPopup>
    </div>

    <c:choose
      ><c:when test="${not buildForm.template}">
      <div class="toolbarItem">
        <bs:buildTypeLink buildType="${buildForm.settingsBuildType}" style="float:left">Build Configuration Home</bs:buildTypeLink>
      </div></c:when
      ><c:otherwise>
      <div class="toolbarItem">
        <bs:projectLink project="${buildForm.project}">Parent Project Home</bs:projectLink>
      </div></c:otherwise>
    </c:choose>
    <div class="healthItemIndicatorContainer">
      <c:choose>
        <c:when test="${buildForm.template}">
          <bs:changeRequest key="template" value="${buildForm.settingsTemplate}">
            <bs:changeRequest key="excludeCategoryId" value="<%=SuggestionCategory.CATEGORY_ID%>">
              <jsp:include page="/admin/buildTypeTemplateHealthStatusItems.html">
                <jsp:param name="originUrl" value="${pageUrl}"/>
              </jsp:include>
            </bs:changeRequest>
          </bs:changeRequest>
        </c:when>
        <c:otherwise>
          <bs:changeRequest key="buildType" value="${buildForm.settingsBuildType}">
            <bs:changeRequest key="onlyCategoryId" value="<%=SuggestionCategory.CATEGORY_ID%>">
              <jsp:include page="/admin/buildTypeSuggestedItems.html">
                <jsp:param name="originUrl" value="${pageUrl}"/>
              </jsp:include>
            </bs:changeRequest>
            <bs:changeRequest key="excludeCategoryId" value="<%=SuggestionCategory.CATEGORY_ID%>">
              <jsp:include page="/admin/buildTypeHealthStatusItems.html">
                <jsp:param name="originUrl" value="${pageUrl}"/>
              </jsp:include>
            </bs:changeRequest>
          </bs:changeRequest>
        </c:otherwise>
      </c:choose>
    </div>
  </jsp:attribute>

  <jsp:attribute name="body_include">
    <bs:refreshable containerId="buildTypeSettingsContainer" pageUrl="${pageUrl}">
    <table id="admin-container">
      <tr>
        <td class="admin-sidebar compact">
          <div class="category">
            <c:choose>
              <c:when test="${buildForm.template}">
                <bs:projectOrBuildTypeIcon type="buildTypeTemplate"/>
                Template Settings
              </c:when>
              <c:otherwise>
                <bs:projectOrBuildTypeIcon type="buildType"/>
                Build Configuration Settings
              </c:otherwise>
            </c:choose>
          </div>

          <div id="buildTypeConfSteps">
            <admin:editBuildTypeNav buildTypeForm="${buildForm}" selectedLink="${selectedStep}"/>
          </div>
        </td>
        <td class="admin-content buildTypeContent">
          <c:if test="${not buildForm.template}">
            <bs:buildTypePaused buildType="${buildForm.settingsBuildType}"/>
          </c:if>

          <c:if test="${buildForm.readOnly}">
            <div class="headerNote">
              Editing of the ${buildForm.template ? 'template settings' : 'build configuration settings'} is disabled, reason: <c:out value="${buildForm.readOnlyReason}"/>.
            </div>
          </c:if>

          <c:if test="${buildForm.templateBased}">
            <c:set var="tpl" value="${buildForm.settingsBuildType.template}"/>
            <div class="headerNote">
              Based on
              <span class="tc-icon_before icon16 buildTypeTemplate-icon">
              <authz:authorize projectId="${tpl.project.projectId}" allPermissions="EDIT_PROJECT">
                <jsp:attribute name="ifAccessGranted">
                  <admin:editTemplateLink templateId="${tpl.externalId}" step="${selectedStep}"><c:out value="${tpl.fullName}"/></admin:editTemplateLink>
                </jsp:attribute>
                <jsp:attribute name="ifAccessDenied">
                  <c:out value="${tpl.fullName}"/>
                </jsp:attribute>
              </authz:authorize>
              </span> template.
            </div>
          </c:if>

          <bs:unprocessedMessages/>
          <jsp:invoke fragment="body_include"/>
        </td>
      </tr>
    </table>
    </bs:refreshable>

    <c:if test="${not buildForm.template}">
      <bs:pauseBuildTypeDialog/>
      <admin:attachTemplateDialog buildType="${buildForm.settingsBuildType}" availableTemplates="${buildForm.availableTemplates}"/>
      <admin:extractTemplate project="${buildForm.project}"/>
    </c:if>

  </jsp:attribute>
</bs:page>
