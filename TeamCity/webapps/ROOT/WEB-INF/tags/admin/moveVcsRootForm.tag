<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<%@ taglib prefix="afn" uri="/WEB-INF/functions/authz" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ attribute name="availableProjects" required="true" type="java.util.List" %>

<c:url value='/admin/moveVcsRoot.html' var="moveAction"/>
<bs:modalDialog formId="moveVcsRootForm"
                dialogClass="modalDialog_small"
                title="Move VCS Root"
                action="${moveAction}"
                closeCommand="BS.MoveVcsRootForm.cancelDialog()"
                saveCommand="BS.MoveVcsRootForm.submitMove()">

  <label for="moveToProjectId" class="tableLabel" style="float: none; padding-right: 1em;">Move to project:</label>
  <bs:projectsFilter id="moveToProjectId" name="moveToProjectId" style="width: 21em;"
                     defaultOption="true"
                     disableRoot="false"
                     projectBeans="${availableProjects}"/>

  <script type="text/javascript">
    $('moveToProjectId').onchange = function () {
      if (this.selectedIndex <= 0) {
        $('moveVcsRootButton').disable();
      } else {
        $('moveVcsRootButton').enable();
      }
    }
  </script>

  <span class="error" id="error_moveVcsRootForm" style="margin-left: 0;"></span>

  <div class="popupSaveButtonsBlock">
    <forms:submit name="moveBuildType" id="moveVcsRootButton" label="Move"/>
    <forms:cancel onclick="BS.MoveVcsRootForm.cancelDialog()" showdiscardchangesmessage="false"/>
    <forms:saving id="moveVcsRootProgress"/>
  </div>
  <input type="hidden" name="vcsRootId" value=""/>
</bs:modalDialog>
