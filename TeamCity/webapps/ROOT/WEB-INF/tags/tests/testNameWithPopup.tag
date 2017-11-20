<%@ tag display-name="testNameWithPopup"%><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %><%@
    taglib prefix="util" uri="/WEB-INF/functions/util" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    attribute name="testRun" type="jetbrains.buildServer.serverSide.TestRunEx" required="true" %><%@
    attribute name="test" type="jetbrains.buildServer.serverSide.STest" required="false" %><%@
    attribute name="showPackage" type="java.lang.Boolean" required="false" %><%@
    attribute name="trimTestName" type="java.lang.Boolean" required="false" %><%@
    attribute name="maxTestNameLength" type="java.lang.Integer" required="false" %><%@
    attribute name="noClass" type="java.lang.Boolean"
              description="<p>If <code>true</code>, the name of the class
              containing the test is hidden. The default is <code>false</code>
              (class name displayed).</p>

              <p>Additionally, if the flag is
              <code>true</code>, investigated/muted/flaky icons are not
              displayed, either (their display is the responsibility of the
              enclosing container).<p>" %><%@
    attribute name="hideResponsibileIcon" type="java.lang.Boolean" required="false" %><%@
    attribute name="link2Stacktrace" type="java.lang.Boolean" required="false" %><%@
    attribute name="testDetailsUrlParams" type="java.lang.String" required="false" %><%@
    attribute name="testLinkAttrs" type="java.lang.String" required="false" %><%@
    attribute name="ignoreMuteScope" type="java.lang.Boolean" required="false" %><%@
    attribute name="flakyIconVisible" type="java.lang.Boolean"
              description="Whether flaky icon should be visible for flaky tests.
              The default is <code>true</code>. For regular (non-flaky) tests no
              icon is displayed, even if this attribute is <code>true</code>. If
              <code>noClass</code> flag is set, no icon is displayed, either." %><%@
    attribute name="showMuteFromTestRun" type="java.lang.Boolean" required="false" %><%@
    attribute name="groupIdForBulkMode" type="java.lang.String" required="false" %><%@
    attribute name="doNotHighlightMyInvestigation" type="java.lang.String" required="false" %><%@
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

%><c:set var="popupId">testActionsPopup${util:uniqueId()}</c:set
><c:set var="build" value="${testRun.buildOrNull}"
/><c:set var="test" value="${not empty test ? test : testRun.test}"
/><c:set var="allResp" value="${test.allResponsibilities}"
/><c:set var="resp" value="${not empty allResp ? allResp[0] : null}"
/><%--@elvariable id="resp" type="jetbrains.buildServer.responsibility.TestNameResponsibilityEntry"--%><c:if
    test="${empty showPackage}"><c:set var="showPackage" value="${true}"/></c:if
><c:set var="testNameClass" value="${testRun.newFailure ? 'newTestFailure' : ''}"
/><%--@elvariable id="currentUser" type="jetbrains.buildServer.users.SUser"--%><c:if
    test="${not doNotHighlightMyInvestigation and currentUser.highlightRelatedDataInUI and
                not empty resp and resp.responsibleUser == currentUser and resp.state.active}"
    ><c:set var="testNameClass" value="${testNameClass} highlightChanges"
/></c:if

><bs:popup_static controlId="${popupId}"
                 controlClass="testNamePopup ${testNameClass}"
                 popup_options="shift: {x: -30, y: 15}">
  <jsp:attribute name="content">
    <table class="testActionsPopup">
      <tr><td>
        <tt:testDetailsLink testBean="${test}">Test History</tt:testDetailsLink>
      </td></tr>
      <authz:authorize projectId="${test.projectId}" anyPermission="ASSIGN_INVESTIGATION,MANAGE_BUILD_PROBLEMS">
        <jsp:attribute name="ifAccessGranted">
          <tr><td>
            <span class="icon icon16 bp taken"></span>
            <tt:testInvestigationLinks test="${test}"
                                       buildId="${build.buildId}"
                                       testGroupId="${groupIdForBulkMode}"
                                       withFix="${not empty resp && resp.state.active}"
                                       responsibilityRemovalMethod="${responsibilityRemovalMethod}"
                                       unmuteOptionType="${unmuteOptionType}"
                                       comment="${comment}"/>
          </td></tr>
        </jsp:attribute>
      </authz:authorize>
      <c:if test="${not empty build and testRun.status.failed}">
        <tr><td>
          <tt:activateTestLink build="${build}" testId="${testRun.testRunId}">Open in IDE</tt:activateTestLink>
        </td></tr>
        <tr><td>
          <bs:buildLogLink buildData="${build}" buildLogAnchor="${testRun.firstFailedTestRunId}"/>
        </td></tr>
        <tr id="copyInMenuLinkTR_${build.buildId}_${testRun.test.testNameId}" style="display: none"><td>
          <bs:copy2ClipboardLink dataId="fullStacktrace_${build.buildId}_${testRun.test.testNameId}">Copy Stacktrace to Clipboard</bs:copy2ClipboardLink>
        </td></tr>
      </c:if>
      <c:if test="${not empty build and not testRun.status.failed}">
        <tr><td>
          <bs:buildLogLink buildData="${build}" buildLogAnchor="${testRun.testRunId}"/>
        </td></tr>
      </c:if>
    </table>
  </jsp:attribute>

  <jsp:body>
    <c:set var="body">
      <tt:testName testRun="${testRun}" testBean="${test}" trimTestName="${trimTestName}"
                   maxTestNameLength="${maxTestNameLength}"
                   noClass="${noClass}" showPackage="${showPackage}"/>
    </c:set>

    <c:choose>
      <c:when test="${link2Stacktrace}">
        <c:set var="body">
          <tt:testStatusDetailsLink testNameId="${test.testNameId}"
                                    buildData="${build}"
                                    attrs="${testLinkAttrs}">${body}</tt:testStatusDetailsLink>
        </c:set>
      </c:when>
      <c:when test="${not empty testDetailsUrlParams}">
        <c:set var="body">
          <c:set var="onclick"
                 value="BS.TestDetails.toggleDetails(this, '/change/testDetails.html?${testDetailsUrlParams}'); return false;"/>
          <a class="testWithDetails" onclick="${onclick}" title="Show related test details" href="#testNameId${testRun.test.testNameId}">${body}</a>
        </c:set>
      </c:when>
    </c:choose>

    <c:if test="${testRun.fixed && !build.personal}">
      <c:set var="body"><s class="fixed" title="Test is already fixed">${body}</s></c:set>
    </c:if><tt:testIcon hideResponsibileIcon="${hideResponsibileIcon}" responsibility="${resp}" responsibilities="${allResp}"
                 test="${test}" testRun="${testRun}"
                 btScope="${not empty build ? build.buildType : null}"
                 ignoreMuteScope="${ignoreMuteScope}"
                 showMuteFromTestRun="false" noClass="${noClass}"
                 flakyIconVisible="${empty flakyIconVisible or flakyIconVisible}"></tt:testIcon>${body}</jsp:body>
</bs:popup_static>

<c:if test="${showMuteFromTestRun and testRun.muted}">
  <bs:inlineMuteInfo muteInfo="${testRun.muteInfo}" currentMuteInfo="${testRun.test.currentMuteInfo}"/>
</c:if>
