<%@ tag import="jetbrains.buildServer.serverSide.BuildTypeOptions" %>
<%@ tag import="jetbrains.buildServer.web.util.WebUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %>
<%@ taglib prefix="afn" uri="/WEB-INF/functions/authz" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<%@ taglib prefix="admfn" uri="/WEB-INF/functions/admin" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ attribute name="buildTypeForm" required="true" type="jetbrains.buildServer.controllers.admin.projects.BuildTypeForm"%>
<%@ attribute name="mode" required="true" %>
<%@ attribute name="pageUrl" type="java.lang.String" required="true" %>
<%@ attribute name="branchesConfigured" type="java.lang.Boolean" required="true" %>
<c:set var="vcsRootsBean" value="${buildTypeForm.vcsRootsBean}"/>
<c:set var="encodedCameFromUrl" value="<%=WebUtil.encode(pageUrl)%>"/>
<bs:linkScript>
  /js/bs/systemProblemsMonitor.js
</bs:linkScript>

<script type="text/javascript">
  $j(function() {
    $('checkoutDir').on('keypress', function() {
      setTimeout(BS.EditVcsRootsForm.updateCheckoutDirectoryWarning, 10);
    });
    BS.EditVcsRootsForm.updateCheckoutDirectoryWarning();
  });
</script>

<c:set var="pageTitle">
  <c:choose>
    <c:when test="${mode == 'editTemplate'}">Edit Build Configuration Template</c:when>
    <c:when test="${mode == 'editBuildType'}">Edit Build Configuration</c:when>
  </c:choose>
</c:set>

<c:url var="attachUrl" value="/admin/attachBuildTypeVcsRoots.html?init=1&id=${buildTypeForm.settingsId}"/>
<c:set var="description">In this section you can configure how project source code is retrieved from VCS. <bs:help file="Configuring+VCS+Settings"/></c:set>
<c:set var="canAttachRoot" value="${not buildTypeForm.readOnly and (fn:length(vcsRootsBean.attachableVcsRoots) > 0 or afn:permissionGrantedForProject(buildTypeForm.project, 'CREATE_DELETE_VCS_ROOT'))}"/>
<c:set var="vcsRoots" value="${vcsRootsBean.vcsRoots}"/>
<div class="section noMargin">
  <h2 class="noBorder">VCS Roots</h2>
  <bs:smallNote>${description}</bs:smallNote>

  <c:if test="${canAttachRoot}">
    <forms:addButton href="${attachUrl}" showdiscardchangesmessage="false">Attach VCS root</forms:addButton>
  </c:if>

  <div id="existingVcsRoots">
    <admin:vcsRootsTable vcsRootsBean="${vcsRootsBean}"
                         pageUrl="${pageUrl}"
                         pageTitle="${pageTitle}"
                         buildForm="${buildTypeForm}" />
  </div>
</div>

<bs:messages key="vcsSettingsChanged"/>

