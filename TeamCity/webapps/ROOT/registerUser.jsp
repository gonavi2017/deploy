<%--@elvariable id="serverSummary" type="jetbrains.buildServer.web.openapi.ServerSummary"--%>
<%@ include file="include-internal.jsp" %>
<c:set var="title" value="Register a New User Account"/>
<jsp:useBean id="registerUserForm" type="jetbrains.buildServer.controllers.user.NewUserForm" scope="request"/>
<bs:externalPage>
  <jsp:attribute name="page_title">${title}</jsp:attribute>
  <jsp:attribute name="head_include">
    <bs:linkCSS>
      /css/forms.css
      /css/maintenance-initialPages-common.css
      /css/initialPages.css
    </bs:linkCSS>
    <bs:ua/>
    <bs:linkScript>
      /js/crypt/rsa.js
      /js/crypt/jsbn.js
      /js/crypt/prng4.js
      /js/crypt/rng.js
      /js/bs/forms.js
      /js/bs/encrypt.js
      /js/bs/createUser.js
    </bs:linkScript>
    <script type="text/javascript">
      $j(document).ready(function($) {
        var loginForm = $('.loginForm');

        $("#username").focus();

        loginForm.attr('action', '<c:url value='/registerUserSubmit.html'/>');
        loginForm.submit(function() {
          return BS.CreateUserForm.submitCreateUser();
        });
      });
    </script>
  </jsp:attribute>
  <jsp:attribute name="body_include">
    <bs:_loginPageDecoration id="registerUserPage" title="${title}">
        <form class="loginForm" method="post">

          <div id="errorMessage"></div>
          <div>
            <label for="input_teamcityUsername">Username</label>
            <span class="input-wrapper input-wrapper_username"><input class="text" id="input_teamcityUsername" type="text" name="username1"/></span>
          </div>
          <c:if test="${registerUserForm.emailIsMandatory}">
            <div>
              <label for="input_teamcityEmail">Email</label>
              <span class="input-wrapper input-wrapper_email"><input class="text" id="input_teamcityEmail" type="text" name="email" maxlength="80" value="${suggestedEmail}"></span>
            </div>
          </c:if>
          <div>
            <label for="password1">Password</label>
            <span class="input-wrapper input-wrapper_password1"><input class="text" id="password1" type="password" name="password1" maxlength="80"></span>
          </div>
          <div>
            <label for="retypedPassword">Confirm password</label>
            <input class="text" id="retypedPassword" type="password" name="retypedPassword" maxlength="80">
          </div>

          <noscript>
            <div class="noJavaScriptEnabledMessage">
              Please enable JavaScript in your browser to proceed with registration.
            </div>
          </noscript>

          <div class="buttons">
            <input class="btn loginButton" type="submit" value="Register"/>
            <div class="loader-cell"><forms:saving className="progressRingSubmitBlock"/></div>
            <p><a class="loginButton" href="<c:url value='/login.html'/>">Login page</a></p>
          </div>

          <input type="hidden" id="submitCreateUser" name="submitCreateUser"/>
          <input type="hidden" id="publicKey" name="publicKey" value="${registerUserForm.hexEncodedPublicKey}"/>
        </form>
    </bs:_loginPageDecoration>
  </jsp:attribute>
</bs:externalPage>
