<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
    %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
    %><%@ attribute name="prevent" required="true" type="java.lang.String"
    %><%@ attribute name="parentPrevent" required="false" type="java.lang.String"
    %>
<c:set var="effectivePrevent" value="${prevent == '' ? parentPrevent : prevent}"/>
<c:set var="text">
  <c:choose>
    <c:when test="${effectivePrevent == 'true'}">Prevent dependency artifacts cleanup</c:when>
    <c:when test="${effectivePrevent == 'false'}">Do not prevent dependency artifacts cleanup</c:when>
  </c:choose>
</c:set>
<c:if test="${parentPrevent != null and prevent == ''}"><span class="defaults">${text}</span></c:if>
<c:if test="${parentPrevent != null and prevent != ''}">${text}</c:if>
<c:if test="${parentPrevent == null}">${text}</c:if>
