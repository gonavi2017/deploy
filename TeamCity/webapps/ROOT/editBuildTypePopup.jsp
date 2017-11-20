<%@ page import="jetbrains.buildServer.serverSide.SBuildServer" %>
<%@ page import="jetbrains.buildServer.serverSide.SBuildType" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin"
  %><%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%
  SBuildServer server = (SBuildServer) request.getAttribute("serverTC");
  SBuildType buildType = server.getProjectManager().findBuildTypeByExternalId(request.getParameter("buildTypeId"));
  pageContext.setAttribute("buildType", buildType);
%>
<%--@elvariable id="buildType" type="jetbrains.buildServer.serverSide.SBuildType"--%>
<admin:editBuildTypeNavSteps settings="${buildType}"/>
  <ul class="menuList">
    <c:forEach var="confStep" items="${buildConfigSteps}">
      <c:set var="url"><admin:editBuildTypeLink cameFromUrl="${param['cameFromUrl']}" step="${confStep.stepId}" withoutLink="true"
                                                buildTypeId="${buildType.externalId}"/></c:set>
      <l:li title="Edit build configuration"><a href="${url}">${confStep.title}</a></l:li>
    </c:forEach>
  </ul>
