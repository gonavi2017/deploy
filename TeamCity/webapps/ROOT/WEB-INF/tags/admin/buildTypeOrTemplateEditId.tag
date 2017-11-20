<%@ tag import="jetbrains.buildServer.controllers.admin.projects.EditBuildTypeFormFactory" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="buildType" required="false" type="jetbrains.buildServer.serverSide.SBuildType" %>
<%@ attribute name="template" required="false" type="jetbrains.buildServer.serverSide.BuildTypeTemplate" %>

<c:choose>
  <c:when test="${buildType != null}">
    <%=EditBuildTypeFormFactory.BT_PREFIX%>${buildType.externalId}
  </c:when>
  <c:when test="${template != null}">
    <%=EditBuildTypeFormFactory.TEMPLATE_PREFIX%>${template.externalId}
  </c:when>
</c:choose>
