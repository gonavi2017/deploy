<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="l" tagdir="/WEB-INF/tags/layout" %><%@
    taglib prefix="util" uri="/WEB-INF/functions/util" %><%@
    taglib prefix="ftd" uri="/WEB-INF/functions/flaky-test-detector" %><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %><%@

    attribute name="groupId" type="java.lang.String" required="false" %><%@
    attribute name="withoutActions" required="true" %><%@
    attribute name="testBean" type="jetbrains.buildServer.web.problems.STestBean" %><%@

    attribute name="testMoreData" fragment="true" required="false" %><%@
    attribute name="testAfterName" fragment="true" required="false" %><%@

    attribute name="maxTestNameLength" type="java.lang.Integer" required="false" %><%@
    attribute name="testLinkAttrs" required="false" %><%@

    attribute name="ignoreMuteScope" type="java.lang.Boolean" required="false" %><%@
    attribute name="showMuteFromTestRun" type="java.lang.Boolean" required="false" %><%@

    attribute name="showPackage" required="false" type="java.lang.Boolean" %><%@
    attribute name="checkboxRequired" required="false" type="java.lang.Boolean" %><%@
    attribute name="singleBuildTypeContext" required="false" type="java.lang.Boolean"

%>
<c:set var="failedRunCount" value="${testBean.failedRunCount}"/>
<c:set var="buildsCount" value="${testBean.buildsCount}"/>
<c:set var="btCount" value="${testBean.buildTypeCount}"/>

<c:set var="buildsNum" value="${singleBuildTypeContext ? 1 : buildsCount}"/>
<c:set var="testRun" value="${testBean.run}"/>
<%--@elvariable id="testRun" type="jetbrains.buildServer.serverSide.TestRunEx"--%>
<c:set var="test" value="${testBean.test}"/>
<c:set var="build" value="${testRun.buildOrNull}"/>
<c:set var="testDetailsUrlParams" value="testNameId=${testBean.test.testNameId}&builds="/>
<c:forEach var="bld" items="${testBean.relatedBuilds}">
  <c:set var="testDetailsUrlParams" value="${testDetailsUrlParams}${bld.buildId}."/>
</c:forEach>
<c:set var="testDetailsUrlParams" value="${testDetailsUrlParams}&projectId=${test.projectExternalId}"/>
<c:set var="link2stacktrace" value="${false}"/>
<%--@elvariable id="linkToTestRequired" type="java.lang.Boolean"--%>
<%--@elvariable id="doNotHighlightMyInvestigation" type="java.lang.Boolean"--%>

<tr>
  <td class="testNamePart">
    <c:set var="testNameId" value="${test.testNameId}"/>
    <c:if test="${checkboxRequired}">
      <authz:authorize projectId="${test.projectId}" anyPermission="ASSIGN_INVESTIGATION,MANAGE_BUILD_PROBLEMS">
        <c:set var="test_uuid"><bs:id/></c:set>
        <forms:checkbox custom="true" name="tst-${test_uuid}" attrs="data-testId=\"${testNameId}\" data-flaky=\"${ftd:isFlaky(testNameId)}\"" className="checkbox"/>
        <span class="chkboxPlace"></span>
      </authz:authorize>
    </c:if>
    <c:if test="${linkToTestRequired}">
      <c:set var="link2stacktrace" value="${true}"/>
      <c:set var="testDetailsUrlParams" value="${null}"/>
    </c:if>
    <!-- This span is for #testNameId navigation to the test ONLY -->
    <span id="testNameId${testNameId}">
      <tt:testNameWithPopup testRun="${testRun}" test="${test}"
                            trimTestName="${true}" maxTestNameLength="${maxTestNameLength}"
                            testDetailsUrlParams="${testDetailsUrlParams}" link2Stacktrace="${link2stacktrace}"
                            showPackage="${showPackage}"
                            testLinkAttrs="${testLinkAttrs}"
                            ignoreMuteScope="${ignoreMuteScope}" showMuteFromTestRun="${showMuteFromTestRun}"
                            groupIdForBulkMode="${groupId}"
                            doNotHighlightMyInvestigation="${doNotHighlightMyInvestigation}"/>
      </span>
      <jsp:invoke fragment="testAfterName"/>
  </td>
  <td class="testFailedInPart">
    <c:if test="${failedRunCount > 1}">
      <c:choose>
        <%-- Multiple build types, single build type context: --%>
        <c:when test="${singleBuildTypeContext and btCount == 2}">
          <c:set var="_buildType" value="${testBean.buildTypes[1]}"/>
          also fails in <%@include file="_buildTypeLink.jspf" %>
          <c:if test="${failedRunCount != btCount}">(total ${failedRunCount} failures)</c:if>
        </c:when>
        <c:when test="${singleBuildTypeContext and btCount > 2}">
          also fails in ${btCount - 1} configurations<c:if test="${failedRunCount != btCount}"> (total ${failedRunCount} failures)</c:if><%@include file="_buildTypesTooltip.jspf" %>
        </c:when>

        <%-- Multiple build types, not single build type context --%>
        <c:when test="${failedRunCount == btCount}">
          ${btCount} build configurations<%@include file="_buildTypesTooltip.jspf" %>
        </c:when>
        <c:when test="${btCount > 1 and btCount == buildsCount}">
          ${failedRunCount} failures in ${btCount} configurations<%@include file="_buildTypesTooltip.jspf"%>
        </c:when>
        <c:when test="${btCount > 1 and btCount < buildsCount and failedRunCount == buildsCount}">
          ${buildsCount} builds of ${btCount} configurations<%@include file="_buildTypesTooltip.jspf" %>
        </c:when>
        <c:when test="${btCount > 1 and btCount < buildsCount}">
          ${failedRunCount} failures in ${buildsCount} builds of ${btCount} configurations<%@include file="_buildTypesTooltip.jspf" %>
        </c:when>

        <%-- Single build type: --%>
        <c:when test="${btCount == 1 and failedRunCount == buildsCount}">
          ${buildsCount} builds
        </c:when>
        <c:when test="${btCount == 1 and buildsCount > 1}">
          ${failedRunCount} failures in ${buildsCount} builds
        </c:when>
        <c:when test="${buildsCount == 1}">
          ${failedRunCount} failures in one build
        </c:when>
      </c:choose>
    </c:if>
    <c:if test="${failedRunCount == 1 and btCount > 0 and not singleBuildTypeContext}">
      <c:set var="_buildType" value="${testBean.buildTypes[0]}"/>
      Failed in <%@include file="_buildTypeLink.jspf" %>
    </c:if>
    <c:if test="${failedRunCount == 0 and testBean.runCount > 0 and not testBean.run.status.ignored}">
      <em>no recent failures</em>
    </c:if>
    <c:if test="${testBean.runCount == 0}">
      <em>no recent test runs</em>
    </c:if>
  </td>
</tr>
<jsp:invoke fragment="testMoreData"/>
<c:if test="${btCount > 1}">
  <c:set var="_lastBuild" value="${null}" scope="request"/>
</c:if>
<c:if test="${buildsNum == 1}">
  <c:set var="_lastBuild" value="${build}" scope="request"/>
</c:if>
