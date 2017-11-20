<%@ tag import="jetbrains.buildServer.web.util.SessionUser" %>
<%@ tag import="jetbrains.buildServer.users.SimplePropertyKey" %>
<%@ tag import="jetbrains.buildServer.serverSide.TeamCityProperties" %>
<%@ tag import="jetbrains.buildServer.util.StringUtil" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>

<%
  String user_pages_css = SessionUser.getUser(request).getPropertyValue(new SimplePropertyKey("user.provided.pages.css"));
  if (StringUtil.isEmptyOrSpaces(user_pages_css)) {
    user_pages_css = TeamCityProperties.getProperty("teamcity.additional.pages.css");
  }
  if (StringUtil.isNotEmpty(user_pages_css)) {
    out.write("<style>");
    out.write(StringUtil.unquoteString(user_pages_css));
    out.write("</style>");
  }
%>