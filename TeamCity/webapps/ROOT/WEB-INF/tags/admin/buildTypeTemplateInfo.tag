<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@attribute name="buildType" required="true" type="jetbrains.buildServer.serverSide.SBuildType" %>
<c:set var="template" value="${buildType.templateAccessible ? buildType.template : null}"/>
<c:choose>
  <c:when test="${template != null and template.parentProject.projectId == buildType.projectId}"><span class="templateUsage">Based on <strong><bs:trimWithTooltip maxlength="30">${template.name}</bs:trimWithTooltip></strong></span></c:when>
  <c:when test="${template != null}"><span class="templateUsage">Based on <strong><bs:trimWithTooltip maxlength="30">${template.fullName}</bs:trimWithTooltip></strong></span></c:when>
  <c:when test="${buildType.templateBased and not buildType.templateAccessible}"><span class="templateUsage"><i>Based on inaccessible template, you do not have enough permissions to modify settings of this build configuration</i></span></c:when>
</c:choose>
