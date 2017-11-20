<%@ page import="jetbrains.buildServer.serverSide.SBuildServer" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin"
  %><%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%
  SBuildServer server = (SBuildServer) request.getAttribute("serverTC");
  jetbrains.buildServer.serverSide.BuildTypeTemplate template = server.getProjectManager().findBuildTypeTemplateByExternalId(request.getParameter("templateId"));
  pageContext.setAttribute("template", template);
%>
<%--@elvariable id="buildType" type="jetbrains.buildServer.serverSide.SBuildType"--%>
<admin:editBuildTypeNavSteps settings="${template}"/>
  <ul class="menuList">
    <c:forEach var="confStep" items="${buildConfigSteps}">
      <c:set var="url"><admin:editTemplateLink cameFromUrl="${param['cameFromUrl']}" step="${confStep.stepId}" withoutLink="true"
                              templateId="${template.externalId}"/></c:set>
      <l:li title="Edit build configuration template"><a href="${url}">${confStep.title}</a></l:li>
    </c:forEach>
  </ul>