<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="newVersionBean" type="jetbrains.buildServer.controllers.updates.NewVersionBean" required="true" %>
<%@ attribute name="linkText" type="java.lang.String" required="true" %>
<%@ taglib prefix="afn" uri="/WEB-INF/functions/authz"%>
<a target="_blank" title="Download <c:out value="${newVersionBean.fullDisplayName}"/>"
     href="https://www.jetbrains.com/teamcity/download/index.html?fromServer">${linkText}</a>
<c:if test="${newVersionBean.activeLicensesThatShouldBeRenewedCount != 0}">
  <c:choose>
    <c:when test="${afn:permissionGrantedGlobally('MANAGE_SERVER_LICENSES')}">
      <span class="commentText">(<a href="<c:url value='/admin/admin.html?item=license'/>">Some licenses</a> are not compatible with the new version)</span>
    </c:when>
    <c:otherwise>
      <span class="commentText">(Some licenses are not compatible with the new version)</span>
    </c:otherwise>
  </c:choose>
</c:if>

