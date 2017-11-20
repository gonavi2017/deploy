<%-- referenced from flakyReasons.jspf --%>
<%@ include file="/include.jsp"%>

<%--@elvariable id="flakyReason" type="jetbrains.buildServer.serverSide.flakyTestDetector.opendata.FlakyFailure"--%>
<%--@elvariable id="builds" type="java.util.Map<java.lang.Long, jetbrains.buildServer.serverSide.SBuild>"--%>

Different test status for multiple invocations in the same build:
<span class="counter">${flakyReason.successCount}</span> times successful,
<span class="counter">${flakyReason.failureCount}</span> failures in
<c:set var="buildId" value="${flakyReason.build.id}"/>
<c:set var="build" value="${builds[buildId]}"/>
<c:choose>
  <c:when test="${not empty build}">
    <table class="flakyReason">
      <tr>
        <c:set var="_currBuild" value="${build}"/>
        <%@ include file="/change/_relatedBuildTDs.jspf" %>
      </tr>
    </table>
  </c:when>
  <c:otherwise>
    <%-- Build is inaccessible (was removed or insufficient permissions) --%>
    <c:set var="buildIdPopup"><bs:tooltipAttrs text="id = ${buildId}"/></c:set>
    <span class="inaccessible" ${buildIdPopup}>an inaccessible build</span>
  </c:otherwise>
</c:choose>
