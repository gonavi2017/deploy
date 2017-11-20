<%@ tag import="jetbrains.buildServer.controllers.admin.projects.EditBuildTypeFormFactory" %>
<%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %><%@
    taglib prefix="afn" uri="/WEB-INF/functions/authz" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %><%@
    taglib prefix="l" tagdir="/WEB-INF/tags/layout" %><%@
    attribute name="buildTypeForm" required="true" type="jetbrains.buildServer.controllers.admin.projects.EditableBuildTypeSettingsForm" %><%@
    attribute name="targetProjects" required="true" type="java.util.List" %><%@
    attribute name="runnerId" required="true" type="java.lang.String"
%><c:set var="btPrefix" value="<%=EditBuildTypeFormFactory.BT_PREFIX%>"
/><c:set var="tplPrefix" value="<%=EditBuildTypeFormFactory.TEMPLATE_PREFIX%>"
/><c:url value="/admin/copyBuildStep.html" var="copyAction"/>

<bs:modalDialog formId="copyBuildStepForm"
                title="Copy Build Step"
                action="${copyAction}"
                closeCommand="BS.CopyBuildStepForm.cancelDialog()"
                saveCommand="BS.CopyBuildStepForm.submitCopy()">
  <label for="targetSettingsId" class="tableLabel">Copy Build Step to:</label>
  <forms:select id="targetSettingsId" name="targetId" style="width: 22em;" enableFilter="true">
    <c:forEach items="${targetProjects}" var="bean">
      <%--@elvariable id="bean" type="jetbrains.buildServer.web.util.ProjectHierarchyBean"--%>
      <c:set var="project" value="${bean.project}"/>
      <c:set var="buildTypes" value="${project.ownBuildTypes}"/>
      <c:set var="templates" value="${project.ownBuildTypeTemplates}"/>
      <c:set var="subprojects" value="${project.projects}"/>
      <c:if test="${not empty buildTypes or not empty templates or not empty subprojects}">
        <forms:projectOptGroup project="${project}" classes="user-depth-${bean.limitedDepth}">
          <c:forEach items="${buildTypes}" var="bt">
            <forms:option value="${btPrefix}${bt.externalId}"
                          title="${bt.fullName}"
                          selected="${buildTypeForm.settings == bt}"
                          className="user-depth-${bean.limitedDepth + 1}"><c:out value="${bt.name}"/></forms:option>
          </c:forEach>
          <c:forEach items="${templates}" var="tpl">
            <forms:option value="${tplPrefix}${tpl.externalId}"
                          title="${tpl.fullName}"
                          selected="${buildTypeForm.settings == tpl}"
                          className="user-depth-${bean.limitedDepth + 1}"><c:out value="${tpl.name}"/> (template)</forms:option>
          </c:forEach>
          <c:if test="${empty buildTypes and empty templates}"><forms:option value="" className="user-delete" disabled="true">&nbsp;</forms:option></c:if>
        </forms:projectOptGroup>
      </c:if>
    </c:forEach>
  </forms:select>

  <div class="popupSaveButtonsBlock">
    <forms:submit name="copyBuildStep" label="Copy"/>
    <forms:cancel onclick="BS.CopyBuildStepForm.cancelDialog()" showdiscardchangesmessage="false"/>
    <forms:saving id="copyBuildStepProgress"/>
  </div>

  <input type="hidden" name="id" id="sourceSettingsId" value="${buildTypeForm.settingsId}"/>
  <input type="hidden" name="runnerId" id="sourceRunnerId" value="${runnerId}"/>
</bs:modalDialog>