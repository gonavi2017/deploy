<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<%@attribute name="buildType" required="true" type="jetbrains.buildServer.serverSide.SBuildType"%>
<%@attribute name="num" required="true" type="java.lang.Integer"%>
<admin:editBuildTypeNavSteps settings="${buildType}"/>
<h2 class="groupTitle">
  ${buildConfigSteps[num].title}
    <authz:authorize projectId="${buildType.projectId}" allPermissions="EDIT_PROJECT">
      <span class="editSettingsLink">
        <admin:editBuildTypeLink buildTypeId="${buildType.externalId}" step="${buildConfigSteps[num].stepId}" cameFromUrl="${cameFromUrl}">edit &raquo;</admin:editBuildTypeLink>
      </span>
    </authz:authorize>
</h2>
