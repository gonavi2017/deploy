<%@ tag import="jetbrains.buildServer.serverSide.dependency.DependencyOptions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@attribute name="dependency" type="jetbrains.buildServer.controllers.buildType.SourceDependencyBean" %>

<c:set var="takeStartedBuildOption"><%=DependencyOptions.TAKE_STARTED_BUILD_WITH_SAME_REVISIONS.getKey()%></c:set>
<c:set var="takeSuccessfulBuildsOnlyOption"><%=DependencyOptions.TAKE_SUCCESSFUL_BUILDS_ONLY.getKey()%></c:set>
<c:set var="runBuildOnTheSameAget"><%=DependencyOptions.RUN_BUILD_ON_THE_SAME_AGENT.getKey()%></c:set>
<c:set var="runBuildIfDependencyFailedOption"><%=DependencyOptions.RUN_BUILD_IF_DEPENDENCY_FAILED.getKey()%></c:set>
<c:set var="runBuildIfDependencyFailedToStartOption"><%=DependencyOptions.RUN_BUILD_IF_DEPENDENCY_FAILED_TO_START.getKey()%></c:set>
<c:set var="continuationMode_fail_to_start"><%=DependencyOptions.BuildContinuationMode.MAKE_FAILED_TO_START.name()%></c:set>
<c:set var="continuationMode_add_problem"><%=DependencyOptions.BuildContinuationMode.RUN_ADD_PROBLEM.name()%></c:set>
<c:set var="continuationMode_run"><%=DependencyOptions.BuildContinuationMode.RUN.name()%></c:set>
<c:set var="continuationMode_cancel"><%=DependencyOptions.BuildContinuationMode.CANCEL.name()%></c:set>

<c:if test="${dependency.setOptions[takeStartedBuildOption]}">
  <div>Do not run new build if there is a suitable one</div>
</c:if>
<c:if test="${dependency.setOptions[takeSuccessfulBuildsOnlyOption]}">
  <div style="margin-left: 1.5em">Only use successful builds from suitable ones</div>
</c:if>
<c:if test="${dependency.setOptions[runBuildOnTheSameAget]}">
  <div>Run build on the same agent</div>
</c:if>
<c:if test="${empty dependency.setOptions[takeStartedBuildOption] and
              empty dependency.setOptions[takeSuccessfulBuildsOnlyOption] and
              empty dependency.setOptions[runBuildOnTheSameAget]}">
  <div>Always run a new build</div>
</c:if>
<c:if test="${dependency.setOptions[runBuildIfDependencyFailedOption] == continuationMode_run}">
  <div>On failed dependency: run build, do not add problem</div>
</c:if>
<c:if test="${dependency.setOptions[runBuildIfDependencyFailedOption] eq continuationMode_add_problem}">
  <div>On failed dependency: run build, but add problem</div>
</c:if>
<c:if test="${dependency.setOptions[runBuildIfDependencyFailedOption] == continuationMode_cancel}">
  <div>On failed dependency: cancel build</div>
</c:if>
<c:if test="${empty dependency.setOptions[runBuildIfDependencyFailedOption]}">
  <div>On failed dependency: make build failed to start</div>
</c:if>
<c:if test="${dependency.setOptions[runBuildIfDependencyFailedToStartOption] == continuationMode_run}">
  <div>On failed to start/canceled dependency: run build, do not add problem</div>
</c:if>
<c:if test="${dependency.setOptions[runBuildIfDependencyFailedToStartOption] eq continuationMode_add_problem}">
  <div>On failed to start/canceled dependency: run build, but add problem</div>
</c:if>
<c:if test="${dependency.setOptions[runBuildIfDependencyFailedToStartOption] == continuationMode_cancel}">
  <div>On failed to start/canceled dependency: cancel build</div>
</c:if>
<c:if test="${empty dependency.setOptions[runBuildIfDependencyFailedToStartOption]}">
  <div>On failed to start/canceled dependency: make build failed to start</div>
</c:if>
