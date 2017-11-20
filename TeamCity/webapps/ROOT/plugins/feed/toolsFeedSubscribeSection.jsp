<%@ page import="jetbrains.buildServer.web.util.WebUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="feedCustomizeLink" type="java.lang.String" scope="request"/>
<jsp:useBean id="feedPluginResourcesPath" type="java.lang.String" scope="request"/>
<jsp:useBean id="pageUrl" type="java.lang.String" scope="request"/>
<c:set var="feed_encodedCameFrom" value="<%=WebUtil.encode(pageUrl)%>"/>

<style type="text/css">
  p.toolTitle.feed {
    background-image: url("<c:url value="${feedPluginResourcesPath}"/>feed-icon.svg");
    background-repeat: no-repeat;
    background-size: 16px;
  }
</style>
<p class="toolTitle feed">Syndication Feed</p>
<a showdiscardchangesmessage="false" href="${feedCustomizeLink}?cameFromUrl=${feed_encodedCameFrom}">customize</a>
