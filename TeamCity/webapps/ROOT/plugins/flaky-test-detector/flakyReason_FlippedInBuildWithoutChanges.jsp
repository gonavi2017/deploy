<%-- referenced from flakyReasons.jspf --%>
<%@ include file="/include.jsp"%>

<%--@elvariable id="flakyReason" type="jetbrains.buildServer.serverSide.flakyTestDetector.opendata.FlippedInBuildWithoutChanges"--%>

<c:set var="lastBuildId" value="${flakyReason.build.id}"/>
Test status change in build without changes: from
<c:set var="testNameId" value="${flakyReason.testNameId}"/>
<c:set var="buildId" value="${flakyReason.build.previousId}"/>
<c:set var="testStatus" value="${flakyReason.build.previousTestStatus}"/>
<%@ include file="testStatus.jspf"%>
to
<c:set var="buildId" value="${lastBuildId}"/>
<c:set var="testStatus" value="${flakyReason.build.testStatus}"/>
<%@ include file="testStatus.jspf"%>
in
<%--@elvariable id="builds" type="java.util.Map<java.lang.Long, jetbrains.buildServer.serverSide.SBuild>"--%>
<c:set var="lastBuild" value="${builds[lastBuildId]}"/>
<c:choose>
  <c:when test="${not empty lastBuild}">
    <table class="flakyReason">
      <tr>
        <c:set var="_currBuild" value="${lastBuild}"/>
        <%@ include file="/change/_relatedBuildTDs.jspf" %>
      </tr>
    </table>
  </c:when>
  <c:otherwise>
    <%-- Build is inaccessible (was removed or insufficient permissions) --%>
    <c:set var="buildIdPopup"><bs:tooltipAttrs text="id = ${lastBuildId}"/></c:set>
    <span class="inaccessible" ${buildIdPopup}>an inaccessible build</span>
  </c:otherwise>
</c:choose>
