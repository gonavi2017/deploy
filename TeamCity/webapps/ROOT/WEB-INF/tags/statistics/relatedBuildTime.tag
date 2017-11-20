<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<%@ attribute name="time" rtexprvalue="true" type="java.math.BigDecimal" required="true" description="Build time in milliseconds" %>
<%@ attribute name="total" rtexprvalue="true" type="java.math.BigDecimal" required="true" description="Build time in milliseconds" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:choose>
  <c:when test="${total.longValue()>0}">
    <fmt:formatNumber value="${(time.longValue()/total.longValue())*100}" maxFractionDigits="2" minFractionDigits="2"/>%</c:when>
  <c:otherwise>-</c:otherwise>
</c:choose>