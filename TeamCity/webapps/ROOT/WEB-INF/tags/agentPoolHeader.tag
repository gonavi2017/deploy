<%@ tag import="jetbrains.buildServer.serverSide.agentPools.AgentPoolConstants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz"%>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ attribute name="pool" required="true" type="jetbrains.buildServer.controllers.agent.PoolBox"%>
<c:set var="poolId" value="${pool.agentPool.agentPoolId}"/>
<c:set var="nameCut" value="0"/>
<c:set var="poolName"><c:out value="${pool.name}"></c:out></c:set>
<c:set var="poolMinAgents"><c:out value="${pool.minAgents}"></c:out></c:set>
<c:set var="poolMaxAgents"><c:out value="${pool.maxAgents}"></c:out></c:set>
<c:set var="numProjects" value="${pool.projectsCount + pool.hiddenProjectCount}"/>
<span title="Click to expand/collapse this block" class="pool-name-title" id="pool-name-${poolId}"
      data-poolName="${poolName}" data-poolMinAgents="${poolMinAgents}" data-poolMaxAgents="${poolMaxAgents}"
><span class="pool-name"><c:if test="${pool.projectPool}"
><c:if test="${fn:endsWith(poolName, ' project')}"><c:set var="nameCut" value="${fn:length(' project')}"/></c:if
>${fn:substring(poolName, 0, fn:length(poolName)-nameCut)}<span style="font-weight: normal;"> project pool</span></c:if><c:if test="${not pool.projectPool}"
>${poolName}<span style="font-weight: normal;"> pool</span></c:if></span>
<span title="Click to expand/collapse this block" class="pool-numbers"><c:if
    test="${pool.cloudImagesCount > 0}">${pool.cloudImagesCount} cloud image<bs:s val="${pool.cloudImagesCount}"/>, </c:if
    >${pool.agentsCount} agent<bs:s val="${pool.agentsCount}"/><c:if
    test="${poolMinAgents > 0 or poolMaxAgents != -1}">
    (<c:if
    test="${poolMinAgents > 0}">min: ${poolMinAgents}</c:if><c:if
    test="${poolMinAgents > 0 and poolMaxAgents != -1}">, </c:if><c:if
    test="${poolMaxAgents != -1}">max: ${poolMaxAgents}</c:if>)</c:if>,
    ${numProjects} project<bs:s val="${numProjects}"/><c:if test="${pool.archivedProjectCount>0}">
<span title="Click to expand/collapse this block" class="info">(${pool.archivedProjectCount} archived)</span></c:if></span>
<authz:authorize allPermissions="MANAGE_AGENT_POOLS">
    <jsp:attribute name="ifAccessGranted">
      <c:if test="${poolId ne 0 and not pool.agentPool.projectPool}">
        <span class="pool-delete"><a href="#" onclick="BS.AP.confirmRemovePool(${poolId}); event.cancelBubble=true; return false">Delete</a></span>
        <span class="pool-rename"><a href="#" onclick="BS.AP.confirmRenamePool(${poolId}); event.cancelBubble=true; return false">Edit</a></span>
      </c:if>
    </jsp:attribute>
    <jsp:attribute name="ifAccessDenied">
    <c:if test="${poolId ne 0 && !pool.admin}">
      <c:set var="poolProjects" value="${pool.allProjects}"/>
      <c:set var="description">
        <c:choose>
          <c:when test="${pool.hiddenProjectCount > 0}">
            You don't have 'Change agent pools associated with project' permission in ${pool.hiddenProjectCount} project<bs:s val="${pool.hiddenProjectCount}"/>
          </c:when>
          <c:when test="${fn:length(poolProjects) == 0}">
            You don't have 'Change agent pools associated with project' permission
          </c:when>
          <c:otherwise>
            You don't have 'Change agent pools associated with project' permission in following projects:
            <c:forEach items="${pool.allProjects}" var="p" varStatus="pStatus">
              <c:if test="${!p.admin && p.associated}"><div><bs:projectLinkFull project="${p.project}"/></div></c:if>
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </c:set>
      <span class="pool-noEdit info">
        <bs:popup_static controlId="edit-${poolId}" linkOpensPopup="false" popup_options="delay: 0, shift: {x: 0, y: 20}">
          <jsp:attribute name="content">
              ${description}
          </jsp:attribute>
          <jsp:body>
            <span class="icon icon16 yellowTriangle"></span>&nbsp;You do not have enough permissions to edit this pool
          </jsp:body>
        </bs:popup_static>
      </span>
    </c:if>
    </jsp:attribute>
</authz:authorize>

