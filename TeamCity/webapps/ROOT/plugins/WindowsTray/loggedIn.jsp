<%--no whitespace before page tag and <!DOCTYPE> --%><%@ include file="/include-internal.jsp"
    %><c:set var="title" value="Login to TeamCity"
    /><jsp:useBean id="userId" scope="request" type="java.lang.Long"
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
    <script type="text/javascript">
      Win32.Extension.setAuthorizedUser(${userId});
    </script>
    Logged in. <a href="<c:url value='/ajax.html?logout=1'/>">Logout</a>
  </jsp:attribute>
</bs:externalPage>
