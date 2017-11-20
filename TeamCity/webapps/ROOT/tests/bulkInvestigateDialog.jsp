<%@ page import="jetbrains.buildServer.controllers.tests.BulkInvestigateDialogController" %>
<%@ include file="/include-internal.jsp" %>
<%@ taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ftd" uri="/WEB-INF/functions/flaky-test-detector" %>
<%@ taglib prefix="resp" tagdir="/WEB-INF/tags/responsible" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="problems" tagdir="/WEB-INF/tags/problems" %>

<jsp:useBean id="investigateBean" type="jetbrains.buildServer.controllers.tests.BulkInvestigateBean" scope="request"/>
<jsp:useBean id="muteTestBean" type="jetbrains.buildServer.controllers.investigate.BulkMuteBean" scope="request"/>
<jsp:useBean id="tests" type="java.util.Map<jetbrains.buildServer.serverSide.STest,java.util.List<jetbrains.buildServer.serverSide.SBuild>>" scope="request"/>
<jsp:useBean id="buildProblems" type="java.util.List<jetbrains.buildServer.serverSide.problems.BuildProblem>" scope="request"/>
<jsp:useBean id="projectScopeBeans" type="java.util.List" scope="request"/>
<jsp:useBean id="allRelatedProjects" type="java.util.List" scope="request"/>
<jsp:useBean id="requestedProject" type="jetbrains.buildServer.serverSide.SProject" scope="request"/>
<jsp:useBean id="projectsWithoutPermissions" type="java.util.Map" scope="request"/>
<%--@elvariable id="currentUser" type="jetbrains.buildServer.users.SUser"--%>

<c:set var="flakyTestCount" value="${0}"/>
<c:set var="origProjectId" value="<%= BulkInvestigateDialogController.PARAM_ORIG_PROJECT_ID%>"/>
<%--@elvariable id="flakyTestCount" type="int"--%>

