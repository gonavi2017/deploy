<%@include file="/include-internal.jsp"%>
<%@ taglib prefix="clouds" tagdir="/WEB-INF/tags/clouds"  %>
<jsp:useBean id="form" type="jetbrains.buildServer.clouds.server.web.beans.CloudTabForm" scope="request"/>
<jsp:useBean id="pageUrl" scope="request" type="java.lang.String"/>
<bs:linkScript>
  /js/bs/blocks.js
  /js/bs/blocksWithHeader.js
</bs:linkScript>
<script type="text/javascript">
  BS.Clouds.registerRefresh();
</script>

<c:if test="${fn:length(form.selfProfiles) > 0}">
  <authz:authorize allPermissions="MANAGE_AGENT_CLOUDS">
  <div class="right_info_pane">
    <clouds:editProfilesNote/>
  </div>
  </authz:authorize>
</c:if>

<c:url value="/clouds/tab.html" var="refreshUrl"/>
<bs:refreshable containerId="cloudRefreshable" pageUrl="${refreshUrl}">
  <c:choose>
    <c:when test="${not form.disabled}">
      <jsp:include page="cloud-list.jsp"/>
    </c:when>
    <c:otherwise>
      <clouds:disabledWarning disabled="${form.disabled}"/>
    </c:otherwise>
  </c:choose>
</bs:refreshable>