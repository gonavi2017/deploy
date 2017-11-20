<%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    attribute name="buildType" fragment="false" required="true" type="jetbrains.buildServer.serverSide.BuildTypeEx" %><%@
    attribute name="redirectTo" fragment="false" required="false" %><%@
    attribute name="userBranch" fragment="false" required="false" %><%@
    attribute name="hideEnviroments" type="java.lang.Boolean" required="false" %><%@
    attribute name="className" fragment="false" required="false" type="java.lang.String"%><%@
    attribute name="title" fragment="false" required="false" type="java.lang.String"%><%@
    attribute name="redirectToQueuedBuild" fragment="false" required="false" %><%@
    attribute name="options" fragment="false" required="false"
%><c:if test="${not hideEnviroments or not buildType.environment or !buildType.parameters['teamcity.buildType.environmentBuildType.promoteOnly']}"
><c:set var="caption"><c:out value="${buildType.runBuildActionName}"/></c:set
><c:set var="opts">redirectTo: '${redirectTo}', redirectToQueuedBuild: ${redirectToQueuedBuild != null ? redirectToQueuedBuild : false}</c:set
><c:choose
    ><c:when test="${not empty userBranch}"><c:set var="opts">${opts}, branchName: '<bs:escapeForJs text="${userBranch}" forHTMLAttribute="true"/>'</c:set></c:when
    ><c:when test="${not empty branchBean and not branchBean.wildcardBranch}"
      ><c:set var="opts">${opts}, branchName: '<bs:escapeForJs text="${branchBean.userBranch}" forHTMLAttribute="true"/>'</c:set
    ></c:when
></c:choose><%--@elvariable id="branchBean" type="jetbrains.buildServer.controllers.BranchBean"--%>
<c:set var="openChangesTab" value="${empty userBranch and (empty branchBean or empty branchBean.userBranch or (not empty branchBean and branchBean.wildcardBranch)) and buildType.defaultBranchExcluded}"
/><c:set var="openChangesTabOption" value=", afterShowDialog: function() {BS.RunBuildDialog.showTab('changes-tab');}"
/><c:if test="${not empty options}"><c:set var="opts">${opts}, ${options}</c:set></c:if
><c:set var="runClickHandler"><c:choose
><c:when test="${openChangesTab}">Event.stop(event); BS.RunBuild.runCustomBuild('${buildType.externalId}', { ${opts}${openChangesTabOption}, isCustomRunDialogForRunButton: true });</c:when
><c:otherwise>Event.stop(event); BS.RunBuild.runOnAgent(this, '${buildType.externalId}', { ${opts} });</c:otherwise></c:choose
></c:set>
<span class="btn-group">
  <button class="btn btn_mini ${className}" type="button"
          onclick="${runClickHandler}" title="${title}">${caption}</button
      ><button class="btn btn_mini btn_append ${className} js_to-enable" type="button"
          onclick="Event.stop(event); BS.RunBuild.runCustomBuild('${buildType.externalId}', { ${opts}${openChangesTab ? openChangesTabOption : ''}});"
          title="Run custom build" disabled>...</button>
</span>
</c:if>