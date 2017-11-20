<%@ tag import="jetbrains.buildServer.web.openapi.PlaceId" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="afn" uri="/WEB-INF/functions/authz"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="ext" tagdir="/WEB-INF/tags/ext"
  %><%@attribute name="runnerBean" type="jetbrains.buildServer.controllers.admin.projects.BuildRunnerBean" required="true" %>

<c:set scope="request" var="propertiesBean" value="${runnerBean.propertiesBean}"/>
<c:set var="runType" value="${runnerBean.runType}"/>

<c:set value="${runnerBean.runTypeWithExtensions}" var="runType"/>
<c:choose>
  <c:when test="${not empty runType.viewRunnerParamsJspFilePath}">
    <c:choose>
      <c:when test="${fn:startsWith(runType.viewRunnerParamsJspFilePath, '/')}">
        <jsp:include page="${runType.viewRunnerParamsJspFilePath}"/>
      </c:when>
      <c:otherwise>
        <c:set var="url" value="/plugins/${runType.runType.type}/${runType.viewRunnerParamsJspFilePath}"/>
        <jsp:include page="${url}"/>
      </c:otherwise>
    </c:choose>
  </c:when>
  <c:otherwise>
    <jsp:include page="/notImplemented.jsp"/>
  </c:otherwise>
</c:choose>

<c:forEach items="${runType.availableExtensions}" var="ext">
  <c:if test="${not empty ext.viewRunnerParamsJspFilePath}">
    <jsp:include page="${ext.viewRunnerParamsJspFilePath}"/>
  </c:if>
</c:forEach>

<ext:includeExtensions placeId="<%=PlaceId.VIEW_BUILD_RUNNER_SETTINGS_FRAGMENT%>"/>
