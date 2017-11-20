<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %>
<%@ taglib prefix="afn" uri="/WEB-INF/functions/authz"%>
<%@attribute name="user" type="jetbrains.buildServer.users.SUser" required="true" %>

<c:if test="${adminEditUserForm.canAddToAnyGroup}">
<div style="margin: 0 0 1em">
  <forms:addButton onclick="BS.AttachToGroupsDialog.showAttachUserDialog(${user.id}); return false">Add/remove from groups</forms:addButton>
</div>
</c:if>

<c:set var="groups" value="${user.userGroups}"/>
<c:set var="groupsNum" value="${fn:length(groups)}"/>
<div class="note">
  <strong><c:out value="${user.username}"/></strong>
  <c:choose>
    <c:when test="${groupsNum == 0}">is not assigned to any group.</c:when>
    <c:when test="${groupsNum == 1}">is assigned to <strong>1</strong> group.</c:when>
    <c:when test="${groupsNum > 1}">is assigned to <strong>${groupsNum}</strong> groups.</c:when>
</c:choose>
</div>

<div class="userGroupsContainer">
  <bs:messages key="userAssigned"/>

  <c:if test="${groupsNum > 0}">
  <table class="settings userProfileTable">
    <tr>
      <th>Group name</th>
      <th>Description</th>
    </tr>
  <c:forEach items="${groups}" var="group">
    <tr>
      <td>
        <bs:editGroupLink group="${group}"/>
      </td>
      <td><c:out value="${group.description}"/></td>
    </tr>
  </c:forEach>
  </table>
  </c:if>

</div>

<jsp:include page="/admin/attachToGroups.html"/>
