<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<%@attribute name="feature" type="jetbrains.buildServer.controllers.admin.projects.BuildFeatureBean" required="true" %>
<%@attribute name="showName" type="java.lang.Boolean" %>
<%@attribute name="showDescription" type="java.lang.Boolean" %>
<div style="${not feature.enabled ? 'color: #888': ''}">
  <c:if test="${empty showName or showName}">
    <div class="featureName">
      <c:out value="${feature.descriptor.buildFeature.displayName}"/>
      <admin:buildTypeSettingStatusDescription
          inherited="${feature.inherited}" disabled="${not feature.enabled}" overridden="${feature.overridden and feature.canEdit}"
          inheritanceDescription="${feature.canEdit ? 'inherited' : feature.inheritanceDescription}" />

      <c:if test="${not feature.canEdit}">
        <c:choose>
          <c:when test="${feature.own != null}">
            <i href="#" class="icon-lock undefinedParam" title="Local settings are overriden by ${feature.inheritanceDescription}"></i>
          </c:when>
          <c:otherwise>
            <i class="icon-lock protectedSetting" title="${feature.inheritanceDescription}"></i>
          </c:otherwise>
        </c:choose>
      </c:if>
    </div>
  </c:if>
  <c:if test="${empty showDescription or showDescription}">
  <div class="featureDescription">
    ${feature.shortDescription}
  </div>
  </c:if>
</div>