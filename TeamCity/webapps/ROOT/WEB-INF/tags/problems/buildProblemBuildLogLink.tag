<%@ tag import="jetbrains.buildServer.BuildProblemDataEx" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>

<%@attribute name="buildData" type="jetbrains.buildServer.serverSide.SBuild" required="true" %>
<%@attribute name="buildProblem" type="jetbrains.buildServer.serverSide.problems.BuildProblem" required="true" %>

<c:set var="isBuildProblemEx" value="<%=(buildProblem.getBuildProblemData() instanceof BuildProblemDataEx)%>"/>

<c:if test="${isBuildProblemEx}">
  <c:set var="buildLogAnchor" value='<%=((BuildProblemDataEx)buildProblem.getBuildProblemData()).getBuildLogAnchor()%>'/>
  <c:if test="${not empty buildLogAnchor && buildLogAnchor > 0}">
    <bs:buildLogLink buildData="${buildData}" buildLogAnchor="${buildLogAnchor}"/>
  </c:if>
</c:if>

