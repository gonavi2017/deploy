<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ attribute name="head_include" fragment="true"
  %><%@ attribute name="body_include" fragment="true"
  %><%@ attribute name="page_title" fragment="true"
  %><%@ tag body-content="empty"
  %><!DOCTYPE html>
<html>
<c:set var="pageTitle"><jsp:invoke fragment="page_title"/> &mdash; TeamCity</c:set>
<head>
  <title>${pageTitle}</title>
  <bs:XUACompatible/>
  <bs:pageMeta title="${pageTitle}"/>

  <bs:linkCSS>
    /css/FontAwesome/css/font-awesome.min.css
    /css/main.css
    /css/icons.css
  </bs:linkCSS>

  <bs:ua/>
  <bs:baseUri/>

  <bs:jquery/>
  <bs:prototype/>
  <bs:commonFrameworks/>

  <bs:predefinedIntProps/>

  <bs:linkScript>
    /js/bs/bs.js
    /js/bs/cookie.js
    /js/bs/position.js
    /js/bs/basePopup.js
    /js/bs/menuList.js
    /js/bs/bs-clipboard.js
  </bs:linkScript>

  <bs:encrypt/>

  <jsp:invoke fragment="head_include"/>

</head>

<body>

<jsp:invoke fragment="body_include"/>
</body>
</html>