<%@ page import="jetbrains.buildServer.users.User" %>
<%@ include file="include-internal.jsp" %>
<jsp:useBean id="serverTC" type="jetbrains.buildServer.serverSide.SBuildServer" scope="request"/>

<c:set var="hideSuccessful" value="${ufn:booleanPropertyValue(currentUser, 'changePage_hideSuccessful')}"/>
<bs:_hideSuccessfulLine changeStatus="${changeStatus}" hideSuccessful="${hideSuccessful}"
                        jsBuildTypes="BS.buildTypes"/>

<table class="modificationBuilds">
<c:forEach var="item" items="${sortedConfigurations}" varStatus="pos">

  <et:subscribeOnBuildTypeEvents buildTypeId="${item.buildTypeId}">
      <jsp:attribute name="eventNames">
        BUILD_STARTED
        BUILD_FINISHED
        BUILD_INTERRUPTED
      </jsp:attribute>
      <jsp:attribute name="eventHandler">
        $('buildTypesContainerId').refresh(null, '');
      </jsp:attribute>
  </et:subscribeOnBuildTypeEvents>

  <c:if test="${not empty changeStatus.buildTypesStatus[item]}">
    <c:set var="buildType" value="${item}" scope="request"/>
    <ext:includeJsp jspPath="/viewModificationBuildType.jsp"/>
  </c:if>
</c:forEach>
</table>

<script>
  /*  Array of interesting build types to allow javascript hide/show for hide successful operation */
  BS.buildTypes = {};
  <c:forEach var="buildType" items="${sortedConfigurations}">
  <jsp:useBean id="buildType" type="jetbrains.buildServer.serverSide.SBuildType"/>
  <c:set var="btStatus" value="${changeStatus.buildTypesStatus[buildType]}"/>

    <c:if test="${not empty btStatus}">
      BS.buildTypes["${buildType.buildTypeId}"] = {id: "${buildType.buildTypeId}", running: [], failed: ${btStatus.failed}, successful: ${btStatus.successful} };

      <c:forEach var="build" items='<%= serverTC.getRunningBuilds((User)request.getAttribute("currentUser"), null)%>'>
        if (BS.buildTypes["${build.buildTypeId}"]) { BS.buildTypes["${build.buildTypeId}"].running.push(${build.buildId}); }
      </c:forEach>
    </c:if>

  </c:forEach>
</script>
