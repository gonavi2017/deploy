<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    attribute name="users" type="java.util.List" required="true" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><span class="allEmails tc-icon icon16 tc-icon_download_white"  <bs:nl>
<c:if test="${not empty users}">
  <c:set var="result" value="${users[0].email}"/>
  <c:if test="${empty result}"><c:set var="result">N/A</c:set></c:if>
  <c:forEach var="user" items="${users}" begin="1">
    <c:if test="${not empty user.email}"><c:set var="result" value="${result}, ${user.email}"/></c:if>
  </c:forEach>
  <c:set var="allEmails"><c:out value="${result}"/></c:set>
  onmouseover="BS.Tooltip.showMessage(this, {shift: {x: 10, y: 10}, delay: 300}, '${allEmails}')" onmouseout="BS.Tooltip.hidePopup()"
</c:if>
</bs:nl>></span>