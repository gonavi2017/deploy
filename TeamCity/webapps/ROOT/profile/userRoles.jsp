<%@ include file="/include-internal.jsp" %>
<%@ taglib prefix="profile" tagdir="/WEB-INF/tags/userProfile" %>
<%@ taglib prefix="roles" tagdir="/WEB-INF/tags/roles" %>
<jsp:useBean id="profileForm" type="jetbrains.buildServer.controllers.profile.EditPersonalProfileForm" scope="request"/>

<roles:authorityRoles authorityRolesBean="${profileForm.userRolesBean}" editable="false" rolesHolderId="${profileForm.editee.id}"/>
