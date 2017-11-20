<%@ tag import="jetbrains.buildServer.web.util.WebUtil" %>
<%@ attribute name="buildTypeId" required="true" type="java.lang.String"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="tags" tagdir="/WEB-INF/tags/tags"
  %><%@ attribute name="tag" required="true" type="java.lang.String"
  %><%@ attribute name="onclick" type="java.lang.String"
  %><%@ attribute name="markAsPrivate" type="java.lang.Boolean"
  %><%@ attribute name="selected" required="true" type="java.lang.Boolean"
  %><c:set var="escapedTag" value="<%=WebUtil.encode(tag)%>"/><c:url var="url" value="/viewType.html?buildTypeId=${buildTypeId}&tab=buildTypeHistoryList&${markAsPrivate ? 'privateTag=' : 'tag='}${escapedTag}"/>
<tags:printTag tag="${tag}" selected="${selected}" markAsPrivate="${markAsPrivate}" href="${url}" onclick="${onclick}"/>