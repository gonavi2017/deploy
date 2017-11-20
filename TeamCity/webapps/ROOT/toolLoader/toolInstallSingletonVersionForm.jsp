<%@ include file="/include-internal.jsp" %>
<jsp:useBean id="singletonTool" type="jetbrains.buildServer.tools.web.AvailableSingletonToolData" scope="request"/>
<jsp:useBean id="defaultAction" type="java.lang.String" scope="request"/>

<c:set var="singletonVersion" value="${singletonTool.singletonVersion}"/>
<c:set var="selectedType" value="${singletonVersion.type}"/>

<div id="toolTypeSelectorContainer">
  <c:choose>
    <c:when test="${empty singletonTool.toolTypes}">
      All available tools are already installed.
      <br>
      Use 'Add Version...' action to install new tool version.
    </c:when>
    <c:otherwise>
      <table  class="runnerFormTable">
        <tr>
          <th><label for="toolType">Tool:<l:star/></label></th>
          <td>
            <forms:select name="toolType" enableFilter="${true}" onchange="BS.Tools.InstallDialog.selectToolType()">
              <forms:option value="">-- Please choose tool --</forms:option>
              <c:forEach var="tool" items="${singletonTool.toolTypes}">
                <forms:option value="${tool.type}" selected="${tool.type.equals(selectedType.type)}"><c:out value="${tool.displayName}"/></forms:option>
              </c:forEach>
            </forms:select>
          </td>
        </tr>
      </table>
    </c:otherwise>
  </c:choose>
</div>

<div class="download-upload-container">
  <c:if test="${selectedType.supportDownload}">
    <div class="download-container">
      <forms:radioButton name="loadType" id="install"
                         checked="${defaultAction.equalsIgnoreCase('install')}"
                         onclick="BS.Tools.InstallDialog.switchInstallMode('install')" value="install"/>
      <label for="install">Download</label>
    </div>
  </c:if>
  <c:if test="${selectedType.supportUpload}">
    <div class="upload-container">
      <forms:radioButton name="loadType" id="upload"
                         checked="${defaultAction.equalsIgnoreCase('upload')}"
                         onclick="BS.Tools.InstallDialog.switchInstallMode('upload')" value="upload"/>
      <label for="upload">Upload</label>
    </div>
  </c:if>
</div>

<c:set var="selectedTypeName" value="${selectedType.displayName}"/>
<table class="runnerFormTable" id="uploadSettingsContainer">
  <tr>
    <td colspan="2">
      Select a
      <c:choose>
        <c:when test="${empty selectedType.toolSiteUrl}">
          ${selectedType.displayName}
        </c:when>
        <c:otherwise>
          <a showdiscardchangesmessage="false"
             target="_blank"
             href="${selectedType.toolSiteUrl}">${selectedType.displayName}</a>
        </c:otherwise>
      </c:choose>
      <c:if test="${selectedType.versionBased}"> version</c:if> to upload:
    </td>
  </tr>
  <tr id="uploadRow">
    <th><label for="uploadControl">Upload:<l:star/></label></th>
    <td>
      <forms:file name="uploadControl"/>
      <span class="smallNote">
          <c:choose>
            <c:when test="${not empty selectedType.validPackageDescription}">
              ${selectedType.validPackageDescription}
            </c:when>
            <c:otherwise>
              Specify the path to ${selectedTypeName}.
            </c:otherwise>
          </c:choose>
        </span>
      <span class="error" id="error_tool_upload"></span>
    </td>
  </tr>
  <c:if test="${not empty selectedType.toolLicenseUrl}">
    <tr>
      <td colspan="2" class="grayNote">
        Note that by pressing "Add" button you accept the
        <a target="_blank" href="${selectedType.toolLicenseUrl}"> license terms</a>.
      </td>
    </tr>
  </c:if>
</table>

<table class="runnerFormTable" id="downloadSettingsContainer">
  <tr>
    <td colspan="2">
      Download
      <c:choose>
        <c:when test="${empty selectedType.toolSiteUrl}">
          ${singletonVersion.displayName}
        </c:when>
        <c:otherwise>
          <a showdiscardchangesmessage="false"
             target="_blank"
             href="${selectedType.toolSiteUrl}">${singletonVersion.displayName}</a>
        </c:otherwise>
      </c:choose>
    </td>
  </tr>
  <c:if test="${not empty selectedType.toolLicenseUrl}">
    <tr>
      <td colspan="2" class="grayNote">
        Note that by pressing "Add" button you accept the
        <a target="_blank" href="${selectedType.toolLicenseUrl}"> license terms</a>.
      </td>
    </tr>
  </c:if>
</table>

<span class="error" id="error_action"></span>

<input type="hidden" id="actionName" name="actionName" value="${defaultAction}"/>
<input type="hidden" id="selectedToolType" name="selectedToolType" value="${selectedType.type}"/>
<input type="hidden" id="selectedToolId" name="selectedToolId" value="${singletonVersion.id}" />
<input type="hidden" id="selectedToolVersion" name="selectedToolVersion" value="${singletonVersion.version}" />

<script type="javascript">
  BS.Tools.InstallDialog.switchInstallMode('${defaultAction}');
</script>
