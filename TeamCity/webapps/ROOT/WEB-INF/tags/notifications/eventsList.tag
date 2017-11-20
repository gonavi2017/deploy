<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@attribute name="rule" type="java.lang.Object" required="true" %>
<c:if test="${not empty rule.enabledEventsNames}">
  <ul class="elementList">
    <c:forEach items="${rule.enabledEventsNames}" var="event" varStatus="pos">
      <li>- ${event}</li>
    </c:forEach>
  </ul>
</c:if>
<c:if test="${empty rule.enabledEventsNames}">
  <p class="notificationsNotSent">Do not notify</p>
</c:if>
