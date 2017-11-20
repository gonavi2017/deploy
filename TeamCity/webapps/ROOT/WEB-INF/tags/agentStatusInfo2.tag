<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@ attribute name="trueText" required="true" type="java.lang.String"
  %><%@ attribute name="falseText" required="true" type="java.lang.String"
  %><%@ attribute name="trueCssClass" required="true" type="java.lang.String"
  %><%@ attribute name="falseCssClass" required="true" type="java.lang.String"
  %><%@ attribute name="comment" required="true" type="jetbrains.buildServer.serverSide.comments.Comment"
  %><%@ attribute name="state" required="true" type="java.lang.Boolean"%>

<c:set var="pattern" value="dd MMM yy HH:mm"/>

<c:choose>
  <c:when test="${state}"><span class="${trueCssClass}">${trueText}</span></c:when>
  <c:otherwise><span class="${falseCssClass}">${falseText}</span></c:otherwise>
</c:choose>
<c:if test="${not empty comment.user}"> on
  <strong><bs:date value="${comment.timestamp}" pattern="${pattern}"/></strong>
  by <strong><c:out value="${comment.user.descriptiveName}"/></strong></c:if>
<c:if test="${not empty comment.comment}"> with comment: <bs:out value="${comment.comment}"/></c:if>
