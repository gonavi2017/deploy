<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ attribute name="user" type="jetbrains.buildServer.users.User" required="true"
%><c:if test="${user != null}"> by <strong><c:out value="${user.descriptiveName}"/></strong></c:if>