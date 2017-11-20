<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %>
<%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %>

<%@ attribute name="buildProblem" type="jetbrains.buildServer.serverSide.problems.BuildProblem" required="true" %>
<%@ attribute name="responsibility" type="jetbrains.buildServer.responsibility.ResponsibilityEntry" required="false" %>
<%@ attribute name="showIcon" type="java.lang.Boolean" required="false" %>
<%@ attribute name="showFixLink" type="java.lang.Boolean" required="false" %>

<authz:authorize projectId="${buildProblem.projectId}" anyPermission="ASSIGN_INVESTIGATION,MANAGE_BUILD_PROBLEMS">
  <jsp:attribute name="ifAccessGranted">
    <div class="actions">
      <c:if test="${showIcon}">
        <span class="icon icon16 bp taken actionPopupIcon"></span>
      </c:if>

      <c:set var="promoId" value="${buildProblem.buildPromotion.id}"/>

      <c:set var="onclick"
             value="return BS.BulkInvestigateMuteTestDialog.showForBuildProblem('${buildProblem.id}', '${promoId}');"/>

      <c:if test="${empty responsibility}"><c:set var="responsibility" value="${buildProblem.responsibility}"/></c:if>

      <c:if test="${showFixLink and not empty responsibility and responsibility.state.active}">
        <authz:authorize projectId="${buildProblem.projectId}" allPermissions="ASSIGN_INVESTIGATION">
          <jsp:attribute name="ifAccessGranted">
            <a href="#" title="Fix and unmute"
               onclick="return BS.BulkInvestigateMuteTestDialog.showForBuildProblem('${buildProblem.id}', '${promoId}', true);">Fix...</a><span
              class="separator">|</span
          ></jsp:attribute
        ></authz:authorize
      ></c:if
          ><tt:testInvestigationLink onclick="${onclick}" projectId="${buildProblem.projectId}"
                                     hideMuteLink="<%=jetbrains.buildServer.messages.ErrorData.isInternalError(buildProblem.getBuildProblemData().getType())%>"/>
    </div>
  </jsp:attribute>
</authz:authorize>