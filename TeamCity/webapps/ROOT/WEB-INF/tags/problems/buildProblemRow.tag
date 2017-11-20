<%@ tag import="jetbrains.buildServer.serverSide.impl.problems.BuildProblemImpl" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="problems" tagdir="/WEB-INF/tags/problems" %>
<%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="util" uri="/WEB-INF/functions/util" %>

<%@ attribute name="buildProblemsBean" type="jetbrains.buildServer.web.problems.BuildProblemsBean" required="true" %>
<%@ attribute name="compactMode" type="java.lang.Boolean" required="true" %>
<%@ attribute name="showPopup" type="java.lang.Boolean" required="true" %>
<%@ attribute name="showLink" type="java.lang.Boolean" required="true" %>
<%@ attribute name="buildProblem" type="jetbrains.buildServer.serverSide.problems.BuildProblem" required="true" %>
<%@ attribute name="buildProblemType" type="java.lang.String" required="false" %>
<%@ attribute name="buildProblemListId" type="java.lang.String" required="true" %>
<c:set var="uid" value="${buildProblemListId}_${buildProblem.id}_${buildProblem.buildPromotion.id}"/>
<c:set var="isNew" value="<%=((BuildProblemImpl)buildProblem).isNew()%>"/>
<c:set var="requestProblemId" value='<%=request.getParameter("problemId")%>'/>
<c:set var="expand" value="${not compactMode and (((buildProblemsBean.hasOneBuildProblem or isNew) and not buildProblem.mutedInBuild) or buildProblem.id eq requestProblemId)}"/>
<div class="tcRow problemToHighlight problem${buildProblem.id}" data-id="${buildProblem.id}">
  <div class="tcCell" style="padding-left: 1em;">
    <span class="icons tcRight">
      <problems:buildProblemIcon currentMuteInfo="${buildProblem.currentMuteInfo}" showBuildSpecificInfo="${true}" buildProblem="${buildProblem}"/>
    </span><span class="description" id="bpd_${uid}">
      <problems:buildProblemDescription buildProblemUID="${uid}" buildProblem="${buildProblem}" showPopup="${showPopup}" showLink="${showLink}" compactMode="${compactMode}"
                                        buildProblemType="${buildProblemType}" invokeDescription="true"/>
    </span>
  </div>
  <div class="tcCell rightSideActions">
    <jsp:doBody/>
  </div>
  <div class="clear"></div>
</div>
<problems:buildProblemDescription buildProblemUID="${uid}" buildProblem="${buildProblem}" showPopup="${showPopup}" showLink="${showLink}" compactMode="${compactMode}"
                                  buildProblemType="${buildProblemType}" invokeDetails="true"/>
<problems:buildProblem buildProblem="${buildProblem}" compactMode="${compactMode}" buildProblemUID="${uid}" showExpanded="${expand}"/>


