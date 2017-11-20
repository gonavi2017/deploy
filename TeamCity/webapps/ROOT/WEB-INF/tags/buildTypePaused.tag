<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags"%><%@
    taglib prefix="l" tagdir="/WEB-INF/tags/layout"%><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz"%><%@
    taglib prefix="admin" tagdir="/WEB-INF/tags/admin"%><%@
    attribute name="buildType" required="true" type="jetbrains.buildServer.serverSide.SBuildType"%><%@
    attribute name="style" required="false"
%><c:if test="${buildType.paused}">
  <div <c:if test="${style != null}">style="${style}"</c:if> id="buildTypeDetails" class="headerNote">
    <span class="icon build-status-icon build-status-icon_paused"></span>
    <span>Build configuration was paused</span><bs:pauseCommentText buildType="${buildType}" forTooltip="false"/>
    <c:if test="${not buildType.readOnly and not buildType.project.archived}">
      <authz:authorize projectId="${buildType.projectId}" allPermissions="PAUSE_ACTIVATE_BUILD_CONFIGURATION">
        <a class="btn btn_mini" href="#" onclick="<bs:_pauseBuildTypeLinkOnClick buildType="${buildType}" pause="false"/>; return false">Activate</a>
      </authz:authorize>
    </c:if>
  </div>
</c:if>