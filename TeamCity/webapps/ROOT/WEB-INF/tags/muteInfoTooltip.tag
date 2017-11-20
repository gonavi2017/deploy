<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %>
<%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %>

<%@ attribute name="test" type="jetbrains.buildServer.serverSide.TestEx" required="false" %>
<%@ attribute name="testRun" type="jetbrains.buildServer.serverSide.TestRunEx" required="false" %>
<%@ attribute name="showActions" type="java.lang.Boolean" required="false" %>

<c:set var="project" value="<%=test == null ? testRun.getBuild().getBuildType().getProject() : test.getProject()%>"/>

<bs:muteInfo currentMuteInfo="${empty test ? null : test.currentMuteInfo}"
             buildMuteInfo="${empty testRun ? null : testRun.muteInfo}"
             project="${project}"/>

<c:if test="${showActions}">
  <authz:authorize projectId="${test.projectId}" anyPermission="ASSIGN_INVESTIGATION,MANAGE_BUILD_PROBLEMS">
    <jsp:attribute name="ifAccessGranted">
      <div class="actions">
        <tt:testInvestigationLinks test="${test}" buildId="${not empty testRun.buildOrNull ? testRun.build.buildId : ''}"/>
      </div>
    </jsp:attribute>
    <jsp:attribute name="ifAccessDenied">
      <div class="actions">No permissions to modify mute state</div>
    </jsp:attribute>
  </authz:authorize>
</c:if>