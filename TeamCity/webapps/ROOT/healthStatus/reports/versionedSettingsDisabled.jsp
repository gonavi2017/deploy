<%@include file="/include-internal.jsp"%>
<%@ page import="jetbrains.buildServer.web.openapi.healthStatus.HealthStatusItemDisplayMode" %>
<jsp:useBean id="showMode" type="jetbrains.buildServer.web.openapi.healthStatus.HealthStatusItemDisplayMode" scope="request"/>
<jsp:useBean id="healthStatusItem" type="jetbrains.buildServer.serverSide.healthStatus.HealthStatusItem" scope="request"/>
<jsp:useBean id="pageUrl" type="java.lang.String" scope="request"/>
<c:set var="inplaceMode" value="<%=HealthStatusItemDisplayMode.IN_PLACE%>"/>
<c:set var="reason" value="${healthStatusItem.additionalData['reason']}"/>
<script type="text/javascript">
  enableVersionedSettings = function() {
    if (!confirm('Enabling versioned settings will commit project configs to VCS, do you want to continue?'))
      return;
    $j('#enablingVersionedSettings').show();
    BS.ajaxRequest('<c:url value="/admin/versionedSettingsActions.html"/>', {
      parameters: Object.toQueryString({action: 'enableVersionedSettings'}),
      onComplete: function(transport) {
        BS.XMLResponse.processErrors(transport.responseXML, {}, function(id, elem) {
          alert(elem.firstChild.nodeValue);
        });
        BS.reload();
      }
    });
  };
</script>
<c:set var="serverAdmin" value="${afn:permissionGrantedGlobally('CHANGE_SERVER_SETTINGS')}"/>
<c:set var="msg">
  Versioned settings are globally disabled on the server, reason: <c:out value="${reason}"/>.
  <bs:helpLink file="Storing+Project+Settings+in+Version+Control" anchor="enableAfterUpgrade"><bs:helpIcon/></bs:helpLink>
</c:set>
<c:choose>
  <c:when test="${showMode == inplaceMode}">${msg}</c:when>
  <c:otherwise><div>${msg}</div></c:otherwise>
</c:choose>
<c:if test="${serverAdmin}">
  <div style="margin-top: 0.5em;">
    <c:choose>
      <c:when test="${empty projects}">
        Versioned settings are not used on the server and can be safely enabled.
      </c:when>
      <c:otherwise>
        If this is the main server, click "Enable" to commit the current server settings to VCS.
      </c:otherwise>
    </c:choose>

    <input type="button" class="btn btn_mini" value="Enable" onclick="enableVersionedSettings()"/>
    <forms:saving id="enablingVersionedSettings" style="float: none; margin-left: 0.5em;"/>
  </div>
  <c:if test="${not empty insecureProjects}">
  <div style="margin-top: 0.5em;">
    Note: <a href="javascript:;" onclick="$j('#disabledVsettingsAffectedProjects_${showMode}').toggle()">some of the projects</a> have secure values (passwords or API tokens) in their configuration files.
    Before enabling versioned settings, it is recommended to change versioned settings configuration for these projects to store secure values outside of VCS.
  </div>
  </c:if>
</c:if>
<c:if test="${not empty projects}">
  <div style="margin-top: 0.5em;">
    <a href="javascript:;" onclick="$j('#disabledVsettingsAffectedProjects_${showMode}').toggle()">Show ${fn:length(projects)} affected project<bs:s val="${fn:length(projects)}"/> &raquo;</a>
  </div>
  <div id="disabledVsettingsAffectedProjects_${showMode}" style="display: none; margin-left: 1em;">
    <c:forEach var="p" items="${projects}">
      <div class="icon_before icon16 project-icon"><admin:projectName project="${p}" addToUrl="&tab=versionedSettings&subTab=config"/><c:if test="${not empty insecureProjects[p.projectId]}"> <strong>(has secure values)</strong></c:if></div>
    </c:forEach>
  </div>
</c:if>
