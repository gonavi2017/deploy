<%@ tag import="jetbrains.buildServer.util.TimePrinter" %>
<%@ tag import="jetbrains.buildServer.web.util.WebUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@attribute name="value" type="java.lang.Integer" required="false"
  %>
<c:choose>
  <c:when test="${value < 0}">--</c:when>
  <c:otherwise>
<%
  final String s = TimePrinter.createMillisecondsFormatter().formatTime(value);
  out.write(s.replace("ms", "<small>ms</small>"));
%>
  </c:otherwise>
</c:choose>
