<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="problems" tagdir="/WEB-INF/tags/problems" %>
<%@ attribute name="buildProblemsBean" type="jetbrains.buildServer.web.problems.BuildProblemsBean" required="true" %>
<c:if test="${!buildProblemsBean.hasBuildFailureReasons}">
  <c:set var="mutedClass" value="muted red"/>
</c:if>
<span class="icon icon16 bp ${mutedClass}"></span>Build problems
<c:if test="${buildProblemsBean.hasNewBuildProblems}">&nbsp;(${buildProblemsBean.newBuildProblemsNumber} new)</c:if>