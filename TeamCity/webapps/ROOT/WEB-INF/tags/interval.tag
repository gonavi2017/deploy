<%@ tag import="jetbrains.buildServer.util.Dates"
  %><%@ tag import="jetbrains.buildServer.web.util.SessionUser"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@attribute name="from" required="true" rtexprvalue="true" type="java.util.Date"
  %><%@attribute name="to" required="true" rtexprvalue="true" type="java.util.Date"
  %><%
  out.print(Dates.formatInterval(from, to, SessionUser.getUserTimeZone(request)));
%>