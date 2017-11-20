<%@ page import="jetbrains.buildServer.serverSide.oauth.tfs.TfsAccessTokenController" %>
<%@ include file="/include-internal.jsp"%>
<jsp:useBean id="params" class="jetbrains.buildServer.serverSide.oauth.tfs.TfsConstants"/>
<jsp:useBean id="project" type="jetbrains.buildServer.serverSide.SProject" scope="request"/>
<jsp:useBean id="oauthConnectionBean" type="jetbrains.buildServer.serverSide.oauth.OAuthConnectionBean" scope="request"/>
<jsp:useBean id="propertiesBean" type="jetbrains.buildServer.serverSide.oauth.OAuthConnectionBean" scope="request"/>
<c:set var="callbackPath" value="<%=TfsAccessTokenController.PATH%>"/>

<c:if test="${empty oauthConnectionBean.connectionId}">
<tr class="tfsNote">
  <td colspan="2">
    <div class="attentionComment">
      Please <a href="https://app.vssps.visualstudio.com/app/register" target="_blank">register TeamCity</a> on Visual Studio Team Services using the following parameters:<br/>
      <table class="applicationUrls">
        <tr>
          <td>Homepage URL:</td>
          <td>
            <span id="tfsHomepageUrl"><c:out value="${serverSummary.rootURL}"/></span> <span class="clipboard-btn tc-icon icon16 tc-icon_copy" data-clipboard-action="copy" data-clipboard-target="#tfsHomepageUrl"></span>
          </td>
        </tr>
        <tr>
          <td>Callback URL:</td>
          <td>
            <span id="tfsCallbackUrl"><c:out value="${serverSummary.rootURL}${callbackPath}"/></span> <span class="clipboard-btn tc-icon icon16 tc-icon_copy" data-clipboard-action="copy" data-clipboard-target="#tfsCallbackUrl"></span>
          </td>
        </tr>
        <tr>
          <td>Scope:</td>
          <td>
            <span>All scopes</span>
          </td>
        </tr>
      </table><br/>
      <script type="text/javascript">
        BS.Clipboard('.clipboard-btn');
      </script>
      And once registered, enter the <strong>App ID</strong> and the <strong>App Secret</strong> in the form below.
    </div>
  </td>
</tr>
</c:if>

<tr>
  <td><label for="${params.clientId}">App ID:</label><l:star/></td>
  <td>
    <props:textProperty name="${params.clientId}" className="longField"/>
    <span class="error" id="error_${params.clientId}"></span>
  </td>
</tr>
<tr>
  <td><label for="${params.clientSecret}">App Secret:</label><l:star/></td>
  <td>
    <props:textProperty name="${params.clientSecret}" className="longField"/>
    <span class="error" id="error_${params.clientSecret}"></span>
  </td>
</tr>
