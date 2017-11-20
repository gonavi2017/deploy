<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="form" type="jetbrains.buildServer.agentpush.web.forms.AgentPushBaseForm" scope="request"/>
<jsp:useBean id="action" type="jetbrains.buildServer.agentpush.web.controllers.actions.BaseAction" scope="request"/>

<c:set var="onChangePlatform"><%=request.getParameter("onChangePlatform")%></c:set>

<div>
    <table class="runnerFormTable">
        <tr>
            <th><label for="platform">Platform: <l:star/></label></th>
            <td>
                <select name="platform" id="platform" style="width: 25em"
                        onchange="BS.AgentPush.PresetForm.onPlatformChanged(); ${onChangePlatform}">
                    <forms:option value="" selected="${empty form.platform}">-- Choose platform --</forms:option>
                    <c:forEach items="${form.availablePlatforms}" var="plat">
                        <forms:option value="${plat}" selected="${form.platform eq plat}"><c:out
                                value="${plat}"/></forms:option>
                    </c:forEach>
                </select>
                <span class="error" id="errorPlatform"></span>
            </td>
        </tr>
        
        <tr id="installLocationContainer">
            <th><label for="installLocation">Install agent to: </label></th>
            <td>
                <forms:textField name="installLocation" id="installLocation" style="width:25em;"
                                 value="${form.installLocation}"/>
            </td>
        </tr>

        <tr id="ap_gt_1" class="groupingTitle">
            <td colspan="2">
                Credentials to push agent
            </td>
        </tr>

        <tr id="portContainer">
            <th><label for="port">SSH port:</label></th>
            <td>
                <forms:textField name="port" id="port" style="width:25em;"
                                 value="${form.port}"/>
                <div class="smallNote" style="margin: 0;">
                    Port to connect to, 22 by default.
                </div>
                <div class="smallNote" style="margin: 0;">
                    The port specified here can be overridden in the <b>Host</b> field, e.g. 'hostname.domain:2222'
                </div>
            </td>
        </tr>

        <tr id="authenticationSchemeContainer" style="display: none">
            <th>Authentication method:</th>
            <td>
                <forms:radioButton name="authenticationScheme" id="userAndPassword"
                                   checked="${form.authenticationScheme eq 'PASSWORD'}"
                                   onclick="BS.AgentPush.PresetForm.onAuthSchemeChanged();" value="PASSWORD"/>
                <label for="userAndPassword">Password</label><br/>

                <forms:radioButton name="authenticationScheme" id="keyFile"
                                   checked="${form.authenticationScheme eq 'KEY_FILE'}"
                                   onclick="BS.AgentPush.PresetForm.onAuthSchemeChanged();" value="KEY_FILE"/>
                <label for="keyFile">Private-Key</label><br/>

                <div class="smallNote" style="margin: 0;">
                    Choose appropriate
                    <a showdiscardchangesmessage="false"
                       target="_blank"
                       href="http://tools.ietf.org/html/rfc4252">
                        SSH user authentication method</a>.
                </div>
            </td>
        </tr>


        <tr id="userContainer">
            <th><label for="user">Username: <l:star/></label></th>
            <td>
                <forms:textField name="user" id="user" style="width:25em;"
                                 value="${form.user}"/>
                <span class="error" id="errorUser"></span>
            </td>
        </tr>

        <tr id="passwordWarningContainer" class="noBorder" style="display: none">
            <td colspan="2">
                <div class="attentionComment">
                    Password authentication should be enabled on the target machine
                </div>
            </td>
        </tr>

        <tr id="passwordContainer" style="display: none">
            <th><label for="password">Password: <l:star/></label></th>
            <td>
                <input type="password" id="password" name="password" style="width:25em;" value="${form.password}"/>
                <span class="error" id="errorPassword"></span>
            </td>
        </tr>

        <tr id="keyFilePathContainer" style="display: none">
            <th><label for="keyFilePath">Private key file: <l:star/></label></th>
            <td>
                <forms:textField name="keyFilePath" id="keyFilePath" style="width:25em;"
                                 value="${form.keyFilePath}"/>
                <span class="error" id="errorKeyFilePath"></span>
                <div class="smallNote" style="margin: 0;">
                    Path to the private key file on server.
                </div>
            </td>
        </tr>

        <tr id="passphraseContainer" style="display: none">
            <th><label for="passphrase">Passphrase:</label></th>
            <td>
                <input type="password" id="passphrase" name="passphrase" style="width:25em;"
                       value="${form.passphrase}"/>
            </td>
        </tr>

        <tr id="ap_gt_2" class="groupingTitle">
            <td colspan="2" id="runtimeGroupingTitle">
                <%--Dymanically updatable. Depends on platform--%>
            </td>
        </tr>

        <tr id="runtimeUserContainer">
            <th><label for="runtimeUser">Username: </label></th>
            <td>
                <forms:textField name="runtimeUser" id="runtimeUser" style="width:25em;" value="${form.runtimeUser}"/>
                <div id="runtimeUserNoteWindows" class="smallNote" style="margin: 0;">
                    The Agent will run under 'LocalSystem' account if omitted.
                </div>
                <div id="runtimeUserNoteUnix" class="smallNote" style="margin: 0;">
                    The Agent will run under same account if omitted.
                </div>
            </td>
        </tr>
        <tr id="runtimePasswordContainer">
            <th><label for="runtimePassword">Password:</label></th>
            <td>
                <input type="password" id="runtimePassword" name="runtimePassword" style="width:25em;" value="${form.runtimePassword}"/>
            </td>
        </tr>
        
    </table>

    <input type="hidden" id="action" name="action" value="${action.actionName}"/>
    <c:if test="${not empty form.presetId}">
        <input type="hidden" id="presetId" name="presetId" value="${form.presetId}"/>
    </c:if>
    <input type="hidden" id="encryptedPassword" name="encryptedPassword" value=""/>
    <input type="hidden" id="encryptedPassphrase" name="encryptedPassphrase" value=""/>
    <input type="hidden" id="encryptedRuntimePassword" name="encryptedRuntimePassword" value=""/>    
    <input type="hidden" id="publicKey" name="publicKey"
           value="<c:out value='${form.hexEncodedPublicKey}'/>"/>


    <script type="text/javascript">
        BS.AgentPush.PresetForm.onPlatformChanged();
    </script>
</div>