<%@include file="/include-internal.jsp" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<jsp:useBean id="publicKey" scope="request" type="java.lang.String"/>
<jsp:useBean id="action" scope="request" type="java.lang.String"/>
<jsp:useBean id="form" scope="request" type="jetbrains.buildServer.clouds.server.web.admin.CloudAdminProfileForm"/>
<jsp:useBean id="extensions" scope="request" type="java.util.Collection<jetbrains.buildServer.clouds.CloudTypeExtension>"/>
<jsp:useBean id="postUrl" scope="request" type="java.lang.String"/>
<jsp:useBean id="serverUrl" scope="request" type="java.lang.String"/>
<jsp:useBean id="projectId" scope="request" type="java.lang.String"/>
<jsp:useBean id="cameFromSupport" scope="request" type="jetbrains.buildServer.web.util.CameFromSupport"/>
<jsp:useBean id="terminateConditionsFactory" scope="request" type="jetbrains.buildServer.clouds.server.instances.terminate.TerminateConditionsFactory "/>

<c:set var="cameFromUrl" value="<%=cameFromSupport.getCameFromUrl()%>"/>

<c:if test="${empty form.selectedProfile}">
  <c:set var="title">Create New Cloud Profile</c:set>
</c:if>
<c:if test="${not empty form.selectedProfile}">
  <c:set var="title">Edit cloud profile ${fn:escapeXml(form.selectedProfile.profileName)}</c:set>
</c:if>

<script type="text/javascript">
  var prevItem = BS.Navigation.items[BS.Navigation.items.length-1];
  prevItem.selected = false;
  prevItem.url = '<c:url value="/admin/editProject.html?projectId=${form.projectExtId}&tab=clouds"/>';

  BS.Navigation.items.push({
    title: "<bs:escapeForJs text='${title}'/>",
    url: '${pageUrl}',
    selected: true
  });
  BS.Navigation.writeBreadcrumbs();

  BS.Clouds.Admin.CreateProfileForm.baseParams = function() {
    return "&action=${action}<c:if test="${not empty form.selectedProfile}">&profileId=${form.selectedProfile.profileId}</c:if>";
  };
</script>

<c:set var="ajaxUrl"><c:url value="${postUrl}"/></c:set>

<div id="newProfileFormDialog" class="cloudProfile">

<form id="newProfileForm" action="${ajaxUrl}" method="post" onsubmit="return BS.Clouds.Admin.CreateProfileForm.submit();" autocomplete="off">

<input type="hidden" name="projectId" id="projectId" value="${projectId}" class="ignoreModified"/>

<table class="runnerFormTable">
  <tr>
    <th><label for="profileName">Profile name: <l:star/></label></th>
    <td>
      <props:textProperty name="profileName" className="longField"/>
      <span id="error_profileName" class="error"></span>
    </td>
  </tr>
  <tr>
    <th><label for="profileDescription">Description:</label></th>
    <td>
      <props:textProperty name="profileDescription" className="longField"/>
      <span id="error_profileDescription"></span>
    </td>
  </tr>
  <tr>
    <th><label for="cloudType">Cloud type: <l:star/></label></th>
    <td>
      <forms:select name="cloudType" onchange="BS.Clouds.Admin.CreateProfileForm.refreshSelectedCloudType();" className="longField" enableFilter="true">
        <forms:option value="" selected="${empty form.selectedTypeCode}">--- Choose cloud type ---</forms:option>
        <c:forEach items="${form.cloudTypes}" var="type">
          <forms:option value="${type.cloudCode}" selected="${not empty form.selectedTypeCode and type.cloudCode eq form.selectedTypeCode}"><c:out value="${type.displayName}"/></forms:option>
        </c:forEach>
      </forms:select>
      <forms:saving id="newProviderSaving" className="progressRingInline"/>
      <span class="error" id="error_cloudType"></span>
    </td>
  </tr>
  <tr>
    <td colspan="2">
      <forms:attentionComment>
        Server URL<bs:help file="Configuring+Server+URL"/> is <strong><c:out value="${serverUrl}"/></strong>.
        It will be used by build agent to connect. Make sure this URL is available from build agent machine.
        To change it use <a href="<c:url value='/admin/admin.html?item=serverConfigGeneral'/>" target="_blank">Server Configuration page</a>.
      </forms:attentionComment>
    </td>
  </tr>
