<%@ tag import="jetbrains.buildServer.util.TimePrinter" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@
    attribute name="duration" required="true" type="java.lang.Long" %><%
  final String s = TimePrinter.createMillisecondsFormatter().formatTime(duration);
  out.write(s.replace("ms", "<small>ms</small>"));
%>