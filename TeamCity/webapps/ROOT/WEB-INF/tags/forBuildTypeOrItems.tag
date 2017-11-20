<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ attribute name="items" rtexprvalue="true" type="java.util.List" required="true"
  %>

<c:if test="${not empty buildType}">
  <jsp:doBody />
</c:if>

<c:forEach var="buildType" items="${items}">
  <c:set var="buildTypeId" value="${buildType.buildTypeId}" scope="request"/>
  <c:set var="buildType" value="${buildType}" scope="request"/>

  <jsp:doBody />

  <c:set var="buildTypeId" value="${null}" scope="request"/>
  <c:set var="buildType" value="${null}" scope="request"/>
</c:forEach>
