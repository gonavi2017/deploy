     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
    %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
    %><%@ taglib prefix="queue" tagdir="/WEB-INF/tags/queue"%>
<%@attribute name="dependency" type="jetbrains.buildServer.serverSide.BuildPromotion" required="true" %>
<%@attribute name="dontShowProjectName" type="java.lang.Boolean" required="false" %>
<c:set var="startedBuild" value="${dependency.associatedBuild}"/>
<c:set var="queuedBuild" value="${dependency.queuedBuild}"/>
<c:choose>
  <c:when test="${not empty startedBuild}">
    <bs:buildRow build="${startedBuild}" showBranchName="true"  addLinkToBuildTypeName="true"  showBuildTypeName="true" showStatus="true" showBuildNumber="true"/>
  </c:when>
  <c:when test="${not empty queuedBuild}">
    <bs:queuedBuild queuedBuild="${queuedBuild}" showBranches="true" showBuildType="true" showNumber="true"/>
  </c:when>
  <c:otherwise>
    <td colspan="4"><i>Deleted build</i><!--build id: ${dependency.id}--></td>
  </c:otherwise>
</c:choose>
