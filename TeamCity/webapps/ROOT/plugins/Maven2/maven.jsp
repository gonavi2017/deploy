<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@include file="/include-internal.jsp"%>
<%@include file="mavenConsts.jsp"%>
<jsp:useBean id="buildType" type="jetbrains.buildServer.serverSide.SBuildType" scope="request"/>
<et:subscribeOnProjectEvents projectId="${buildType.projectId}">
  <jsp:attribute name="eventNames">
    PROJECT_REMOVED
    PROJECT_RESTORED
    PROJECT_PERSISTED
    PROJECT_ARCHIVED
    PROJECT_DEARCHIVED
  </jsp:attribute>
  <jsp:attribute name="eventHandler">
    BS.reload();
  </jsp:attribute>
</et:subscribeOnProjectEvents>
<et:subscribeOnBuildTypeEvents buildTypeId="${buildType.buildTypeId}">
  <jsp:attribute name="eventNames">
    BUILD_TYPE_UNREGISTERED
  </jsp:attribute>
  <jsp:attribute name="eventHandler">
    BS.reload();
  </jsp:attribute>
</et:subscribeOnBuildTypeEvents>
<style type="text/css">
  .mavenDataContainer {
    width: 60em;
  }

  .mavenDataContainer table {
    width: 100%;
  }

  .mavenDataContainer h2 {
    margin: 1em 0 0;
  }

  .mavenReread {
    margin: 0.5em 0 1.5em;
  }

  .mavenReread .btn {
    margin-left: 0;
  }
</style>

<script type="text/javascript">
  BS.Maven = {
    enableRefresh: true,

    registerRefreshable: function() {
      if(!BS.Maven.enableRefresh)
        return;

      BS.PeriodicalRefresh.start(15, function() {
        return $('mavenDataContainer').refresh();
      });
    },

    unregisterRefreshable: function() {
      BS.Maven.enableRefresh = false;
      BS.PeriodicalRefresh.stop();
    },


    reloadMetadata: function(a) {
      a.innerHTML = "Re-reading data ...";
      new BS.ajaxRequest("<c:url value='/maven/refreshMetadata.html'/>", {
        parameters: "buildTypeId=${buildType.buildTypeId}",
        onSuccess: function () {
          document.location.reload();
        }
      });
      return false;
    }
  };

  $j(BS.Maven.registerRefreshable);

</script>

<bs:refreshable containerId="mavenDataContainer" pageUrl="${pageUrl}"><div class="mavenDataContainer">

<%--@elvariable id="mavenMetadata" type="jetbrains.buildServer.maven.metadata.MavenMetadata"--%>
<c:set var="isRecollectingPossible" value="${mavenMetadata.state.regenerationPossible}"/>

<c:if test="${not mavenMetadata.state.generationPhase}">
  <script type="text/javascript">
    BS.Maven.unregisterRefreshable();
  </script>
</c:if>

<%--@elvariable id="warnOfMultipleMavenSteps" type="java.lang.Boolean"--%>
<c:if test="${warnOfMultipleMavenSteps}">
<div class="icon_before icon16 attentionComment" style="margin-top:0.5em;">This build configuration contains multiple Maven2 build steps. The information below is related only to the first Maven2 step.</div>
</c:if>

<%--@elvariable id="errorMessage" type="java.lang.String"--%>
<c:if test="${(mavenMetadata.state.name eq STATE_ERROR) and (not empty errorMessage)}">
<p><strong style="color:red"><c:out value="${errorMessage}"/></strong></p>
</c:if>

<c:if test="${not empty mavenMetadata.warnings}">
<p>
  <strong>Warnings occurred while reading the project:</strong>
  <c:forEach var="warning" items="${mavenMetadata.warnings}">
    <div class="icon_before icon16 attentionComment"><c:out value="${warning.message}"/></div>
  </c:forEach>
</p>
</c:if>

<c:if test="${(mavenMetadata.state.name eq STATE_DISABLED)}">
<div class="successMessage">Maven specific information gathering is disabled for this build configuration.</div>
</c:if>

<c:if test="${(mavenMetadata.state.name eq STATE_UNSPECIFIED)}">
<div class="successMessage">Maven POM file location isn't specified in this build configuration.</div>
</c:if>

