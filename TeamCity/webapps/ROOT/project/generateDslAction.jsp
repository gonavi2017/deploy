<%@ include file="/include-internal.jsp" %>
<jsp:useBean id="project" scope="request" type="jetbrains.buildServer.serverSide.SProject"/>
<jsp:useBean id="formats" type="java.util.List<jetbrains.buildServer.serverSide.impl.versionedSettings.ProjectSettingsGenerator>" scope="request"/>
<c:forEach var="format" items="${formats}">
  <l:li>
    <c:url var="genUrl" value="/admin/versionedSettingsActions.html?projectId=${project.externalId}&action=generate&format=${format.format}"/>
    <c:set var="menuItem">Download settings in <c:out value="${format.formatDisplayName}"/> format</c:set>
    <a href="${genUrl}" title="${menuItem}">${menuItem}</a>
  </l:li>
</c:forEach>

