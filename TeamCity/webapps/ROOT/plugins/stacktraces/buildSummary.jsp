<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %>
<%--@elvariable id="threadDumpTargetAgent" type="jetbrains.buildServer.serverSide.SBuildAgent"--%>
<%--@elvariable id="threadDumpBuild" type="jetbrains.buildServer.serverSide.SRunningBuild"--%>
<c:set var="buildType" value="${threadDumpBuild.buildType}"/>
<c:if test="${not empty buildType}">
<authz:authorize projectId="${threadDumpBuild.projectId}" allPermissions="VIEW_FILE_CONTENT">
<c:if test="${not empty threadDumpTargetAgent}">
  <tr>
  <td class="st labels">Thread dump:</td>
  <td colspan="3" class="st">
    <c:choose>
      <c:when test="${threadDumpTargetAgent.registered}">
        <c:url value="/stacktraces/stacktrace.html?agentId=${threadDumpTargetAgent.id}&projectId=${buildType.projectExternalId}" var="threadDumpUrl"/>
        <a href="#" onclick="BS.Util.popupWindow('${threadDumpUrl}', 'agent_${threadDumpTargetAgent.id}'); return false">View thread dump</a>
      </c:when>
      <c:otherwise>
        <i>thread dumps are available for connected agents only</i>
      </c:otherwise>
    </c:choose>
  </td>
  </tr>
</c:if>
</authz:authorize>
</c:if>