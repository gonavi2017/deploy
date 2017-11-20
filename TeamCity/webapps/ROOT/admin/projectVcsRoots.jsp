<%@ include file="/include-internal.jsp" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<%@ taglib prefix="admfn" uri="/WEB-INF/functions/admin" %>
<jsp:useBean id="vcsRootsForm" type="jetbrains.buildServer.controllers.admin.projects.ProjectVcsRootsBean" scope="request"/>

<bs:linkScript>
  /js/bs/systemProblemsMonitor.js
</bs:linkScript>

<c:set value="<%=jetbrains.buildServer.serverSide.systemProblems.StandardSystemProblemTypes.VCS_CONFIGURATION%>" var="problemType"/>
<c:set var="visibleVcsRoots" value="${vcsRootsForm.visibleVcsRoots}"/>
<c:set var="formHasFilter" value="${not empty vcsRootsForm.keyword or vcsRootsForm.showUnusedOnly or not vcsRootsForm.showSubProjectsVcsRoots}"/>
<div id="existingVcsRoots" class="section noMargin">
  <h2 class="noBorder">VCS Roots</h2>
  <bs:smallNote>A VCS Root is a set of settings defining how TeamCity communicates with a version control system to monitor changes and get sources of a build<bs:help file="VCS+root"/></bs:smallNote>

  <c:set var="cameFromUrl" value="${param['cameFromUrl']}"/>
  <c:if test="${not currentProject.readOnly}">
  <authz:authorize projectId="${vcsRootsForm.ownerProjectId}" anyPermission="CREATE_DELETE_VCS_ROOT">
    <p style="margin-top: 0">
      <admin:createVcsRootLink editingScope="editProject:${vcsRootsForm.ownerProjectExternalId}" cameFromUrl="${cameFromUrl}" cameFromTitle="">Create VCS root</admin:createVcsRootLink>
    </p>
  </authz:authorize>
  </c:if>

  <bs:messages key="vcsRootRemoved"/>
  <bs:messages key="vcsRootsUpdated"/>
  <bs:messages key="vcsRootDetached"/>
  <bs:messages key="vcsRootAttached"/>
  <bs:messages key="vcsRootUpdateFailure"/>

  <c:if test="${not empty visibleVcsRoots or formHasFilter}">
    <form action="<c:url value='/admin/editProject.html'/>" method="get" id="vcsRootsFilterForm">
      <div class="actionBar">
      <span class="nowrap">
        <label class="firstLabel" for="keyword">Filter: </label>
        <forms:textField name="keyword" value="${vcsRootsForm.keyword}" size="20"/>
      </span>

        <forms:filterButton/>
        <c:if test="${not empty vcsRootsForm.keyword}">
          <forms:resetFilter resetHandler="$('vcsRootsFilterForm').keyword.value='';$('vcsRootsFilterForm').submit();"/>
        </c:if>

      <span style="margin-left: 20px">
        <forms:checkbox name="showSubProjectsVcsRoots" checked="${vcsRootsForm.showSubProjectsVcsRoots}" onclick="$('vcsRootsFilterForm').submit();"/>
        <label for="showSubProjectsVcsRoots" style="margin: 0;">Show VCS roots from sub-projects</label>
      </span>

      <span style="margin-left: 20px">
        <forms:checkbox name="showUnusedOnly" checked="${vcsRootsForm.showUnusedOnly}" onclick="$('vcsRootsFilterForm').submit();"/>
        <label for="showUnusedOnly" style="margin: 0;">Show unused VCS roots only</label>
      </span>
      </div>
      <input type="hidden" name="projectId" value="${vcsRootsForm.ownerProjectExternalId}"/>
      <input type="hidden" name="tab" value="projectVcsRoots"/>
    </form>
  </c:if>

  <c:if test="${not empty visibleVcsRoots}">
    <l:tableWithHighlighting className="parametersTable" id="projectVcsRoots" highlightImmediately="true">
      <tr>
        <th colspan="3">Name</th>
        <th class="usages">Usages</th>
      </tr>
      <c:forEach items="${visibleVcsRoots}" var="vcsRoot" varStatus="status">
        <c:set var="rootProject" value="${vcsRootsForm.projectsMap[vcsRoot.scope.ownerProjectId]}"/>
        <c:set var="canDeleteRoot" value="${afn:permissionGrantedForProject(rootProject, 'CREATE_DELETE_VCS_ROOT')}"/>

        <c:set var="onclick" value=""/>
        <c:set var="highlight" value=""/>
        <c:set var="canEditRoot" value="${afn:canEditVcsRoot(vcsRoot)}"/>
        <c:if test="${canEditRoot}">
          <c:choose>
            <c:when test="${not empty vcsRootsForm.ownerProjectExternalId}"><c:set var="editingScope">editProject:${vcsRootsForm.ownerProjectExternalId}</c:set></c:when>
            <c:when test="${not empty rootProject}"><c:set var="editingScope">editProject:${rootProject.externalId}</c:set></c:when>
            <c:otherwise><c:set var="editingScope">none</c:set></c:otherwise>
          </c:choose>
          <c:set var="editVcsRootLink"><admin:editVcsRootLink editingScope="${editingScope}"
                                                              vcsRoot="${vcsRoot}"
                                                              withoutLink="true"
                                                              cameFromUrl="${cameFromUrl}"
                                                              cameFromTitle="Edit Project"/></c:set>
          <c:set var="highlight" value="highlight"/>
          <c:set var="onclick">BS.openUrl(event, '${editVcsRootLink}');</c:set>
        </c:if>

        <c:set var="templateUsages" value="${vcsRootsForm.templateUsages[vcsRoot]}"/>
        <c:set var="btUsages" value="${vcsRootsForm.buildTypeUsages[vcsRoot]}"/>
        <c:set var="templateUsagesNum" value="${fn:length(templateUsages)}"/>
        <c:set var="btUsagesNum" value="${fn:length(btUsages)}"/>
        <c:set var="versionedSettingsUsages" value="${vcsRootsForm.versionedSettingsRootUsages[vcsRoot]}"/>
        <c:set var="versionedSettingsUsagesNum" value="${fn:length(versionedSettingsUsages)}"/>
        <c:set var="usagesNum" value="${templateUsagesNum + btUsagesNum + versionedSettingsUsagesNum}"/>
        <c:set var="problemsCountInfo" value="${vcsRootsForm.vcsProblemsBean.problemsCountInfo[vcsRoot]}"/>

        <tr>
          <td class="${highlight}" onclick="${onclick}">
            <span class="smallNote" style="float: right; white-space: nowrap;">
              <span id="vcsRootProgress_${vcsRoot.externalId}" style="display: none; padding-left: 2em;"><forms:saving id="vcsRootProgress_${vcsRoot.externalId}:img" className="progressRingInline"/> Saving...</span>
              ${vcsRootsForm.status[vcsRoot]}
            </span>

            <span class="vcsRoot"><admin:vcsRootName editingScope="${editingScope}" cameFromUrl="${pageUrl}" vcsRoot="${vcsRoot}"/></span>
            <c:if test="${vcsRoot.project.projectId != currentProject.projectId}">
              belongs to <admin:projectName project="${vcsRoot.project}"/>
            </c:if>

            <span style="float: right">
               <bs:systemProblemCountLabel problemsCount="${problemsCountInfo.totalProblemsCount}"
                                           onclick="return BS.AdminActions.toggleVcsRootUsages(this, '${vcsRoot.externalId}');"/>
            </span>

            <div class="clearfix"></div>
          </td>
          <td class="edit ${highlight}" onclick="${onclick}">
            <c:choose>
              <c:when test="${canEditRoot}"><a href="${editVcsRootLink}">${rootProject.readOnly ? 'View' : 'Edit'}</a></c:when>
              <c:otherwise>Edit</c:otherwise>
            </c:choose>
          </td>
          <td class="edit">
            <c:choose>
              <c:when test="${canDeleteRoot and !rootProject.readOnly and usagesNum == 0}"><a href="#" onclick="BS.AdminActions.deleteVcsRoot('${vcsRoot.externalId}'); return false">Delete</a></c:when>
              <c:when test="${not canDeleteRoot}">
                <span title="VCS root cannot be deleted, because you do not have enough permissions">undeletable</span>
              </c:when>
              <c:when test="${not rootProject.readOnly}">
                <span title="VCS root cannot be deleted, because VCS root project is in read only mode">undeletable</span>
              </c:when>
              <c:otherwise>
                <span title="VCS root cannot be deleted, because it has ${usagesNum} usage<bs:s val="${usagesNum}"/>">undeletable</span>
              </c:otherwise>
            </c:choose>
          </td>
          <td>
            <c:choose>
              <c:when test="${usagesNum == 0}"><span title="This VCS root is not used">no usages</span></c:when>
              <c:otherwise>
                <a href="#" onclick="return BS.AdminActions.toggleVcsRootUsages(this, '${vcsRoot.externalId}');">${usagesNum} usage<bs:s val="${usagesNum}"/></a>
              </c:otherwise>
            </c:choose>
          </td>
        </tr>
        <tr id="${vcsRoot.externalId}_usages" class="usages usageHl" style="display: none">
          <td>
            <c:if test="${templateUsagesNum > 0}">
              <div class="templateUsages">
                <div>
                  Used in <b>${templateUsagesNum}</b> template<bs:s val="${templateUsagesNum}"/>:
                </div>
                <ul>
                  <c:forEach items="${templateUsages}" var="btSettings" varStatus="pos">
                    <li>
                      <c:set var="canEdit" value="${afn:permissionGrantedForProject(btSettings.project, 'EDIT_PROJECT')}"/>
                      <c:choose>
                        <c:when test="${canEdit}">
                          <admin:editTemplateLink step="vcsRoots" templateId="${btSettings.externalId}" ><c:out value="${btSettings.fullName}"/></admin:editTemplateLink>
                        </c:when>
                        <c:otherwise><c:out value="${btSettings.fullName}"/></c:otherwise>
                      </c:choose>
                    </li>
                  </c:forEach>
                </ul>
              </div>
            </c:if>

            <c:if test="${btUsagesNum > 0}">
              <div class="btUsages">
                <div>
                  Used in <b>${btUsagesNum}</b> build configuration<bs:s val="${btUsagesNum}"/>:
                </div>
                <ul>
                  <c:forEach items="${btUsages}" var="btSettings" varStatus="pos">
                    <li>
                      <span class="buildConfigurationLink">
                        <c:set var="canEdit" value="${afn:permissionGrantedForBuildType(btSettings, 'EDIT_PROJECT') and (not btSettings.templateBased or btSettings.templateAccessible)}"/>
                        <c:choose>
                          <c:when test="${canEdit}">
                            <admin:editBuildTypeLinkFull step="vcsRoots" buildType="${btSettings}"/>
                          </c:when>
                          <c:otherwise><c:out value="${btSettings.fullName}"/></c:otherwise>
                        </c:choose>
                      </span>

                      <bs:systemProblemCountLabel problemsCount="${problemsCountInfo.countPerBuildType[btSettings]}"
                          onclick="BS.SystemProblemsPopup.showDetails('${btSettings.buildTypeId}', '${problemType}', '${vcsRoot.id}', true, this); return false;"/>
                    </li>
                  </c:forEach>
                </ul>
              </div>
            </c:if>

            <c:if test="${versionedSettingsUsagesNum > 0}">
              <div>
                <div>
                  Used in <b>${versionedSettingsUsagesNum}</b> project<bs:s val="${versionedSettingsUsagesNum}"/> to store settings:
                </div>
                <ul>
                  <c:forEach items="${versionedSettingsUsages}" var="proj">
                    <c:set var="canEdit" value="${afn:permissionGrantedForProject(proj, 'EDIT_PROJECT')}"/>
                    <li>
                      <c:choose>
                        <c:when test="${canEdit}">
                          <admin:editProjectLink projectId="${proj.externalId}" addToUrl="&tab=versionedSettings"><c:out value="${proj.fullName}"/></admin:editProjectLink>
                        </c:when>
                        <c:otherwise>
                          <c:out value="${proj.fullName}"/>
                        </c:otherwise>
                      </c:choose>
                    </li>
                  </c:forEach>
                </ul>
              </div>
            </c:if>
            <c:if test="${templateUsagesNum == 0 and btUsagesNum == 0}">
              <div class="templateUsages"><i>The VCS root is not used in any build configuration or template.</i></div>
            </c:if>
          </td>
          <td></td>
          <td></td>
          <td style="border-top: none"></td>
        </tr>
      </c:forEach>
    </l:tableWithHighlighting>
  </c:if>
  <c:if test="${empty visibleVcsRoots and formHasFilter}">
    <p>No VCS roots found.</p>
  </c:if>

  <bs:pager place="bottom"
            urlPattern="editProject.html?tab=projectVcsRoots&projectId=${vcsRootsForm.ownerProjectExternalId}&page=[page]&keyword=${vcsRootsForm.keyword}&showUnusedOnly=${vcsRootsForm.showUnusedOnly}"
            pager="${vcsRootsForm.pager}"/>
</div>
