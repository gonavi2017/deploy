<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ attribute name="projectId" required="true" description="external project id"
%><%@ attribute name="withoutLink"
%><%@ attribute name="addToUrl"
%><%@ attribute name="onmouseover"
%><%@ attribute name="onmouseout"
%><%@ attribute name="title"
%><%@ attribute name="style"
%><%@ attribute name="classes"
%><c:url var="url" value="/admin/editProject.html?init=1&projectId=${projectId}"/><c:choose><c:when test="${not withoutLink}"><a href="${url}${addToUrl}" <c:if test="${not empty onmouseover}">onmouseover="${onmouseover}"</c:if> <c:if test="${not empty onmouseout}">onmouseout="${onmouseout}"</c:if> <c:if test="${not empty title}">title="${title}"</c:if> <c:if test="${not empty style}">style="${style}"</c:if> <c:if test="${not empty classes}">class="${classes}"</c:if>><jsp:doBody/></a></c:when><c:otherwise>${url}${addToUrl}</c:otherwise></c:choose>