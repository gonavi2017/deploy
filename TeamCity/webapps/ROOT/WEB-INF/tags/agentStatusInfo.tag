<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ attribute name="trueText" required="true" type="java.lang.String"
  %><%@ attribute name="falseText" required="true" type="java.lang.String"
  %><%@ attribute name="trueCssClass" required="true" type="java.lang.String"
  %><%@ attribute name="falseCssClass" required="true" type="java.lang.String"
  %><%@ attribute name="comment" required="true" type="jetbrains.buildServer.serverSide.comments.Comment"
  %><%@ attribute name="state" required="true" type="java.lang.Boolean"
  %><%@ attribute name="action" required="false" type="java.lang.String" %>

<c:set var="pattern" value="dd MMM yy HH:mm"/>

<c:set var="shortTitle">
<c:choose><c:when test="${state}">${fn:substring(trueText, 0, fn:indexOf(trueText, ' '))}</c:when><c:otherwise>${fn:substring(falseText, 0, fn:indexOf(falseText, ' '))}</c:otherwise></c:choose>
 <bs:_commentInfo comment="${comment}"/>
</c:set>

<c:set var="text">
<c:choose>
  <c:when test="${state}"><span class="agent ${trueCssClass}" title="Click to change status">${trueText}</span></c:when>
  <c:otherwise><span class="agent ${falseCssClass}" title="Click to change status">${falseText}</span></c:otherwise>
</c:choose>
</c:set>
<c:choose>
  <c:when test="${not empty action}">
    <a ${action}>${fn:trim(text)}</a>
  </c:when>
  <c:otherwise>
    ${fn:trim(text)}
  </c:otherwise>
</c:choose>
<c:if test="${not empty comment && not empty comment.comment}">
  <c:set var="title">${shortTitle}<bs:_commentText comment="${comment}" forTooltip="true"/></c:set>
  <bs:commentIcon text="${title}"/>
</c:if>
