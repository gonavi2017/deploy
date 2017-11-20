<%@ tag import="jetbrains.buildServer.serverSide.projectsExport.ArtifactDependencyUsage" %>
<%@ tag import="jetbrains.buildServer.serverSide.projectsExport.SnapshotDependencyUsage" %>
<%@ tag import="jetbrains.buildServer.serverSide.projectsExport.TemplateUsage" %>
<%@ tag import="jetbrains.buildServer.serverSide.projectsExport.VcsRootUsage" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<%@ attribute name="usagePath" required="true" type="java.util.List" %>
<%@ attribute name="name" required="true" type="java.lang.String" %>
<%@ attribute name="isWarning" required="false" type="java.lang.Boolean" %>
<%@ attribute name="prefix" required="false" fragment="true" %>

<c:set var="artifactDepUsageType"><%=ArtifactDependencyUsage.TYPE%></c:set>
<c:set var="snapshotDepUsageType"><%=SnapshotDependencyUsage.TYPE%></c:set>
<c:set var="vcsRootUsageType"><%=VcsRootUsage.TYPE%></c:set>
<c:set var="templateUsageType"><%=TemplateUsage.TYPE%></c:set>

<c:if test="${usagePath != null && fn:length(usagePath) > 0}">
    <c:set var="pathHtml">
      <div class="usageDetails">
        <div class="usageDetailsHeader">
          <c:out value="${name}"/> usage details
        </div>
        <jsp:invoke fragment="prefix" var="prefixHtml"/>
        <c:if test="${fn:length(prefixHtml) > 0}">
          <div class="usageDetailsPrefix">${prefixHtml}</div>
        </c:if>
        <div>
          <c:forEach items="${usagePath}" var="usage" varStatus="loopStatus">
            <%--@elvariable id="usage" type="jetbrains.buildServer.serverSide.projectsExport.EntityUsage"--%>
            <c:if test="${loopStatus.index == 0}">Used in</c:if>
            <c:if test="${loopStatus.index > 0}">that is used in</c:if>
            <c:choose>
              <c:when test="${usage.type eq artifactDepUsageType}">
                artifact dependencies of <admin:editBuildTypeLinkFull buildType="${usage.whereUsed}" step="dependencies"/>
              </c:when>
              <c:when test="${usage.type eq snapshotDepUsageType}">
                snapshot dependencies of <admin:editBuildTypeLinkFull buildType="${usage.whereUsed}" step="dependencies"/>
              </c:when>
              <c:when test="${usage.type eq templateUsageType}">
                <admin:editBuildTypeLinkFull buildType="${usage.whereUsed}"/>
              </c:when>
              <c:when test="${usage.type eq vcsRootUsageType}">
                <admin:editBuildTypeLinkFull buildType="${usage.whereUsed}" step="vcsRoots"/>
              </c:when>
            </c:choose>
            <br/>
          </c:forEach>
        </div>
      </div>
    </c:set>

  <c:choose>
    <c:when test="${isWarning}">
      <span class="icon icon16 yellowTriangle" <bs:tooltipAttrs text="${pathHtml}" withOnClick="true"/>></span>
    </c:when>
    <c:otherwise>
      <bs:commentIcon text="${pathHtml}"/>
    </c:otherwise>
  </c:choose>

</c:if>