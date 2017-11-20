<%@ page import="jetbrains.buildServer.web.openapi.PlaceId" %>
<%@ page import="jetbrains.buildServer.web.openapi.WebPlace" %>
<%@ include file="/include-internal.jsp"%>
<%@ taglib prefix="profile" tagdir="/WEB-INF/tags/userProfile"%>
<jsp:useBean id="notifierSettingsForm" type="jetbrains.buildServer.controllers.profile.notifications.NotifierSettingsForm" scope="request"/>
<ext:includeExtensions placeId="<%=PlaceId.NOTIFIER_SETTINGS_FRAGMENT%>"/>

<bs:messages key="settingsUpdated" style="margin-left: 0; width: 53em;"/>

<c:if test="${not empty notifierSettingsForm.pluginSection and (notifierSettingsForm.editee.id == currentUser.id || afn:permissionGrantedGlobally('CHANGE_USER'))}">
<div class="notifierSettings clearfix">
  <c:set var="pluginSection" value="${notifierSettingsForm.pluginSection}"/>
  <form id="notifierSettingsForm" action="<c:url value='/notifierSettings.html'/>" method="POST" onsubmit="return BS.NotifierPropertiesForm.submitSettings()">
    <div class="notifierSettingControls">
      <table>
      <c:forEach items="${pluginSection.propertyList}" var="property" varStatus="pos">
        <c:set var="propertyField" value="properties[${property.propertyName}].value"/>
        <tr>
          <td><label class="notifierSettingControls__label" for="${propertyField}"><c:out value="${property.displayName}"/>:</label></td>
          <td>
            <input class="textField" type="text" id="${propertyField}" name="${propertyField}" style="width: 30em;"
                     maxlength="256" value="<c:out value="${property.value}"/>"/>
          </td>
        </tr>
      </c:forEach>
      </table>
    </div>
    <input type="hidden" name="notificatorType" value="${notifierSettingsForm.notificator.notificatorType}"/>
    <input type="hidden" name="userId" value="${notifierSettingsForm.editee.id}"/>
    <input type="submit" value="Save" class="btn btn_mini submitButton"/>
    <forms:saving id="saving_settings"/>
  </form>
</div>
</c:if>

<div id="notificationRulesPage">
<jsp:include page="/notificationRules.html?notificatorType=${notifierSettingsForm.notificator.notificatorType}&holderId=user:${notifierSettingsForm.editee.id}"/>
</div>
