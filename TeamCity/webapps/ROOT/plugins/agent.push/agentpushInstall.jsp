<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="presetsInfo" type="jetbrains.buildServer.agentpush.web.PresetsInfo" scope="request"/>
<jsp:useBean id="installPresetForm" type="jetbrains.buildServer.agentpush.web.forms.AgentPushInstallForm" scope="request"/>
<jsp:useBean id="action" type="jetbrains.buildServer.agentpush.web.controllers.actions.BaseAction" scope="request"/>

<jsp:useBean id="isPsExecPathRequired" type="java.lang.Boolean" scope="request"/>
<jsp:useBean id="isEulaAcceptRequired" type="java.lang.Boolean" scope="request"/>

<jsp:useBean id="serverUrl" type="java.lang.String" scope="request"/>

<%@ page import="com.intellij.openapi.util.SystemInfo" %>
<%@ page import="jetbrains.buildServer.agentpush.PsExecTool" %>

<c:set var="isServerWindows"><%=SystemInfo.isWindows%></c:set>

<script type="application/javascript">
    BS.AgentPush.Info.isServerWindows = ${isServerWindows};
    BS.AgentPush.Info.isPsExecPathRequired = ${isPsExecPathRequired};
    BS.AgentPush.Info.isEulaAcceptRequired = ${isEulaAcceptRequired};
</script>

<div class="agentpushInstallDialogScrollable">
    <table class="runnerFormTable">
        <tr>
          <td colspan="2">
            <em>Server URL<bs:help file="Configuring+Server+URL"/> is <strong>${serverUrl}</strong>.
            It will be used by build agent to connect. Make sure this URL is available from build agent machine.
            To change it use <a href="<c:url value='/admin/admin.html?item=serverConfigGeneral'/>" target="_blank">Server Configuration page</a>.</em>
          </td>
        </tr>
        <tr>
            <th><label for="host">Host: <l:star/></label></th>
            <td>
                <forms:textField name="host" id="host" style="width:25em;"
                                 value="${installPresetForm.host}"/>
                <span class="error" id="errorHost"></span>

                <div class="smallNote" style="margin: 0;">
                    Host name or IP address.
                </div>
            </td>
        </tr>
        <tr class="noBorder">
            <th><label for="selectedPreset">Preset: <l:star/></label></th>
            <td>
                <select name="selectedPreset" id="selectedPreset" style="width: 25em"
                        onchange="BS.AgentPush.InstallDialog.onPresetChanged(this)">
                    <forms:option value=""
                                  selected="${empty installPresetForm.selectedPreset}">-- Choose preset --</forms:option>
                    <c:forEach items="${presetsInfo.presets}" var="preset">
                        <forms:option value="${preset.id}" selected="${installPresetForm.selectedPreset == preset.id}"><c:out
                                value="${preset.name}"/></forms:option>
                    </c:forEach>
                    <forms:option value="CUSTOM"
                                  selected="${installPresetForm.selectedPreset == 'CUSTOM'}">&lt;Use custom settings&gt;</forms:option>
                </select>
                <span class="error" id="errorSelectedPreset"></span>
            </td>
        </tr>

        <c:if test="${isServerWindows}">
            <script type="application/javascript">
                BS.AgentPush.Info.PresetsPlatforms = {
                    <c:forEach items="${presetsInfo.presets}" var="preset">
                    "${preset.id}": "${preset.platform}",
                    </c:forEach>
                }
            </script>
            <c:if test="${isPsExecPathRequired}">
                <tr class="noBorder" id ="psexecPathNoteContainer" style="display:none;">
                  <td colspan="2">
                    <div class="attentionComment">
                        Could not find <a showdiscardchangesmessage="false"
                           target="_blank"
                           href="http://technet.microsoft.com/en-us/sysinternals/bb897553.aspx">Sysinternals psexec.exe</a> tool on the server.<br/>
                        <c:set var="PSEXEC_TOOL_TYPE" value="<%=PsExecTool.PSEXEC_TOOL_TYPE%>"/>
                        <c:url var="psexecDownloader" value="/admin/admin.html?item=toolInstallTab&toolType=${PSEXEC_TOOL_TYPE}"/>
                        <a href="${psexecDownloader}" target="_blank" showdiscardchangesmessage="false">Load SysInternals psexec.exe</a>
                    </div>
                  </td>
                </tr>
            </c:if>
        </c:if>
    </table>

    <div id="customSettings" style="display:none;">
        <c:set var="form" value="${installPresetForm}" scope="request"/>
        <jsp:include page="preset.jsp">
            <jsp:param name="onChangePlatform" value="BS.AgentPush.InstallDialog.onPlatformChanged(this)"/>
        </jsp:include>
        <input type="hidden" id="presetName" name="presetName" value="${installPresetForm.presetName}"/>
    </div>
</div>

<c:if test="${isServerWindows && isEulaAcceptRequired}">
    <div id="licenceAcceptingNoteContainer" style="display:none;">
    <br/>
    By pressing "Install agent" button you are accepting the
    <a showdiscardchangesmessage="false"
       target="_blank"
       href="http://technet.microsoft.com/en-us/sysinternals/bb469936.aspx">Sysinternals Software License Terms</a>.
    </div>
</c:if>

<div class="popupSaveButtonsBlock">
    <forms:submit label="Install agent"/>
    <forms:cancel onclick="BS.AgentPush.CreatePresetDialog.close()"/>
</div>
<script type="application/javascript">
    BS.AgentPush.InstallDialog.onPresetChanged($('selectedPreset'));
</script>
<div class="clr"></div>

