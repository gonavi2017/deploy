<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<%@attribute name="runner" type="jetbrains.buildServer.controllers.admin.projects.BuildRunnerBean" required="true" %>
<%@attribute name="stepno" required="false" %>
<div style="${not runner.enabled ? 'color: #888': ''}">
  <div class="stepName">
    <strong><c:if test="${not empty stepno}"><c:out value="${stepno}" />. </c:if><bs:makeBreakable text="${runner.displayName}" regex=".{60}"/></strong>
    <c:choose>
      <c:when test="${runner.inherited and not runner.enabled}">&nbsp;<span class="inheritedParam">(inherited, disabled)</span></c:when>
      <c:when test="${runner.inherited}">&nbsp;<span class="inheritedParam">(inherited)</span></c:when>
      <c:when test="${not runner.enabled}">&nbsp;<span class="inheritedParam">(disabled)</span></c:when>
    </c:choose>
    <br/>
  </div>
  <div class="stepDescription">
    <c:if test="${fn:length(runner.buildStepName) > 0}"><c:out value="${runner.runType.displayName}"/><br/></c:if>
    <bs:makeMultiline><bs:makeBreakable text="${runner.shortDescription}" regex=".{60}"/></bs:makeMultiline>
  </div>
  <div class="stepDescription">
    Execute: <c:out value="${runner.selectedExecutionPolicy.description}"/>
  </div>
</div>