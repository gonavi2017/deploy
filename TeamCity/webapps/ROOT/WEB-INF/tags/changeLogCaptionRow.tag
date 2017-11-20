<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="rowClass" required="false" %>
<%@ attribute name="rowId" required="false" %>
<c:choose>
  <c:when test="${empty rowId}">
    <tr class="${rowClass}">
  </c:when>
  <c:otherwise>
    <tr class="${rowClass}" id="${rowId}">
  </c:otherwise>
</c:choose>
  <td colspan="7">
    <div class="captionRow"><jsp:doBody/></div>
  </td>
</tr>