<%@include file="/include-internal.jsp" %>
<%@ taglib prefix="clouds" tagdir="/WEB-INF/tags/clouds" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="form" type="jetbrains.buildServer.clouds.server.web.beans.CloudTabForm" scope="request"/>
<jsp:useBean id="pageUrl" scope="request" type="java.lang.String"/>
<jsp:useBean id="profileInfo" scope="request" type="jetbrains.buildServer.clouds.server.web.beans.CloudTabFormProfileInfo"/>
<jsp:useBean id="image" scope="request" type="jetbrains.buildServer.clouds.server.web.beans.CloudTabFormImageInfo"/>
<jsp:useBean id="instance" scope="request" type="jetbrains.buildServer.clouds.server.web.beans.CloudTabFormInstanceInfo"/>


<tr class="instance">
  <td class="noRightBorder instanceName <c:if test="${not instance.canManuallyTerminate}">instanceNameGrayed</c:if>">
    <span style="float:right;">Launched <bs:date value="${instance.instance.startedTime}"/></span>
    <c:if test="${not instance.hasError}">
      <clouds:imageState status="${instance.instance.status}"/>
    </c:if>
    <c:if test="${(instance.agent eq null) or not(instance.name eq instance.agent.name)}">
      <c:out value="${instance.name}"/> <br/>
    </c:if>
    <bs:agentDetailsFullLink agent="${instance.agent}" doNotShowOSIcon="${true}" doNotShowPoolInfo="${true}"  useDisplayName="${true}"/>
    <clouds:cloudProblemsLink controlId="error_${instance.id}" problems="${instance.problems}">
      Instance Error
    </clouds:cloudProblemsLink>
    <clouds:cloudProblemContent controlId="error_${instance.id}" problems="${instance.problems}"/>
  </td>
  <td class="buttons">
    <c:set var="showInstanceStatus" value="${true}"/>
    <authz:authorize anyPermission="START_STOP_CLOUD_AGENT" projectIds="${image.agentType.agentPool.projectIds}" checkGlobalPermissions="true">
      <c:if test="${instance.canManuallyTerminate}">
        <c:set var="showInstanceStatus" value="${false}"/>
        <div id="stopInstanceDiv_${instance.uniqueId}">
          <a href="#" onclick="BS.Clouds.stopInstance('<bs:forJs>${instance.uniqueId}</bs:forJs>','<bs:forJs>${profileInfo.id}</bs:forJs>', '<bs:forJs>${image.id}</bs:forJs>', '<bs:forJs>${instance.id}</bs:forJs>', <bs:forJs>${instance.runningBuild}</bs:forJs>); return false">Stop</a>
        </div>
        <div id="stoppingInstanceDiv_${instance.uniqueId}" style="display:none;">
          <forms:saving className="progressRingInline"/> Stopping...
        </div>
      </c:if>
    </authz:authorize>
    <c:if test="${showInstanceStatus}">
      <c:out value="${instance.statusText}"/>
    </c:if>
  </td>
</tr>