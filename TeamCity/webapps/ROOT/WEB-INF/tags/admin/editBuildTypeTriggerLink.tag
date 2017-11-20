<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="buildType" required="true" type="jetbrains.buildServer.serverSide.SBuildType" %>
<%@ attribute name="triggerId" required="true" %>
<%@ attribute name="withoutLink" type="java.lang.Boolean" %>

<c:url var="url" value="/admin/editTriggers.html?init=1&id=buildType:${buildType.externalId}#editTrigger=${triggerId}"/>

<c:choose>
  <c:when test="${withoutLink}">
    ${url}
  </c:when>
  <c:otherwise>
    <a href="${url}"><jsp:doBody/></a>
  </c:otherwise>
</c:choose>
