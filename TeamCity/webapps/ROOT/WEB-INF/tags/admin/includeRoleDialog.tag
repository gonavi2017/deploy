<%@ attribute name="rolesForm" type="jetbrains.buildServer.controllers.admin.roles.EditRolesForm" required="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="afn" uri="/WEB-INF/functions/authz"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz"
  %><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
  %>

<c:url var="action" value="/admin/action.html"/>
<bs:modalDialog formId="includeRole" title="Include Role" action="${action}"
                closeCommand="BS.IncludeRoleDialog.close();" saveCommand="BS.IncludeRoleDialog.save();">
  <script type="text/javascript">
     window.rolesWithIncluded = {};
     <c:forEach items="${rolesForm.roles}" var="role">
        var rolesList = [];
        <c:forEach items="${role.availableRoles}" var="includedRole">
            rolesList.push({
                id: '${includedRole.id}',
                name: '<bs:escapeForJs text="${includedRole.name}"/>'
            });
        </c:forEach>
        rolesWithIncluded['${role.id}'] = {
          availableRoles: rolesList
        };
     </c:forEach>

      function fillRolesList(roleId) {
          var selector = $('rolesToInclude');
          while (selector.options.length > 0) {
              selector.options[0] = null;
          }

          var availableRoles = rolesWithIncluded[roleId].availableRoles;
          for (var i = 0; i < availableRoles.length; i++) {
              selector.options[i] = new Option(availableRoles[i].name, availableRoles[i].id, false, false);
          }
      }

      BS.IncludeRoleDialog.fillRolesList = fillRolesList;
  </script>
  Select role:
  <br>
  <select name="rolesToInclude" id="rolesToInclude" style="width: 99%" size="7">
  </select>
  <div class="popupSaveButtonsBlock">
    <forms:submit name="includeRole" label="Include"/>
    <forms:cancel onclick="BS.IncludeRoleDialog.close()"/>
    <forms:saving id="includingRoles"/>
  </div>
</bs:modalDialog>
