<%@ page import="jetbrains.buildServer.agentpush.web.AgentPushInfo" %>

<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions' %>
<%@ taglib prefix="util" uri="/WEB-INF/functions/util" %>

<jsp:useBean id="agentpushInfo" type="jetbrains.buildServer.agentpush.web.AgentPushInfo" scope="session"/>
<jsp:useBean id="presetsInfo" type="jetbrains.buildServer.agentpush.web.PresetsInfo" scope="request"/>
<jsp:useBean id="agentpushPathPrefix" type="java.lang.String" scope="request"/>
<jsp:useBean id="pageUrl" type="java.lang.String" scope="request"/>

<c:set var="pageTitle" value="Agent Push" scope="request"/>
<c:set var="presetAjaxUrl"><c:url value="/agentpushPreset.html"/></c:set>
<c:set var="installAjaxUrl"><c:url value="/agentpushInstall.html"/></c:set>

<c:set var="hasCriticalError"><%=AgentPushInfo.hasError()%>
</c:set>
<c:set var="criticalError"><%=AgentPushInfo.getError()%>
</c:set>

<c:set var="presets" value="${presetsInfo.presets}"/>

<c:if test="${hasCriticalError}">
    <div class="attentionComment" style="padding-bottom:10px;">
        ${criticalError}
    </div>
</c:if>

<p>Agent Push installs TeamCity agent to a remote host.<bs:help file="Setting+up+and+Running+Additional+Build+Agents" anchor="InstallingviaAgentPush"/> For usual agent installation use <a href="<c:url value='/agents.html'/>">Install Build Agents</a>.</p>

<c:set var="disabledAttr"><c:if test="${agentpushInfo.running}">disabled="disabled"</c:if></c:set>

<bs:refreshable containerId="agentpushProgress" pageUrl="${pageUrl}">
    <input class="btn" type="button" value="Install agent..."
           onclick="BS.AgentPush.installPreset(event)" ${disabledAttr}/>&nbsp;<c:if
        test="${agentpushInfo.running}"><forms:progressRing id="agentpushRunning"
                                                            style="${agentpushInfo.running ? 'display:inline;' : ''}"/>&nbsp;<c:if
        test="${agentpushInfo.cancelable}"><input type="button" value="Cancel" class="btn cancel"style="display:inline; float: none;"
                                                  onclick="BS.AgentPush.CancelInstallDialog.showDialog('<bs:forJs>${agentpushInfo.host}</bs:forJs>')"
        /></c:if></c:if><c:if
        test="${!agentpushInfo.running && agentpushInfo.preset != null && agentpushInfo.errors}"><input
        class="btn" type="button" value="Retry failed..." onclick="BS.AgentPush.restart(event, '${agentpushInfo.host}', '${agentpushInfo.preset.id}')"/></c:if>
    <p>
    <div class="mono mono-12px agentpushLog">
        <c:forEach items="${agentpushInfo.allMessages}" var="message">
            ${message}<br/>
        </c:forEach>
    </div>
    </p>
    <script type="text/javascript">
        BS.AgentPush.scheduleRefresh(${agentpushInfo.running});
    </script>
    <c:if test="${!agentpushInfo.running && agentpushInfo.preset != null && agentpushInfo.errors}">
        <input class="btn" type="button" value="Retry failed..."
               onclick="BS.AgentPush.restart(event, '${agentpushInfo.host}', '${agentpushInfo.preset.id}')"/>
    </c:if>
</bs:refreshable>

<c:choose>
    <c:when test="${not empty presets}">
        <l:tableWithHighlighting className="agentpushSettings" highlightImmediately="true">
            <tr class="header">
            <th colspan="3">Available Presets</th>
        </tr>
        <c:forEach var="pr" items="${presets}">
            <c:set var="onclick">BS.AgentPush.updatePreset(event, '<bs:forJs>${pr.id}</bs:forJs>');</c:set>
            <tr>
                <td class="highlight" title="<c:out value='${pr.description}'/>" onclick="${onclick}">
                    <c:out value="${pr.name}"/>
                    <c:if test="${not empty pr.description}">
                        <span style="color: #707070">(<c:out value="${pr.description}"/>)</span>
                    </c:if>
                </td>
                <td class="highlight edit"><a href="#" onclick="${onclick}; return false">edit</a></td>
                <td class="edit"><a href="#"
                                    onclick="BS.AgentPush.DeletePresetDialog.showDialog(${pr.id}, '${util:forJS(pr.name, true, true)}'); return false">delete</a>
                </td>
            </tr>
        </c:forEach>
    </l:tableWithHighlighting>
</c:when>
<c:otherwise>
    <p>Agent installation settings can be saved as a preset.</p>
</c:otherwise>
</c:choose>

<p>
    <forms:addButton onclick="return BS.AgentPush.createNewPreset(event); return false">Create new preset</forms:addButton>
</p>

<bs:modalDialog formId="createPresetForm"
                title="Agent Push preset"
                action="${presetAjaxUrl}"
                closeCommand="BS.AgentPush.CreatePresetDialog.close()"
                saveCommand="BS.AgentPush.CreatePresetDialog.submit()">
    <bs:refreshable containerId="createPresetFormMainRefresh" pageUrl="${presetAjaxUrl}"/>
</bs:modalDialog>

<bs:modalDialog formId="installPresetForm"
                title="Install agent"
                action="${installAjaxUrl}"
                closeCommand="BS.AgentPush.CreatePresetDialog.close()"
                saveCommand="BS.AgentPush.CreatePresetDialog.submit()">
    <bs:refreshable containerId="installPresetFormMainRefresh" pageUrl="${installAjaxUrl}"/>
</bs:modalDialog>

<bs:modalDialog formId="deletePresetForm"
                title="Delete preset"
                action="${presetAjaxUrl}"
                closeCommand="BS.AgentPush.DeletePresetDialog.close()"
                saveCommand="BS.AgentPush.DeletePresetDialog.submit()">
    Are you sure you want to delete "<span id="presetName"></span>"?
    <input type="hidden" name="presetId" id="presetId"/>

    <div class="popupSaveButtonsBlock">
        <forms:submit label="Delete"/>
        <forms:cancel onclick="BS.AgentPush.DeletePresetDialog.close(); return false" label="Cancel"/>
    </div>
</bs:modalDialog>

<bs:modalDialog formId="cancelInstallForm"
                title="Cancel agent installation"
                action="${presetAjaxUrl}"
                closeCommand="BS.AgentPush.CancelInstallDialog.close()"
                saveCommand="BS.AgentPush.CancelInstallDialog.submit()">
    Are you sure you want to cancel installing agent to "<span id="host"></span>"?
    <div class="popupSaveButtonsBlock">
        <forms:submit label="Yes"/>
        <forms:cancel onclick="BS.AgentPush.CancelInstallDialog.close(); return false" label="No"/>
    </div>
</bs:modalDialog>