<%@ include file="/include-internal.jsp"%>
<jsp:useBean id="cons" class="jetbrains.buildServer.serverSide.oauth.tfs.TfsConstants"/>
<jsp:useBean id="project" type="jetbrains.buildServer.serverSide.SProject" scope="request"/>
<jsp:useBean id="oauthConnectionBean" type="jetbrains.buildServer.serverSide.oauth.OAuthConnectionBean" scope="request"/>
<jsp:useBean id="propertiesBean" type="jetbrains.buildServer.serverSide.oauth.OAuthConnectionBean" scope="request"/>

<c:if test="${empty oauthConnectionBean.connectionId}">
<tr class="tfsNote">
  <td colspan="2">
    <div class="attentionComment">
      Please <a href="https://www.visualstudio.com/en-us/docs/setup-admin/team-services/use-personal-access-tokens-to-authenticate" target="_blank">create Personal Access Token</a>
      in your account with All scopes option.<br/>
      And after that, enter the <strong>Server URL</strong> and the <strong>Access Token</strong> in the form below.
    </div>
  </td>
</tr>
</c:if>

<tr>
  <td><label for="${cons.serverUrl}">Server URL:</label><l:star/></td>
  <td>
    <props:textProperty name="${cons.serverUrl}" className="longField"/>
    <span class="error" id="error_${cons.serverUrl}"></span>
    <span class="smallNote">
    <%--TFS 2017+: http[s]://{tfs-server}:{port}/tfs/{collection}<br/>--%>
    URL format: https://{account}.visualstudio.com</span>
  </td>
</tr>
<tr>
  <td><label for="${cons.accessToken}">Access Token:</label><l:star/></td>
  <td>
    <props:passwordProperty name="${cons.accessToken}" maxlength="80" className="longField"/>
    <span class="error" id="error_${cons.accessToken}"></span>
  </td>
</tr>