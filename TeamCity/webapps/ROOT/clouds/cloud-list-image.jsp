<%@include file="/include-internal.jsp" %>
<%@ taglib prefix="clouds" tagdir="/WEB-INF/tags/clouds" %>
<jsp:useBean id="form" type="jetbrains.buildServer.clouds.server.web.beans.CloudTabForm" scope="request"/>
<jsp:useBean id="pageUrl" scope="request" type="java.lang.String"/>
<jsp:useBean id="profileInfo" scope="request" type="jetbrains.buildServer.clouds.server.web.beans.CloudTabFormProfileInfo"/>
<jsp:useBean id="image" scope="request" type="jetbrains.buildServer.clouds.server.web.beans.CloudTabFormImageInfo"/>

<table class="cloudSettings">
  <tr class="image">
    <td class="noRightBorder">
      <c:set var="imageName"><c:out value="${image.name}"/></c:set>
      <c:choose>
        <c:when test="${not empty image.agentType}">
          <bs:agentDetailsFullLink agentType="${image.agentType}"
           imageWarningsText="${image.imageWarningsAsText}"
          >${imageName}</bs:agentDetailsFullLink>
        </c:when>
        <c:otherwise>${imageName}</c:otherwise>
      </c:choose>
      <c:if test="${not image.containsAgent}">
        <span <bs:tooltipAttrs width="350px" text="No agents connected after instance start. Please check the image has TeamCity agent configured and it can connect to the server using ${image.serverUrlForCreatingAgent} address. Start the instance manually to check for agent again."/> style="color:red; font-weight:bold;">(!)</span>
      </c:if>
      <clouds:cloudProblemsLink controlId="error_${image.uniqueId}" problems="${image.problems}">
        Image Error
      </clouds:cloudProblemsLink>
      <clouds:cloudProblemContent controlId="error_${image.uniqueId}" problems="${image.problems}"/>
    </td>
    <td class="buttons">
      <authz:authorize anyPermission="START_STOP_CLOUD_AGENT" projectIds="${image.agentType.agentPool.projectIds}" checkGlobalPermissions="true">
        <forms:saving id="startImageLoader_${image.uniqueId}" className="progressRingInline"/>
        <input id="startImageButton_${image.uniqueId}" type="button" class="btn btn_mini" value="Start"
               <c:if test="${not image.canStartMoreInstances}">disabled="disabled" title="${image.canNotStartMoreInstancesReason}" </c:if>
               onclick="return BS.Clouds.startInstance('<bs:forJs>${image.uniqueId}</bs:forJs>', '<bs:forJs>${profileInfo.id}</bs:forJs>', '<bs:forJs>${image.id}</bs:forJs>');"/>
      </authz:authorize>
    </td>
  </tr>
  <c:if test="${not image.hasErrors}">
    <bs:changeRequest key="image" value="${image.image}">
      <jsp:include page="/clouds/cloud-include-image-details.html"/>
    </bs:changeRequest>
  </c:if>
  <c:choose>
    <c:when test="${image.hasErrors}"> </c:when>
    <c:when test="${not empty image.instances}">
      <c:forEach items="${image.instances}" var="instance">
        
        <bs:changeRequest key="instance" value="${instance}">
          <jsp:include page="cloud-list-instance.jsp"/>
        </bs:changeRequest>
      </c:forEach>
    </c:when>
    <c:otherwise>
      <tr class="noInstance">
        <td class="instanceName" colspan="2">There are no running instances</td>
      </tr>
    </c:otherwise>
  </c:choose>
</table>