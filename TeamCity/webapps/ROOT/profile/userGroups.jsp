<%@ include file="/include-internal.jsp" %>
<%@ taglib prefix="profile" tagdir="/WEB-INF/tags/userProfile" %>
<jsp:useBean id="profileForm" type="jetbrains.buildServer.controllers.profile.ProfileForm" scope="request"/>

<profile:userGroups user="${profileForm.editee}"/>
