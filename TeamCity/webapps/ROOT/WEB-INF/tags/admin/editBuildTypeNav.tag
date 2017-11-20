<%--@elvariable id="serverSummary" type="jetbrains.buildServer.web.openapi.ServerSummary"--%>
<%@ tag import="jetbrains.buildServer.serverSide.healthStatus.SuggestionCategory" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="util" uri="/WEB-INF/functions/util" %>

<%@ attribute name="buildTypeForm" required="true" type="jetbrains.buildServer.controllers.admin.projects.EditableBuildTypeSettingsForm"%>
<%@ attribute name="selectedLink" required="false" %>

<admin:editBuildTypeNavSteps settings="${buildTypeForm.settings}"/>
<c:forEach var="configStep" items="${buildConfigSteps}">
  <c:choose>
    <c:when test="${buildTypeForm.template}">
      <c:set var="url"><admin:editTemplateLink step="${configStep.stepId}" templateId="${buildTypeForm.settings.externalId}" title="${configStep.title}" withoutLink="true"/></c:set>
      <div class="item${selectedLink == configStep.stepId ? ' active' : ''}"><a class="stepLink" href="${url}" title="${util:escapeUrlForQuotes(configStep.title)}"><c:out value="${configStep.title}"/></a></div>
    </c:when>

    <c:when test="${not buildTypeForm.template}">
      <c:set var="url"><admin:editBuildTypeLink step="${configStep.stepId}" buildTypeId="${buildTypeForm.settingsBuildType.externalId}" title="${configStep.title}" withoutLink="true"/></c:set>
      <div class="item${selectedLink == configStep.stepId ? ' active' : ''}"><a class="stepLink" href="${url}" title="${util:escapeUrlForQuotes(configStep.title)}"><c:out value="${configStep.title}"/></a></div>
    </c:when>
  </c:choose>
</c:forEach>

<script type="text/javascript">
  new TabbedPane.Tab().extractCountForElements("#buildTypeConfSteps .stepLink");
</script>

<c:if test="${buildTypeForm.template}">
  <c:set var="tpl" value="${buildTypeForm.settings}"/>
  <table class="usefulLinks">
    <tr>
      <td>
      Used in <strong>${tpl.numberOfUsages}</strong> build <admin:templateUsagesPopup templateId="${tpl.id}" selectedStep="${selectedLink}">configuration<bs:s val="${tpl.numberOfUsages}"/></admin:templateUsagesPopup>
      </td>
    </tr>
  </table>
</c:if>

<admin:configModificationInfo auditLogAction="${buildTypeForm.settings.lastConfigModificationAction}" project="${buildTypeForm.project}"/>
