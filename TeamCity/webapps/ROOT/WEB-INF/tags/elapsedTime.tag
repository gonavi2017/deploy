<%@ tag import="jetbrains.buildServer.util.StringUtil" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    attribute name="time" type="java.util.Date" required="true" %><%@
    attribute name="includeTimestamp" type="java.lang.Boolean" required="false"
%><c:if test="${not empty time}"
  ><span title="<%=StringUtil.dateToString(time)%>" <c:if test="${includeTimestamp}">data="${time.time}"</c:if>><%=StringUtil.elapsedTimeToString(time)%></span></c:if>