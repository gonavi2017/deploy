<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="jetbrains.buildServer.resetPassword.ResetPasswordController" %>
<%@ page import="jetbrains.buildServer.controllers.PublicKeyUtil" %>
<%@ page import="jetbrains.buildServer.serverSide.crypt.RSACipher" %>
<%@ page import="jetbrains.buildServer.resetPassword.ForgotPasswordController" %>
<%@ page import="static jetbrains.buildServer.resetPassword.ForgotPasswordController.DISABLED_ERROR_MSG" %>
<%@ include file="/include-internal.jsp" %>
<c:set var="title" value="Reset password"/>
<c:set var="link"><%=ResetPasswordController.URL_PATH%></c:set>
<c:set var="forgetLink"><%=ForgotPasswordController.URL_PATH%></c:set>
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
      ${teamcityPluginResourcesPath}resetPassword.js
    </bs:linkScript>
    <style>
      #formNote {
        margin-top: 1em;
        font-weight: bold;
      }
    </style>
  </jsp:attribute>
  <jsp:attribute name="body_include">
    <bs:_loginPageDecoration id="loginPage" title="${title}">

        <c:choose>
           <c:when test="${!enabled}">
             <p id="formNote">
                 <c:set var="error" value="<%=DISABLED_ERROR_MSG%>"/>
                 <p>${error}</p>
             </p>
          </c:when>
           <c:when test="${token == null}">
             <p id="formNote">
               The reset password link has expired or is invalid. <br/>
               Try to <a href="<c:url value="${forgetLink}"/>">reset password</a> again.
             </p>
          </c:when>
          <c:otherwise>
            <%--@elvariable id="user" type="jetbrains.buildServer.users.SUser"--%>
            <div id="formNote">Please specify new password for the user '<c:out value="${user.extendedName}"/>'</div>

              <form class="loginForm" method="post" action="<c:url value="${link}"/>" onsubmit="BS.ResetPasswordForm.submit(); return false;">

                <table>
                  <tr class="formField">
                    <th><label for="password1">Password: <l:star/></label></th>
                    <td><input class="text" id="password1" type="password" name="password1" maxlength="80">
                    </td>
                  </tr>
                  <tr class="formField">
                    <th><label for="retypedPassword">Confirm password: <l:star/></label></th>
                    <td><input class="text" id="retypedPassword" type="password" name="retypedPassword" maxlength="80"></td>
                  </tr>
                  <tr>
                    <th class="loader-cell"><forms:saving className="progressRingSubmitBlock"/></th>
                    <td>
                      <noscript>
                        <div class="noJavaScriptEnabledMessage">
                          Please enable JavaScript in your browser to proceed with registration.
                        </div>
                      </noscript>

                      <input class="btn loginButton" type="submit" value="Submit"/>
                      <span class="error" id="resetError" style="margin-left: 0;"></span>
                    </td>
                  </tr>
                </table>

                <input type="hidden" id="token" name="token" value="${token}"/>
                <input type="hidden" id="publicKey" name="publicKey" value="<c:out value='<%=RSACipher.getHexEncodedPublicKey()%>'/>"/>

              </form>
              <script type="text/javascript">
                $j(document).ready(function($) {
                  $j("#password1").focus();
                });
              </script>
          </c:otherwise>
        </c:choose>
      <p class="registerUser">
        <span><a href="<c:url value='/login.html'/>">Login page</a></span>
      </p>
    </bs:_loginPageDecoration>
  </jsp:attribute>
</bs:externalPage>
