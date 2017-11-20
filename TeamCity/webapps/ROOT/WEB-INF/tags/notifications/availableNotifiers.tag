<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@attribute name="urlPattern" required="true" %><!-- url with placeholder for notifierType, placeholder is ##notifierType## -->
<%@attribute name="selectedNotifier" required="true" %>
<%@attribute name="availableNotifiersBean" required="true" type="jetbrains.buildServer.controllers.profile.notifications.AvailableNotifiersBean" %>
<div class="notifierChooser">
  <c:set var="rulesMap" value="${availableNotifiersBean.notificationRulesMap}"/>
  <c:set var="numInheritedRulesMap" value="${availableNotifiersBean.numberOfInheritedRulesMap}"/>
  <c:forEach items="${availableNotifiersBean.availableNotifiers}" var="notifier" varStatus="pos">
    <c:set var="numDirect" value="${fn:length(rulesMap[notifier.notificatorType])}"/>
    <c:set var="numInherited" value="${numInheritedRulesMap[notifier.notificatorType]}"/>
    <c:choose>
      <c:when test="${numDirect + numInherited == 0}"><c:set var="numRules" value="(0)"/></c:when>
      <c:when test="${numInherited == 0}"><c:set var="numRules" value="(${numDirect})"/></c:when>
      <c:otherwise><c:set var="numRules" value="(${numDirect}/${numInherited})"/></c:otherwise>
    </c:choose>
    <c:choose>
      <c:when test="${selectedNotifier == notifier.notificatorType}"><strong><c:out value="${notifier.displayName}"/> ${numRules}</strong></c:when>
      <c:otherwise>
        <c:set var="url" value="${fn:replace(urlPattern, '##notifierType##', notifier.notificatorType)}"/>
        <a href="${url}"><c:out value="${notifier.displayName}"/> ${numRules}</a>
      </c:otherwise>
    </c:choose>
    <c:if test="${not pos.last}"><span class="separator">|</span></c:if>
  </c:forEach>
</div>
