<%@ include file="/include-internal.jsp" %>
<%@ taglib prefix="labels" tagdir="/WEB-INF/tags/labels" %>
<jsp:useBean id="currentUser" scope="request" type="jetbrains.buildServer.users.SUser"/>
<jsp:useBean id="contextProject" scope="request" type="jetbrains.buildServer.serverSide.SProject"/>
<bs:linkCSS>
  /css/buildQueue.css
</bs:linkCSS>

<%--@elvariable id="buildChainsBean" type="jetbrains.buildServer.controllers.graph.BuildChainsBean"--%>
<%--@elvariable id="dependenciesBean" type="jetbrains.buildServer.controllers.viewLog.DependenciesBean"--%>
<c:set var="buildChainsBean" value="${buildChainsBean}"/>
<c:set var="numChains" value="${buildChainsBean.numberOfChains}"/>

<c:set var="hasSnapshotDependencies" value="${numChains > 0}"/>
<c:set var="hasDownloadedArtifacts" value="${(not empty dependenciesBean) and (dependenciesBean.numberOfArtifactsSourceBuilds > 0)}"/>
<c:set var="hasProvidedArtifacts" value="${(not empty dependenciesBean) and (dependenciesBean.numberOfArtifactsTargetBuilds > 0)}"/>

<c:set var="depsTab" value="${param['depsTab']}"/>
<c:if test="${empty depsTab}">
  <c:choose>
    <c:when test="${hasSnapshotDependencies}"><c:set var="depsTab" value="snapshot"/></c:when>
    <c:when test="${hasDownloadedArtifacts}"><c:set var="depsTab" value="downloadedArtifacts"/></c:when>
    <c:when test="${hasProvidedArtifacts}"><c:set var="depsTab" value="deliveredArtifacts"/></c:when>
  </c:choose>
</c:if>
<div class="subTabs"
  ><c:set var="separator" value=""
  /><c:if test="${hasSnapshotDependencies and (hasDownloadedArtifacts or hasProvidedArtifacts)}">
    <bs:_viewLog build="${buildData}" noLink="true" tab="dependencies" urlAddOn="&depsTab=snapshot"/>
    <c:choose>
      <c:when test="${depsTab == 'snapshot'}"><strong>Snapshot dependencies</strong></c:when>
      <c:otherwise><a href="${url}">Snapshot dependencies</a></c:otherwise>
    </c:choose>
    <c:set var="separator"><span class="separator">|</span></c:set>
  </c:if
  ><c:if test="${hasDownloadedArtifacts and (hasSnapshotDependencies or hasProvidedArtifacts)}">
    <bs:_viewLog build="${buildData}" noLink="true" tab="dependencies" urlAddOn="&depsTab=downloadedArtifacts"/>
    ${separator}
    <c:choose>
      <c:when test="${depsTab == 'downloadedArtifacts'}"><strong>Downloaded artifacts</strong></c:when>
      <c:otherwise><a href="${url}">Downloaded artifacts</a></c:otherwise>
    </c:choose>
    <c:set var="separator"><span class="separator">|</span></c:set>
  </c:if
  ><c:if test="${hasProvidedArtifacts and (hasSnapshotDependencies or hasDownloadedArtifacts)}">
    <bs:_viewLog build="${buildData}" noLink="true" tab="dependencies" urlAddOn="&depsTab=deliveredArtifacts"/>
    ${separator}
    <c:choose>
      <c:when test="${depsTab == 'deliveredArtifacts'}"><strong>Delivered artifacts</strong></c:when>
      <c:otherwise><a href="${url}">Delivered artifacts</a></c:otherwise>
    </c:choose>
  </c:if
></div>
<div>
  <c:if test="${depsTab == 'snapshot' and numChains > 0}">
    <bs:buildChains buildChainsBean="${buildChainsBean}" showFilter="true" contextProject="${contextProject}"/>
  </c:if>

  <!--=========================== ARTIFACT DEPENDENCIES INFORMATION BLOCK =======-->
  <c:if test="${depsTab == 'downloadedArtifacts' and hasDownloadedArtifacts}">
    <div id="downloadedArtifacts">
      <p>This build has downloaded artifacts of <strong>${dependenciesBean.numberOfArtifactsSourceBuilds}</strong> build<bs:s val="${dependenciesBean.numberOfArtifactsSourceBuilds}"/>.</p>
      <c:if test="${not dependenciesBean.enoughPermissionsForArtifactsSourceBuilds}">
        <c:if test="${dependenciesBean.numberOfArtifactsSourceBuilds == 1}">
          <div class="icon_before icon16 attentionComment">You do not have enough permissions to view this build</div>
        </c:if>
        <c:if test="${dependenciesBean.numberOfArtifactsSourceBuilds > 1}">
          <div class="icon_before icon16 attentionComment">You do not have enough permissions to view all of the ${dependenciesBean.numberOfArtifactsSourceBuilds} build<bs:s val="${dependenciesBean.numberOfArtifactsSourceBuilds}"/></div>
        </c:if>
      </c:if>

      <bs:dependentArtifactsTable mode="downloadedFrom" ownerBuild="${dependenciesBean.currentBuild}" builds="${dependenciesBean.artifactsSourceBuilds}"/>
    </div>
  </c:if>

  <c:if test="${depsTab == 'deliveredArtifacts' and hasProvidedArtifacts}">
    <div id="providedArtifacts">
      <p>Artifacts of this build were delivered to <strong>${dependenciesBean.numberOfArtifactsTargetBuilds}</strong> other build<bs:s val="${dependenciesBean.numberOfArtifactsTargetBuilds}"/>.</p>
      <c:if test="${not dependenciesBean.enoughPermissionsForArtifactsTargetBuilds}">
        <c:if test="${dependenciesBean.numberOfArtifactsTargetBuilds == 1}">
          <div class="icon_before icon16 attentionComment">You do not have enough permissions to view this build</div>
        </c:if>
        <c:if test="${dependenciesBean.numberOfArtifactsTargetBuilds > 1}">
          <div class="icon_before icon16 attentionComment">You do not have enough permissions to view all of the ${dependenciesBean.numberOfArtifactsTargetBuilds} build<bs:s val="${dependenciesBean.numberOfArtifactsTargetBuilds}"/></div>
        </c:if>
      </c:if>

      <bs:dependentArtifactsTable mode="providedTo" ownerBuild="${dependenciesBean.currentBuild}" builds="${dependenciesBean.artifactsTargetBuilds}"/>
      <c:set var="url" value="viewLog.html?buildTypeId=${dependenciesBean.currentBuild.buildTypeId}&buildId=${dependenciesBean.currentBuild.buildId}&tab=dependencies&depsTab=deliveredArtifacts&targetBuildsPage=[page]"/>
      <bs:pager place="bottom" urlPattern="${url}" pager="${dependenciesBean.targetBuildsPager}"/>
    </div>
  </c:if>

  <c:if test="${depsTab != 'snapshot'}">
  <script type="text/javascript">
    enablePeriodicalRefresh();
  </script>
  </c:if>
</div>
