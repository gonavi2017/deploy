<%--no whitespace before page tag and <!DOCTYPE> --%><%@ include file="/include-internal.jsp"
    %><c:set var="title" value="Login to TeamCity"
    /><jsp:useBean id="publicKey" scope="request" type="java.lang.String"
    /><jsp:useBean id="loginDescription" scope="request" type="java.lang.String"
    /><jsp:useBean id="pluginName" scope="request" type="java.lang.String"
    /><bs:externalPage>
  <jsp:attribute name="page_title">${title}</jsp:attribute>
  <jsp:attribute name="head_include">
    <bs:linkCSS>
      /css/forms.css
      /css/initialPages.css
      /plugins/${pluginName}/css/notifierCommon.css
      /plugins/${pluginName}/css/notifierLogin.css
    </bs:linkCSS>
    <bs:ua/>
    <bs:baseUri/>
    <bs:linkScript>
      /js/crypt/rsa.js
      /js/crypt/jsbn.js
      /js/crypt/prng4.js
      /js/crypt/rng.js
      /js/bs/forms.js
      /js/bs/encrypt.js
      /js/bs/login.js
      /plugins/${pluginName}/js/extension.js
      /plugins/${pluginName}/js/login.js
    </bs:linkScript>
    <script type="text/javascript">
      $j(document).ready(function($) {
        if (BS.Cookie.get("__test") != "1") {
          $("#noCookiesEnabledMessage").show();
        }
        BS.Cookie.remove("__test");
      });
    </script>
  </jsp:attribute>

  <jsp:attribute name="body_include">

  <div id="container">
    <div id="header">
      <div class="actions">
        <a title="Close" class="close" href="#" onclick="Win32.Extension.closeMe(); return false;"><i class="icon-remove-sign"></i></a>
      </div>
      <div class="title" id="title">Login to TeamCity</div>
    </div>
    <script type="text/javascript">
      Win32.UpdateTitle('title', window['base_uri']);
    </script>

    <div class="panel">
      <div>
        <!-- redesign -->
        <div id="loginPage" class="initialPage notifierPage">

          <div id="pageContent" class="clearfix">
            <c:if test="${fn:length(loginDescription) > 0}">
              <p id="loginDescription"><c:out value="${loginDescription}"/></p>
            </c:if>

            <form action="<c:url value='/loginSubmit.html'/>" onsubmit="return BS.LoginForm.submitLogin();" method="post" class="clearfix">
              <table>
                <tr class="formField">
                  <th><label for="username">Username:</label></th>
                  <td><input class="text" id="username" type="text" name="username" style="width: 100%;"></td>
                </tr>
                <tr class="formField">
                  <th><label for="password">Password:</label></th>
                  <td><input class="text" id="password" type="password" name="password" style="width: 100%;"></td>
                </tr>
                <tr>
                  <th><forms:saving className="progressRingSubmitBlock"/></th>
                  <td><input class="btn submitButton" type="submit" name="submitLogin" value="Login"></td>
                </tr>
              </table>

              <input id="remember" type="hidden" name="remember" value="true">
              <input type="hidden" id="publicKey" name="publicKey" value="${publicKey}"/>
            </form>

            <div id="errorMessage"></div>

            <div id="noJavaScriptEnabledMessage" class="noJavaScriptEnabledMessage">
              Please enable JavaScript in your browser to proceed with login.
            </div>
            <script type="text/javascript">
              $("noJavaScriptEnabledMessage").hide();
            </script>

            <div id="noCookiesEnabledMessage" class="noCookiesEnabledMessage" style="display: none;">
              Please enable cookies in your browser to proceed with login.
            </div>

            <jsp:include page="/loginExtensions.html"/>
          </div>
        </div>
      </div>
      <div class="versionNumber"><bs:version/></div>
    </div>
  </div>
  </jsp:attribute>
</bs:externalPage>
