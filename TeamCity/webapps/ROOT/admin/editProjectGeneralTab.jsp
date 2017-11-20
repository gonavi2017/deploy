<%@ include file="/include-internal.jsp"%>
<jsp:useBean id="currentProject" type="jetbrains.buildServer.serverSide.impl.ProjectEx" scope="request"
/><jsp:useBean id="projectForm" type="jetbrains.buildServer.controllers.admin.projects.EditProjectForm" scope="request"
/><jsp:useBean id="editableProjects" type="java.util.Collection" scope="request"
/><jsp:useBean id="serverSummary" type="jetbrains.buildServer.web.openapi.ServerSummary" scope="request"
/><c:set var="originalExternalId" value="${currentProject.externalId}"
/><c:set var="ownBuildTypes" value="${currentProject.ownBuildTypes}"
/><c:set var="ownSubprojects" value="${currentProject.ownProjects}"
/><c:set var="ownTemplates" value="${currentProject.ownBuildTypeTemplates}"/>

<bs:linkScript>
  /js/bs/queueLikeSorter.js
</bs:linkScript>

<div class="editProjectPage">
  <bs:messages key="projectCreated"/>
  <bs:messages key="projectCopied"/>
  <bs:messages key="projectMoved"/>
  <bs:messages key="projectRemoved"/>
  <bs:messages key="projectArchived"/>
  <bs:messages key="projectDearchived"/>
  <bs:messages key="projectIdsSaved"/>
  <bs:messages key="buildTypesStatusBulkChanged"/>

  <%--@elvariable id="buildTypesOrderingEnabled" type="java.lang.Boolean"--%>
  <%--@elvariable id="projectOrderingEnabled" type="java.lang.Boolean"--%>
  <c:set var="projectAuthorized" value="${afn:permissionGrantedForProject(currentProject, 'EDIT_PROJECT')}"/>
  <form id="editProjectForm" action="<c:url value='/admin/editProject.html?projectId=${originalExternalId}'/>"
        onsubmit="return BS.EditProjectForm.submitProject()" method="post" class="clearfix">
    <admin:projectForm projectForm="${projectForm}"/>

    <c:if test="${not currentProject.rootProject and afn:permissionGrantedForProject(currentProject, 'EDIT_PROJECT')}">
      <div class="saveButtonsBlock">
        <forms:submit name="submitButton" label="Save"/>
        <forms:cancel cameFromSupport="${projectForm.cameFromSupport}"/>
        <forms:saving/>
      </div>
    </c:if>
  </form>

  <c:if test="${not currentProject.rootProject}">
  <div class="section smallMargin">
    <h2 class="noBorder">Build Configurations<admin:bcLeft/></h2>
    <bs:messages key="buildTypeRemoved" style="text-align: left;"/>

    <c:set var="description">Build configurations define how to retrieve and build sources of a project. <bs:help file="Build+Configuration"/></c:set>
    <c:if test="${not currentProject.readOnly}">
    <authz:authorize allPermissions="EDIT_PROJECT" projectId="${currentProject.projectId}">
      <jsp:attribute name="ifAccessGranted">
        <div>
        <c:choose>
          <c:when test="${fn:length(currentProject.buildTypes) == 0}">
            <div class="nextStepHint">
              <p class="sectionDescription">${description}<br/>
                There are no build configurations in this project.
              </p>
              <admin:createBuildTypeButtons project="${currentProject}" cameFromUrl="${pageUrl}"/>
            </div>
          </c:when>
          <c:otherwise>
            <bs:smallNote>${description}</bs:smallNote>
            <admin:createBuildTypeButtons project="${currentProject}" cameFromUrl="${pageUrl}"/>
          </c:otherwise>
        </c:choose>
        <c:if test="${fn:length(ownBuildTypes) > 1}">
          <bs:reorderDialog dialogId="reorderBuildTypesDialog" dialogTitle="Build Configurations">
            <jsp:attribute name="sortables">
              <c:forEach items="${ownBuildTypes}" var="buildType">
                <div class="buildType draggable tc-icon_before icon16 tc-icon_draggable" id="ord_${buildType.externalId}"><c:out value="${buildType.name}"/></div>
              </c:forEach>
            </jsp:attribute>
            <jsp:attribute name="actionsExtension">
              <c:if test="${buildTypesOrderingEnabled}"><forms:button className="resetOrder">Disable custom order</forms:button></c:if>
            </jsp:attribute>
            <jsp:attribute name="messageBody"><div>This will affect the default display for all users.</div></jsp:attribute>
          </bs:reorderDialog>

          <div class="editCustomOrder">
            <span class="greyNote">sorted ${buildTypesOrderingEnabled ? 'with custom order' : 'alphabetically'}
              <a title="Click to ${buildTypesOrderingEnabled ? 'edit or disable' : 'enable'} custom ordering" id="editBuildTypesOrder" class="btn">Reorder</a>
            </span>
          </div>
        </c:if>
        </div>
      </jsp:attribute>
      <jsp:attribute name="ifAccessDenied">
        <p class="sectionDescription">${description}</p>
        <div class="clearfix" style="color: #888"><i>You do not have permissions to create build configurations in this project</i></div>
      </jsp:attribute>
    </authz:authorize>
    </c:if>
    <c:if test="${not empty ownBuildTypes}">
      <l:tableWithHighlighting className="parametersTable" id="configurations">
        <tr>
          <th class="name">Name</th>
          <th class="runner" colspan="3">Build Steps</th>
        </tr>
        <c:forEach items="${ownBuildTypes}" var="buildType">
          <c:set var="onclick">BS.openUrl(event, '<admin:editBuildTypeLink withoutLink="true"
                                                                           buildTypeId="${buildType.externalId}"
                                                                           cameFromUrl="${cameFromUrl}"/>');</c:set>
          <tr>
            <authz:editBuildTypeGranted buildType="${buildType}">
              <jsp:attribute name="ifAccessDenied">
                <td class="name">
                  <admin:buildTypeTemplateInfo buildType="${buildType}"/>
                  <bs:_buildTypePausedIcon buildType="${buildType}"/>
                  <strong><c:out value="${buildType.name}"/></strong>
                  <bs:smallNote><c:out value="${buildType.description}"/></bs:smallNote>
                </td>
                <td class="runner" onclick="${onclick}" colspan="3">
                  <admin:buildRunnersInfo buildRunners="${buildType.buildRunners}"/>
                </td>
              </jsp:attribute>
              <jsp:attribute name="ifAccessGranted">
                <td class="name highlight" onclick="${onclick}">
                  <admin:buildTypeTemplateInfo buildType="${buildType}"/>
                  <bs:_buildTypePausedIcon buildType="${buildType}"/>
                  <strong><c:out value="${buildType.name}"/></strong>
                  <bs:smallNote><c:out value="${buildType.description}"/></bs:smallNote>
                </td>
                <td class="runner highlight" onclick="${onclick}">
                  <admin:buildRunnersInfo buildRunners="${buildType.buildRunners}"/>
                </td>
                <td class="edit highlight" onclick="${onclick}">
                  <admin:editBuildTypeMenu buildType="${buildType}" cameFromUrl="${cameFromUrl}">${buildType.readOnly ? 'View' : 'Edit'}</admin:editBuildTypeMenu>
                </td>
                <td class="edit">
                  <admin:buildTypeActions buildType="${buildType}" editableProjects="${editableProjects}"/>
                </td>
              </jsp:attribute>
            </authz:editBuildTypeGranted>
          </tr>
        </c:forEach>
      </l:tableWithHighlighting>
    </c:if>
  </div>
  </c:if>

  <div class="section">
    <h2 class="noBorder">Build Configuration Templates</h2>
    <bs:smallNote>Build configuration templates define settings that can be reused by different build configurations. <bs:help file="Build+Configuration+Template"/></bs:smallNote>

    <bs:messages key="templateRemoved" style="text-align: left;"/>
    <c:if test="${not currentProject.readOnly}">
    <authz:authorize allPermissions="EDIT_PROJECT" projectId="${currentProject.projectId}">
      <jsp:attribute name="ifAccessGranted">
        <div class="clearfix">
          <c:url value="/admin/createTemplate.html?projectId=${currentProject.externalId}&init=1" var="url"/>
          <forms:addButton href="${url}">Create template</forms:addButton>
        </div>
      </jsp:attribute>
      <jsp:attribute name="ifAccessDenied">
        <div class="clearfix" style="color: #888"><i>You do not have permissions to create build configuration templates in this project</i></div>
      </jsp:attribute>
    </authz:authorize>
    </c:if>
    <c:if test="${not empty ownTemplates}">
    <l:tableWithHighlighting className="parametersTable" id="templates">
      <tr>
        <th class="name">Name</th>
        <th class="runner" colspan="3">Build Steps</th>
      </tr>
      <c:forEach items="${ownTemplates}" var="template">
        <c:set var="numUsages" value="${template.numberOfUsages}"/>
        <tr>
          <authz:authorize projectId="${currentProject.projectId}" allPermissions="EDIT_PROJECT">
          <jsp:attribute name="ifAccessDenied">
            <td class="name">
              <admin:templateUsageInfo template="${template}"/>
              <strong><c:out value="${template.name}"/></strong>
            </td>
            <td class="runner" colspan="3">
              <admin:buildRunnersInfo buildRunners="${template.buildRunners}"/>
            </td>
          </jsp:attribute>
          <jsp:attribute name="ifAccessGranted">
            <c:set var="onclick">BS.openUrl(event, '<admin:editTemplateLink withoutLink="true"
                                                                            templateId="${template.externalId}"
                                                                            cameFromUrl="${cameFromUrl}"/>');</c:set>
            <td class="name highlight" onclick="${onclick}">
              <admin:templateUsageInfo template="${template}"/>
              <strong><c:out value="${template.name}"/></strong>
            </td>
            <td class="runner highlight" onclick="${onclick}">
              <admin:buildRunnersInfo buildRunners="${template.buildRunners}"/>
            </td>
            <td class="edit highlight" onclick="${onclick}">
              <admin:editTemplateMenu template="${template}" cameFromUrl="${cameFromUrl}">${template.readOnly ? 'View' : 'Edit'}</admin:editTemplateMenu>
            </td>
            <td class="edit">
              <admin:templateActions template="${template}" editableProjects="${editableProjects}"/>
            </td>
          </jsp:attribute>
          </authz:authorize>
        </tr>
      </c:forEach>
    </l:tableWithHighlighting>
    </c:if>
  </div>

  <div class="section">
    <h2 class="noBorder">Subprojects</h2>
    <bs:smallNote>Subprojects can be used to group build configurations and define projects hierarchy within a single project. <bs:help file="Project"/></bs:smallNote>
    <c:if test="${not currentProject.readOnly}">
    <div class="clearfix">
      <authz:authorize allPermissions="CREATE_SUB_PROJECT" projectId="${currentProject.projectId}">
        <jsp:attribute name="ifAccessGranted">
          <admin:createProjectButtons parentProject="${currentProject}" cameFromUrl="${pageUrl}" createProjectTitle="Create subproject"/>
        </jsp:attribute>
        <jsp:attribute name="ifAccessDenied">
          <div style="color: #888"><i>You do not have permissions to create subprojects in this project</i></div>
        </jsp:attribute>
      </authz:authorize>
      <c:if test="${fn:length(ownSubprojects) > 1 && projectAuthorized}">
        <bs:reorderDialog dialogId="reorderProjectsDialog" dialogTitle="Subprojects">
          <jsp:attribute name="sortables">
            <c:forEach items="${ownSubprojects}" var="project">
              <div class="project draggable tc-icon_before icon16 tc-icon_draggable" id="ord_${project.externalId}"><c:out value="${project.name}"/></div>
            </c:forEach>
          </jsp:attribute>
          <jsp:attribute name="actionsExtension">
            <c:if test="${projectOrderingEnabled}"><forms:button className="resetOrder">Disable custom order</forms:button></c:if>
          </jsp:attribute>
          <jsp:attribute name="messageBody"><div>This will affect the default display for all users.</div></jsp:attribute>
        </bs:reorderDialog>

        <div class="editCustomOrder">
              <span class="greyNote">sorted ${projectOrderingEnabled ? 'with custom order' : 'alphabetically'}
                 <a title="Click to ${projectOrderingEnabled ? 'edit or disable' : 'enable'} custom ordering" id="editProjectsOrder" class="btn">Reorder</a> </span>
        </div>
      </c:if>
    </div>
    </c:if>
    <c:if test="${not empty ownSubprojects}">
      <l:tableWithHighlighting className="parametersTable" id="subprojects">
        <tr>
          <th class="name" colspan="3">Name</th>
        </tr>
        <c:forEach items="${ownSubprojects}" var="project">
          <c:set var="onclick">BS.openUrl(event, '<admin:editProjectLink projectId="${project.externalId}"
                                                                         title="Edit project"
                                                                         withoutLink="true"/>');</c:set>
          <tr>
            <c:set var="editable" value="${afn:permissionGrantedForProject(project, 'EDIT_PROJECT')}"/>
            <td class="${editable ? 'highlight' : ''}" style="width: 90%" onclick="${editable ? onclick : ''}" colspan="${editable ? 1 : 3}">
              <strong><c:out value="${project.name}"/></strong>
              <c:if test="${project.archived}"><i class="archived_project">(archived)</i></c:if>
              <c:if test="${not empty project.description}">
                <bs:smallNote><c:out value="${project.description}"/></bs:smallNote>
              </c:if>
            </td>
            <c:if test="${editable}">
              <td class="edit highlight" onclick="${onclick}">
                <admin:editProjectLink projectId="${project.externalId}">${project.readOnly ? 'View' : 'Edit'}</admin:editProjectLink>
              </td>
              <td class="edit">
                <admin:projectActions project="${project}"/>
              </td>
            </c:if>
          </tr>
        </c:forEach>
      </l:tableWithHighlighting>
    </c:if>
  </div>

</div>

<script type="text/javascript">
  $j(function() {
    BS.EditProjectTab.initReorderModalDialogs("${currentProject.externalId}");
    var $modifiedMessage = $j(".modifiedMessage");
    $j("#subprojectsOrderingCB").on("change", function(event) {
      var $cb = $j(event.target);
      if (arguments[0].target.checked == $cb.attr("data-init-state")) {
        $modifiedMessage.hide();
      } else {
        $modifiedMessage.show();
      }
      $j("td.reorderHandle").toggleClass("draggable");
    });

    var $subs = $j("#subprojects tbody");
    if ($subs.length > 0) {
      $subs.sortable({
                       cancel: ".inherited",
                       tolerance: "pointer",
                       scroll: true,
                       axis: "y",
                       opacity: 0.7,
                       handle: ".reorderHandle",
                       items: "tr.allowed"
                     });
    }

    $subs.on("sortupdate", function() {
      $modifiedMessage.show();
    });
  });

  <c:if test="${currentProject.readOnly}">
  BS.EditProjectForm.disable();
  </c:if>
</script>

<forms:modified/>
