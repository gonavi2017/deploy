<%@ taglib prefix="props" uri="http://www.springframework.org/tags/form" %>
<%@ page import="jetbrains.buildServer.serverSide.oauth.github.GitHubAccessTokenController" %>
<%@ page import="jetbrains.buildServer.serverSide.oauth.github.GitHubConstants" %>
<%@ include file="/include-internal.jsp"%>
<jsp:useBean id="project" type="jetbrains.buildServer.serverSide.SProject" scope="request"/>
<jsp:useBean id="oauthConnectionBean" type="jetbrains.buildServer.serverSide.oauth.OAuthConnectionBean" scope="request"/>
<jsp:useBean id="propertiesBean" type="jetbrains.buildServer.serverSide.oauth.OAuthConnectionBean" scope="request"/>
<c:set var="callbackPath" value="<%=GitHubAccessTokenController.PATH%>"/>
<c:set var="defaultTokenScopeParam" value="<%=GitHubConstants.DEFAULT_TOKEN_SCOPE_PARAM%>"/>
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
      <c:choose>
        <c:when test="${oauthConnectionBean.providerType == 'GitHub'}">
          Please <a href="https://github.com/settings/applications/new" target="_blank">register TeamCity</a> on GitHub using the following parameters:<br/>
        </c:when>
        <c:otherwise>
          Please register TeamCity OAuth application on GitHub Enterprise server using the following parameters:<br/>
        </c:otherwise>
      </c:choose>
      <table class="applicationUrls">
        <tr>
          <td>Homepage URL:</td>
          <td>
            <span id="githubHomepageUrl"><c:out value="${serverSummary.rootURL}"/></span> <span class="clipboard-btn tc-icon icon16 tc-icon_copy" data-clipboard-action="copy" data-clipboard-target="#githubHomepageUrl"></span>
          </td>
        </tr>
        <tr>
          <td>Callback URL:</td>
          <td>
            <span id="githubCallbackUrl"><c:out value="${serverSummary.rootURL}${callbackPath}"/></span> <span class="clipboard-btn tc-icon icon16 tc-icon_copy" data-clipboard-action="copy" data-clipboard-target="#githubCallbackUrl"></span>
          </td>
        </tr>
      </table><br/>
      <script type="text/javascript">
        BS.Clipboard('.clipboard-btn');
      </script>
      <c:choose>
        <c:when test="${oauthConnectionBean.providerType == 'GitHub'}">
          And once registered, enter the <strong>client id</strong> and the <strong>client secret</strong> in the form below.
        </c:when>
        <c:otherwise>
          And once registered, enter the <strong>GitHub server URL</strong>, the <strong>client id</strong> and the <strong>client secret</strong> in the form below.
        </c:otherwise>
      </c:choose>
    </div>
  </td>
</tr>
</c:if>
<tr>
  <td><label for="displayName">Display name:</label><l:star/></td>
  <td>
    <props:textProperty name="displayName" className="longField"/>
    <span class="smallNote">Provide some name to distinguish this connection from others.</span>
    <span class="error" id="error_displayName"></span>
  </td>
</tr>
<c:choose>
  <c:when test="${oauthConnectionBean.providerType == 'GitHub'}">
  <tr>
    <td colspan="2" style="border: none; padding: 0; border-spacing: 0"><props:hiddenProperty name="gitHubUrl" /></td>
  </tr>
  </c:when>
  <c:otherwise>
    <tr>
      <td><label for="gitHubUrl">Server URL:</label><l:star/></td>
      <td>
        <props:textProperty name="gitHubUrl" className="longField"/>
        <span class="error" id="error_gitHubUrl"></span>
      </td>
    </tr>
  </c:otherwise>
</c:choose>
<tr>
  <td><label for="clientId">Client ID:</label><l:star/></td>
  <td>
    <props:textProperty name="clientId" className="longField"/>
    <span class="error" id="error_clientId"></span>
  </td>
</tr>
<tr>
  <td><label for="secure:clientSecret">Client secret:</label><l:star/></td>
  <td>
    <props:passwordProperty name="secure:clientSecret" maxlength="80" className="longField"/>
    <span class="error" id="error_secure:clientSecret"></span>

    <input type="hidden" name="prop:${defaultTokenScopeParam}" value="${propertiesBean.properties[defaultTokenScopeParam]}"/>
  </td>
</tr>
