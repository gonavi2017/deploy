<%--no whitespace before page tag and <!DOCTYPE> --%><%@ include file="include-internal.jsp"
    %><jsp:useBean id="loginDescription" beanName="loginDescription" scope="request" type="java.lang.String"
    /><jsp:useBean id="canRegisterUsers" beanName="canRegisterUsers" scope="request" type="java.lang.Boolean"
    /><jsp:useBean id="guestLoginAllowed" beanName="guestLoginAllowed" scope="request" type="java.lang.Boolean"
    /><jsp:useBean id="publicKey" scope="request" type="java.lang.String"
    /><jsp:useBean id="unauthenticatedReason" scope="request" type="java.lang.String"
    /><jsp:useBean id="showNoAdminWarning" scope="request" type="java.lang.Boolean"
    /><jsp:useBean id="superUser" scope="request" type="java.lang.Boolean"
    /><c:set var="title" value="Log in to TeamCity"
    /><c:if test="${superUser}"><c:set var="title" value="Log in as Super user"/></c:if
    ><bs:externalPage>
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
      /js/aculo/effects.js
      /js/bs/forms.js
      /js/bs/encrypt.js
      /js/bs/login.js
    </bs:linkScript>
    <script type="text/javascript">
      $j(document).ready(function($) {
        var loginForm = $('.loginForm');

        $("#username").focus();

        loginForm.attr('action', '<c:url value='/loginSubmit.html'/>');
        loginForm.submit(function() {
          return BS.LoginForm.submitLogin();
        });

        if (BS.Cookie.get("__test") != "1") {
          $("#noCookiesEnabledMessage").show();
        }

        if ($('#fading').length > 0) {
          BS.Highlight('fading');
        }
      });
    </script>
  </jsp:attribute>
  <jsp:attribute name="body_include">
    <bs:_loginPageDecoration id="loginPage" title="${title}">
      <c:if test="${!superUser && fn:length(loginDescription) > 0}">
        <div class="loginDescription"><bs:out value="${loginDescription}"/></div>
      </c:if>

      <div id="errorMessage" <c:if test="${not empty unauthenticatedReason}">style="display: block;"</c:if>><bs:out value="${unauthenticatedReason}" multilineOnly="${true}"/></div>

      <c:if test="${showNoAdminWarning}">
         <div  class="icon_before icon16 attentionComment">
           No System Administrator found. <bs:help file="How+To..." anchor="RetrieveAdministratorPassword"/> <br/>
          Log in <a href="<c:url value='/login.html?super=1'/>"> as a Super user</a> to create an administrator account.
         </div>
      </c:if>

      <c:if test="${superUser}">
        <input type="hidden" id="username" name="username" value="">
      </c:if>

      <form class="loginForm" method="post">
        <c:if test="${!superUser}">
          <div>
            <label for="username">Username</label>
            <input class="text" id="username" type="text" name="username">
          </div>
        </c:if>

        <div>
          <label for="password"><c:choose><c:when test="${superUser}"
                >Authentication token: <bs:help file="Super+User"/></c:when
                ><c:otherwise>Password</c:otherwise
          ></c:choose></label>
          <input class="text" id="password" type="password" name="password" maxlength="80">
        </div>


        <div class="remember-section">
        <div  class="remember-section__inner"><forms:checkbox className="checkbox" id="remember" name="remember" checked="${intprop:getBooleanOrTrue('teamcity.user.rememberMe.checkedByDefault')}"/>
          <label class="rememberMe" for="remember">Remember me</label></div>

        <c:if test="${guestLoginAllowed}">
          <span class="greyNote"><a href="<c:url value='/guestLogin.html?guest=1'/>">Log in as guest</a>&nbsp;<bs:help file="User+Account"/></span>
        </c:if>
        </div>

        <noscript>
          <div class="noJavaScriptEnabledMessage">
            Please enable JavaScript in your browser to proceed with the login.
          </div>
        </noscript>

        <div id="noCookiesEnabledMessage" class="noCookiesEnabledMessage" style="display: none;">
          Please enable cookies in your browser to proceed with the login.
        </div>

        <div class="buttons">
          <input class="btn loginButton" type="submit" name="submitLogin" value="Log in">
          <div class="loader-cell"><forms:saving className="progressRingSubmitBlock"/></div>
        </div>

        <input type="hidden" id="publicKey" name="publicKey" value="${publicKey}"/>
        <c:if test="${superUser}">
          <input type="hidden" name="super" value="1"/>
        </c:if>
      </form>

      <c:if test="${!superUser}">
        <c:if test="${canRegisterUsers}">
          <p class="registerUser">
            <span><a href="<c:url value='/registerUser.html?init=1'/>">Register a new user account</a></span>
          </p>
        </c:if>

        <jsp:include page="/loginExtensions.html"/>
      </c:if>
    </bs:_loginPageDecoration>
  </jsp:attribute>
</bs:externalPage>
