<%@ page import="jetbrains.buildServer.web.openapi.PlaceId" %>
<%@ page import="jetbrains.buildServer.web.util.WebUtil" %>

<%@ include file="/include-internal.jsp" %>

<jsp:useBean id="pageUrl" type="java.lang.String" scope="request"/>
<c:set var="escapedPageUrl" value="<%=WebUtil.encode(pageUrl)%>"/>
<jsp:useBean id="loginConfig" scope="request" type="jetbrains.buildServer.serverSide.ServerSettings"/>
<jsp:useBean id="serverConfigForm" scope="request" type="jetbrains.buildServer.controllers.admin.ServerConfigForm"/>
<c:set var="internalDbWarn">
  <c:if test="${serverConfigForm.hsqldb}">
    <div class="smallNote unscalableDbWarning tc-icon_before icon16 tc-icon_attention">
      For production purposes, switching to a standalone database is recommended to achieve better performance and reliability.
      See <a href="<bs:helpUrlPrefix/>/Migrating+to+an+External+Database" target="_blank">Migration Instructions</a>.
    </div>
  </c:if>
</c:set>

<div>
  <div class="serverConfigPage">
    <bs:refreshable pageUrl="${pageUrl}" containerId="serverSettings">
      <bs:messages key="serverSettingsSaved"/>

      <form action="<c:url value='/admin/serverConfigGeneral.html'/>" method="post" onsubmit="return BS.ServerConfigForm.submitSettings()">
        <table class="runnerFormTable">
          <tr class="groupingTitle">
            <td colspan="2">TeamCity Configuration</td>
          </tr>
          <tr>
            <th>Database: </th>
            <td>
              Database&nbsp;type: <c:out value="${serverConfigForm.dbTypeName}"/><br/>
              <c:if test="${not serverConfigForm.hsqldb}">
                Connection&nbsp;URL: <span class="mono"><c:out value="${serverConfigForm.dbConnectionString}"/></span>
              </c:if>
              <c:if test="${serverConfigForm.hsqldb}">
                ${internalDbWarn}
              </c:if>
            </td>
          </tr>
          <tr>
            <th>Data directory: <bs:help file="TeamCity+Data+Directory"/></th>
            <td>
              <span id="dataDirectory"><c:out value="${serverConfigForm.dataDirectory}"/></span>
              <a href="<c:url value='/admin/admin.html?item=diagnostics&tab=dataDir'/>" style="margin-left: 20px; font-size: 90%;">Browse</a>
            </td>
          </tr>
          <tr>
            <th>Artifact directories: </th>
            <td>
              <forms:textField name="artifactDirectories" expandable="true" value="${serverConfigForm.artifactDirectories}" className="longField"/>
              <input type="hidden" id="originalArtifactDirectories" value="<c:out value="${serverConfigForm.artifactDirectories}"/>"/>
              <span class="error" id="artifactDirectoriesError"></span>
              <span class="smallNote">
                New-line delimited paths to artifact directories used by the server.
                Artifacts for all new builds are published under the first directory in the list.
                Relative paths are relative to TeamCity data directory: <c:out value="${serverConfigForm.dataDirectory}"/>.
              </span>
            </td>
          </tr>
          <tr>
            <th>Caches directory: </th>
            <td>
              <c:out value="${serverConfigForm.cacheDirectory}"/>
            </td>
          </tr>
          <tr>
            <th><label for="rootUrl">Server URL:</label> <bs:help file="Configuring+Server+URL"/></th>
            <td>
              <forms:textField name="rootUrl" style="width: 370px;" value="${serverConfigForm.rootUrl}"/>
              <span class="error" id="invalidRootUrl"></span>
            </td>
          </tr>

          <tr class="groupingTitle">
            <td colspan="2">Builds Settings</td>
          </tr>
          <tr>
            <th><label for="maxArtifactSize">Maximum build artifact file size:</label></th>
            <td>
              <forms:textField name="maxArtifactSize" value="${serverConfigForm.maxArtifactSize}" size="10" maxlength="20"/>
              <span class="error" id="invalidMaxArtifactSize"></span>
              <bs:smallNote>in bytes. <it>KB, MB, GB or TB</it> suffixes are allowed, -1 indicates no limit</bs:smallNote>
            </td>
          </tr>
          <tr>
            <th><label for="defaultExecutionTimeout">Default build execution timeout:</label></th>
            <td>
              <forms:textField name="defaultExecutionTimeout" value="${serverConfigForm.defaultExecutionTimeout}" size="6" maxlength="8"/> minutes
              <span class="error" id="invalidDefaultExecutionTimeout"></span>
              <bs:smallNote>0 and negative values indicate no execution timeout</bs:smallNote>
            </td>
          </tr>

          <tr class="groupingTitle">
            <td colspan="2">Version Control Settings</td>
          </tr>
          <tr>
            <th><label for="defaultModificationCheckInterval">Default VCS changes check interval:</label></th>
            <td><forms:textField name="defaultModificationCheckInterval" size="6" maxlength="8" value="${serverConfigForm.defaultModificationCheckInterval}"/> seconds
              <span class="error" id="invalidDefaultModificationCheckInterval"></span></td>
          </tr>
          <tr>
            <th><label for="defaultQuietPeriod">Default VCS trigger quiet period:</label></th>
            <td><forms:textField name="defaultQuietPeriod" size="6" maxlength="8" value="${serverConfigForm.defaultQuietPeriod}"/> seconds
              <span class="error" id="invalidDefaultQuietPeriod"></span></td>
          </tr>
        </table>

        <div class="saveButtonsBlock">
          <forms:submit label="Save"/>
          <input type="hidden" id="submitSettings" name="submitSettings" value="store"/>
          <forms:saving/>
        </div>

      </form>

      <forms:modified/>

      <script type="text/javascript">
        BS.ServerConfigForm.setupEventHandlers();
        BS.ServerConfigForm.setModified(${serverConfigForm.stateModified});
        BS.VisibilityHandlers.updateVisibility('serverSettings');
      </script>

    </bs:refreshable>

    <div class="clr"></div>

    <ext:includeExtensions placeId="<%=PlaceId.ADMIN_SERVER_CONFIGURATION%>"/>
  </div>
</div>
