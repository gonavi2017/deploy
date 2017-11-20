<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ attribute name="user" type="jetbrains.buildServer.users.SUser" required="true"
%><c:set var="title">Click to open &quot;<c:out value="${user.descriptiveName}"/>&quot; user details</c:set
><c:set var="agentUrl"><c:url value="/admin/editUser.html?userId=${user.id}"/></c:set
><a href="${agentUrl}" title="${title}"><jsp:doBody/></a>