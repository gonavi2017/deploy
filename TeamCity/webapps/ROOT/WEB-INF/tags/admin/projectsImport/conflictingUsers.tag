<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ attribute name="conflictingUsers" required="true" type="java.util.Collection" %>

<table class="dark conflictingUsersTable">
  <tr>
    <th>Username</th>
    <th>User from the backup file</th>
    <th>User from this TeamCity server</th>
  </tr>
</table>
<div class="conflictsList">
  <table class="dark conflictingUsersTable borderBottom">
    <c:forEach items="${conflictingUsers}" var="conflictingUser">
      <%--@elvariable id="conflictingUser" type="jetbrains.buildServer.serverSide.projectsImport.conflicts.ConflictingUsersCalculator.ConflictingUser"--%>

      <tr>
        <td><c:out value="${conflictingUser.username}"/></td>
        <td>
          Email: <bs:defaultIfEmpty><c:out value="${conflictingUser.importedUser.email}"/></bs:defaultIfEmpty> <br/>
          Name: <bs:defaultIfEmpty><c:out value="${conflictingUser.importedUser.name}"/></bs:defaultIfEmpty> <br/>
          Last login: <bs:defaultIfEmpty><bs:date smart="true" value="${conflictingUser.importedUser.lastLoginTimestamp}"/></bs:defaultIfEmpty>
        </td>
        <td>
          Email: <bs:defaultIfEmpty><c:out value="${conflictingUser.existingUser.email}"/></bs:defaultIfEmpty> <br/>
          Name: <bs:defaultIfEmpty><c:out value="${conflictingUser.existingUser.name}"/></bs:defaultIfEmpty><br/>
          Last login: <bs:defaultIfEmpty><bs:date smart="true" value="${conflictingUser.existingUser.lastLoginTimestamp}"/></bs:defaultIfEmpty>
        </td>
      </tr>
    </c:forEach>
  </table>
</div>