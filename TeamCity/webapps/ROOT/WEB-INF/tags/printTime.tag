<%@ tag import="jetbrains.buildServer.util.TimePrinter"%><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ attribute name="time" rtexprvalue="true" type="java.lang.Long" required="true"
%><%@ attribute name="showIfNotPositiveTime" required="false" %><%
%><%@ attribute name="alwaysIncludeSeconds" required="false" type="java.lang.Boolean"%><%
  if (showIfNotPositiveTime != null && time <= 0) {
    out.write(showIfNotPositiveTime);
  } else {
    final StringBuilder sb = new StringBuilder();
    TimePrinter.createSecondsFormatter(alwaysIncludeSeconds != null ? alwaysIncludeSeconds.booleanValue() : false).formatTime(sb, time.longValue());
    out.write(sb.toString());
  }
%>