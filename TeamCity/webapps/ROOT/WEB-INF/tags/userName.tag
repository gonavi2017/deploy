<%@ tag import="jetbrains.buildServer.users.User" %><%@
    tag import="jetbrains.buildServer.util.StringUtil" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    attribute name="server" type="jetbrains.buildServer.serverSide.SBuildServer" required="true" %><%@
    attribute name="userId" type="java.lang.Integer" required="true"
%><%
  User user = server.getUserModel().findUserById(userId);
  if (user == null) {
    out.write("unknown user");
  } else {
    out.write(StringUtil.escapeHTML(user.getDescriptiveName(), false));
  }
%>