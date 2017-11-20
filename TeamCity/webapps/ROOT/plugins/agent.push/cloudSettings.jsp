<%@ page import="jetbrains.buildServer.agentpush.PsExecTool" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="presetsInfo" type="jetbrains.buildServer.agentpush.web.PresetsInfo" scope="request"/>

<jsp:useBean id="isPsExecPathRequired" type="java.lang.Boolean" scope="request"/>
<jsp:useBean id="isEulaAcceptRequired" type="java.lang.Boolean" scope="request"/>
<jsp:useBean id="isServerWindows" type="java.lang.Boolean" scope="request"/>

<c:choose>
    <c:when test="${isServerWindows}">
        <c:set var="onPresetChange">
            var selectedValue = this.options[this.selectedIndex].value;
            if (selectedValue == '') {
                BS.Util.hide($('psexecPathNoteContainer'));
                BS.Util.hide($('licenceAcceptingNoteContainer'));
            } else {
                if ($(selectedValue + '_platform').innerHTML.indexOf('Windows') != -1) {
                    if (${isPsExecPathRequired}) BS.Util.show($('psexecPathNoteContainer'));
                    if (${isEulaAcceptRequired}) BS.Util.show($('licenceAcceptingNoteContainer'));
                } else {
                    BS.Util.hide($('psexecPathNoteContainer'));
                    BS.Util.hide($('licenceAcceptingNoteContainer'));
                }
            }
        </c:set>
    </c:when>
    <c:otherwise>
        <c:set var="onPresetChange" value=""/>
    </c:otherwise>
</c:choose>

<tr>
<th>
    <label for="agentPushPreset">Install Build Agent:<bs:help file="Setting+up+and+Running+Additional+Build+Agents" anchor="InstallingviaAgentPush"/></label>
</th>
<td>
    <props:selectProperty name="agentPushPreset" className="longField" onchange="${onPresetChange}">
        <props:option value="" selected="true">&lt;Do not install&gt;</props:option>
        <c:forEach items="${presetsInfo.presets}" var="preset">
            <props:option value="${preset.id}" selected="false">
                <c:out value="${preset.name}"/>
            </props:option>
        </c:forEach>
    </props:selectProperty>
    <span class="error" id="errorAgentPushPreset"></span>
    <span class="smallNote">Select Agent Push preset to automatically install build agent to started cloud instance.<br/>
        Agent Push presets can be configured at <a href="<c:url value='/agents.html?tab=agent.push'/>" target="_blank">Agent Push tab</a></span>
</td>
</tr>

<c:if test="${isServerWindows}">
    <c:forEach items="${presetsInfo.presets}" var="preset">
        <div id="${preset.id}_platform" style="display:none;">
                ${preset.platform}
        </div>
    </c:forEach>

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

    <c:if test="${isEulaAcceptRequired}">
        <tr class="noBorder" id="licenceAcceptingNoteContainer" style="display:none;">
            <td colspan="2">
                By pressing "Create" button you are accepting the
                <a showdiscardchangesmessage="false"
                   target="_blank"
                   href="http://technet.microsoft.com/en-us/sysinternals/bb469936.aspx">Sysinternals Software License
                    Terms</a>.
            </td>
        </tr>
    </c:if>
</c:if>
