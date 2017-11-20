<%@ attribute name="rolesForm" type="jetbrains.buildServer.controllers.admin.roles.EditRolesForm" required="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="afn" uri="/WEB-INF/functions/authz"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz"
  %><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
  %>

<c:url var="action" value="/admin/action.html"/>
<bs:modalDialog formId="addPermissions" title="Add Permissions" action="${action}"
                closeCommand="BS.AddPermissionsDialog.close();" saveCommand="BS.AddPermissionsDialog.save();">
  <script type="text/javascript">
    (function () {
     window.rolesWithPermissions = {};
     <c:forEach items="${rolesForm.roles}" var="role">
        var perms = [];
        <c:forEach items="${role.availablePermissions}" var="permission">
            perms.push({
                name: '${permission.name}',
                description: '<bs:escapeForJs text="${permission.description}"/>'
            });
        </c:forEach>
        rolesWithPermissions['${role.id}'] = {
          availablePermissions: perms
        };
     </c:forEach>

      function fillPermissionsList(roleId) {
          var selector = $('permissionId');
          while (selector.firstChild) {
              selector.firstChild.remove();
          }

          var availablePermissions = rolesWithPermissions[roleId].availablePermissions;
          for (var i = 0; i < availablePermissions.length; i++) {
              var option = new Option(availablePermissions[i].description, availablePermissions[i].name, false, false);
              option.className = "inplaceFiltered";
              selector.options[i] = option;
          }
          BS.expandMultiSelect($j('#permissionId'));
      }

      BS.AddPermissionsDialog.fillPermissionsList = fillPermissionsList;
    })();
  </script>
  Select permissions:
  <br>
  <bs:inplaceFilter containerId="permissionId" activate="false" filterText="&lt;filter permissions&gt;" afterApplyFunc="function(){BS.expandMultiSelect($j('#permissionId'))}"/>
  <forms:selectMultipleHScroll name="permissionId"/>

  <div class="popupSaveButtonsBlock">
    <forms:submit name="addRolePermissions" label="Add"/>
    <forms:cancel onclick="BS.AddPermissionsDialog.close()"/>
    <forms:saving id="addingPermissions"/>
  </div>
</bs:modalDialog>
