<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ attribute name="val" fragment="false"
  %><%@ attribute name="addLineFeedIfEmpty" fragment="false" required="false" type="java.lang.Boolean"%>
<c:choose>
  <c:when test="${empty val}">
    <c:if test="${addLineFeedIfEmpty}"><br/></c:if> 
  </c:when>
  <c:otherwise>
    <c:set var="escapedVal" scope="request"><c:out value="${val}"/></c:set>
    <%=((String)request.getAttribute("escapedVal")).replace("\n", "<br/>\n")%>
  </c:otherwise>
</c:choose>
