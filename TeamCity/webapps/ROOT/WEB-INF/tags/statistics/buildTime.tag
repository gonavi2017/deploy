<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<%@ attribute name="time" rtexprvalue="true" type="java.math.BigDecimal" required="true" description="Build time in milliseconds" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="longTime" value="<%=time.longValue()%>"/>
<c:choose>
  <c:when test="${longTime>0}"><bs:printTime time="${longTime/1000}"/></c:when>
  <c:otherwise>0</c:otherwise>
</c:choose>