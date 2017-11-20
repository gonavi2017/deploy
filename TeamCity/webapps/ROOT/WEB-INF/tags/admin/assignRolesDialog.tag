<%@attribute name="availableRolesBean" type="jetbrains.buildServer.controllers.user.AvailableRolesBean" required="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="afn" uri="/WEB-INF/functions/authz"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz"
  %><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
  %><%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin"
  %>
<c:if test="${serverSummary.perProjectPermissionsEnabled}">
<c:url var="assignRoleAction" value="/admin/action.html"/>
<bs:modalDialog formId="assignRole"
                title="Assign role"
                action="${assignRoleAction}"
                closeCommand="BS.AssignRoleDialog.close()"
                saveCommand="BS.AssignRoleDialog.save()">
  <bs:help file="Managing+Users+and+User+Groups" anchor="Assigningrolestousers" style="float: right;"/>
  <admin:_assignUnassignRole availableRolesBean="${availableRolesBean}" formId="assignRole" dialogObject="BS.AssignRoleDialog" assignMode="true"/>

  <c:if test="${afn:permissionGrantedGlobally('CHANGE_USER')}">
  <div>
    <forms:checkbox name="replaceRoles"/> <label for="replaceRoles">Replace existing roles with newly selected</label>
  </div>
  </c:if>

  <div class="popupSaveButtonsBlock">
    <forms:submit name="assignRoles" label="Assign"/>
    <forms:cancel onclick="BS.AssignRoleDialog.close()"/>
    <forms:saving id="assignRole_saving"/>
  </div>
</bs:modalDialog>
</c:if>