<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="tags" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%>
<%@ taglib prefix="util" uri="/WEB-INF/functions/util" %>
<%@attribute name="rule" type="jetbrains.buildServer.controllers.profile.notifications.NotificationRulesForm.EditableNotificationRule" required="true" %>
<%
  request.setAttribute("favoriteBuildsOnly", rule.getFavoriteBuildsFilter());
%>
<c:choose>
  <c:when test="${rule.watchType == 'SPECIFIC_PROJECT_BUILD_TYPES'}">
    <b>Events in </b>
    <ul class="additionalFiltersBlock">
      <c:if test="${favoriteBuildsOnly}">
        <li>- My favorite builds</li>
      </c:if>
      <c:if test="${rule.committerRule}">
        <li>- Builds containing my changes</li>
      </c:if>
      <c:choose>
        <c:when test="${rule.branchFilter == '+:*' || rule.defaultBranchFilter && rule.currentDefaultBranchFilter == '+:*'}">
          <li>- All branches</li>
        </c:when>
        <c:when test="${rule.branchFilter == '+:<default>' || rule.defaultBranchFilter && rule.currentDefaultBranchFilter == '+:<default>'}">
          <li>- Default branch</li>
        </c:when>
        <c:otherwise>
          <li>- Branches:</li>
          <bs:out value="${rule.branchFilter}"/>
        </c:otherwise>
      </c:choose>
    </ul>

    <b>and related to the following projects and build configurations</b>
    <bs:projectHierarchy rootProjects="${rule.rootProjects}" treeId="${rule.id}" collapsedByDefault="false" collapsible="true" rootNotCollapsible="false"
                         customEmptyProjectMessage=" " linksToAdminPage="false" addLevelToConfigurations="true" subprojectsPreceed="true">
      <jsp:attribute name="projectHTML"/>
      <jsp:attribute name="projectNameHTML">
        <c:choose>
          <c:when test="${fn:contains(rule.selectedProjects, projectBean.project)}">
            <bs:projectOrBuildTypeIcon type="project"/> <bs:projectLink project="${projectBean.project}"/>
          </c:when>
          <c:otherwise>
            <bs:projectOrBuildTypeIcon type="project" className="grey"/> <bs:projectLink classes="grey" project="${projectBean.project}"/>
          </c:otherwise>
        </c:choose>
      </jsp:attribute>
      <jsp:attribute name="buildTypeHTML"/>
    </bs:projectHierarchy>
  </c:when>
  <c:when test="${rule.watchType == 'SYSTEM_WIDE'}">
    <b>System wide events</b>
  </c:when>
</c:choose>
