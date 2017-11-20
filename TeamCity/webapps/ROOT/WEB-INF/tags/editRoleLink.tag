<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@attribute name="role" required="true" type="jetbrains.buildServer.serverSide.auth.Role"
%><a href='<c:url value="/admin/admin.html?item=roles#${role.id}"/>'><c:out value="${role.name}"/></a>