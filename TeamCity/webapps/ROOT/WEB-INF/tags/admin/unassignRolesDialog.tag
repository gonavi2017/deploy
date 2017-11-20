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
<c:url var="unassignRoleAction" value="/admin/action.html"/>
<bs:modalDialog formId="unassignRole"
                title="Unassign role"
                action="${unassignRoleAction}"
                closeCommand="BS.UnassignRoleDialog.close()"
                saveCommand="BS.UnassignRoleDialog.save()">
  <bs:help file="Managing+Users+and+User+Groups" anchor="Assigningrolestousers" style="float: right;"/>
  <admin:_assignUnassignRole availableRolesBean="${availableRolesBean}" formId="unassignRole" dialogObject="BS.UnassignRoleDialog" assignMode="false"/>

  <div class="popupSaveButtonsBlock">
    <forms:submit name="unassignRolesMultiple" label="Unassign"/>
    <forms:cancel onclick="BS.UnassignRoleDialog.close()"/>
    <forms:saving id="unassignRole_saving"/>
  </div>
</bs:modalDialog>
</c:if>