<c:if test="${mavenMetadata.state.name eq STATE_GENERATING}">
  <p><forms:progressRing className="progressRingInline"/> TeamCity is collecting Maven specific information. This may take up to several minutes.</p>
</c:if>

<c:if test="${mavenMetadata.state.name eq STATE_OUT_OF_DATE}">
  <p><forms:progressRing className="progressRingInline"/> This information is out of date. TeamCity is recollecting data. This may take up to several minutes.</p>
</c:if>

<c:if test="${isRecollectingPossible}">
<div class="clearfix mavenReread">
  <a class="btn" href="#" onclick="return BS.Maven.reloadMetadata(this);">Reread Maven project data</a>
</div>
</c:if>

<%--@elvariable id="mavenParams" type="java.util.Map<java.lang.String,java.lang.String>"--%>
<c:if test="${not empty mavenParams}">

<h2>Provided parameters</h2>
You can reference them within the build number pattern using %-notation. For example: <strong>%maven.project.version%.%build.counter%</strong>.
<table class="settings">
  <tr><th>Parameter name</th><th>Parameter value</th></tr>
  <c:forEach var="entry" items="${mavenParams}">
  <tr><td><c:out value="${entry.key}"/></td><td><c:out value="${entry.value}"/></td></tr>
  </c:forEach>
</table>
</c:if>

<%--@elvariable id="modules" type="java.util.List<org.jetbrains.maven.model.TCMavenProjectModel>"--%>
<c:if test="${not empty modules}">
<h2>Modules</h2>
<table class="settings">
  <tr>
    <th>Name</th>
    <th>Version</th>
  </tr>
  <c:forEach var="module" items="${modules}">
    <%--@elvariable id="module" type="org.jetbrains.maven.model.TCMavenProjectModel"--%>
  <tr>
    <td><c:out value="${module.name}"/></td>
    <td><c:out value="${module.version}"/></td>
  </tr>
  </c:forEach>
</table>
</c:if>

<%--@elvariable id="dependencies" type="java.util.Collection"--%>
<c:if test="${not empty dependencies}">
<h2>External Dependencies</h2>
The merged list of all module dependencies
<table class="settings">
  <tr>
    <th>Group ID</th>
    <th>Artifact ID</th>
    <th>Version</th>
    <th>Scope</th>
    <th>Type</th>
  </tr>
  <c:forEach var="dep" items="${dependencies}">
    <%--@elvariable id="dep" type="org.jetbrains.maven.model.Dependency"--%>
  <tr>
    <td><c:out value="${dep.GAV.groupId}"/></td>
    <td><c:out value="${dep.GAV.artifactId}"/></td>
    <td><c:out value="${dep.GAV.version}"/></td>
    <td><c:out value="${dep.scope}"/></td>
    <td><c:out value="${dep.GAV.type}"/></td>
  </tr>
  </c:forEach>
</table>
</c:if>

    <%--@elvariable id="tcDependencies" type="java.util.Collection<com.intellij.openapi.util.Pair<SBuildType, java.util.Collection<org.jetbrains.maven.model.MavenGAV>>>"--%>
<c:if test="${not empty tcDependencies}">
  <h2>Related Build Configurations</h2>
  These build configurations produce artifacts which are snapshot dependencies of this Maven project  
  <table class="settings">
    <tr>
      <th>Configuration</th>
      <th>Produced Artifacts</th>
    </tr>
    <c:forEach var="pair" items="${tcDependencies}">
      <%--@elvariable id="pair" type="com.intellij.openapi.util.Pair<SBuildType, java.util.Collection<org.jetbrains.maven.model.MavenGAV>>"--%>
      <c:set var="buildType" value="${pair.first}"/>
      <c:set var="producedArtifacts" value="${pair.second}"/>

      <%--@elvariable id="buildType" type="jetbrains.buildServer.serverSide.SBuildType"--%>
      <%--@elvariable id="producedArtifacts" type="java.util.Collection<org.jetbrains.maven.model.MavenGAV>"--%>
    <tr>
      <td><bs:buildTypeLink buildType="${buildType}"/></td>
      <td>
        <c:forEach var="artifact" items="${producedArtifacts}">
          <c:out value="${artifact}"/><br/>
        </c:forEach>
      </td>
    </tr>
    </c:forEach>
  </table>
</c:if>

</div></bs:refreshable>