<%@ include file="/include-internal.jsp"%>
<jsp:useBean id="project" type="jetbrains.buildServer.serverSide.SProject" scope="request"/>
<jsp:useBean id="oauthConnectionBean" type="jetbrains.buildServer.serverSide.oauth.OAuthConnectionBean" scope="request"/>
<jsp:useBean id="propertiesBean" type="jetbrains.buildServer.serverSide.oauth.OAuthConnectionBean" scope="request"/>
<style type="text/css">
  tr.githubNote table {
    width: 100%;
    border-spacing: 0;
  }

  tr.githubNote table td {
    padding: 1px 0 1px 0;
    border: none;
  }

  table.applicationUrls {
    padding: 4px;
  }
</style>
<c:if test="${empty oauthConnectionBean.connectionId}">
<tr class="githubNote">
  <td colspan="2">
    <div class="attentionComment">
      Please register OAuth consumer on <a href="https://bitbucket.org/" target="_blank">Bitbucket Cloud</a> using the following parameters:<br/>
      <table class="applicationUrls">
        <tr>
          <td>URL:</td>
          <td><span id="bitbucketHomeUrl"><c:out value="${serverSummary.rootURL}"/></span> <span class="clipboard-btn tc-icon icon16 tc-icon_copy" data-clipboard-action="copy" data-clipboard-target="#bitbucketHomeUrl"></span></td>
        </tr>
        <tr>
          <td>Callback URL:</td>
          <td><span id="bitbucketCallbackUrl"><c:out value="${serverSummary.rootURL}/oauth/bitbucket/"/></span> <span class="clipboard-btn tc-icon icon16 tc-icon_copy" data-clipboard-action="copy" data-clipboard-target="#bitbucketCallbackUrl"></span></td>
        </tr>
        <tr>
          <td>Permissions:</td>
          <td>Account: <strong>Read</strong>, Repositories: <strong>Read</strong></td>
        </tr>
      </table><br/>
      <script type="text/javascript">
        BS.Clipboard('.clipboard-btn');
      </script>

      And once registered, enter the <strong>key</strong> and the <strong>secret</strong> in the form below.
    </div>
  </td>
</tr>
</c:if>
<tr>
  <td><label for="displayName">Display name:</label><l:star/></td>
  <td>
    <props:textProperty name="displayName" style="width: 25em;"/>
    <span class="smallNote">Provide some name to distinguish this connection from others.</span>
    <span class="error" id="error_displayName"></span>
  </td>
</tr>
<tr>
  <td><label for="clientId">Key:</label><l:star/></td>
  <td>
    <props:textProperty name="clientId" style="width: 25em;"/>
    <span class="error" id="error_clientId"></span>
  </td>
</tr>
<tr>
  <td><label for="secure:clientSecret">Secret:</label><l:star/></td>
  <td>
    <props:passwordProperty name="secure:clientSecret" maxlength="80" style="width: 25em;"/>
    <span class="error" id="error_secure:clientSecret"></span>
  </td>
</tr>
