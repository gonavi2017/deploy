<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<%@ taglib prefix="afn" uri="/WEB-INF/functions/authz" %>
<%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ attribute name="availableTemplates" required="true" type="java.util.List" %>
<%@ attribute name="buildType" required="true" type="jetbrains.buildServer.serverSide.SBuildType" %>

<c:url value='/admin/action.html' var="actionUrl"/>
<bs:modalDialog formId="useTemplateForm"
                title="Associate with Template"
                action="${actionUrl}"
                closeCommand="BS.AttachDetachTemplateAction.cancelDialog()"
                saveCommand="BS.AttachDetachTemplateAction.submit()">
  <span class="error" id="error_attachFailed" style="margin-left: 0;"></span>
  <br/>

  <table class="runnerFormTable">
    <tr>
      <td class="name"><label for="templateId"><strong>Choose template:</strong></label></td>
      <td class="value">
        <forms:select id="templateId" name="templateId" style="width: 20em;" enableFilter="true"
                onchange="BS.AttachDetachTemplateAction.templateChanged('${buildType.externalId}', this.options[this.selectedIndex].value)">
          <option value="">-- Please choose template --</option>
          <c:set var="curPrj" value=""/>
          <c:forEach items="${availableTemplates}" var="bean">
            <forms:projectOptGroup project="${bean.project}" classes="user-depth-${bean.limitedDepth}">
              <c:forEach var="template" items="${bean.buildTypeTemplates}">
                <forms:option value="${template.externalId}"
                              title="${template.fullName}"
                              className="user-depth-${bean.limitedDepth + 1}">
                  <c:out value="${template.name}"/>
                </forms:option>
              </c:forEach>
            </forms:projectOptGroup>
          </c:forEach>
        </forms:select> <forms:saving id="templateParamsUpdateProgress"/>
      </td>
    </tr>
  </table>

  <div id="templateParameters"></div>

  <div class="popupSaveButtonsBlock">
    <forms:submit name="associateWithTemplate" label="Associate"/>
    <forms:cancel onclick="BS.AttachDetachTemplateAction.cancelDialog()" showdiscardchangesmessage="false"/>
    <forms:saving id="associateWithTemplateProgress"/>
  </div>

  <input type="hidden" name="buildTypeId" value=""/>
  <input type="hidden" name="attachToTemplate" value="1"/>

</bs:modalDialog>
