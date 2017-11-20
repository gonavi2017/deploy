<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %><%@
    taglib prefix="afn" uri="/WEB-INF/functions/authz" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %><%@
    taglib prefix="l" tagdir="/WEB-INF/tags/layout" %><%@
    attribute name="sourceTemplate" required="true" type="jetbrains.buildServer.serverSide.BuildTypeTemplate" %><%@
    attribute name="projectList" required="true" type="java.util.List" %><%@attribute name="usagesExist" required="true" type="java.lang.Boolean"%>
<c:url value='/admin/moveTemplate.html' var="moveAction"/>
<bs:modalDialog formId="moveTemplateForm"
                title="Move Build Configuration Template"
                action="${moveAction}"
                closeCommand="BS.MoveTemplateForm.cancelDialog()"
                saveCommand="BS.MoveTemplateForm.submitMove()">

  <c:choose>
    <c:when test="${not projectList.isEmpty()}">
      <table>
        <tr>
          <td><label for="moveTemplateToProjectId">Move to project:</label></td>
          <td><forms:select id="moveTemplateToProjectId" name="projectId" className="longField" enableFilter="true">
            <forms:option value="">-- Choose a project --</forms:option>
            <c:forEach items="${projectList}" var="p">
              <forms:option value="${p.externalId}"><c:out value="${p.fullName}"/></forms:option>
            </c:forEach>
          </forms:select></td>
        </tr>
        <c:if test="${usagesExist}">
          <tr><td colspan="2"><span class="grayNote">
              The list of possible destinations is limited by those projects that contain, directly or indirectly, all build types derived from this template.
            </span></td></tr>
        </c:if>
      </table>
      <span class="error" id="error_moveTemplateForm_projectId"></span>
      <script type="text/javascript">
        $('moveTemplateToProjectId').onchange = function() {
          var selectedIdx = this.selectedIndex;
          var moveImpossibleEl = $('moveTemplateImpossible');
          if (selectedIdx < 1) {
            moveImpossibleEl.hide();
            $('moveTemplateButton').disable();
            return;
          }

          var id = this.options[selectedIdx].value;

          $('moveTemplateButton').disable();
          BS.MoveBuildTypeForm.checkCanMove(id, 'templateId=' + '${sourceTemplate.externalId}', 'Template', function(msg) {
            if (msg != null) {
              moveImpossibleEl.show();
              moveImpossibleEl.innerHTML = msg;
            } else {
              moveImpossibleEl.hide();
              moveImpossibleEl.innerHTML = '';
              $('moveTemplateButton').enable();
            }
          });
        }
      </script>
    </c:when>
    <c:otherwise>
      <div>
        This template cannot be moved to any other project<c:if test="${usagesExist}"> without breaking references in the build types derived from it</c:if>.
      </div>
    </c:otherwise>
  </c:choose>

  <div id="moveTemplateImpossible" style="display: none; margin-top: 0.5em;"></div>

  <c:if test="${not projectList.isEmpty()}">
    <div class="popupSaveButtonsBlock">
      <forms:submit name="moveTemplate" id="moveTemplateButton" label="Move"/>
      <forms:cancel onclick="BS.MoveTemplateForm.cancelDialog()" showdiscardchangesmessage="false"/>
      <forms:saving id="moveTemplateProgress"/>
    </div>
  </c:if>

  <input type="hidden" name="templateId" id="templateId" value="${sourceTemplate.externalId}"/>
  <input type="hidden" name="sourceProjectId" id="sourceProjectId" value="${sourceTemplate.project.externalId}"/>
</bs:modalDialog>
