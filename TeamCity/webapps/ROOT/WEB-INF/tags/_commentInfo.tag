<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ attribute name="comment" type="jetbrains.buildServer.serverSide.comments.Comment" required="true"
%><bs:_commentUserInfo user="${comment.user}"
/><c:set var="date"
   ><c:if test="${not empty comment.timestamp}">&nbsp;<bs:date value="${comment.timestamp}" smart="true" no_smart_title="true"/></c:if></c:set
 >${date}