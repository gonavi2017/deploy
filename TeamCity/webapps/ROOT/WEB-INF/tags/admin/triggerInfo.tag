<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<%@attribute name="trigger" type="jetbrains.buildServer.controllers.admin.projects.BuildTriggerInfo" required="true" %>
<%@attribute name="showName" type="java.lang.Boolean" %>
<%@attribute name="showDescription" type="java.lang.Boolean" %>
<div style="${not trigger.enabled ? 'color: #888': ''}">
  <c:if test="${empty showName or showName}">
    <div class="triggerName">
      <c:out value="${trigger.buildTriggerService.displayName}"/>
      <admin:buildTypeSettingStatusDescription inherited="${trigger.inherited}" disabled="${not trigger.enabled}" overridden="${trigger.overridden}" />
    </div>
  </c:if>
  <c:if test="${empty showDescription or showDescription}">
  <div class="triggerDescription">
    <bs:out value="${trigger.description}"/>
  </div>
  </c:if>
</div>