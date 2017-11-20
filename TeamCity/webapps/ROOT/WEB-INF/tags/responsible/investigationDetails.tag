<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@
    attribute name="entry" type="jetbrains.buildServer.responsibility.ResponsibilityEntry" required="true"  %>
<span class="investigationDetails">
  <c:set var="selfAssign" value="${entry.reporterUser == entry.responsibleUser}"/>
<c:choose>
  <c:when test="${entry.state.active}">
    ${selfAssign ? "Self-assigned" : "Assigned"}
  </c:when>
  <c:when test="${entry.state.fixed}">Fixed</c:when>
  <c:when test="${entry.state.givenUp}">Given up</c:when>
</c:choose>

<c:if test="${currentUser != entry.responsibleUser}">
  ${entry.state.active && !selfAssign ? "to" : "by"} <b><c:out value="${entry.responsibleUser.descriptiveName}"/></b>
</c:if>

<c:if test="${not empty entry.reporterUser and entry.state.active and not selfAssign}">
  by <b><c:out value="${entry.reporterUser.descriptiveName}"/></b>
</c:if>
<bs:elapsedTime time="${entry.timestamp}"/><c:if test="${not empty entry.comment}">:
  <em><bs:out value="${entry.comment}"/></em>
</c:if>
</span>