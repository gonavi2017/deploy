<%@ page import="jetbrains.buildServer.controllers.ActionMessages" %>
<%@ page import="jetbrains.buildServer.web.openapi.PlaceId" %>
<%@ include file="/include-internal.jsp" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<jsp:useBean id="buildForm" type="jetbrains.buildServer.controllers.admin.projects.BuildTypeForm" scope="request"/>
<c:set var="saved" value='<%=ActionMessages.getOrCreateMessages(request).hasMessage("buildRunnerSettingsUpdated")%>'/>

<bs:messages key="buildRunnerSettingsUpdated"/>
<bs:messages key="noRunnersFound"/>
<c:set var="numRunners" value="${fn:length(buildForm.multipleRunnersBean.buildRunners)}"/>
<c:if test="${not buildForm.buildRunnerBean.newRunner and not buildForm.readOnly}">
  <div style="float:right;">
    <c:url value='/admin/editRunType.html?init=1&id=${buildForm.settingsId}&runnerId=__NEW_RUNNER__' var="addStepUrl"/>
    <forms:addButton href="${addStepUrl}">Add build step &raquo;</forms:addButton>
  </div>
</c:if>

<h2 class="noBorder">
<c:choose>
  <c:when test="${numRunners > 1}">
    <bs:popup_static controlId="configurationSteps" popup_options="shift: {x: -150, y: 20}, className: 'buildStepsPopup quickLinksMenuPopup'">
      <jsp:attribute name="content">
        <l:tableWithHighlighting highlightImmediately="true" className="buildStepsMenu" style="width:100%;">
          <tr><th>Build Steps</th></tr>
          <c:set var="stepno" value="0" />
          <c:forEach items="${buildForm.multipleRunnersBean.buildRunners}" var="runner">
            <c:set var="stepno" value="${stepno + 1}" />
            <c:url value='/admin/editRunType.html?init=1&id=${buildForm.settingsId}&runnerId=${runner.id}&cameFromUrl=${buildForm.cameFromSupport.cameFromUrl}' var="onclickUrl"/>
            <tr>
              <td class="highlight" onclick="BS.openUrl(event, '${onclickUrl}')">
                <admin:runnerInfo runner="${runner}" stepno="${stepno}"/>
              </td>
            </tr>
          </c:forEach>
        </l:tableWithHighlighting>
      </jsp:attribute>
      <jsp:body>
        <%--do not reformat the following line--%>
        <span style="white-space: normal">${buildForm.buildRunnerBean.newRunner ? 'New' : ''} Build Step<c:if test="${buildForm.multipleRunnersBean.currentRunnerPosition > 0}"> (${buildForm.multipleRunnersBean.currentRunnerPosition} of
            <a href="<c:url value='/admin/editBuildRunners.html?id=${buildForm.settingsId}'/>" title="Build Steps List">${numRunners}</a>)</c:if>:
          <c:choose>
            <c:when test="${fn:length(buildForm.buildRunnerBean.buildStepName) > 0}">
              <c:set var="buildStepName"><c:out value="${buildForm.buildRunnerBean.buildStepName}"/></c:set>
              <bs:makeBreakable text="${buildStepName}" regex=".{60}" escape="${false}"/>
            </c:when>
            <c:otherwise><c:out value="${buildForm.buildRunnerBean.runType.displayName}"/></c:otherwise>
          </c:choose>
        </span>
      </jsp:body>
    </bs:popup_static>
  </c:when>
  <c:otherwise>${buildForm.buildRunnerBean.newRunner ? 'New' : ''} Build Step</c:otherwise>
</c:choose>
</h2>

<p:container contextId="runner_edit_${buildForm.buildRunnerBean.id}" JSObject="BS.EditBuildRunnerForm.Controls">
<jsp:attribute name="content">

