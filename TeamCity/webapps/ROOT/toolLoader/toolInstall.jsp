<%@include file="/include-internal.jsp" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="form" scope="request" type="jetbrains.buildServer.tools.web.ToolInstallForm"/>

<bs:linkScript>
  /js/bs/multipart.js
  /toolLoader/tools.js
</bs:linkScript>

<bs:linkCSS>
  /toolLoader/tools.css
</bs:linkCSS>

<c:set var="installControllerUrl"><c:url value="/admin/tools/install.html"/></c:set>
<c:set var="removeControllerUrl"><c:url value="/admin/tools/remove.html"/></c:set>
<c:set var="setDefaultControllerUrl"><c:url value="/admin/tools/setDefault.html"/></c:set>
<c:set var="showUsagesControllerUrl"><c:url value="/admin/tools/showUsages.html"/></c:set>

<h2 class="noBorder">Tools</h2>

<bs:smallNote>Here you can set up tools to be used by appropriate plugins. Tools are automatically distributed to all build agents and can be used in related runners.</bs:smallNote>

<p><forms:addButton onclick="BS.Tools.InstallDialog.show(); return false;">Install Tool...</forms:addButton></p>

<c:set var="numInstalledTools" value="${fn:length(form.installedToolTypes)}"/>
<%--@elvariable id="pageUrl" type="java.lang.String"--%>
<bs:refreshable containerId="all-types-container" pageUrl="${pageUrl}">
  <c:choose>
    <c:when test="${numInstalledTools == 0}">
      <div>There are no tools installed.</div>
    </c:when>
    <c:otherwise>
      <div>You have ${numInstalledTools} type<bs:s val="${numInstalledTools}"/> of tools installed.</div>
      <c:forEach var="installedToolData" items="${form.installedToolTypes}">
        <c:set var="toolType" value="${installedToolData.type}"/>
        <bs:refreshable containerId="${toolType.type}-container" pageUrl="${pageUrl}">
          <div>
            <h3 class="noBorder tool-name">${toolType.displayName}</h3>
            <c:if test="${not empty toolType.description}">
              <bs:smallNote>
                ${toolType.description}
                <c:if test="${not empty toolType.teamCityHelpFile}">
                  <bs:help file="${toolType.teamCityHelpFile}" anchor="${toolType.teamCityHelpAnchor}"/>
                </c:if>
              </bs:smallNote>
            </c:if>
            <c:if test="${toolType.supportDownload || toolType.supportUpload}">
              <c:choose>
                <c:when test="${toolType.supportDownload}">
                  <c:set var="onclick">BS.Tools.InstallDialog.showInstallForToolType('<bs:forJs>${toolType.type}</bs:forJs>','<bs:forJs>${toolType.displayName}</bs:forJs>'); return false;</c:set>
                </c:when>
                <c:otherwise>
                  <c:set var="onclick">BS.Tools.InstallDialog.showUploadForToolType('<bs:forJs>${toolType.type}</bs:forJs>','<bs:forJs>${toolType.displayName}</bs:forJs>'); return false;</c:set>
                </c:otherwise>
              </c:choose>
              <c:if test="${not toolType.singleton}">
                <forms:addButton onclick="${onclick}">
                  <c:choose>
                    <c:when test="${toolType.versionBased}">
                      Install Version...
                    </c:when>
                    <c:otherwise>
                      Install...
                    </c:otherwise>
                  </c:choose>
                </forms:addButton>
              </c:if>
            </c:if>
          </div>
          <c:if test="${not empty installedToolData.toolVersions}">
            <table class="settings installed-versions">
            <tr>
              <th class="name" colspan="4">
                <c:choose>
                  <c:when test="${toolType.versionBased}">
                    Installed version<bs:s val="${fn:length(installedToolData.toolVersions)}"/>
                  </c:when>
                  <c:otherwise>
                    Installed tool<bs:s val="${fn:length(installedToolData.toolVersions)}"/>
                  </c:otherwise>
                </c:choose>
              </th>
            </tr>
              <c:forEach var="toolVersionData" items="${installedToolData.toolVersions}">
                <c:set var="toolVersion" value="${toolVersionData.toolVersion}" />
                <tr class="installed-version">
                  <td class="installed-version__name">
                    <c:out value="${toolVersion.version}"/>
                    <c:if test="${toolType.countUsages}">
                      <a style="float: right" href="#" onclick="BS.Tools.ShowUsagesDialog.show('<bs:forJs>${toolVersion.id}</bs:forJs>', '<bs:forJs>${toolVersion.displayName}</bs:forJs>'); return false;">Show Usages...</a>
                    </c:if>
                  </td>
                  <c:if test="${toolType.versionBased and not toolType.singleton}">
                    <td class="installed-version__action">
                      <c:choose>
                        <c:when test="${not toolVersionData.defaultVersion}">
                          <a href="#" onclick="BS.Tools.setDefault('<bs:forJs>${toolVersion.id}</bs:forJs>', '<bs:forJs>${toolType.type}</bs:forJs>', '<bs:forJs>${toolType.displayName}</bs:forJs>', <bs:forJs>${toolType.countUsages}</bs:forJs>); return false;">
                            Make&nbsp;Default<c:if test="${toolType.countUsages}">...</c:if>
                          </a>
                        </c:when>
                        <c:otherwise>
                          <span>Default&nbsp;Version</span>
                        </c:otherwise>
                      </c:choose>
                    </td>
                  </c:if>
                  <td class="installed-version__action">
                    <c:choose>
                      <c:when test="${toolVersionData.bundled}">
                        <span>Bundled</span>
                      </c:when>
                      <c:otherwise>
                        <a href="#" onclick="BS.Tools.removeTool('<bs:forJs>${toolVersion.id}</bs:forJs>', '<bs:forJs>${toolVersion.displayName}</bs:forJs>', <bs:forJs>${toolType.countUsages}</bs:forJs>); return false;">
                          Remove<c:if test="${toolType.countUsages}">...</c:if>
                        </a>
                      </c:otherwise>
                    </c:choose>
                  </td>
                </tr>
              </c:forEach>
            </table>
          </c:if>
        </bs:refreshable>
      </c:forEach>
    </c:otherwise>
  </c:choose>
  <c:if test="${not empty form.installationErrors}">
    <h3 class="noBorder tool-name">Installation Errors</h3>
    <table class="settings installed-versions">
      <tr>
        <th class="name">Tool Id</th>
        <th class="name">Error</th>
      </tr>
      <c:forEach var="error" items="${form.installationErrors}">
        <tr class="installed-version">
          <td>
            <c:out value="${error.toolPackage.name}"/>
          </td>
          <td>
            <c:out value="${error.error}"/>
          </td>
        </tr>
      </c:forEach>
    </table>
  </c:if>
