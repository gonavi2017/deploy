<%@ page import="jetbrains.buildServer.controllers.admin.projects.EditVcsRootsController" %>
<%@ page import="jetbrains.buildServer.controllers.admin.projects.VcsPropertiesBean" %>
<%@ include file="/include-internal.jsp"%>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="vcsPropertiesBean" scope="request" type="jetbrains.buildServer.controllers.admin.projects.VcsPropertiesBean"/>
<jsp:useBean id="pageUrl" scope="request" type="java.lang.String"/>
<c:set var="pageTitle" scope="request"><c:choose><c:when test="${vcsPropertiesBean.newRoot}">New </c:when><c:otherwise>Edit </c:otherwise></c:choose>VCS Root</c:set>
<c:set var="tplUsages" value="${vcsPropertiesBean.templateVcsRootUsages}"/>
<c:set var="btUsages" value="${vcsPropertiesBean.buildTypeVcsRootUsages}"/>
<c:set var="vsettingsUsages" value="${vcsPropertiesBean.versionedSettingsRootUsages}"/>
<c:set var="moveToProjects" value="${vcsPropertiesBean.moveToProjects}"/>
<c:set var="belongsToProject" value="${vcsPropertiesBean.belongsToProject}"/>
<c:set var="inaccessibleNum" value="${vcsPropertiesBean.numberOfInaccessibleUsages}"/>
<c:if test="${not empty belongsToProject}">
  <c:set var="belongsToProjectLink">
    <admin:editProjectLink projectId="${belongsToProject.externalId}"><c:out value="${belongsToProject.fullName}"/></admin:editProjectLink>
  </c:set>
</c:if>
<c:set var="totalUsages" value="${fn:length(tplUsages) + fn:length(btUsages) + fn:length(vsettingsUsages)}"/>
<bs:page>
<jsp:attribute name="head_include">
  <bs:linkCSS>
    /css/admin/adminMain.css
    /css/admin/vcsSettings.css
    /healthStatus/css/healthStatus.css
  </bs:linkCSS>
  <bs:linkScript>
    /js/bs/editProject.js
    /js/bs/testConnection.js
    /js/bs/moveBuildType.js
    /js/bs/editBuildType.js
  </bs:linkScript>
  <script type="text/javascript">
    <admin:projectPathJS startProject="${belongsToProject}" startAdministration="${true}"/>

    BS.Navigation.items.push(<forms:cameBackNav cameFromSupport="${vcsPropertiesBean.cameFromSupport}"/>);
    BS.Navigation.items.push({title: "${pageTitle}", selected:true});

    <c:if test="${not vcsPropertiesBean.newRoot}">
    $j(document).ready(function() {
      BS.VcsSettingsForm.setupEventHandlers();
      <c:if test="${belongsToProject.readOnly}">
      BS.VcsSettingsForm.disable();
      </c:if>
    });
    </c:if>
  </script>
</jsp:attribute>
<jsp:attribute name="quickLinks_include">
  <c:if test="${not vcsPropertiesBean.newRoot and ((totalUsages + inaccessibleNum) == 0 or (fn:length(moveToProjects) > 0)) and not belongsToProject.readOnly}">
    <div class="toolbarItem">
      <bs:actionsPopup controlId="prjActions"
                     popup_options="shift: {x: -100, y: 20}, width: '10em', className: 'quickLinksMenuPopup'">
      <jsp:attribute name="content">
        <div>
          <ul class="menuList">
          <c:if test="${fn:length(moveToProjects) > 0}">
            <l:li><a href="#" onclick="return BS.MoveVcsRootForm.showDialog('${vcsPropertiesBean.vcsRootId}')">Move this VCS root...</a></l:li>
          </c:if>
          <c:if test="${(totalUsages + inaccessibleNum) == 0 and afn:canEditVcsRoot(vcsPropertiesBean.originalVcsRoot)}">
            <l:li><a href="#" onclick="return BS.AdminActions.deleteVcsRoot('${vcsPropertiesBean.vcsRootId}', function() { document.location.href = '${vcsPropertiesBean.cameFromSupport.cameFromUrl}'; })">Delete...</a></l:li>
          </c:if>
          </ul>
        </div>
      </jsp:attribute>
      <jsp:body>Actions</jsp:body>
    </bs:actionsPopup>
    </div>
  </c:if>
