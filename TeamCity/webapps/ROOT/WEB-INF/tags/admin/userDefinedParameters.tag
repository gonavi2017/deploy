<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin"%>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"%>
<%@ taglib prefix="ufn" uri="/WEB-INF/functions/user"%>
<%@attribute name="userParametersBean" type="jetbrains.buildServer.controllers.buildType.ParametersBean" required="true" %>
<%@attribute name="parametersActionUrl" type="java.lang.String" required="true" %>
<%@attribute name="parametersAutocompletionUrl" type="java.lang.String" required="true" %>
<%@attribute name="readOnly" type="java.lang.Boolean" required="false" %>
<%@ attribute name="externalId" required="true" type="java.lang.String"%>

<bs:refreshable containerId="userParams" pageUrl="${pageUrl}">
  <c:if test="${not readOnly}">
  <div>
    <forms:addButton showdiscardchangesmessage="false" onclick="BS.EditParameterDialog.showDialog('', '', 'conf', false, false, false, ''); return false"><c:out value="Add new parameter"/></forms:addButton>
  </div>
  </c:if>

  <c:set var="userPropName" value="sip_${fn:substring(externalId, 0, 75)}"/>
  <c:set var="showInherited" value="${ufn:getPropertyValue(currentUser, userPropName) != 'hide'}"/>
  <c:set var="numInherited" value="${userParametersBean.inheritedParamsNum}"/>
  <div class="showInheritedLink" style="${numInherited == 0 or showInherited ? 'display: none' : ''}">
    <a href="#" onclick="BS.EditParameterForm.toggleInheritedParams(true, 'userParams', '${userPropName}')">Show inherited parameters (${numInherited}) &raquo;</a>
  </div>
  <div class="hideInheritedLink" style="${numInherited == 0 or not showInherited ? 'display: none' : ''}">
    <a href="#" onclick="BS.EditParameterForm.toggleInheritedParams(false, 'userParams', '${userPropName}')">&laquo; Hide inherited parameters (${numInherited})</a>
  </div>

  <div style="margin-top: 1em">
    <h2 class="noBorder">Configuration Parameters</h2>
    <bs:smallNote>
      Configuration parameters are not passed into build, can be used in references only.<bs:help file="Configuring+Build+Parameters" anchor="ConfigurationParameters"/>
    </bs:smallNote>
    <admin:editableParametersList params="${userParametersBean.configurationParameters}" paramType="conf" readOnly="${readOnly}" externalId="${externalId}"/>
  </div>

  <div class="section">
    <h2 class="noBorder">System Properties (system.)</h2>
    <bs:smallNote>
      System properties will be passed into the build (without system. prefix), they are only supported by the build runners that understand the property notion.
      <bs:help file="Configuring+Build+Parameters" anchor="BuildParameters"/>
    </bs:smallNote>
    <admin:editableParametersList params="${userParametersBean.systemProperties}" paramType="system" readOnly="${readOnly}" externalId="${externalId}"/>
  </div>

  <div class="section">
    <h2 class="noBorder">Environment Variables (env.)</h2>
    <bs:smallNote>
      Environment variables will be added to the environment of the processes launched by the build runner (without env. prefix).
      <bs:help file="Configuring+Build+Parameters" anchor="BuildParameters"/>
    </bs:smallNote>
    <admin:editableParametersList params="${userParametersBean.environmentVariables}" paramType="env" readOnly="${readOnly}" externalId="${externalId}"/>
  </div>

  <c:if test="${not empty userParametersBean.dependencyParameters}">
  <div class="section">
    <h2 class="noBorder">Dependency parameters redefined</h2>
    <bs:smallNote>
      It is a bad practice to use custom parameter names with dep. prefix as such prefix is used to refer to parameters in snapshot dependencies.
    </bs:smallNote>
    <admin:editableParametersList params="${userParametersBean.dependencyParameters}" paramType="dependency" readOnly="${readOnly}" externalId="${externalId}"/>
  </div>
  </c:if>

  <script type="text/javascript">
    <c:if test="${not showInherited}">
    BS.EditParameterForm.toggleInheritedParams(false, 'userParams', '${userPropName}');
    </c:if>
  </script>
</bs:refreshable>

