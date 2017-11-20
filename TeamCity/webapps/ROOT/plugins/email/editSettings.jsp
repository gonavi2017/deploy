<%@ include file="/include.jsp" %>

<jsp:useBean id="emailSettings" scope="request" type="jetbrains.buildServer.controllers.email.SettingsBean"/>
<bs:linkCSS dynamic="${true}">
  /plugins/email/css/emailSettings.css
</bs:linkCSS>
<bs:linkScript>
  /js/bs/testConnection.js
  /plugins/email/js/editSettings.js
</bs:linkScript>

<script type="text/javascript">
  $j(function() {
    Email.SettingsForm.setupEventHandlers();
    $('hostname').focus();
  });
</script>

<c:url value="/email/notificatorSettings.html?edit=1" var="url"/>
<div id="settingsContainer">
  <form action="${url}" method="post" onsubmit="return Email.SettingsForm.submitSettings()" autocomplete="off">
  <div class="editNotificatorSettingsPage">
  <c:choose>
    <c:when test="${emailSettings.paused}">
      <div class="headerNote">
        <span class="icon icon16 build-status-icon build-status-icon_paused"></span>The notifier is <strong>disabled</strong>. All email notifications are suspended&nbsp;&nbsp;<a class="btn btn_mini" href="#" id="enable-btn">Enable</a>
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
        <th><label for="hostname">SMTP host: <l:star/></label></th>
        <td>
          <forms:textField name="hostname" value="${emailSettings.hostname}"/>
          <span class="error" id="errorHostname"></span>
        </td>
      </tr>
      <tr>
        <th><label for="port">SMTP port: <l:star/></label></th>
        <td>
          <forms:textField name="port" value="${emailSettings.port}" maxlength="60" className="textField_smtp-port"/>
          <span class="error" id="errorPort"></span>
        </td>
      </tr>

      <tr>
        <th><label for="emailFrom">Send email messages from: <l:star/></label></th>
        <td>
          <forms:textField name="emailFrom" value="${emailSettings.emailFrom}"/>
          <span class="error" id="errorEmailFrom"></span>
        </td>
      </tr>

      <tr>
        <th><label for="username1">SMTP login:</label></th>
        <td><forms:textField name="username1" value="${emailSettings.username1}"/></td>
      </tr>

      <tr>
        <th><label for="password1">SMTP password:</label></th>
        <td><forms:passwordField name="password1" encryptedPassword="${emailSettings.encryptedPassword1}"/></td>
      </tr>
      <tr>
        <th><label for="securityMode">Secure connection:</label></th>
        <td>
          <forms:select name="securityMode">
            <c:forEach var="item" items="${emailSettings.allSecurityModes}">
              <forms:option value="${item.value}" selected="${item == emailSettings.securityMode}"><c:out
                  value="${item.description}"/></forms:option>
            </c:forEach>
          </forms:select>
        </td>
      </tr>
      <tr class="noBorder">
        <td colspan="2">
          The templates for Email notifications
          <a target="_blank" href="<bs:helpUrlPrefix/>/Customizing+Notifications" showdiscardchangesmessage="false">can be customized</a>.
        </td>
      </tr>
    </table>

    <div class="saveButtonsBlock">
      <forms:submit label="Save"/>
      <forms:submit id="testConnection" type="button" label="Test connection"/>
      <input type="hidden" id="submitSettings" name="submitSettings" value="store"/>
      <input type="hidden" name="testAddress" id="testAddress" value=""/>
      <input type="hidden" id="publicKey" name="publicKey" value="<c:out value='${emailSettings.hexEncodedPublicKey}'/>"/>
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
      if (!confirm("E-mail notifications will not be sent until enabled. Disable the notifier?")) return false;
      return sendAction(false);
    });
  })(jQuery);
</script>
