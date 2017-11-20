<%@ tag import="jetbrains.buildServer.web.util.WebUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ attribute name="comment" required="true" type="jetbrains.buildServer.serverSide.comments.Comment"
%><%@ attribute name="forTooltip" required="true" type="java.lang.Boolean"
%><c:if test="${not empty comment.comment}"><c:choose
    ><c:when test="${forTooltip}"><br/>Comment: </c:when
    ><c:otherwise> with comment: </c:otherwise
    ></c:choose><bs:out value="${comment.comment}"/></c:if>