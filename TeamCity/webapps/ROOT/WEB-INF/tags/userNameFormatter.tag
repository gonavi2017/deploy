<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ attribute name="user" rtexprvalue="true" required="true" type="jetbrains.buildServer.users.User"%>
<%@ attribute name="showName" rtexprvalue="true" required="true" type="java.lang.Boolean"%>
<%@ attribute name="showUsername" rtexprvalue="true" required="true" type="java.lang.Boolean"%>
<c:choose>
  <c:when test="${showUsername and not showName}">
    <c:out value="${user.username}"/>
  </c:when>
  <c:when test="${showName and fn:length(user.name) == 0}">
    <c:out value="${user.username}"/>
  </c:when>
  <c:when test="${showName and not showUsername}">
    <c:out value="${user.name}"/>
  </c:when>
  <c:when test="${showName and showUsername}">
    <c:out value="${user.name}"/> (<c:out value="${user.username}"/>)
  </c:when>
</c:choose>