<div class="investigation-dialog">
  <div class="list custom-scroll">
    <c:forEach items="${tests}" var="entry">
      <c:set var="test" value="${entry.key}"/>
      <c:set var="testNameId" value="${test.testNameId}"/>
      <c:if test="${ftd:isFlaky(testNameId)}">
        <c:set var="flakyTestCount" value="${flakyTestCount + 1}"/>
      </c:if>
      <div class="testSpan">
        <bs:responsibleIcon responsibilities="${test.allResponsibilities}" test="${test}" noActions="true"/>
        <bs:currentMuteIcon test="${test}" noActions="true"/>
        <bs:testFlakyIcon test="${test}" noActions="true"/>
        <tt:testName testBean="${test}" showPackage="true"/>

        <c:set var="valueStr" value=""/>
        <c:forEach var="build" items="${entry.value}">
          <c:set var="valueStr" value="${valueStr},${build.buildId}"/>
        </c:forEach>
        <input type="hidden" name="${testNameId}" value="${valueStr}"/>
      </div>
    </c:forEach>

    <div class="bpl custom-scroll">
      <div class="tcTable">
        <c:forEach items="${buildProblems}" var="entry" varStatus="entryStatus">
          <div class="tcRow">
            <%--@elvariable id="entry" type="jetbrains.buildServer.serverSide.problems.BuildProblem"--%>
            <c:set var="uid" value="bpuid_${entryStatus.index}"
            /><problems:buildProblemIcon buildProblem="${entry}" currentMuteInfo="${entry.currentMuteInfo}"
            /><problems:buildProblemDescription buildProblemUID="${uid}" buildProblem="${entry}" compactMode="true" showPopup="false" showLink="false" invokeDescription="true"
            /><problems:buildProblem buildProblem="${entry}" compactMode="true" buildProblemUID="${uid}"/>
          </div>
          <c:set var="problemId" value="${entry.id}"/>
          <input type="hidden" name="BuiPro${problemId}" value="${entry.buildPromotion.id}"/>
        </c:forEach>
      </div>
    </div>
  </div>

  <%--
    If more than one test is selected, issue a warning if some/all tests are
    flaky.
  --%>
  <c:set var="testCount" value="${fn:length(tests)}"/>
  <c:if test="${testCount gt 1 and flakyTestCount gt 0}">
    <c:set var="warningText">
      <c:choose>
        <c:when test="${flakyTestCount eq testCount}">
          All ${testCount} tests are flaky.
        </c:when>
        <c:otherwise>
          ${flakyTestCount} of ${testCount} tests
          ${flakyTestCount eq 1 ? "is" : "are"} flaky.
        </c:otherwise>
      </c:choose>
    </c:set>
    <div class="icon_before icon16 tc-icon_attention">${warningText}</div>
  </c:if>

  <div class="project-info">
    <table class="investigate-params">
      <tr>
        <th>
          <label for="scopeProjectId">Project scope:</label>
        </th>
        <td><bs:projectsFilter projectBeans="${projectScopeBeans}"
                               selectedProjectExternalId="${investigateBean.projectExternalId}"
                               disabledProjects="${projectsWithoutPermissions}"
                               name="projectId"
                               id="scopeProjectId"
                               onchange="BS.BulkInvestigateMuteTestDialog.reloadDialog()"/>
          <forms:saving id="mute-dialog-inner-progress" className="progressRingInline"/>

          <span class="commentText">Investigation and mute options will be applied in the selected project.</span>

          <c:if test="${ fn:length(allRelatedProjects) > 1 or (fn:length(allRelatedProjects) == 1 and not util:contains(allRelatedProjects, requestedProject))}">
            <p>
              The following projects contain related investigations/mutes:
            </p>
            <ul class="relatedProjects">
              <c:forEach items="${allRelatedProjects}" var="prj">
                <li>

                    <bs:projectLinkFull project="${prj}" target="_blank"/>
                    <authz:authorize projectId="${prj.projectId}" anyPermission="ASSIGN_INVESTIGATION, MANAGE_BUILD_PROBLEMS">
                    <jsp:attribute name="ifAccessDenied">
                       <span class="commentText">(no permission to change)</span>
                    </jsp:attribute>
                    </authz:authorize>

                </li>

              </c:forEach>
            </ul>

          </c:if>
        </td>
      </tr>
    </table>
  </div>

  <resp:investigationAndMuteSettings investigateBean="${investigateBean}" muteBean="${muteTestBean}"/>

  <div class="popupSaveButtonsBlock">

    <input type="hidden" name="origProjectId" value="${not empty param[origProjectId] ? param[origProjectId] : param['projectId']}"/>

    <forms:submit onclick="return BS.BulkInvestigateMuteTestDialog.submit();" id="submit" label="Save"/>
    <forms:cancel onclick="BS.BulkInvestigateMuteTestDialog.close()"/>
    <forms:saving id="investigate-saving"/>

    <!-- 'init' parameter is passed on the first load of the dialog; dialog reload means something has changed -->
    <forms:checkbox name="commentOrScopeChanged" checked="${empty param['init']}"/>

    <c:if test="${not empty param['projectId'] and param['projectId'] ne investigateBean.projectExternalId}">
      <div class="icon_before icon16 attentionComment _inline-block">Project scope was changed due to presence of existing investigations/mutes</div>
    </c:if>
  </div>
</div>

<script type="text/javascript">
  <c:set var="assignAutomatically" value="${investigateBean.givenUp and not muteTestBean.muted and not muteTestBean.bulk}"/>
  <c:set var="assignAutomatically" value="${assignAutomatically or fn:length(allRelatedProjects) > 1}"/>

  <c:set var="contextBuildTypeId" value="${not empty muteTestBean.contextBuildType ? muteTestBean.contextBuildType.buildTypeId : ''}"/>
  BS.BulkInvestigateMuteTestDialog.prepareOnShow(${assignAutomatically}, '${contextBuildTypeId}');
  BS.BulkInvestigateMuteTestDialog.checkUserPermissionsOnChange('${investigateBean.projectExternalId}');
</script>
