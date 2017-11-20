<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@
    taglib prefix="intprop" uri="/WEB-INF/functions/intprop"%><%@
    attribute name="title" required="true" %>
<link rel="Shortcut Icon" href="<c:url value="${intprop:getProperty('teamcity.ui.favicon.ico.url', '/favicon.ico?v10')}"/>" type="image/x-icon" sizes="16x16 32x32"/>
<%-- iOS - don't parse numbers as phone numbers --%>
<meta name="format-detection" content="telephone=no"/>
<%-- Google Chrome info and icons --%>
<meta name="application-name" content="TeamCity (<c:out value="${title}"/>)"/>
<meta name="description" content="Powerful Continuous Integration and Build Server"/>
<meta name="viewport" content="width=1000"/>
<%-- Safari 9 uses "apple-touch-icon" on favorites panel, in bookmarks and home screen on iOS --%>
<link rel="apple-touch-icon" sizes="57x57" href="<c:url value='/img/icons/apple-touch-icon-57x57.png'/>"/>
<link rel="apple-touch-icon" sizes="60x60" href="<c:url value='/img/icons/apple-touch-icon-60x60.png'/>"/>
<link rel="apple-touch-icon" sizes="72x72" href="<c:url value='/img/icons/apple-touch-icon-72x72.png'/>"/>
<link rel="apple-touch-icon" sizes="76x76" href="<c:url value='/img/icons/apple-touch-icon-76x76.png'/>"/>
<link rel="apple-touch-icon" sizes="114x114" href="<c:url value='/img/icons/apple-touch-icon-114x114.png'/>"/>
<link rel="apple-touch-icon" sizes="120x120" href="<c:url value='/img/icons/apple-touch-icon-120x120.png'/>"/>
<link rel="apple-touch-icon" sizes="144x144" href="<c:url value='/img/icons/apple-touch-icon-144x144.png'/>"/>
<link rel="apple-touch-icon" sizes="152x152" href="<c:url value='/img/icons/apple-touch-icon-152x152.png'/>"/>
<link rel="apple-touch-icon" sizes="180x180" href="<c:url value='/img/icons/apple-touch-icon-180x180.png'/>"/>
<%-- safari 9 pinned page icon --%>
<link rel="mask-icon" href="<c:url value="/img/icons/teamcity.black.svg?v2"/>" color="black"/>
<%-- MS tiles --%>
<meta name="msapplication-TileColor" content="#000000"/>
<%-- MS tiles --%>
<meta name="msapplication-TileImage" content="<c:url value="/img/icons/mstile-144x144.png"/>"/>
<meta name="msapplication-square70x70logo" content="<c:url value="/img/icons/mstile-70x70.png"/>"/>
<meta name="msapplication-square150x150logo" content="<c:url value="/img/icons/mstile-150x150.png"/>"/>
<meta name="msapplication-wide310x150logo" content="<c:url value="/img/icons/mstile-310x150.png"/>"/>
<meta name="msapplication-square310x310logo" content="<c:url value="/img/icons/mstile-310x310.png"/>"/>
<meta name="tc-csrf-token" content="${sessionScope['tc-csrf-token']}"/>