<%-- referenced from flakyReasons.jspf --%>
<%@ include file="/include.jsp"%>

<%--@elvariable id="flakyReason" type="jetbrains.buildServer.serverSide.flakyTestDetector.opendata.DifferentStatusAtSameVcsChange"--%>
<%--@elvariable id="vcsChanges" type="java.util.Map<java.lang.Long, jetbrains.buildServer.vcs.SVcsModification>"--%>
<%--@elvariable id="vcsChange" type="jetbrains.buildServer.vcs.SVcsModification"--%>

Different test status of build configurations with the same VCS change
<c:set var="vcsChange" value="${vcsChanges[flakyReason.vcsChangeId]}"/>
<c:choose>
  <c:when test="${not empty vcsChange}">
    <c:set var="vcsChangeUrl"><bs:vcsModificationUrl change = '${vcsChange}'/></c:set>
    <a href="${vcsChangeUrl}" <bs:tooltipAttrs text="${vcsChange.version}"/>>
      <c:out value="${vcsChange.displayVersion}"/></a>:
  </c:when>

  <c:otherwise>
    <%-- VCS change is inaccessible (was removed or insufficient permissions) --%>
    <c:set var="vcsChangeIdPopup"><bs:tooltipAttrs text="id = ${flakyReason.vcsChangeId}"/></c:set>
    <span class="inaccessible" ${vcsChangeIdPopup}>(inaccessible)</span>:
  </c:otherwise>
</c:choose>
<table class="flakyReason">
  <tbody>
    <c:set var="build" value="${flakyReason.buildA}"/>
    <%@ include file="flakyReason_DifferentStatusAtSameVcsChange.jspf"%>
    <c:set var="build" value="${flakyReason.buildB}"/>
    <%@ include file="flakyReason_DifferentStatusAtSameVcsChange.jspf"%>
  </tbody>
</table>
