<%@ tag display-name = "testInvestigationLinks" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="ftd" uri="/WEB-INF/functions/flaky-test-detector" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %><%@
    attribute name="test" type="jetbrains.buildServer.serverSide.STest" required="true" %><%@
    attribute name="buildId" type="java.lang.String" required="false" %><%@
    attribute name="testGroupId" type="java.lang.String" required="false" %><%@
    attribute name="withFix" type="java.lang.Boolean" required="false" %><%@
    attribute name="responsibilityRemovalMethod"
              type="jetbrains.buildServer.responsibility.ResponsibilityEntry.RemoveMethod"
              required="false" description="Default resolution mode for new
              investigations created for this test, either &quot;Automatically
              when fixed&quot; or &quot;Manually&quot;." %><%@
    attribute name="unmuteOptionType"
              type="jetbrains.buildServer.serverSide.mute.UnmuteOptionType"
              required="false" description="The requested unmute method for new
              investigations." %><%@
    attribute name="comment" type="java.lang.String" required="false"
              description="The requested initial comment for new investigations."
%>
<c:set var="testFlaky" value="${ftd:isFlaky(test.testNameId)}"/>
<%-- Below, we actually use the "reverse ordinal", as 0 (the default) conforms
to WHEN_FIXED in HTML, while WHEN_FIXED itself has an ordinal of 1.--%>
<c:set var = "responsibilityRemovalMethodOrdinal">
  <c:choose>
    <c:when test="${not empty responsibilityRemovalMethod}">${responsibilityRemovalMethod.manually ? 1 : 0}</c:when>
    <%-- If the test is flaky, prefer RemoveMethod = MANUALLY --%>
    <c:when test="${testFlaky}">1</c:when>
    <c:otherwise>undefined</c:otherwise>
  </c:choose>
</c:set>
<c:set var = "unmuteOptionTypeCode">
  <c:choose>
    <c:when test="${not empty unmuteOptionType}">'${unmuteOptionType.code}'</c:when>
    <%-- If the test is flaky, prefer UnmuteOptionType = MANUALLY --%>
    <c:when test="${testFlaky}">'M'</c:when>
    <c:otherwise>undefined</c:otherwise>
  </c:choose>
</c:set>
<c:set var = "escapedComment">
  <c:choose>
    <c:when test="${not empty comment}">'<bs:escapeForJs text="${comment}" forHTMLAttribute="${true}"/>'</c:when>
    <%-- If the test is flaky, prefer non-empty comment --%>
    <c:when test="${testFlaky}">'This test is flaky!'</c:when>
    <c:otherwise>undefined</c:otherwise>
  </c:choose>
</c:set>
<c:set var="optionalArgs">
  {
  responsibilityRemovalMethod: ${responsibilityRemovalMethodOrdinal},
  unmuteOptionType: ${unmuteOptionTypeCode},
  comment: ${escapedComment}
  }
</c:set>
<c:if test="${withFix}">
<authz:authorize projectId="${test.projectId}" anyPermission="ASSIGN_INVESTIGATION">
  <jsp:attribute name="ifAccessGranted">
    <a href="#" title="Fix and unmute test"
       onclick="return BS.BulkInvestigateMuteTestDialog.showForTest('${test.testNameId}', '${buildId}', '${testGroupId}', '${test.projectExternalId}', true, ${optionalArgs});">Fix...</a><span class="separator">|</span>
  </jsp:attribute>
</authz:authorize></c:if>
<tt:testInvestigationLink
    onclick="return BS.BulkInvestigateMuteTestDialog.showForTest('${test.testNameId}', '${buildId}', '${testGroupId}', '${test.projectExternalId}', false, ${optionalArgs});"
    projectId="${test.projectId}"/>
