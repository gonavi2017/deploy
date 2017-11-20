<%@ tag import="jetbrains.buildServer.util.Dates"
%><%@ tag import="jetbrains.buildServer.web.util.WebUtil"
%><%@ tag import="jetbrains.buildServer.web.util.SessionUser"
%><%@attribute name="value" required="true" rtexprvalue="true" type="java.util.Date"
%><%@attribute name="pattern" required="false"
%><%@attribute name="timezone" required="false" type="java.util.TimeZone"
%><%
  if (pattern == null || pattern.trim().length() == 0) pattern = WebUtil.DEFAULT_WEB_DATE_FORMAT;
  if (timezone != null) {
    out.print(Dates.formatDate(value, pattern, timezone));
  } else {
    out.print(Dates.formatDate(value, pattern));
  }
%>