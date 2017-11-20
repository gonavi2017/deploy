<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@attribute name="notifier" required="true" %>
<%@attribute name="user" required="true" type="jetbrains.buildServer.users.User" %>
<%@attribute name="adminMode" required="false" type="java.lang.Boolean" %>
<%@attribute name="cameFromUrl" required="false" %>
<%@attribute name="cameFromTitle" required="false" %>
<c:choose>
  <c:when test="${adminMode}">
    <c:url value='/admin/editUser.html?init=1&notificatorType=${notifier}&userId=${user.id}&tab=userNotifications' var="url">
      <c:param name="cameFromUrl" value="${cameFromUrl}"/>
    </c:url>
  </c:when>
  <c:otherwise>
    <c:url value='/profile.html?init=1&notificatorType=${notifier}&userId=${user.id}&tab=userNotifications' var="url">
      <c:param name="cameFromUrl" value="${cameFromUrl}"/>
    </c:url>
  </c:otherwise>
</c:choose>
<a class="editNotifierSettingsLink" href="${url}"><jsp:doBody/></a>