<bs:modalDialog formId="editParamForm"
                title="Parameters"
                action="${parametersActionUrl}"
                closeCommand="BS.EditParameterDialog.cancelDialog()"
                saveCommand="BS.EditParameterForm.saveParameter()">
  <table class="runnerFormTable">
    <tr>
      <th>
        <label class="editParameterLabel" for="parameterName">Name: <l:star/></label>
      </th>
      <td>
        <forms:textField name="parameterName" value="" style="width:100%;" maxlength="512" noAutoComplete="true"/>
        <span class="error" id="error_parameterName"></span>
        <span class="smallNote" id="inheritedParamName" style="display: none; margin-left: 0;">Name of the inherited parameter cannot be changed</span>
      </td>
    </tr>
    <tr>
      <th>
        <label class="editParameterLabel" for="paramType">Kind: </label>
      </th>
      <td>
        <forms:select name="paramType" enableFilter="true" style="width:100%">
          <option value="conf">Configuration parameter</option>
          <option value="system">System property (system.)</option>
          <option value="env">Environment variable (env.)</option>
        </forms:select>
      </td>
    </tr>
    <tr>
      <th>
        <label class="editParameterLabel" for="parameterValue">Value:</label>
      </th>
      <td>
        <div class="completionIconWrapper">
          <forms:textField expandable="true" name="parameterValue" style="width: 100%;" className="buildTypeParams"/>
        </div>
        <span class="error" id="error_parameterValue"></span>
        <span class="smallNote">Type '%' for reference completion</span>
      </td>
    </tr>
    <tr>
      <th>
        <label class="editParameterLabel" for="parameterSpec">Spec:</label>
      </th>
      <td>
        <div style="margin-bottom: 5px">
          <forms:saving id="parameterSpecEditFormContentLoading" className="progressRingInline"/>
          <input id="editParameterSpec" class="btn btn_mini" type="button"
                 onclick="return BS.EditParametersSpecDialog.showDialog($('parameterSpec').value);" value="Edit..."/>
        </div>
        <div id="parameterSpecHolderEdit">
          <forms:textField expandable="true" name="parameterSpec" style="width:100%;" className="buildTypeParams" noAutoComplete="${true}"/>

          <div class="clr spacing"></div>
          <span class="error" id="error_parameterSpec"></span>
          <span class="smallNote">
            Defines parameter control presentation and validation. Parameter specification format is <em>typeName[ key='value'[ key2='value2']]</em>, ServiceMessage syntax is used.
          </span>
        </div>

        <div id="parameterSpecHolderExpand">
          <a href="#" style="vertical-align: middle;" onclick="return BS.EditParameterDialog.showSpecEditFields(true, true);">Show raw value</a>
          <span class="smallNote">
            Defines parameter control presentation and validation.
          </span>
        </div>
      </td>
    </tr>
  </table>

  <script type="text/javascript">
    (function($) {
      $(document).ready(function() {
        $("#parameterName").on("keyup", BS.EditParameterDialog.createParamNameChangeHandler($("#parameterName"), $("#paramType")));

        $("#paramType")
            .on("change", BS.EditParameterDialog.createParamTypeChangeHandler($("#paramType"), $("#parameterName")))
            .on("keyup", function(event) {
               if (BS.EditParameterDialog.canChangeSelectValue(event)) {
                 BS.EditParameterDialog.paramTypeChangedHandler();
               }
             });
      });
    }(jQuery));
  </script>

  <c:if test="${not readOnly}">
  <div class="popupSaveButtonsBlock">
    <forms:submit label="Save"/>
    <forms:cancel showdiscardchangesmessage="false" onclick="BS.EditParameterDialog.cancelDialog()"/>
    <forms:saving id='userParamsSaving'/>
  </div>
  </c:if>

  <input type="hidden" id="currentNameWithPrefix" name="currentNameWithPrefix" value=""/>
  <input type="hidden" id="currentName" name="currentName" value=""/>
  <input type="hidden" id="submitAction" name="submitAction" value=""/>
  <input type="hidden" id="submitBuildType1" name="submitBuildType" value="1"/>
</bs:modalDialog>

<jsp:useBean id="parametersCongig" class="jetbrains.buildServer.controllers.parameters.ParameterConstants"/>
<c:url var="parametersEditFormUrl" value="${parametersCongig.editTypeParameterUrl}"/>
<bs:modalDialog formId="parameterSpecEditForm"
                title="Edit parameter specification"
                action="${parametersEditFormUrl}"
                closeCommand="BS.EditParametersSpecDialog.closeDialog()"
                saveCommand="BS.EditParametersSpecDialog.submitDialog()">
  <div id="parameterSpecEditFormContent">

  </div>

  <div class="popupSaveButtonsBlock">
    <forms:submit id="parameterSpecEditFormSubmit" label="Save"/>
    <forms:cancel showdiscardchangesmessage="false" onclick="BS.EditParametersSpecDialog.closeDialog()"/>
    <forms:saving id='parameterSpecEditFormSaving'/>
  </div>
</bs:modalDialog>

<script type="text/javascript">
  (function($) {
    var alt = false;
    $(document).keydown(function(event) {
      if (event.keyCode === $.ui.keyCode.ALT) {
        alt = true;
      } else if (alt && event.keyCode === $.ui.keyCode.INSERT) {
        if (!BS.EditParameterDialog.isVisible()) {
          BS.EditParameterDialog.showDialog('', '', 'conf');
          return false;
        }
      }
    }).keyup(function(event) {
      if (event.keyCode === $.ui.keyCode.ALT) {
        alt = false;
      }
    });
  } (jQuery));
</script>