</bs:refreshable>

<bs:modalDialog dialogClass="InstallDialog"
                formId="InstallDialogForm"
                title="Install Tool"
                saveCommand="BS.Tools.InstallDialog.save()"
                closeCommand="BS.Tools.InstallDialog.close()"
                action='${installControllerUrl}'>
  <div id="installFormLoading">
    <forms:progressRing className="progressRingInline"/> Fetching available versions...
  </div>

  <div id="installFormRefresh">

  </div>

  <div class="popupSaveButtonsBlock">
    <forms:submit id="installApplyButton" label="Add"/>
    <forms:cancel onclick="BS.Tools.InstallDialog.close();"/>
    <forms:saving id="installProgress"/>
  </div>
</bs:modalDialog>

<bs:modalDialog dialogClass="RemoveDialog"
                formId="RemoveDialogForm"
                title="Remove Tool"
                saveCommand="BS.Tools.RemoveDialog.save()"
                closeCommand="BS.Tools.RemoveDialog.close()"
                action='${removeControllerUrl}'>
  <div id="removeFormLoading">
    <forms:progressRing className="progressRingInline"/> Searching for tool usages...
  </div>

  <div id="removeFormRefresh">

  </div>

  <div class="popupSaveButtonsBlock">
    <forms:submit id="removeApplyButton" label="Remove"/>
    <forms:cancel onclick="BS.Tools.RemoveDialog.close();"/>
    <forms:saving id="removeProgress"/>
  </div>
</bs:modalDialog>

<bs:modalDialog dialogClass="SetDefaultDialog"
                formId="SetDefaultDialogForm"
                title="Set Default Tool Version"
                saveCommand="BS.Tools.SetDefaultDialog.save()"
                closeCommand="BS.Tools.SetDefaultDialog.close()"
                action='${setDefaultControllerUrl}'>
  <div id="setDefaultFormLoading">
    <forms:progressRing className="progressRingInline"/> Searching for tool usages...
  </div>

  <div id="setDefaultFormRefresh">

  </div>

  <div class="popupSaveButtonsBlock">
    <forms:submit id="setDefaultApplyButton" label="Set Default Version"/>
    <forms:cancel onclick="BS.Tools.SetDefaultDialog.close();"/>
    <forms:saving id="setDefaultProgress"/>
  </div>
</bs:modalDialog>

<bs:modalDialog dialogClass="ShowUsagesDialog"
                formId="ShowUsagesDialogForm"
                title="Tool Usages"
                saveCommand="BS.Tools.ShowUsagesDialog.save()"
                closeCommand="BS.Tools.ShowUsagesDialog.close()"
                action='${setDefaultControllerUrl}'>
  <div id="showUsagesFormLoading">
    <forms:progressRing className="progressRingInline"/> Searching for tool usages...
  </div>

  <div id="showUsagesFormRefresh">

  </div>

  <div class="popupSaveButtonsBlock">
    <forms:cancel label="Close" onclick="BS.Tools.ShowUsagesDialog.close();"/>
    <forms:saving id="showUsagesProgress"/>
  </div>
</bs:modalDialog>

<script type="text/javascript">
  BS.Tools.installUrl = "<bs:forJs>${installControllerUrl}</bs:forJs>";
  BS.Tools.removeUrl = "<bs:forJs>${removeControllerUrl}</bs:forJs>";
  BS.Tools.setDefaultUrl = "<bs:forJs>${setDefaultControllerUrl}</bs:forJs>";
  BS.Tools.showUsagesUrl = "<bs:forJs>${showUsagesControllerUrl}</bs:forJs>";
</script>