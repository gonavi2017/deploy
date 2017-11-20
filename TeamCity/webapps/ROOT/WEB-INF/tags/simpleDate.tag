<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ tag import="jetbrains.buildServer.web.util.SessionUser"
%><%@attribute name="value" required="true" rtexprvalue="true" type="java.util.Date"
%><%@attribute name="pattern" required="false"
%><bs:formatDate pattern="${pattern}" timezone="<%=SessionUser.getUserTimeZone(request)%>" value="${value}"/>