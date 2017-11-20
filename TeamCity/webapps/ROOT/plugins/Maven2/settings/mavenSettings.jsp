<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<%@ include file="/include-internal.jsp" %>
<%--@elvariable id="settingsFiles" type="java.util.Map<jetbrains.buildServer.serverSide.SProject, java.util.List<String>>"--%>
<%--@elvariable id="project" type="jetbrains.buildServer.serverSide.SProject"--%>
<%--@elvariable id="buildTypeSettingsUsages" type="java.util.Map<String, Map<String, Set<BuildTypeSettings>>>"--%>
<%--@elvariable id="templateSettingsUsages" type="java.util.Map<String, Map<String, Set<BuildTypeSettings>>>"--%>
<%--@elvariable id="settingsFilesPath" type="java.lang.String"--%>
<%--@elvariable id="inspectionResults" type="Map<jetbrains.buildServer.serverSide.SProject, Map<jetbrains.buildServer.serverSide.BuildTypeSettings, Set<java.lang.String>>>"--%>

<div class="section noMargin">
  <h2 class="noBorder">Maven Settings</h2>
  <bs:smallNote>In this section you can manage the Maven settings to reuse them within the project <bs:help file="Maven+Server-Side+Settings"/></bs:smallNote>

  <bs:messages key="mavenSettingsUploaded"/>
  <bs:messages key="mavenSettingsDeleted"/>
  <bs:messages key="mavenSettingsDeleteError" className="error"/>

  <c:choose>
    <%--@elvariable id="fileContent" type="java.lang.String"--%>
    <c:when test="${fileContent ne null}">
      <%-- display file content --%>
      <c:url var="homeUrl" value="/admin/editProject.html?projectId=${project.externalId}&tab=mavenSettings"/>
      <%@include file="_mavenSettingsFileDisplay.jspf"%>
    </c:when>
    <c:otherwise>
      <%-- display errors --%>
      <c:if test="${not empty inspectionResults}">
        <%@include file="health/_mavenSettingsInspectionsDisplay.jspf"%>
      </c:if>
      <%-- display file list --%>
      <authz:authorize projectId="${project.projectId}" allPermissions="EDIT_PROJECT">
        <jsp:attribute name="ifAccessGranted">
          <div class="upload">
            <forms:addButton onclick="return BS.MavenAddSettings.show();">Upload settings file</forms:addButton>
          </div>
          <bs:dialog dialogId="addSettings"
                     dialogClass="uploadDialog"
                     title="Upload Maven Settings"
                     titleId="addSettingsTitle"
                     closeCommand="BS.MavenAddSettings.close();">
            <c:url var="actionUrl" value="/admin/uploadMavenSettings.html"/>
            <forms:multipartForm id="addSettingsForm" action="${actionUrl}"
                                 onsubmit="return BS.MavenAddSettings.validate();"
                                 targetIframe="hidden-iframe">
              <div>
                <table class="runnerFormTable">
                  <tr>
                    <th><label for="fileName">Name: </label></th>
                    <td><input type="text" id="fileName" name="fileName" value=""/></td>
                  </tr>
                  <tr>
                    <th>File: <l:star/></th>
                    <td>
                      <forms:file name="fileToUpload" size="28"/>
                      <span id="uploadError" class="error hidden"></span>
                    </td>
                  </tr>
                </table>
              </div>
              <div class="popupSaveButtonsBlock">
                <forms:submit label="Save"/>
                <forms:cancel onclick="BS.MavenAddSettings.close()" showdiscardchangesmessage="false"/>
                <input type="hidden" id="projectId" name="project" value="${project.externalId}"/>
                <forms:saving id="saving"/>
              </div>
            </forms:multipartForm>
          </bs:dialog>
        </jsp:attribute>
      </authz:authorize>

      <script type="text/javascript">
        BS.MavenAddSettings.setFiles([<c:forEach var="file" items="${settingsFiles[project]}">'${file}',</c:forEach>]);
        BS.MavenAddSettings.prepareFileUpload();
      </script>

      <c:if test="${empty settingsFiles[project]}">
        <p>There are no Maven settings files defined in the current project.</p>
      </c:if>
      <c:if test="${not empty settingsFiles[project]}">
        <p style="margin-top: 2em">Maven settings files defined in the current project:</p>
        <l:tableWithHighlighting style="width: 100%"
                                 id="mavenSettingsTable"
                                 className="parametersTable"
                                 mouseovertitle="Click to view configuration file in browser"
                                 highlightImmediately="true">
          <tr>
            <th style="width: 50%">Settings File Name</th>
            <th colspan="3">Usage</th>
          </tr>
          <c:forEach items="${settingsFiles[project]}" var="file">
            <c:url var="fileUrl" value="/admin/editProject.html?projectId=${project.externalId}&tab=mavenSettings&file=${file}"/>
            <c:set var="onclick" value="document.location.href = '${fileUrl}';"/>
            <tr>
              <td class="highlight" onclick="${onclick}"><bs:out value="${file}"/></td>
              <td class="highlight" onclick="${onclick}" style="white-space: nowrap">
                <c:set var="currentProject" value="${project}"/>
                <c:set var="currentUsages" value="${buildTypeSettingsUsages[currentProject.externalId]}"/>
                <c:set var="currentTemplateUsages" value="${templateSettingsUsages[currentProject.externalId]}"/>
                <c:set var="used" value="${not empty currentUsages[file] or not empty currentTemplateUsages[file]}"/>
                <%@ include file="_mavenSettingsUsage.jspf" %>
              </td>
              <td class="edit highlight"><a href="#" onclick="${onclick}">View</a></td>
              <td class="edit">
                <authz:authorize projectId="${project.projectId}" allPermissions="EDIT_PROJECT" >
                  <jsp:attribute name="ifAccessGranted">
                    <a href="#" onclick="BS.MavenSettings.deleteSettings('${currentProject.externalId}', '${file}', ${used});">Delete</a>
                  </jsp:attribute>
                  <jsp:attribute name="ifAccessDenied">
                    <div class="clearfix" style="color: #888"><i>Delete</i></div>
                  </jsp:attribute>
                </authz:authorize>
              </td>
            </tr>
          </c:forEach>
        </l:tableWithHighlighting>
      </c:if>

      <c:forEach items="${settingsFiles}" var="settings">
        <c:set var="p" value="${settings.key}"/>
        <c:if test="${p ne project}">
          <p style="margin-top: 2em">Settings inherited from <admin:editProjectLink projectId="${p.externalId}"><c:out value="${p.fullName}"/></admin:editProjectLink>:</p>
          <table style="width: 100%" class="parametersTable">
            <tr>
              <th style="width: 50%">Settings File Name</th>
              <th style="width: 50%">Usage</th>
            </tr>
            <c:forEach items="${settingsFiles[p]}" var="file">
              <tr>
                <td><bs:out value="${file}"/></td>
                <td style="white-space: nowrap">
                  <c:set var="currentProject" value="${p}"/>
                  <c:set var="currentUsages" value="${buildTypeSettingsUsages[p.externalId]}"/>
                  <c:set var="currentTemplateUsages" value="${templateSettingsUsages[p.externalId]}"/>
                  <%@ include file="_mavenSettingsUsage.jspf" %>
                </td>
              </tr>
            </c:forEach>
          </table>
        </c:if>
      </c:forEach>
    </c:otherwise>
  </c:choose>
</div>
