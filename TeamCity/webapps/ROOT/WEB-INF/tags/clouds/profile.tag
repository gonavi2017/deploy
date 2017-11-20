<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
    %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
    %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
    %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
    %><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
    %><%@ attribute name="profile" type="jetbrains.buildServer.clouds.server.web.beans.CloudTabFormProfileInfo"
    %><%@ attribute name="enabled" type="java.lang.Boolean" required="false"
    %><%@ attribute name="editUrl" type="java.lang.String" required="false"
    %><%@ attribute name="inlineDescription" type="java.lang.Boolean" required="false"
    %><%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin"
    %><%@ taglib prefix="clouds" tagdir="/WEB-INF/tags/clouds"  %>
<c:if test="${not profile.loading and not profile.hasErrors and (empty enabled or enabled)}">
  <span class="profileRunning">
    <strong>${profile.runningInstancesCount}</strong> running
  </span>
</c:if>
<c:choose>
  <c:when test="${editUrl != null}"><a href="${editUrl}"><c:out value="${profile.name}"/></a></c:when>
  <c:otherwise><c:out value="${profile.name}"/></c:otherwise>
</c:choose>
<c:if test="${not profile.profile.enabled}">(disabled)</c:if>
<clouds:cloudProblemsLink controlId="error_${profile.id}" problems="${profile.problems}">Profile Error</clouds:cloudProblemsLink>
<c:if test="${not empty profile.description}">
  <c:choose>
    <c:when test="${inlineDescription}"><span style="font-weight:normal;">(<c:out value="${profile.description}"/>)</span></c:when>
    <c:otherwise><div class="smallNote" style="margin-left: 0;"><c:out value="${profile.description}"/></div></c:otherwise>
  </c:choose>
</c:if>
