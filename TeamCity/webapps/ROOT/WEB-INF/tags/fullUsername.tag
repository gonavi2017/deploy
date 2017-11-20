<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    attribute name="user" type="jetbrains.buildServer.users.User" required="true"

%><c:set var="name" value="${user.descriptiveName} (${user.username})"
/><c:if test="${empty user.descriptiveName}"><c:set var="name" value="${user.username}"/></c:if
 ><c:out value="${name}"/>