<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ attribute name="value" required="true" rtexprvalue="true"
  %><%@ attribute name="total" required="true" rtexprvalue="true"
  %><%@ attribute name="fractionDigits" required="false" type="java.lang.Integer"
  %><%@ attribute name="parenths" required="false" type="java.lang.Boolean"
  %><c:if test="${not empty parenths and parenths}">(</c:if
  ><c:choose
    ><c:when test="${total > 0}"><c:set var="result"
     ><fmt:formatNumber
       maxFractionDigits="${fractionDigits == null ? 1 : fractionDigits}"
       value="${value / total * 100}"/>%</c:set><c:out value="${fn:trim(result)}"/></c:when
  ><c:otherwise>100%</c:otherwise></c:choose><c:if test="${not empty parenths and parenths}">)</c:if>