</jsp:attribute>

<jsp:attribute name="toolbar_include">
    <c:if test="${not vcsPropertiesBean.newRoot}">
      <div class="healthItemIndicatorContainer" style="display: none">
        <c:set var="vcsRootId" scope="request" value="${vcsPropertiesBean.vcsRootId}" />
        <jsp:include page="/admin/vcsRootHealthStatusItems.html">
          <jsp:param name="originUrl" value="${pageUrl}"/>
        </jsp:include>
      </div>
    </c:if>
</jsp:attribute>

<jsp:attribute name="body_include">

  <forms:modified/>

  <bs:unprocessedMessages/>

  <div id="container" class="clearfix">

    <div class="editVcsRootPage">
      <c:set var="autoDetectName" value="<%=VcsPropertiesBean.AUTO_DETECT_NAME%>"/>
      <c:set var="targetSettingsId"><c:out value="${not empty vcsPropertiesBean.targetSettingsId ? vcsPropertiesBean.targetSettingsId : ''}"/></c:set>
      <form id="vcsSettingsForm" action="<c:url value='/admin/editVcsRoot.html?action=${vcsPropertiesBean.newRoot ? "addVcsRoot" : "editVcsRoot"}'/>"
            method="post" onsubmit="return BS.VcsSettingsForm.submitVcsSettings(${vcsPropertiesBean.newRoot}, '${targetSettingsId}');" autocomplete="off">

      <div class="vcsSettings clearfix">
        <table class="runnerFormTable">
          <l:settingsGroup title="Type of VCS">
            <tr>
              <th class="noBorder"><label for="vcsName">Type of VCS:</label></th>
              <td class="noBorder"><forms:select name="vcsName" onchange="BS.VcsSettingsForm.setSelectedVcs(this.options[this.selectedIndex].value)" enableFilter="true" className="mediumField">
                <c:if test="${not vcsPropertiesBean.newRoot}">
                  <forms:option value="">-- Choose type of VCS --</forms:option>
                </c:if>
                <c:if test="${vcsPropertiesBean.newRoot}">
                  <forms:option value="${autoDetectName}" selected="${autoDetectName == vcsPropertiesBean.vcsName}">&lt;Guess from repository URL&gt;</forms:option>
                </c:if>
                <c:forEach items="${vcsPropertiesBean.availableVcsTypes}" var="vcs">
                  <forms:option value="${vcs.name}" selected="${vcs.name == vcsPropertiesBean.vcsName}"><c:out value="${vcs.displayName}"/></forms:option>
                </c:forEach>
              </forms:select><forms:saving id="chooseVcsTypeProgress" className="progressRingInline"/></td>
            </tr>
          </l:settingsGroup>
        </table>
      </div>

      <bs:refreshable containerId="vcsRootProperties" pageUrl="${pageUrl}">
        <script type="text/javascript">
          BS.MultilineProperties.clearProperties();
        </script>
        <c:if test="${vcsPropertiesBean.vcsTypeSelected}">
          <div class="vcsSettings clearfix">
            <table class="runnerFormTable ${vcsPropertiesBean.autoDetectMode ? 'advancedSetting' : ''}">
            <l:settingsGroup title="VCS Root">
              <tr>
                <th class="noBorder"><label for="vcsRootName">VCS root name: <c:if test="${not vcsPropertiesBean.autoDetectMode}"><l:star/></c:if></label><bs:help file="Configuring VCS Roots" anchor="CommonVCSRootProps"/></th>
                <td class="noBorder">
                  <forms:textField name="vcsRootName" value="${vcsPropertiesBean.vcsRootName}" maxlength="256" className="textProperty disableBuildTypeParams longField"/>
                  <span class="error" id="errorVcsRootName"></span>
                  <span class="smallNote">A unique name to distinguish this VCS root from other roots.</span>
                </td>
              </tr>
              <tr>
                <th><label for="externalId">VCS root ID: <c:if test="${not vcsPropertiesBean.autoDetectMode}"><l:star/></c:if><bs:help file="Identifier"/></label></th>
                <td>
                  <forms:textField name="externalId" value="${vcsPropertiesBean.externalId}" maxlength="256" className="textProperty disableBuildTypeParams longField"/>
                  <span class="error" id="errorExternalId"></span>
                  <span class="smallNote">VCS root ID must be unique across all VCS roots. VCS root ID can be used in parameter references to VCS root parameters and REST API.</span>
                </td>
              </tr>
            </l:settingsGroup>
            </table>

            <c:set var="propertiesBean" value="${vcsPropertiesBean.propertiesBean}" scope="request"/>
            <c:set var="parentProject" value="${belongsToProject}" scope="request"/>
            <jsp:include page="${vcsPropertiesBean.vcsSettingsJspPath}"/>

            <c:set var="defaultMode" value="${vcsPropertiesBean.useDefaultModificationCheckInterval}"/>
            <table class="runnerFormTable advancedSetting">
              <l:settingsGroup title="Changes Checking Interval">
                <tr>
                  <c:set var="onclick">
                    $('modificationCheckInterval').disabled = true;
                  </c:set>
                  <th><label for="mod-check-interval-default">Minimum checking interval:</label><bs:help file="Configuring VCS Roots" anchor="CommonVCSRootProps"/></th>
                  <td>
                    <forms:radioButton name="modificationCheckIntervalMode"
                                       id="mod-check-interval-default"
                                       checked="${defaultMode}"
                                       value="DEFAULT"
                                       onclick="${onclick}"
                                       className="${not defaultMode ? 'valueChanged' : ''}"/>
                    <label for="mod-check-interval-default">use global server setting (${vcsPropertiesBean.defaultModificationCheckInterval} seconds)</label>
                </tr>

                <tr>
                  <c:set var="onclick">
                    $('modificationCheckInterval').disabled = false;
                    $('modificationCheckInterval').focus();
                  </c:set>
                  <td>&nbsp;</td>
                  <td>
                    <forms:radioButton name="modificationCheckIntervalMode"
                                       value="SPECIFIED"
                                       id="mod-check-interval-specified"
                                       checked="${not defaultMode}"
                                       onclick="${onclick}"
                                       className="${not defaultMode ? 'valueChanged' : ''}"/>
                    <label for="mod-check-interval-specified">custom:
                    <forms:textField name="modificationCheckInterval" size="4" maxlength="8" value="${vcsPropertiesBean.modificationCheckInterval}" disabled="${defaultMode}" className="smallField"/>
                    seconds</label><span class="error" id="invalidModificationCheckInterval"></span>
                  </td>
                </tr>
                <tr><td colspan="2"><span class="smallNote">Please note that certain servers can refuse access if polled too frequently.
                  Consider intervals greater than 1800 seconds (30 minutes) for public servers.</span></td></tr>
              </l:settingsGroup>

            </table>

            <table class="runnerFormTable ${vcsPropertiesBean.newRoot ? 'advancedSetting' : ''}">
            <l:settingsGroup title="VCS Root Project">
              <tr>
                <th>
                  <label for="ownerProjectId">Belongs to project:</label>
                </th>
                <td>
                    ${belongsToProjectLink}
                    <c:if test="${fn:length(moveToProjects) > 0}">
                      <input type="button" class="btn btn_mini action" style="margin-left: 2em;" value="Move" onclick="BS.MoveVcsRootForm.showDialog('${vcsPropertiesBean.vcsRootId}')"/>
                    </c:if>
                </td>
              </tr>
            </l:settingsGroup>
            </table>
          </div>

          <admin:showHideAdvancedOpts containerId="vcsSettingsForm" optsKey="vcsRootSettings_${vcsPropertiesBean.vcsName}"/>
          <admin:highlightChangedFields containerId="vcsSettingsForm"/>

          <div>
            <c:if test="${not vcsPropertiesBean.newRoot}">
            <c:set var="allProjectsOptionShown" value="${false}"/>
            <c:if test="${vcsPropertiesBean.editTemplateMode}">
              <c:set var="tplUsageCount" value="${vcsPropertiesBean.targetSettings.numberOfUsages}"/>
              <c:set var="tplUsagesSuffix"><c:if test="${tplUsageCount ge 0}"> and ${tplUsageCount} inherited configuration<bs:s val="${tplUsageCount}"/></c:if></c:set>
            </c:if>
            <c:set var="targetName" value=""/>
            <c:choose>
              <c:when test="${vcsPropertiesBean.createBuildTypeMode}"><c:set var="targetName" value="newly created build configuration"/></c:when>
              <c:when test="${vcsPropertiesBean.createTemplateMode}"><c:set var="targetName" value="newly created template"/></c:when>
              <c:when test="${vcsPropertiesBean.editBuildTypeMode}"><c:set var="targetName">${vcsPropertiesBean.targetSettings.name} only</c:set></c:when>
              <c:when test="${vcsPropertiesBean.editTemplateMode}"><c:set var="targetName">${vcsPropertiesBean.targetSettings.name} ${tplUsagesSuffix}</c:set></c:when>
            </c:choose>
            <c:if test="${(vcsPropertiesBean.numberOfProjectUsages > 1 and vcsPropertiesBean.usedInTargetProject)
                          or ((vcsPropertiesBean.createBuildTypeOrTemplateMode or vcsPropertiesBean.editBuildTypeOrTemplateMode) and (fn:length(btUsages) + fn:length(tplUsages) > 1))}">
              <c:set var="saveOptionsShown" value="false"/>
              <div class="icon_before icon16 attentionComment">
                <c:if test="${vcsPropertiesBean.numberOfProjectUsages > 1}">
                  This VCS root is used in more than one project. Changes to this VCS root may affect all of them. Please choose corresponding option for applying changes in this VCS root.
                </c:if>
                <c:if test="${vcsPropertiesBean.numberOfProjectUsages == 1 and (fn:length(btUsages) + fn:length(tplUsages) > 1)}">
                  This VCS root is used in more than one build configuration and / or template. Changes to this VCS root may affect all of them. Please choose corresponding option for applying changes in this VCS root.
                </c:if>
              </div>
              <table class="saveVcsRootOptions">
                <c:if test="${vcsPropertiesBean.createBuildTypeOrTemplateMode or vcsPropertiesBean.editBuildTypeOrTemplateMode}">
                <c:set var="saveOptionsShown" value="true"/>
                <tr>
                  <td>
                    <forms:radioButton name="saveOption" value="<%=EditVcsRootsController.SaveOptions.COPY_TO_TARGET_BUILD_TYPE.name()%>" id="saveOptionCopyToTargetConf"/>
                    <label for="saveOptionCopyToTargetConf">Apply to <strong><c:out value="${targetName}"/></strong> (a copy of this VCS root will be created)</label>
                  </td>
                </tr>
                </c:if>
                <c:if test="${vcsPropertiesBean.numberOfProjectUsages > 1 and vcsPropertiesBean.usedInTargetProject}">
                <c:set var="saveOptionsShown" value="true"/>
                <tr>
                  <td>
                  <forms:radioButton name="saveOption" value="<%=EditVcsRootsController.SaveOptions.COPY_TO_PROJECT_BUILD_TYPES.name()%>" id="saveOptionCopyToProjectConfs"/>
                  <label for="saveOptionCopyToProjectConfs">Apply to all templates <c:if test="${not vcsPropertiesBean.targetProject.rootProject}">& configurations</c:if> of <strong><c:out value="${vcsPropertiesBean.targetProject.fullName}"/></strong> project where this VCS root is used (a copy of this VCS root will be created)</label>
                  </td>
                </tr>
                </c:if>
                <c:if test="${saveOptionsShown}">
                <tr>
                  <td>
                    <c:set var="allProjectsOptionShown" value="${true}"/>
                  <forms:radioButton name="saveOption" value="<%=EditVcsRootsController.SaveOptions.SAVE_FOR_ALL.name()%>" id="saveOptionSave"/>
                  <label for="saveOptionSave">Apply to all ${vcsPropertiesBean.numberOfProjectUsages > 1 ? 'projects' : 'build configurations and templates'}</label>
                  </td>
                </tr>
                </c:if>
              </table>
            </c:if>
            </c:if>
            <div class="saveButtonsBlock">
              <forms:submit label="${vcsPropertiesBean.newRoot ? 'Create' : 'Save'}"/>
              <c:if test="${vcsPropertiesBean.testConnectionSupported}">
                <forms:submit id="testConnectionButton" type="button" label="Test connection" onclick="BS.VcsSettingsForm.submitTestConnection(${vcsPropertiesBean.newRoot});"/>
              </c:if>
              <forms:cancel cameFromSupport="${vcsPropertiesBean.cameFromSupport}" label="${empty param['showSkip'] ? 'Cancel' : 'Skip'}"/>
              <forms:saving/>
              <c:if test="${not allProjectsOptionShown}">
                <input type="hidden" name="saveOption" value="SAVE_FOR_ALL"/>
              </c:if>
            </div>
          </div>

        </c:if>

        <input type="hidden" name="submitVcsRoot" id="submitVcsRoot" value="store"/>
        <input type="hidden" name="publicKey" id="publicKey" value="${vcsPropertiesBean.publicKey}"/>
        <input type="hidden" name="editingScope" id="editingScope" value="<c:out value="${vcsPropertiesBean.editingScope}"/>"/>
        <input type="hidden" name="vcsRootId" id="vcsRootId" value="${vcsPropertiesBean.vcsRootId}"/>
        <input type="hidden" name="skipDuplicatesCheck" id="skipDuplicatesCheck" value="false"/>

        <script type="text/javascript">
          <c:choose>
          <c:when test="${not vcsPropertiesBean.newRoot}">
          BS.VcsSettingsForm.setModified(${vcsPropertiesBean.stateModified});
          BS.AvailableParams.attachPopups('vcsRootId=${vcsPropertiesBean.vcsRootId}', 'textProperty', 'multilineProperty');
          </c:when>
          <c:otherwise>
          BS.AvailableParams.attachPopups('', 'textProperty', 'multilineProperty');
          </c:otherwise>
          </c:choose>
          BS.VisibilityHandlers.updateVisibility('vcsRootProperties');
        </script>

        <bs:dialog dialogId="testConnectionDialog" dialogClass="vcsRootTestConnectionDialog" title="Test Connection" closeCommand="BS.TestConnectionDialog.close();"
          closeAttrs="showdiscardchangesmessage='false'">
          <div id="testConnectionStatus"></div>
          <div id="testConnectionDetails" class="mono"></div>
        </bs:dialog>

        <c:if test="${not belongsToProject.readOnly}">
        <script type="text/javascript">
          BS.AdminActions.prepareVcsRootIdGenerator("externalId", "vcsRootName", '${vcsPropertiesBean.belongsToProject.externalId}', ${not vcsPropertiesBean.newRoot});
        </script>
        </c:if>
      </bs:refreshable>

    </form>

    </div>

    <div id="sidebarAdmin">
      <c:if test="${totalUsages > 0 or inaccessibleNum > 0}">
      <table class="usefulLinks">
      <c:if test="${totalUsages > 0}">
      <tr>
        <td>
          <c:if test="${not empty tplUsages}">
            <div>
            <bs:popup_static controlId="tplUsages"
                             popup_options="shift: {x: -150, y: 20}, className: 'quickLinksMenuPopup'">
              <jsp:attribute name="content">
                <div>
                  <ul class="menuList">
                    <c:forEach items="${tplUsages}" var="tpl">
                      <l:li>
                      <c:choose>
                        <c:when test="${afn:permissionGrantedForProject(tpl.project,'EDIT_PROJECT')}">
                          <admin:editTemplateLink step="vcsRoots" templateId="${tpl.externalId}"><c:out value="${tpl.fullName}"/></admin:editTemplateLink>
                        </c:when>
                        <c:otherwise><span title="You do not have enough permissions to edit this build configuration"><em><c:out value="${tpl.fullName}"/></em></span></c:otherwise>
                      </c:choose>
                      </l:li>
                    </c:forEach>
                  </ul>
                </div>
              </jsp:attribute>
              <jsp:body>
                Used in <strong>${fn:length(tplUsages)}</strong> template<bs:s val="${fn:length(tplUsages)}"/>
              </jsp:body>
            </bs:popup_static>
            </div>
          </c:if>

          <c:if test="${not empty btUsages}">
          <div>
          <bs:popup_static controlId="btUsages" popup_options="shift: {x: -150, y: 20}, className: 'quickLinksMenuPopup'">
            <jsp:attribute name="content">
              <div>
                <ul class="menuList">
                  <c:forEach items="${btUsages}" var="buildType">
                    <l:li>
                    <c:choose>
                      <c:when test="${afn:permissionGrantedForBuildType(buildType,'EDIT_PROJECT')}">
                        <admin:editBuildTypeLink step="vcsRoots" buildTypeId="${buildType.externalId}"><c:out value="${buildType.fullName}"/></admin:editBuildTypeLink>
                      </c:when>
                      <c:otherwise><span title="You do not have enough permissions to edit this build configuration"><c:out value="${buildType.fullName}"/></span></c:otherwise>
                    </c:choose>
                    </l:li>
                  </c:forEach>
                </ul>
              </div>
            </jsp:attribute>
            <jsp:body>
              Used in <strong>${fn:length(btUsages)}</strong> build configuration<bs:s val="${fn:length(btUsages)}"/>
            </jsp:body>
          </bs:popup_static>
          </div>
          </c:if>

          <c:if test="${not empty vsettingsUsages}">
          <div>
            <bs:popup_static controlId="vsettingsUsages" popup_options="shift: {x: -150, y: 20}, className: 'quickLinksMenuPopup'">
            <jsp:attribute name="content">
              <div>
                <ul class="menuList">
                  <c:forEach items="${vsettingsUsages}" var="proj">
                    <l:li>
                      <c:choose>
                        <c:when test="${afn:permissionGrantedForProject(proj,'EDIT_PROJECT')}">
                          <admin:editProjectLink projectId="${proj.externalId}" addToUrl="&tab=versionedSettings"><c:out value="${proj.fullName}"/></admin:editProjectLink>
                        </c:when>
                        <c:otherwise><span title="You do not have enough permissions to edit this project"><c:out value="${proj.fullName}"/></span></c:otherwise>
                      </c:choose>
                    </l:li>
                  </c:forEach>
                </ul>
              </div>
            </jsp:attribute>
            <jsp:body>
              Used in <strong>${fn:length(vsettingsUsages)}</strong> project<bs:s val="${fn:length(vsettingsUsages)}"/> to store settings
            </jsp:body>
            </bs:popup_static>
          </div>
          </c:if>
        </td>
      </tr>
      </c:if>
      <c:if test="${inaccessibleNum > 0}">
      <tr>
        <td>
          <span class="grayNote">This VCS root is also used in ${inaccessibleNum} project<bs:s val="${inaccessibleNum}"/> you do not have access to.</span>
        </td>
      </tr>
      </c:if>
      </table>
      </c:if>

      <admin:configModificationInfo project="${belongsToProject}" auditLogAction="${vcsPropertiesBean.lastConfigModificationAction}"/>
    </div>

  </div>

  <admin:moveVcsRootForm availableProjects="${moveToProjects}"/>
  <admin:duplicateVcsRootsDialog/>
</jsp:attribute>
</bs:page>
