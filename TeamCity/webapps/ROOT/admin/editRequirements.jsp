<%@ page import="jetbrains.buildServer.controllers.buildType.ParameterInfo" %>
<%@ include file="/include-internal.jsp" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<jsp:useBean id="buildForm" type="jetbrains.buildServer.controllers.admin.projects.EditableBuildTypeSettingsForm" scope="request"/>
<c:set var="requirementsBean" value="${buildForm.requirementsBean}"/>
<admin:editBuildTypePage selectedStep="requirements">
  <jsp:attribute name="head_include">
    <bs:linkCSS>
      /css/compatibilityList.css
      /css/admin/requirements.css
    </bs:linkCSS>
  </jsp:attribute>
  <jsp:attribute name="body_include">
    <div class="section noMargin">
      <h2 class="noBorder">Explicit Requirements</h2>
      <bs:smallNote>This page lists all requirements that build agents should meet to run your builds.<bs:help file="Agent+Requirements"/></bs:smallNote>

      <c:if test="${not buildForm.readOnly}">
      <div>
        <admin:newRequirement linkText="Add new requirement"/>
      </div>
      </c:if>

      <admin:requirementsList requirements="${requirementsBean.requirements}" requirementsBean="${requirementsBean}" editable="${not buildForm.readOnly}"/>
    </div>

    <c:set var="runnerRequirements" value="${requirementsBean.runTypeRequirements}"/>
    <c:if test="${not empty runnerRequirements and fn:length(runnerRequirements) > 0}">
      <div class="section">
        <h2 class="noBorder">Build Steps Requirements <%--(${fn:length(runnerRequirements)})--%></h2>
        <bs:smallNote>Additional agent requirements imposed by the configured build steps</bs:smallNote>

        <div class="predefinedBlock" id="runner_requirements">
          <admin:requirementsList requirementsBean="${requirementsBean}" requirements="${runnerRequirements}" editable="false"/>
        </div>
    </c:if>

    <c:set var="undefinedParameters" value="${requirementsBean.undefinedParameters}"/>
    <c:if test="${not empty undefinedParameters}">
      <div class="section">
        <h2 class="noBorder">Implicit Requirements <%--(${fn:length(undefinedParameters)})--%></h2>
        <bs:smallNote>This section lists parameters used in configuration settings without actual values provided</bs:smallNote>

        <div class="predefinedBlock" id="implicit_requirements">
          <admin:editBuildTypeNavSteps settings="${buildForm.settings}"/>
          <l:tableWithHighlighting className="parametersTable">
            <tr style="background-color: #f5f5f5;">
              <th>Parameter Name</th>
              <th colspan="2">Parameter Source</th>
            </tr>
            <c:forEach items="${undefinedParameters}" var="e">
              <tr>
                <td class="name"><c:out value="${e.key}"/></td>
                <td class="value">
                  <c:set var="settingDescr" value="${e.value}"/>
                  <c:choose>
                  <c:when test="${settingDescr.type.name == 'ARTIFACTS' or settingDescr.type.name == 'BUILD_TYPE_OPTIONS'}">
                    <a href="<c:url value='${buildConfigSteps[0].url}'/>"><c:out value="${settingDescr.description}"/></a>
                  </c:when>
                  <c:when test="${settingDescr.type.name == 'VCS_ROOT'}">
                    <c:set var="vcsRoot" value="${settingDescr.additionalData}"/>
                    <admin:editVcsRootLink vcsRoot="${settingDescr.additionalData}" editingScope="none" cameFromUrl="${pageUrl}"><c:out value="${settingDescr.description}"/></admin:editVcsRootLink>
                  </c:when>
                  <c:when test="${settingDescr.type.name == 'CHECKOUT_RULES'}">
                    <a href="<c:url value='${buildConfigSteps[1].url}'/>"><c:out value="${settingDescr.description}"/></a>
                  </c:when>
                  <c:when test="${settingDescr.type.name == 'CHECKOUT_DIR'}">
                    <a href="<c:url value='${buildConfigSteps[1].url}'/>"><c:out value="${settingDescr.description}"/></a>
                  </c:when>
                  <c:when test="${settingDescr.type.name == 'LABEL_PATTERN'}">
                  <a href="<c:url value='${buildConfigSteps[5].url}'/>"><c:out value="${settingDescr.description}"/>a>
                    </c:when>
                    <c:when test="${settingDescr.type.name == 'BUILD_FEATURE'}">
                    <a href="<c:url value='${buildConfigSteps[5].url}'/>"><c:out value="${settingDescr.description}"/></a>
                    </c:when>
                    <c:when test="${settingDescr.type.name == 'BUILD_STEP'}">
                      <c:set var="stepName" value="${settingDescr.additionalData.name}"/>
                      <c:set var="stepType" value="${settingDescr.additionalData.runType.displayName}"/>
                      <c:url value='/admin/editRunType.html?init=1&id=${buildForm.settingsId}&runnerId=${settingDescr.additionalData.id}&cameFromUrl=${pageUrl}' var="stepUrl"/>
                    <a href="${stepUrl}"><c:out value="${settingDescr.description}"/></a>
                    </c:when>
                    <c:when test="${settingDescr.type.name == 'BUILD_FAILURE_CONDITION'}">
                    <a href="<c:url value='${buildConfigSteps[4].url}'/>"><c:out value="${settingDescr.description}"/></a>
                    </c:when>
                    <c:when test="${settingDescr.type.name == 'ARTIFACT_DEPENDENCY'}">
                    <a href="<c:url value='${buildConfigSteps[6].url}'/>"><c:out value="${settingDescr.description}"/></a>
                    </c:when>
                    <c:when test="${settingDescr.type.name == 'PARAMETER'}">
                    <a href="<c:url value='${buildConfigSteps[7].url}'/>#${settingDescr.additionalData}"><c:out value="${settingDescr.description}"/></a>
                    </c:when>
                      <c:otherwise><c:out value="${settingDescr.description}"/></c:otherwise>
                    </c:choose>
                </td>
                <c:set var="paramName" value="${e.key}"/>
                <c:set var="paramId" value='<%=ParameterInfo.makeParameterId((String)jspContext.getAttribute("paramName"))%>'/>
                <td class="edit"><a href="<c:url value='${buildConfigSteps[7].url}'/>#edit_${paramId}">define</a></td>
              </tr>
            </c:forEach>
          </l:tableWithHighlighting>
        </div>
      </div>
    </c:if>

    <div class="section">
      <h2 class="noBorder">Agents Compatibility</h2>
      <bs:smallNote>In this section you can see which agents are compatible with the requirements and which are not.</bs:smallNote>

      <bs:buildTypeCompatibility compatibleAgents="${buildForm.settings}" project="${buildForm.project}"/>
    </div>

    <!--here go two popup dialogs-->
    <c:url value="/admin/editRequirements.html?id=${buildForm.settingsId}" var="editRequirementAction"/>
    <bs:modalDialog formId="editRequirement"
                    title="Edit Requirement"
                    action="${editRequirementAction}"
                    closeCommand="BS.EditRequirementDialog.cancelDialog()"
                    saveCommand="BS.RequirementsForm.saveRequirement()">

      <c:url var="autocompletionUrl" value="/agentParametersAutocompletion.html"/>
      <div class="error" id="errorSimilarRequirementExists" style="margin-left: 0;"></div>
      <label class="editRequirementLabel" for="parameterName">Parameter Name:&nbsp;<l:star/></label>
      <forms:autocompletionTextField name="parameterName" value="" style="width:25em;" maxlength="1024" id="parameterName"
                                     autocompletionSource="BS.EditRequirementDialog.createFindNameFunction('${autocompletionUrl}')"
                                     autocompletionSearchAction="BS.EditRequirementDialog.showLoadingImage('#parameterName')"/>
      <span class="error" id="error_parameterName" style="margin-left: 10.5em;"></span>
      <div class="clr"></div>

      <div class="smallNote" id="inheritedParamName" style="display: none;">Name and type of the inherited parameter cannot be changed.</div>
      <div class="clr spacing"></div>

      <label class="editRequirementLabel" for="requirementType">Condition:</label>
      <forms:select id="requirementType" name="requirementType" onchange="BS.EditRequirementDialog.requirementChanged(this)" style="width: 15em;" enableFilter="true">
        <c:forEach items="${requirementsBean.availableRequirementTypes}" var="reqType">
          <forms:option value="${reqType.name}"><c:out value="${reqType.displayName}"/></forms:option>
        </c:forEach>
      </forms:select>
      <div class="clr spacing"></div>

      <div style="margin-bottom: 0.5em;" id="editParameterValue">
        <label class="editRequirementLabel" for="parameterValue">Value:</label>
        <forms:autocompletionTextField name="parameterValue" value="" style="width:25em;" maxlength="1024" id="parameterValue"
                                       autocompletionSource="BS.EditRequirementDialog.createFindValueFunction('${autocompletionUrl}')"
                                       autocompletionSearchAction="BS.EditRequirementDialog.showLoadingImage('#parameterValue')"
                                       autocompletionShowOnFocus="true"
                                       autocompletionShowEmpty="false"/>
        <div class="error" id="error_parameterValue" style="margin-left: 10.5em;"></div>
      </div>

      <div class="popupSaveButtonsBlock">
        <forms:submit label="Save"/>
        <forms:cancel onclick="BS.EditRequirementDialog.cancelDialog()"/>
        <forms:saving/>
      </div>

      <input type="hidden" id="requirementId" name="requirementId" value=""/>
      <input type="hidden" id="currentName" name="currentName" value=""/>
      <input type="hidden" id="submitAction" name="submitAction" value=""/>
      <input type="hidden" id="submitBuildType" name="submitBuildType" value="1"/>
    </bs:modalDialog>

    <script type="text/javascript">
      BS.EditRequirementDialog.setParameterValueRequired({
      <c:forEach items="${requirementsBean.availableRequirementTypes}" var="reqType" varStatus="pos">'${reqType.name}': ${reqType.parameterRequired}${pos.last ? '' : ', '}</c:forEach>
      });
      (function($) {
        $(document).ready(function() {
          $('#requirementType').bind('keyup', function() {
            BS.EditRequirementDialog.requirementChanged($(this));
          });
          var parsedHash = BS.Util.paramsFromHash('&');
          var name = parsedHash['addRequirement'];
          var val = parsedHash['value'];
          var reqType = parsedHash['type'];
          if (name && val && reqType) {
            BS.Util.setParamsInHash({}, '&', true);
            BS.EditRequirementDialog.showDialog(name, val, reqType)
          }
        });
      }(jQuery));

    </script>
  </jsp:attribute>
</admin:editBuildTypePage>
