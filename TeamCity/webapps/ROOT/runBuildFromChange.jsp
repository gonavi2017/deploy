<%@ include file="/include-internal.jsp" %>
<c:if test="${not empty buildType}">
<jsp:useBean id="modification" scope="request" type="jetbrains.buildServer.vcs.SVcsModification"/>
<jsp:useBean id="buildType" scope="request" type="jetbrains.buildServer.serverSide.SBuildType"/>

<c:if test="${not empty buildType and not modification.personal and afn:permissionGrantedForBuildType(buildType, 'RUN_BUILD') and afn:permissionGrantedForBuildType(buildType, 'CUSTOMIZE_BUILD_REVISIONS')}">
  <c:set var="branch"><c:if test="${not empty branchName}">, branchName: '<bs:escapeForJs forHTMLAttribute="true" text="${branchName}"/>'</c:if></c:set>
  <c:set var="runBuildClickHandler">BS.RunBuild.runCustomBuild('${buildType.externalId}', { modificationId: ${modification.id}${branch}, init: true, stateKey: 'history' }); return false</c:set>
  <c:choose>
    <c:when test="${runBuildShowMode == 'compact'}">
      <a class="noUnderline" href="#" onclick="${runBuildClickHandler}" title="Run build with this change..."><span class="tc-icon icon16 tc-icon_run-build-changes"></span></a>
    </c:when>
    <c:otherwise>
      <dt><span class="tc-icon icon16 tc-icon_run-build-changes"></span> <a href="#" onclick="${runBuildClickHandler}" title="Run build with this change...">Run build with this change</a></dt>
    </c:otherwise>
  </c:choose>
</c:if>
</c:if>