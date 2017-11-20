<%@ page import="jetbrains.buildServer.web.openapi.PlaceId" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags/tags" %><%@
    taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@
    taglib prefix="ext" tagdir="/WEB-INF/tags/ext"
%><jsp:useBean id="build" type="jetbrains.buildServer.serverSide.SBuild" scope="request"
/><jsp:useBean id="showAll" type="java.lang.Boolean" scope="request"
/><jsp:useBean id="hasVisibleArtifacts" type="java.lang.Boolean" scope="request"
/>

<div class="buildArtifacts">
  <c:if test="${not build.finished}">
    <div class="icon_before icon16 attentionComment" style="margin-bottom: 10px">
      This page is not automatically refreshed while the build is running.
      <a href="#" class="btn btn_mini" onclick="$('buildResults').refresh(null, 'runningBuildRefresh=1'); return false;">Refresh</a>
    </div>
  </c:if>

  <bs:userBuildDetails promotion="${build.buildPromotion}"/>
  <c:choose>
    <c:when test="${not hasVisibleArtifacts and not showAll}">
      <div class="artifactsNote">
        The build has hidden artifacts only.
        <bs:_viewLog build="${build}" title="View build artifacts" urlAddOn="&showAll=true" tab="artifacts">Show hidden</bs:_viewLog>
      </div>
    </c:when>
    <c:otherwise>
      <jsp:include page="printArtifactsTree.jsp" />
    </c:otherwise>
  </c:choose>
  <%--@elvariable id="storageSettingsDescription" type="java.lang.String"--%>
  <c:if test="${hasVisibleArtifacts and not empty storageSettingsDescription}">
    <div class="artifactsNote">
      Some artifacts of this build were published using
      <authz:authorize projectId="${build.buildType.project.projectId}" allPermissions="EDIT_PROJECT">
        <jsp:attribute name="ifAccessGranted">
          <admin:editProjectLink projectId="${build.buildType.project.externalId}" addToUrl="&tab=artifactsStorage"><c:out value="${storageSettingsDescription}"/></admin:editProjectLink>
        </jsp:attribute>
        <jsp:attribute name="ifAccessDenied">
          <c:out value="${storageSettingsDescription}"/>
        </jsp:attribute>
      </authz:authorize>
    </div>
  </c:if>
  <ext:includeExtensions placeId="<%=PlaceId.BUILD_ARTIFACTS_FRAGMENT%>"/>
</div>
