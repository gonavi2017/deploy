<%@attribute name="authorityRolesBean" type="jetbrains.buildServer.controllers.profile.AuthorityRolesBean" required="true" %>
<%@attribute name="availableRolesBean" type="jetbrains.buildServer.controllers.user.AvailableRolesBean" required="false" %>
<%@attribute name="editable" type="java.lang.Boolean" required="true" %>
<%@attribute name="rolesHolderId" required="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin"
  %><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
  %><%@ taglib prefix="roles" tagdir="/WEB-INF/tags/roles"
  %>
<c:if test="${serverSummary.perProjectPermissionsEnabled}">
<c:url var="assignRoleAction" value="/admin/action.html"/>
<c:set var="hasRoles" value="${not empty authorityRolesBean.roles}"/>

<bs:refreshable containerId="authorityRolesContainer" pageUrl="${pageUrl}">
<bs:messages key="userRolesUpdated" style="width:80%;"/>

<div id="editGroup">
  <c:if test="${editable}">
    <forms:addButton additionalClasses="assignRoleBtn" onclick="$j(function() {BS.AssignRoleDialog.show(['${rolesHolderId}'], function() { $('authorityRolesContainer').refresh(); } );}); return false">Assign role</forms:addButton>
  </c:if>
<form id="unassignRolesForm" action="${assignRoleAction}" onsubmit="return BS.UnassignRolesForm.submit()">
<c:set var="rolesList" value="${authorityRolesBean.roles}"/>
<div class="groupHeader">
  <div class="note">
    <c:if test="${not hasRoles}">
      <p class="noteText">There are no directly assigned roles.</p>
    </c:if>
    <c:if test="${hasRoles}">
        <p class="noteText"><strong>${fn:length(rolesList)}</strong> role<bs:s val="${fn:length(rolesList)}"/> assigned directly.</p>
        <roles:rolesPopup rolesList="${rolesList}"/>
    </c:if>
  </div>
  <c:if test="${editable}">
    <c:if test="${authorityRolesBean.modifiableRolesAvailable}">
      <div class="saveButtonsBlock saveButtonsBlockRight">
        <forms:saving id="unassignInProgress" className="progressRingInline"/>
        <input class="btn" type="submit" name="unassignRolesSingle" value="Unassign"/>
        <input type="hidden" name="rolesHolderId" value="${rolesHolderId}"/>
      </div>
    </c:if>
  </c:if>
</div>
<c:if test="${hasRoles}">
  <div class="clr"></div>
  <roles:rolesTable rolesList="${rolesList}" editable="${editable}" modifiableRolesAvailable="${authorityRolesBean.modifiableRolesAvailable}"/>
</c:if>
</form>

<c:if test="${editable and not empty availableRolesBean.availableRoles}">
<c:if test="${not authorityRolesBean.modifiableRolesAvailable}">
<div class="clr"></div>
</c:if>

<admin:assignRolesDialog availableRolesBean="${availableRolesBean}"/>
</c:if>

<c:set var="inheritedRolesMap" value="${authorityRolesBean.inheritedRoles}"/>
<c:if test="${not empty inheritedRolesMap}">
<c:set var="groups" value="<%=authorityRolesBean.getInheritedRoles().keySet()%>"/>
<c:forEach items="${groups}" var="group">
  <c:set var="rolesList" value="${inheritedRolesMap[group]}"></c:set>
  <div class="groupHeader">
    <div class="note">
      <p class="noteText">
        <strong>${fn:length(rolesList)}</strong> role<bs:s val="${fn:length(rolesList)}"/>
        inherited from the group <bs:editGroupLink group="${group}"><strong><c:out value="${group.name}"/></strong></bs:editGroupLink><c:if test="${not empty group.description}"> (<c:out value="${group.description}"/>)</c:if>.
      </p>
      <roles:rolesPopup rolesList="${rolesList}"/>
    </div>
  </div>
  <div class="clr"></div>
  <roles:rolesTable rolesList="${rolesList}" editable="${false}" modifiableRolesAvailable="${false}"/>
</c:forEach>
</c:if>
</div>

</bs:refreshable>
</c:if>