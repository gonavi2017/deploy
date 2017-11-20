<%@ include file="/include.jsp" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>

<jsp:useBean id="jabberSettings" scope="request" type="jetbrains.buildServer.controllers.jabber.SettingsBean"/>
<bs:linkCSS dynamic="${true}">
  /css/admin/adminMain.css
  /css/admin/serverConfig.css
  /plugins/jabber/css/jabberSettings.css
</bs:linkCSS>
<bs:linkScript>
  /js/bs/testConnection.js
  /plugins/jabber/js/editSettings.js
</bs:linkScript>
<script type="text/javascript">
  $j(function() {
    Jabber.SettingsForm.setupEventHandlers();
    $('server').focus();
  });
</script>

<c:url value="/jabber/notificatorSettings.html?edit=1" var="url"/>
<div id="settingsContainer">
  <form action="${url}'/>" method="post" onsubmit="return Jabber.SettingsForm.submitSettings()" autocomplete="off">
  <div class="editNotificatorSettingsPage">
  <c:choose>
    <c:when test="${jabberSettings.paused}">
      <div class="headerNote">
        <span class="icon icon16 build-status-icon build-status-icon_paused"></span>The notifier is <strong>disabled</strong>. All jabber notifications are suspended&nbsp;&nbsp;<a class="btn btn_mini" href="#" id="enable-btn">Enable</a>
      </div>
    </c:when>
    <c:otherwise>
      <div class="enableNote">
        The notifier is <strong>enabled</strong>&nbsp;&nbsp;<a class="btn btn_mini" href="#" id="disable-btn">Disable</a>
      </div>
    </c:otherwise>
  </c:choose>

  <bs:messages key="settingsSaved"/>
  <table class="runnerFormTable">
    <tr>
      <th><label for="server">Jabber server: <l:star/></label></th>
      <td>
        <forms:textField name="server" value="${jabberSettings.server}"/>
        <span class="error" id="errorServer"></span>
      </td>
    </tr>

    <tr>
      <th><label for="port">Server port: <l:star/></label></th>
      <td>
        <forms:textField name="port" value="${jabberSettings.port}" style="width:8em;" maxlength="60"/>
        <span class="error" id="errorPort"></span>
      </td>
    </tr>

    <tr>
      <th><label for="username1">Server user: <l:star/></label></th>
      <td>
        <forms:textField name="username1" value="${jabberSettings.username1}"/>
        <span class="error" id="errorUsername1"></span>
      </td>
    </tr>

    <tr>
      <th><label for="password1">Server user password: <l:star/></label></th>
      <td>
        <forms:passwordField name="password1" encryptedPassword="${jabberSettings.encryptedPassword1}"/>
        <span class="error" id="errorPassword"></span>
      </td>
    </tr>

    <tr>
      <th><label for="useLegacySSL">Use legacy SSL: </label></th>
      <td><forms:checkbox name="useLegacySSL" checked="${jabberSettings.useLegacySSL}"/>
    </tr>

    <tr class="noBorder">
      <td colspan="2">
        The templates for Jabber notifications
        <a target="_blank" href="<bs:helpUrlPrefix/>/Customizing+Notifications" showdiscardchangesmessage="false">can be customized</a>.
      </td>
    </tr>
  </table>

    <div class="saveButtonsBlock">
      <forms:submit type="submit" label="Save"/>
      <forms:submit id="testConnection" type="button" label="Test connection"/>
      <input type="hidden" id="submitSettings" name="submitSettings" value="store"/>
      <input type="hidden" name="testAddress" id="testAddress" value=""/>
      <input type="hidden" id="publicKey" name="publicKey" value="<c:out value='${jabberSettings.hexEncodedPublicKey}'/>"/>
      <forms:saving/>
    </div>
  </div>
  </form>
</div>

<bs:dialog dialogId="testConnectionDialog" title="Test Connection" closeCommand="BS.TestConnectionDialog.close();"
  closeAttrs="showdiscardchangesmessage='false'">
  <div id="testConnectionStatus"></div>
  <div id="testConnectionDetails" class="mono"></div>
</bs:dialog>
<forms:modified/>

<script type="text/javascript">
  (function($) {
    var sendAction = function(enable) {
      $.post("${url}&action=" + (enable ? 'enable' : 'disable'), function() {
        BS.reload(true);
      });
      return false;
    };

    $("#enable-btn").click(function() {
      return sendAction(true);
    });

    $("#disable-btn").click(function() {
      if (!confirm("Jabber notifications will not be sent until enabled. Disable the notifier?")) return false;
      return sendAction(false);
    })
  })(jQuery);
</script>
