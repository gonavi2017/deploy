<%@ tag display-name="testNameWithPopupShort"
        trimDirectiveWhitespaces="true"
        example="<tt:testNameWithPopupShort test='${sTest}'/>"
        description="<p>A replacement for <code>&lt;tt:testNameWithPopup/&gt;</code>
        which provides fewer details (&quot;Open&nbsp;in&nbsp;IDE&quot; and
        &quot;Show&nbsp;in&nbsp;Build&nbsp;Log&quot; links are not available)
        but doesn't require a <code>TestRunEx</code> instance.</p>

        <dl>
          <dt><b>Since:</b></dt><dd>10.0</dd>
        </dl>" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %>
<%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %>
<%@ taglib prefix="util" uri="/WEB-INF/functions/util" %>

<%@ attribute name="test" type="jetbrains.buildServer.serverSide.STest" required="true"
              description="The test to display details for." %>
<%@ attribute name="showPackage" type="java.lang.Boolean" required="false"
              description="If <code>true</code> (default), package name of the
              class containing the test is displayed." %>
<%@ attribute name="trimTestName" type="java.lang.Boolean" required="false"
              description="If <code>true</code>, the displayed test name will
              be trimmed to <code>maxTestNameLength</code> character(s). The
              default is <code>false</code>." %>
<%@ attribute name="maxTestNameLength" type="java.lang.Integer" required="false"
              description="Maximum length of the displayed test name. If not
              set, the default value of 80, overridable via
              <code>teamcity.ui.test.max.length</code> internal property,
              is used. Applicable only if <code>trimTestName</code> is
              <code>true</code>." %>
<%@ attribute name="noClass" type="java.lang.Boolean" required="false"
              description="<p>If <code>true</code>, the name of the class
              containing the test is hidden. The default is <code>false</code>
              (class name displayed).</p>

              <p>Additionally, if the flag is
              <code>true</code>, investigated/muted/flaky icons are not
              displayed, either (their display is the responsibility of the
              enclosing container).<p>" %>
<%@ attribute name="hideResponsibleIcon" type="java.lang.Boolean" required="false"
              description="If <code>true</code>, &quot;investigated&quot; (in
              case an investigation is assigned) and &quot;fixed&quot; icons are
              not displayed. The default is <code>false</code>." %>
<%@ attribute name="testDetailsUrlParams" type="java.lang.String" required="false"
              description="Additional URL parameters (in the form of
              <code>projectId=XYZ&builds=1234.&testNameId=5678</code>) necessary
              to construct a link to the related test." %>
<%@ attribute name="flakyIconVisible" type="java.lang.Boolean"
              description="Whether flaky icon should be visible for flaky tests.
              The default is <code>true</code>. For regular (non-flaky) tests no
              icon is displayed, even if this attribute is <code>true</code>. If
              <code>noClass</code> flag is set, no icon is displayed, either." %>
<%@ attribute name="groupIdForBulkMode" type="java.lang.String" required="false"
              description="The unique <code>id</code> of the enclosing test
              group." %>
<%@ attribute name="doNotHighlightMyInvestigation" type="java.lang.String" required="false"
              description="If <code>true</code>, and there's an investigation
              pending assigned to the current user, the displayed test name is
              not highlighted. The default is <code>false</code> (any
              investigation results in test name being highlighted)." %>
<%@ attribute name="responsibilityRemovalMethod"
              type="jetbrains.buildServer.responsibility.ResponsibilityEntry.RemoveMethod"
              required="false" description="Default resolution mode for new
              investigations created for this test, either &quot;Automatically
              when fixed&quot; or &quot;Manually&quot;." %>
<%@ attribute name="unmuteOptionType"
              type="jetbrains.buildServer.serverSide.mute.UnmuteOptionType"
              required="false" description="The requested unmute method for new
              investigations." %>
<%@ attribute name="comment" type="java.lang.String" required="false"
              description="The requested initial comment for new investigations." %>

<c:set var="responsibilities" value="${test.allResponsibilities}"/>
<c:set var="responsibility" value="${not empty responsibilities ? responsibilities[0] : null}"/>
<%--@elvariable id="responsibility" type="jetbrains.buildServer.responsibility.TestNameResponsibilityEntry"--%>
<%--@elvariable id="currentUser" type="jetbrains.buildServer.users.SUser"--%>

<c:if test="${not doNotHighlightMyInvestigation
                and currentUser.highlightRelatedDataInUI
                and not empty responsibility
                and responsibility.responsibleUser == currentUser
                and responsibility.state.active}">
  <c:set var="testNameClass" value="highlightChanges"/>
</c:if>

<bs:popup_static controlId="testActionsPopup${util:uniqueId()}"
                 controlClass="testNamePopup ${testNameClass}"
                 popup_options="shift: {x: -30, y: 15}">
  <jsp:attribute name="content">
    <table class="testActionsPopup">
      <tr>
        <td>
          <tt:testDetailsLink testBean="${test}">Test History</tt:testDetailsLink>
        </td>
      </tr>
      <authz:authorize projectId="${test.projectId}" anyPermission="ASSIGN_INVESTIGATION,MANAGE_BUILD_PROBLEMS">
        <jsp:attribute name="ifAccessGranted">
          <tr>
            <td>
              <span class="icon icon16 bp taken actionPopupIcon"></span>
              <tt:testInvestigationLinks
                  test="${test}"
                  testGroupId="${groupIdForBulkMode}"
                  withFix="${not empty responsibility && responsibility.state.active}"
                  responsibilityRemovalMethod="${responsibilityRemovalMethod}"
                  unmuteOptionType="${unmuteOptionType}"
                  comment="${comment}"/>
            </td>
          </tr>
        </jsp:attribute>
      </authz:authorize>
    </table>
  </jsp:attribute>

  <jsp:body>
    <c:set var="body">
      <tt:testName testBean="${test}"
                   trimTestName="${trimTestName}"
                   maxTestNameLength="${maxTestNameLength}"
                   noClass="${noClass}"
                   showPackage="${empty showPackage ? true : showPackage}"/>
    </c:set>

    <c:if test="${not empty testDetailsUrlParams}">
      <c:set var="body">
        <c:set var="onclick"
               value="BS.TestDetails.toggleDetails(this, '/change/testDetails.html?${testDetailsUrlParams}'); return false;"/>
        <a class="testWithDetails" onclick="${onclick}" title="Show related test details" href="#testNameId${test.testNameId}">${body}</a>
      </c:set>
    </c:if>

    <%--
      We don't have any testRun information, so we can't show any "newly-muted"
      icons.

      Since we don't have any mute scope (no SBuildType instance available),
      we should ignore the it (ignoreMuteScope == true). This is equivalent to
      simply checking test.currentMuteInfo for being non-null.
      --%>
    <tt:testIcon hideResponsibileIcon="${hideResponsibleIcon}"
                 responsibility="${responsibility}"
                 responsibilities="${responsibilities}"
                 test="${test}"
                 testRun="${null}"
                 ignoreMuteScope="${true}"
                 noClass="${noClass}"
                 flakyIconVisible="${empty flakyIconVisible or flakyIconVisible}"/>
    ${body}
  </jsp:body>
</bs:popup_static>
