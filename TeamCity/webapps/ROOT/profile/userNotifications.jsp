<%@ include file="/include-internal.jsp" %>
<%@ taglib prefix="profile" tagdir="/WEB-INF/tags/userProfile" %>
<jsp:useBean id="profileForm" type="jetbrains.buildServer.controllers.profile.ProfileForm" scope="request"/>

<c:set var="notifiersBean" value="${profileForm.notifiersBean}"/>
<c:set var="selectedNotifier" value="${param['notificatorType']}"/>
<c:if test="${empty selectedNotifier}">
  <c:set var="selectedNotifier"><%=profileForm.getNotifiersBean().getAvailableNotifiers().get(0).getNotificatorType()%></c:set>
</c:if>

<c:url value='/profile.html' var="url">
  <c:param name="userId" value="${profileForm.editee.id}"/>
  <c:param name="tab" value="userNotifications"/>
  <c:param name="init" value="1"/>
</c:url>
<n:availableNotifiers urlPattern="${url}&notificatorType=##notifierType##" selectedNotifier="${selectedNotifier}" availableNotifiersBean="${notifiersBean}"/>

<jsp:include page="/notifierSettings.html?userId=${profileForm.editee.id}&adminMode=true">
  <jsp:param name="cameFromUrl" value="${pageUrl}"/>
  <jsp:param name="notificatorType" value="${selectedNotifier}"/>
</jsp:include>
