<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="problems" tagdir="/WEB-INF/tags/problems" %>

<%@ attribute name="projectBuildProblemsBean" type="jetbrains.buildServer.web.problems.ProjectBuildProblemsBean" required="true" %>

<c:if test="${not empty projectBuildProblemsBean and projectBuildProblemsBean.buildProblemsNumber > 0}">
  <problems:buildProblemStylesAndScripts/>

  <c:set var="title"><span class="icon icon16 bp muted"></span> Muted build problems:</c:set>
  <bs:_collapsibleBlock title="${title}" id="buildProblemMutes" collapsedByDefault="false">
      <problems:buildProblemExpandCollapse showExpandCollapseActions="true">
        <problems:buildProblemGroupByProject projectBuildProblemsBean="${projectBuildProblemsBean}" inlineMuteInfo="${true}">
        </problems:buildProblemGroupByProject>
      </problems:buildProblemExpandCollapse>
  </bs:_collapsibleBlock>
</c:if>