<div class="section advancedSetting">
  <h2 class="noBorder">Checkout Options</h2>
  <bs:smallNote>Additional VCS checkout and display settings.</bs:smallNote>

  <table class="runnerFormTable">
    <l:settingsGroup title="Checkout Settings">
      <tr class="advancedSetting">
       <th class="option"><label for="checkoutType">VCS checkout mode: <bs:help file="VCS+Checkout+Mode" /></label></th>
       <td class="selector">

         <admin:selectOption buildTypeForm="${buildTypeForm}" fieldName="checkoutType" optionName="<%=BuildTypeOptions.BT_CHECKOUT_MODE.getKey()%>" onchange="BS.EditVcsRootsForm.updateCheckoutDirectoryWarning()">
           <c:forEach items="${vcsRootsBean.availableCheckoutTypes}" var="typeName">
             <forms:option selected="${vcsRootsBean.checkoutType == typeName}" value="${typeName}"><c:out value="${vcsRootsBean.checkoutTypeDescription[typeName]}"/></forms:option>
           </c:forEach>
         </admin:selectOption>

         <c:if test="${vcsRootsBean.showInefficientCheckoutRulesWarning}">
           <div class="icon_before icon16 attentionComment">
             Exclude checkout rules are specified while "checkout on agent" mode is used. Applying these checkout rules requires additional overhead and is inefficient.
           </div>
         </c:if>
         <c:if test="${vcsRootsBean.showIncludeRulesIntersectWarning}">
           <div class="icon_before icon16 attentionComment">
             The paths specified in the checkout rules of one VCS root conflict (intersect) with checkout rules of another VCS root. This may cause problems in "checkout on agent" mode.
           </div>
         </c:if>
       </td>
      </tr>
      <tr class="advancedSetting">
       <th class="option"><label for="checkoutDirectoryMode">Checkout directory: <bs:help file="Build+Checkout+Directory"/></label></th>
       <td class="selector">
         <c:set var="checkoutDirOpt" value="<%=BuildTypeOptions.BT_CHECKOUT_DIR.getKey()%>"/>
         <c:set var="definedCD" value="${buildTypeForm.definedOptions[checkoutDirOpt]}"/>
         <c:set var="defaultCD" value="${buildTypeForm.defaultOptionValues[checkoutDirOpt]}"/>
         <c:set var="actualCD" value="${buildTypeForm.optionValues[checkoutDirOpt]}"/>
         <c:set var="changedCD" value="${actualCD != defaultCD}"/>
         <c:set var="className">${changedCD ? 'valueChanged' : ''}</c:set>

         <div>
           <forms:select id="checkoutDirectoryMode" name="checkoutDirectoryMode" style="width: 340px;" onchange="BS.EditVcsRootsForm.updateCheckoutSharing()" enableFilter="${true}" className="${className}"
                         disabled="${!buildTypeForm.typedOptions[checkoutDirOpt].modifiable}">
             <forms:option value="shared">Auto (recommended)</forms:option>
             <forms:option value="custom" selected="${not empty vcsRootsBean.checkoutDir}">Custom path</forms:option>
           </forms:select>

           <c:if test="${empty vcsRootsBean.checkoutDir}">
             <c:if test="${definedCD != null and not buildTypeForm.readOnly}"><a href="#" onclick="{
               $('removedOptions_${checkoutDirOpt}').value = '${checkoutDirOpt}';

               <c:if test="${empty defaultCD}">
                 $('checkoutDirectoryMode').setSelectValue('shared');
               </c:if>
               <c:if test="${not empty defaultCD}">
                 $('checkoutDirectoryMode').setSelectValue('custom');
                 BS.EditVcsRootsForm.updateCheckoutSharing();
                 $('resetLink_${checkoutDirOpt}').click();
               </c:if>

              $(this).hide();
              if ($('selector_inheritedOpt_${checkoutDirOpt}')) {
                $('selector_inheritedOpt_${checkoutDirOpt}').show();
              }
              return false;
             }" class="resetLink" showdiscardchangesmessage="false">Reset</a></c:if>
             <c:if test="${buildTypeForm.settings.template != null}"><span class="inheritedParam" id="selector_inheritedOpt_${checkoutDirOpt}" style="${definedCD != null ? 'display: none' : ''}">(inherited)</span></c:if>
             <c:if test="${!buildTypeForm.typedOptions[checkoutDirOpt].modifiable}">
               <c:choose>
                 <c:when test="${not empty buildTypeForm.definedOptions[checkoutDirOpt] && buildTypeForm.definedOptions[checkoutDirOpt] != buildTypeForm.optionValues[checkoutDirOpt]}">
                   <i class="icon-lock undefinedParam" title="Actual value '${buildTypeForm.definedOptions[checkoutDirOpt]}' defined in this configuration is overriden by enforced settings"></i>
                 </c:when>
                 <c:otherwise>
                   <i class="icon-lock protectedSetting" title="This option is bounded"></i>
                 </c:otherwise>
               </c:choose>
             </c:if>
           </c:if>
         </div>
         <div id="autoCheckout" class="smallNote" style='${not empty vcsRootsBean.checkoutDir ? 'display: none' : ''}'>
           With this selection all build configurations with the same VCS settings will use the same checkout directory.
         </div>
         <div id="customCheckout" style='${empty vcsRootsBean.checkoutDir ? 'display: none' : ''}'>
           <admin:textOption buildTypeForm="${buildTypeForm}" fieldName="checkoutDir" optionName="${checkoutDirOpt}" className="buildTypeParams">
             <jsp:attribute name="labelText"></jsp:attribute>
           </admin:textOption>

           <bs:smallNote>A relative or an absolute path to the agent working directory. Restrictions apply.<bs:help file="Build+Checkout+Directory#BuildCheckoutDirectory-Customcheckoutdirectory"/></bs:smallNote>
           <div id="deletionWarning" class="tc-icon_before icon16 tc-icon_attention smallNoteAttention" style="display:none;">This directory might be cleaned by TeamCity before the build</div>
         </div>
         <c:if test="${not buildTypeForm.template}">
           <c:set var="sameDirBuildTypes" value="${vcsRootsBean.checkoutDirBean.buildTypesWithSameCheckoutDirAndDifferentVcsSettings}"/>
           <c:if test="${not empty sameDirBuildTypes}">
             <div><span class="icon icon16 yellowTriangle"></span> The following build configurations have the same checkout directory but different VCS settings,
               this may lead to unnecessary clean checkout on agent:</div>
             <c:forEach var="bt" items="${sameDirBuildTypes}">
               <div style="padding-left: 20px">
               <authz:authorize projectId="${bt.projectId}" allPermissions="EDIT_PROJECT">
                 <jsp:attribute name="ifAccessGranted">
                   <admin:editBuildTypeLinkFull step="vcsRoots" buildType="${bt}"/>
                 </jsp:attribute>
                 <jsp:attribute name="ifAccessDenied">
                   <bs:buildTypeLink buildType="${bt}"><c:out value="${bt.fullName}"/></bs:buildTypeLink>
                 </jsp:attribute>
               </authz:authorize>
               </div>
             </c:forEach>
           </c:if>
         </c:if>
       </td>
      </tr>
      <tr class="advancedSetting">
       <th class="option"><label for="cleanBuild">Clean build: </label></th>
       <td class="selector">
         <admin:booleanOption buildTypeForm="${buildTypeForm}" optionName="<%=BuildTypeOptions.BT_CLEAN_BUILD.getKey()%>" onclick="BS.EditVcsRootsForm.updateCheckoutDirectoryWarning()" fieldName="cleanBuild">
           <jsp:attribute name="labelText">Clean all files in the checkout directory before the build</jsp:attribute>
         </admin:booleanOption>
       </td>
      </tr>
    </l:settingsGroup>

    <l:settingsGroup title="Changes Calculation Settings">
      <tr class="advancedSetting">
        <th rowspan="2">&nbsp;</th>
        <td>
          <admin:booleanOption buildTypeForm="${buildTypeForm}" optionName="<%=BuildTypeOptions.BT_SHOW_DEPS_CHANGES.getKey()%>" fieldName="showDependenciesChanges">
            <jsp:attribute name="labelText">Show changes from snapshot dependencies <bs:help file="Build+Dependencies+Setup" anchor="ShowChangesfromDeps"/></jsp:attribute>
          </admin:booleanOption>
          <span class="smallNote">This also affects treatment of pending changes in schedule trigger.</span>
        </td>
      </tr>
      <tr>
        <td>
          <admin:booleanOption buildTypeForm="${buildTypeForm}" optionName="<%=BuildTypeOptions.BT_EXCLUDE_DEFAULT_BRANCH_CHANGES.getKey()%>" fieldName="excludeDefaultBranchChanges">
            <jsp:attribute name="labelText">Exclude default branch changes from other branches <bs:help file="Configuring+VCS+Settings" anchor="excludeDefaultBranch"/></jsp:attribute>
          </admin:booleanOption>
        </td>
      </tr>
    </l:settingsGroup>
    <l:settingsGroup title="Default Branch Settings">
      <tr class="advancedSettings">
        <th>&nbsp;</th>
        <td>
          <admin:booleanOption buildTypeForm="${buildTypeForm}" optionName="<%=BuildTypeOptions.BT_BUILD_DEFAULT_BRANCH.getKey()%>" fieldName="buildDefaultBranch">
            <jsp:attribute name="labelText">Allow builds in the default branch <bs:help file="Configuring+VCS+Settings" anchor="allowBuildsDefaultBranch"/></jsp:attribute>
          </admin:booleanOption>
        </td>
      </tr>
    </l:settingsGroup>

    <tr>
      <td colspan="2">
        <c:choose>
          <c:when test="${buildTypeForm.template}">
            <c:set var="editFeaturesUrl"><admin:editTemplateLink step="buildFeatures" templateId="${buildTypeForm.externalId}" withoutLink="true"/></c:set>
          </c:when>
          <c:otherwise>
            <c:set var="editFeaturesUrl"><admin:editBuildTypeLink step="buildFeatures" buildTypeId="${buildTypeForm.externalId}" withoutLink="true"/></c:set>
          </c:otherwise>
        </c:choose>
        <div style="margin-top: 1em">
          You can also configure VCS roots labeling with the help of <a href="${editFeaturesUrl}#addFeature=VcsLabeling">VCS labeling build feature</a>.
        </div>
      </td>
    </tr>
  </table>

  <div class="saveButtonsBlock advancedSetting">
    <forms:submit label="Save"/>
    <forms:cancel cameFromSupport="${buildTypeForm.cameFromSupport}"/>
    <forms:saving id="applyVcsSettingsProgress"/>
  </div>
  <input type="hidden" value="${buildTypeForm.numberOfSettingsChangesEvents}" name="numberOfSettingsChangesEvents"/>

  <input type="hidden" name="submitBuildType" id="submitBuildType" value=""/>
  <input type="hidden" name="doAttach" id="doAttach" value="false">
  <input type="hidden" name="doApplyVcsSettings" id="doApplyVcsSettings" value="false">
</div>

<admin:showHideAdvancedOpts containerId="editVcsSettingsForm" optsKey="buildTypeVcsSettings"/>
<admin:highlightChangedFields containerId="editVcsSettingsForm"/>

<script type="text/javascript">
  BS.SystemProblems.startUpdates('<%=jetbrains.buildServer.serverSide.systemProblems.StandardSystemProblemTypes.VCS_CONFIGURATION%>');
</script>
