<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="afn" uri="/WEB-INF/functions/authz" %>
<%@include file="/include-internal.jsp"%>
<jsp:useBean id="healthStatusItem" type="jetbrains.buildServer.serverSide.healthStatus.HealthStatusItem" scope="request"/>
<c:set var="error" value="${healthStatusItem.additionalData['error']}"/>
<%--@elvariable id="error" type="jetbrains.buildServer.configs.dsl.health.DslPluginsError"--%>
<jsp:useBean id="showMode" type="jetbrains.buildServer.web.openapi.healthStatus.HealthStatusItemDisplayMode" scope="request"/>
<c:set var="progressId" value="dslPluginsErrorProgress_${showMode}"/>
<c:set var="detailsId" value="dslPluginsErrorDetails_${showMode}"/>
<c:set var="serverAdmin" value="${afn:permissionGrantedGlobally('CHANGE_SERVER_SETTINGS')}"/>
<div>
  TeamCity failed to initialize DSL plugins.
  <c:choose>
    <c:when test="${serverAdmin}">
      <script type="text/javascript">
        reInitDslPlugins_${showMode} = function() {
          $j('#${progressId}').show();
          BS.ajaxRequest(window['base_uri'] + '/admin/action.html', {
            parameters: Object.toQueryString({initDslPlugins: 'true'}),
            onComplete: function(transport) {
              document.location.reload();
            }
          });
        }
      </script>
      <input type="button" class="btn btn_mini" value="Reinitialize plugins" onclick="reInitDslPlugins_${showMode}()"/>
      <forms:saving id="${progressId}" style="float: none; margin-left: 0.5em;"/>

      <div><a href="javascript:;" onclick="$j('#${detailsId}').toggle();">Show details &raquo;</a></div>
      <div id="${detailsId}" style="display: none">
        <c:forEach var="line" items="${error.details}">
          <div><c:out value="${line}"/></div>
        </c:forEach>
      </div>
    </c:when>
    <c:otherwise>
      Please contact your system administrator for details.
    </c:otherwise>
  </c:choose>
</div>