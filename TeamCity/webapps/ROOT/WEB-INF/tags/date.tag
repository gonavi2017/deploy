<%@ tag import="java.util.Date"
  %><%@ tag import="jetbrains.buildServer.util.Dates"
  %><%@ tag import="jetbrains.buildServer.util.StringUtil"
  %><%@ tag import="jetbrains.buildServer.web.util.SessionUser"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@attribute name="value" required="true" rtexprvalue="true" type="java.util.Date"
  %><%@attribute name="no_span" required="false"
  %><%@attribute name="no_smart_title" required="false"
  %><%@attribute name="title_prefix" required="false"
  %><%@attribute name="smart" required="false" type="java.lang.String"
  %><%@attribute name="pattern"
  %><c:if test="${not empty value}"><c:set var="dateValue"><c:choose><c:when test="${smart == '2'}"><%
  String s;
  if (Dates.isDayChanged(new Date(), value)) {
    s = Dates.formatDate(value, "dd'&nbsp;'MMM'&nbsp;'yy", SessionUser.getUserTimeZone(request));
  }
  else {
    s = Dates.formatDate(value, "HH:mm", SessionUser.getUserTimeZone(request));
  }
  out.print(s);
%></c:when><c:when test="${not empty smart}"
  ><%
  out.print(StringUtil.elapsedTimeToString(value));
%></c:when><c:when test="${empty value}">Unknown</c:when><c:otherwise><bs:simpleDate value="${value}" pattern="${pattern}"/></c:otherwise></c:choose></c:set
  ><c:choose
    ><c:when test="${empty no_span}"
      ><c:set var="title"><c:choose
        ><c:when test="${empty no_smart_title}"><%=StringUtil.elapsedTimeToString(value)%></c:when
        ><c:otherwise><bs:simpleDate value="${value}" pattern="${pattern}"/></c:otherwise
      ></c:choose></c:set><span class="date" title="${empty title_prefix ? '' : title_prefix} ${title}">${dateValue}</span></c:when
    ><c:otherwise>${dateValue}</c:otherwise></c:choose></c:if>