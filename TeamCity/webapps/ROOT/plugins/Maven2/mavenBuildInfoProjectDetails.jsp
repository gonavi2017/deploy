<%@ page import="jetbrains.buildServer.maven.buildInfo.Project" %>
<%@ page import="jetbrains.buildServer.maven.web.MavenWebUtil" %>
<%@ page import="org.jetbrains.maven.model.Dependency" %>
<%@ page import="org.jetbrains.maven.model.MavenGAV" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@include file="/include-internal.jsp"%>

<%--@elvariable id="mavenBuildInfo" type="jetbrains.buildServer.maven.buildInfo.MavenBuildInfo"--%>
<%--@elvariable id="build" type="jetbrains.buildServer.serverSide.SBuild"--%>
<%--@elvariable id="mavenProject" type="jetbrains.buildServer.maven.buildInfo.Project"--%>

<div id="maven-projects-header">
  Maven Projects: <c:if test="${not empty mavenProject}"><span>${mavenProject.name}</span></c:if>
</div>

<table id="maven-projects">
  <tr>
    <td class="left-pane">
      <c:forEach items="${mavenBuildInfo.projects}" var="p">
        <c:if test="${p.id == mavenProject.id}">
          <div class="item selected">
            <strong><c:out value="${p.name}"/></strong>
          </div>
        </c:if>
        <c:if test="${p.id != mavenProject.id}">
          <div class="item">
            <a href="#" onclick="updateProjectDetails('${p.id}');return false">
              <c:out value="${p.name}"/>
            </a>
          </div>
        </c:if>
      </c:forEach>
    </td>

    <td class="right-pane ${empty mavenProject ? 'empty' : ''}">
      <c:if test="${empty mavenProject}">Select a project</c:if>

      <c:if test="${not empty mavenProject}">
        <table class="settings" style="font-size: 100%">
          <tr><td style="width: 15em"><strong>Group ID:</strong></td><td><c:out value="${mavenProject.GAV.groupId}"></c:out></td></tr>
          <tr><td><strong>Artifact ID:</strong></td><td><c:out value="${mavenProject.GAV.artifactId}"></c:out></td></tr>
          <tr><td><strong>Version:</strong></td><td><c:out value="${mavenProject.GAV.version}"></c:out></td></tr>
          <tr><td><strong>Packaging:</strong></td><td><c:out value="${mavenProject.packaging}"></c:out></td></tr>
          <c:if test="${not empty mavenProject.activeProfiles}">
          <tr><td><strong>Active Profiles:</strong></td><td><c:forEach items="${mavenProject.activeProfiles}" var="profile"><c:out value="${profile} "/></c:forEach></td></tr>
          </c:if>
          <tr><td><strong>Produced Artifact:</strong></td><td><c:set var="gav" value='<%=MavenWebUtil.printGAV(((Project)request.getAttribute("mavenProject")).getArtifact())%>'/><c:out value="${gav}"/></td></tr>

          <c:if test="${not empty mavenProject.attachedArtifacts}">
            <tr><td><strong>Attached Artifacts:</strong></td>
            <td><c:forEach items="${mavenProject.attachedArtifacts}" var="artifact">
            <div><c:set var="gav" value='<%=MavenWebUtil.printGAV((MavenGAV)pageContext.getAttribute("artifact"))%>'/><c:out value="${gav}"/></div>
            </c:forEach></td></tr>
          </c:if>

          <c:if test="${not empty mavenProject.dependencyArtifacts}">
            <tr><td><strong>Dependency Artifacts:</strong></td>
            <td><c:forEach items="${mavenProject.dependencyArtifacts}" var="artifact">
            <c:set var="gav" value='<%=MavenWebUtil.printGAV(((Dependency)pageContext.getAttribute("artifact")).getGAV())%>'/>
            <div>
              <c:out value="${gav}"/><c:if test="${not empty artifact.scope}"><c:out value=" (${artifact.scope})"/></c:if>
            </div>
            </c:forEach></td></tr>
          </c:if>

          <c:if test="${not empty mavenProject.effectivePlugins}">
            <tr><td><strong>Effective Plugins:</strong></td>
            <td><c:forEach items="${mavenProject.effectivePlugins}" var="artifact">
            <div><c:set var="gav" value='<%=MavenWebUtil.printGAV((MavenGAV)pageContext.getAttribute("artifact"))%>'/><c:out value="${gav}"/></div>
            </c:forEach></td></tr>
          </c:if>
        </table>
      </c:if>
    </td>
  </tr>
</table>
