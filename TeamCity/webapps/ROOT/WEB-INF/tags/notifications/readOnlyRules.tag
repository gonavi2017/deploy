<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="n" tagdir="/WEB-INF/tags/notifications" %>
<%@attribute name="rules" type="java.util.Collection" required="true" %>
<table class="readOnlyRules">
  <tr style="background-color: #f5f5f5;">
    <th>Watching</th>
    <th>Send notification when</th>
  </tr>
  <c:forEach items="${rules}" var="rule">
  <tr>
    <td class="watchedBuilds">
      <n:watchedBuilds rule="${rule}"/>
    </td>
    <td class="events">
      <n:eventsList rule="${rule}"/>
    </td>
  </tr>
  </c:forEach>
</table>
