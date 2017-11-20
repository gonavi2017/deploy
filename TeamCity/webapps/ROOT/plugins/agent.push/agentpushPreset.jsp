<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="createPresetForm" type="jetbrains.buildServer.agentpush.web.forms.AgentPushPresetForm" scope="request"/>
<jsp:useBean id="action" type="jetbrains.buildServer.agentpush.web.controllers.actions.BaseAction" scope="request"/>

<div class="agentpushPresetDialogScrollable">
    <table class="runnerFormTable">
        <tr>
            <th><label for="presetName">Preset Name: <l:star/></label></th>
            <td>
                <forms:textField name="presetName" id="presetName"
                                 style="width:25em;"
                                 value="${createPresetForm.presetName}"/>
                <span id="errorPresetName" class="error"></span>
            </td>
        </tr>

        <tr class="noBorder">
            <th><label for="presetDescription">Description:</label></th>
            <td>
                <forms:textField name="presetDescription" id="presetDescription"
                                 style="width:25em;"
                                 value="${createPresetForm.presetDescription}"/>
            </td>
        </tr>
    </table>

    <c:set var="form" value="${createPresetForm}" scope="request"/>
    <jsp:include page="preset.jsp"/>
</div>

<div class="popupSaveButtonsBlock">
    <forms:submit label="${action.submitButtonCaption}"/>
    <forms:cancel onclick="BS.AgentPush.CreatePresetDialog.close()"/>
</div>
<div class="clr"></div>

