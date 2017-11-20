<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ attribute name="role" required="true" type="jetbrains.buildServer.controllers.profile.RoleBean" %>
<tr>
  <td class="role" valign="top">
    <a name="${role.role.id}"></a><c:out value="${role.role.name}"/>
  </td>
  <td class="permissions" valign="top">
      <ul>
        <c:forEach items="${role.rolePermissions}" var="permission">
          <li><c:out value="${permission.description}"/></li>
        </c:forEach>
      </ul>
  </td>
</tr>