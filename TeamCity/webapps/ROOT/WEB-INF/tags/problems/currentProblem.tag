<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="problems" tagdir="/WEB-INF/tags/problems" %>

<%@ attribute name="currentProblem" type="jetbrains.buildServer.serverSide.problems.CurrentBuildProblem" required="true" %>
<%@ attribute name="currentBuildType" type="jetbrains.buildServer.serverSide.SBuildType" required="true" %>

<c:set var="buildProblem" value="${currentProblem.instances[currentBuildType]}"/>
<c:set var="currentProject" value="${currentBuildType.project}"/>
<c:set var="bTypes" value="${currentProblem.buildTypes}"/>
<c:set var="btCount" value="${fn:length(bTypes)}"/>

<c:if test="${btCount == 2}">
<c:forEach var="bt" items="${bTypes}"><c:if test="${not (currentBuildType eq bt)}">Also in <bs:buildTypeLinkFull buildType="${bt}"/>&nbsp;&nbsp;</c:if></c:forEach>
</c:if>

<c:if test="${btCount > 2}">
<c:set var="problemId" value="${buildProblem.id}"/>
<c:set var="btId" value="${currentBuildType.buildTypeId}"/>
<c:set var="projId" value="${currentProject.projectId}"/>
Also reported in ${btCount - 1} more build configurations <bs:simplePopup controlId='bTypes_${problemId}_${btId}_${projId}' popup_options="shift: {x: -100, y: 20}">
  <jsp:attribute name="content">
    <span class="failedInPopup">
      <c:forEach var="bt" items="${bTypes}"><c:if test="${not (currentBuildType eq bt)}"><bs:buildTypeLinkFull buildType="${bt}"/><br/></c:if></c:forEach>
    </span>
  </jsp:attribute>
</bs:simplePopup>
</c:if>
