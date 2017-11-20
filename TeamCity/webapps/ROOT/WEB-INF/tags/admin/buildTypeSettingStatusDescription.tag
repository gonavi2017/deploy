<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="inherited" required="true" type="java.lang.Boolean"%>
<%@ attribute name="disabled" required="true" type="java.lang.Boolean"%>
<%@ attribute name="overridden" required="true" type="java.lang.Boolean"%>
<%@ attribute name="inheritanceDescription" required="false" type="java.lang.String"%>
<c:set var="inheritedFrom" value="${empty inheritanceDescription ? 'inherited' : inheritanceDescription}"/>
<c:if test="${disabled or inherited}">
  <span class="inheritedParam">
    <c:choose>
      <c:when test="${not inherited}"><c:if test="${disabled}">(disabled)</c:if></c:when>
      <c:otherwise>
        <c:choose>
          <c:when test="${disabled and overridden}">(<c:out value="${inheritedFrom}" />, overridden, disabled)</c:when>
          <c:when test="${disabled and not overridden}">(<c:out value="${inheritedFrom}" />, disabled)</c:when>
          <c:when test="${overridden and not disabled}">(<c:out value="${inheritedFrom}" />, overridden)</c:when>
          <c:otherwise>(<c:out value="${inheritedFrom}" />)</c:otherwise>
        </c:choose>
      </c:otherwise>
    </c:choose>
  </span>
</c:if>
