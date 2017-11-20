<%@ tag import="jetbrains.buildServer.serverSide.audit.ObjectType" %>
<%@ tag import="jetbrains.buildServer.serverSide.impl.ProjectEx" %>
<%@ tag import="jetbrains.buildServer.serverSide.impl.audit.ActionTypeSet" %>
<%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz"%>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@attribute name="project" required="true" type="jetbrains.buildServer.serverSide.SProject"%>
<%@attribute name="auditLogAction" required="true" type="jetbrains.buildServer.serverSide.audit.AuditLogAction"%>
<c:if test="${auditLogAction != null}">
  <authz:authorize allPermissions="VIEW_AUDIT_LOG">
    <authz:authorize allPermissions="EDIT_PROJECT" projectId="${project.projectId}">
    <c:set var="objectTypeId" value="${auditLogAction.objectType.id}"/>

    <c:set var="projectTypeId" value="<%=ObjectType.PROJECT.getId()%>"/>
    <c:set var="buildTypeTypeId" value="<%=ObjectType.BUILD_TYPE.getId()%>"/>
    <c:set var="templateTypeId" value="<%=ObjectType.BUILD_TYPE_TEMPLATE.getId()%>"/>
    <c:set var="vcsRootTypeId" value="<%=ObjectType.VCS_ROOT.getId()%>"/>

    <c:set var="actionTypeSetId" value=""/>
    <c:set var="filterScopeIdPrefix" value=""/>
    <c:if test="${objectTypeId == projectTypeId}">
      <c:set var="actionTypeSetId" value="<%=ActionTypeSet.PROJECT_EDIT_SETTINGS.getId()%>"/>
      <c:set var="filterScopeIdPrefix" value="project"/>
    </c:if>
    <c:if test="${objectTypeId == buildTypeTypeId}">
      <c:set var="actionTypeSetId" value="<%=ActionTypeSet.BUILD_TYPE_EDIT_SETTINGS.getId()%>"/>
      <c:set var="filterScopeIdPrefix" value="buildType"/>
    </c:if>
    <c:if test="${objectTypeId == templateTypeId}">
      <c:set var="actionTypeSetId" value="<%=ActionTypeSet.BUILD_TYPE_TEMPLATE_EDIT_SETTINGS.getId()%>"/>
      <c:set var="filterScopeIdPrefix" value="template"/>
    </c:if>
    <c:if test="${objectTypeId == vcsRootTypeId}">
      <c:set var="actionTypeSetId" value="<%=ActionTypeSet.VCS_ROOT_UPDATE.getId()%>"/>
      <c:set var="filterScopeIdPrefix" value="vcsRoot"/>
    </c:if>

    <table class="usefulLinks">
      <tr>
        <td>
          <span class="inline">
            <c:choose>
              <c:when test="${auditLogAction.actionType.creatingAction}">Created</c:when>
              <c:otherwise>
                <c:catch var="castException">
                  <c:set var="wrappers" value="${auditLogAction.objects}"/>
                  <c:set var="configModification" value="${wrappers[fn:length(wrappers) - 1].object}"/>
                  <admin:configModificationLink object="${configModification}" text="Last edited" actionId="${auditLogAction.comment.commentId}"/>
                </c:catch>
                <c:if test="${castException != null}">Last edited</c:if>
              </c:otherwise>
            </c:choose>
            <bs:date value="${auditLogAction.timestamp}" smart="true" no_smart_title="true"/>&nbsp;</span><span class="inline">by <admin:auditLogActionUserName auditLogAction="${auditLogAction}"/>&nbsp;</span>
          <span class="inline">(<a href="<c:url value="/admin/admin.html?item=audit&actionTypeSet=${actionTypeSetId}&filterScopeId=${filterScopeIdPrefix}_${auditLogAction.objectExternalId}"/>" target="_blank">view history</a>)</span>
        </td>
      </tr>
    </table>
    </authz:authorize>
  </authz:authorize>
</c:if>
<c:if test="<%= project instanceof ProjectEx && ((ProjectEx) project).hasVersionedSettings()%>">
  <authz:authorize allPermissions="EDIT_PROJECT" projectId="${project.projectId}">
    <table class="usefulLinks">
      <tr>
        <td>
          <span class="inline">
            Settings are stored in VCS (<admin:editProjectLink projectId="${project.externalId}" addToUrl="&tab=versionedSettings&subTab=changeLog">view history</admin:editProjectLink>)
          </span>
        </td>
      </tr>
    </table>
  </authz:authorize>
</c:if>