</table>


<bs:refreshable containerId="newProfilesContainer" pageUrl="${ajaxUrl}">
  <c:if test="${not empty form.selectedType}">
    <table class="runnerFormTable">
      <tr>
      <tr>
        <th><label for="terminateTimeOut">Terminate instance idle time:</label></th>
        <td>
          <props:textProperty name="terminateTimeOut" className="longField"/>
          <span id="error_terminateTimeOut" class="error"></span>
          <span class="smallNote">Minutes to wait before stopping idle build agent. Leave empty to have no timeout</span>
        </td>
      </tr>
      <tr>
        <th>
          <label>Additional terminate conditions:</label>
        </th>
        <td id="terminateConditionsTd">
          <c:forEach items="${terminateConditionsFactory.getTerminateConditionsFactories(true)}" var="fact">
            <div class="terminateCondition">
            <c:if test="${fact.customizable}">
              <input style="margin:0; padding:0" type="checkbox" id="${fact.code}_checkbox"
              <c:if test="${not empty propertiesBean.properties[fact.code]}">checked="checked"</c:if>
                       onclick="BS.Clouds.Admin.Profile.toggleOption($j(this).is(':checked'), '${fact.code}', '${fact.defaultValue}'); return true;"/>
              <label for="${fact.code}_checkbox"><c:out value="${fact.description}"/></label>
              <props:textProperty name="${fact.code}">
                  <jsp:attribute name="className">
                    <c:if test="${empty propertiesBean.properties[fact.code]}">hidden</c:if>
                  </jsp:attribute>
              </props:textProperty>
            </c:if>
            <c:if test="${not fact.customizable}">
              <props:checkboxProperty name="${fact.code}" value="true"/>
              <label for="${fact.code}"><c:out value="${fact.description}"/></label>
            </c:if>
            </div>
          </c:forEach>
        </td>
      </tr>
    <c:choose>
      <c:when test="${not empty form.selectedType.editProfileUrl}">
          <jsp:include page="${form.selectedType.editProfileUrl}"/>
      </c:when>
      <c:otherwise>
        <tr>
          <td colspan="2">
            <bs:smallNote>There are no additional options.</bs:smallNote>
          </td>
        </tr>
      </c:otherwise>
    </c:choose>
    <c:forEach var="ext" items="${extensions}">
      <jsp:useBean id="ext" type="jetbrains.buildServer.clouds.CloudTypeExtension"/>
      <!-- Cloud profile form extension: ${ext} -->
      <jsp:include page="${ext.includeUrl}"/>
      <!-- End of: Cloud profile form extension: ${ext} -->
    </c:forEach>
    </table>
  </c:if>

  <input type="hidden" id="publicKey" name="publicKey" value="${publicKey}"/>
  <input type="hidden" id="action" name="action" value="${action}"/>
  <c:if test="${not empty form.selectedProfile}">
    <input type="hidden" id="profileId" name="profileId" value="${form.selectedProfile.profileId}"/>
  </c:if>
</bs:refreshable>

<div class="popupSaveButtonsBlock">
  <input type="hidden" id="cameFromUrl" value="${cameFromUrl}"/>
  <forms:submit label="${form.submitButtonCaption}" id="createButton"/>
  <forms:cancel cameFromSupport="${cameFromSupport}"/>
  <forms:saving id="newProfileProviderProgress"/>
</div>
  <forms:modified onSave="$j(this.form).submit();"/>

 </form>
</div>

<c:choose>
  <c:when test="${project.readOnly}">
    <script type="text/javascript">
      $j(document).ready(function() {
        BS.Clouds.Admin.CreateProfileForm.disable();
      });
    </script>
  </c:when>
  <c:otherwise>
    <script type="text/javascript">
      BS.Clouds.Admin.CreateProfileForm.beforeShow();
      BS.Clouds.Admin.CreateProfileForm.recordInitialParams();
    </script>
  </c:otherwise>
</c:choose>