<table class="runnerFormTable">
  <tr>
    <th class="noBorder"><label for="runTypeInfoKey">Runner type:</label></th>
    <td class="noBorder"><forms:select name="runTypeInfoKey"
                                       onchange="BS.updateRunnerContainer();"
                                       enableFilter="true"
                                       filterOptions="{listMaxVisible:16}"
                                       className="mediumField">
      <forms:option value="" selected="${not buildForm.buildRunnerBean.runnerTypeSelected}">-- Choose build runner type --</forms:option>
      <c:set var="useGroups" value="${fn:length(buildForm.buildRunnerBean.availableRunTypes) gt 1}"/>
      <c:forEach items="${buildForm.buildRunnerBean.availableRunTypes}" var="it">
        <c:set var="runTypes" value="${it.value}"/>
        <c:choose>
          <c:when test="${useGroups}">
            <optgroup label='<c:out value="${it.key.name}"/>'>
              <%@ include file="editRunParamsOptions.jspf"%>
            </optgroup>
          </c:when>
          <c:otherwise>
            <%@ include file="editRunParamsOptions.jspf"%>
          </c:otherwise>
        </c:choose>
      </c:forEach>
    </forms:select><forms:saving id="chooseRunnerProgress" className="progressRingInline"/>
    <c:if test="${buildForm.buildRunnerBean.runnerTypeSelected}">
      <c:set var="selectedInfo" value="${buildForm.buildRunnerBean.selectedRunType}"/>
      <span class="smallNote"><c:out value="${selectedInfo.description}"/></span>
    </c:if>
    </td>
  </tr>

  <c:if test="${buildForm.buildRunnerBean.runnerTypeSelected}">
  <tr>
    <th class="noBorder"><label for="buildStepName">Step name:</label></th>
    <td>
      <forms:textField name="buildStepName" value="${buildForm.buildRunnerBean.buildStepName}" className="longField"/>
      <span class="smallNote">Optional, specify to distinguish this build step from other steps.</span>
    </td>
  </tr>
  <tr class="advancedSetting">
    <th class="noBorder"><label for="${buildForm.buildRunnerBean.stepExecutionPolicyKey}">Execute step:<bs:help file="Configuring+Build+Steps"/></label></th>
    <td>
      <props:selectProperty name="${buildForm.buildRunnerBean.stepExecutionPolicyKey}" enableFilter="true" className="longField">
        <c:forEach var="p" items="${buildForm.buildRunnerBean.stepExecutionPolicyValues}">
          <props:option value="${p.value}"><c:out value="${p.description}"/></props:option>
        </c:forEach>
      </props:selectProperty>
      <span class="smallNote">Specify the step execution policy.</span>
    </td>
  </tr>
  </c:if>

  <c:if test="${buildForm.buildRunnerBean.runnerTypeSelected}">
  <c:set var="propertiesBean" scope="request" value="${buildForm.buildRunnerBean.propertiesBean}"/>
  <c:set var="includes" value="${buildForm.buildRunnerBean.availableRunnerExtensionUrls}"/>
  <c:choose>
    <c:when test="${not empty includes}">
      <c:forEach var="url" items="${includes}">
        <jsp:include page="${url}"/>
      </c:forEach>
    </c:when>
    <c:otherwise>
      <jsp:include page="/notImplemented.jsp"/>
    </c:otherwise>
  </c:choose>

  <ext:includeExtensions placeId="<%=PlaceId.EDIT_BUILD_RUNNER_SETTINGS_FRAGMENT%>"/>

  <input type="hidden" name="publicKey" id="publicKey" value="${buildForm.publicKey}"/>

  <c:if test="${not empty sessionScope['actionErrors']}">
    <jsp:useBean id="actionErrors" type="jetbrains.buildServer.controllers.ActionErrors" scope="session"/>
    <script type="text/javascript">
      <c:forEach items="${actionErrors.errors}" var="error">
      <c:set var="message"><bs:out value='${error.message}'/></c:set>
      BS.EditBuildRunnerForm.showError('${error.id}', '<bs:escapeForJs text='${message}'/>');
      </c:forEach>
      BS.EditBuildRunnerForm.focusFirstErrorField();
    </script>
  </c:if>

  <script type="text/javascript">
    BS.MultilineProperties.updateVisible();
    BS.EditBuildRunnerForm.setModified(${buildForm.buildRunnerBean.stateModified});
  </script>

  </c:if>
</table>

<admin:showHideAdvancedOpts containerId="editBuildTypeForm" optsKey="buildStepSettings_${buildForm.multipleRunnersBean.currentBuildRunnerBean.runTypeInfoKey}"/>
<admin:highlightChangedFields containerId="editBuildTypeForm"/>

</jsp:attribute>
</p:container>
