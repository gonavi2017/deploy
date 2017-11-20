<%@ tag import="jetbrains.buildServer.web.util.WebUtil"
    %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
    %><%@ taglib prefix="afn" uri="/WEB-INF/functions/authz"
    %><%@attribute name="user" type="jetbrains.buildServer.users.User" required="true"
    %><%@attribute name="tab" required="false"
    %><%@attribute name="cameFromUrl" required="false"
    %><%@attribute name="cameFromTitle" required="false"
    %><%@attribute name="noLink" required="false"
    %><c:set var="tabParam" value=""
    /><c:if test="${not empty tab}"><c:set var="tabParam">&tab=${tab}</c:set></c:if
    ><c:set var="cameFromParam" value=""
    /><c:if test="${not empty cameFromUrl}"><c:set var="cameFromParam">&cameFromUrl=<%=WebUtil.encode(cameFromUrl)%></c:set></c:if
    ><c:set var="cameFromTitleParam" value=""
    /><c:if test="${not empty cameFromTitle}"><c:set var="cameFromTitleParam">&cameFromTitle=<%=WebUtil.encode(cameFromTitle)%></c:set></c:if
    ><c:url value='/admin/editUser.html?init=1&userId=${user.id}${tabParam}${cameFromParam}${cameFromTitleParam}' var="editUrl"
    /><c:set var="content"><jsp:doBody/></c:set
    ><c:if test="${empty content}"><c:set var="content"><c:out value="${user.username}"/></c:set></c:if
    ><c:choose
    ><c:when test="${noLink}">${editUrl}</c:when
    ><c:otherwise
    ><a href="${editUrl}">${content}</a
    ></c:otherwise
    ></c:choose>