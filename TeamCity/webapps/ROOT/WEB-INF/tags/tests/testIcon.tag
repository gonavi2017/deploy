<%@ attribute name="showMuteFromTestRun" type="java.lang.Boolean" %>
<%@ attribute name="btScope" type="jetbrains.buildServer.serverSide.SBuildType"%>
<%@ attribute name="testRun" type="jetbrains.buildServer.serverSide.TestRunEx" required="true"%>
<%@ attribute name="test" type="jetbrains.buildServer.serverSide.STest" required="true" %>
<%@ attribute name="responsibilities" type="java.util.List<jetbrains.buildServer.responsibility.TestNameResponsibilityEntry>" %>
<%@ attribute name="responsibility" type="jetbrains.buildServer.responsibility.TestNameResponsibilityEntry" %>
<%@ attribute name="hideResponsibileIcon" type="java.lang.Boolean" required="false" %>
<%@ attribute name="ignoreMuteScope" type="java.lang.Boolean" required="false" %>
<%@ attribute name="noClass" type="java.lang.Boolean" required="false" %>
<%@ attribute name="flakyIconVisible" type="java.lang.Boolean"
              description="Whether flaky icon should be visible for flaky tests.
              The default is <code>true</code>. For regular (non-flaky) tests no
              icon is displayed, event if this attribute is <code>true</code>." %>
<%@ tag display-name = "testIcon"
        trimDirectiveWhitespaces="true" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %><%@
    taglib prefix="util" uri="/WEB-INF/functions/util" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><span class="testIcons"><c:if test="${not noClass}">
<c:set var="test" value="${not empty test ? test : not empty testRun ? testRun.test : null}"/>
<%--@elvariable id="test" type="jetbrains.buildServer.serverSide.STest"--%>
<c:set var="newFailure" value="${not empty testRun && testRun.newFailure}"/><c:if test="${not hideResponsibileIcon}"
><bs:responsibleIcon responsibility="${responsibility}" responsibilities="${responsibilities}"
                     test="${test}" showNew="${newFailure}"
                     style="cursor: auto;"/></c:if
><bs:testRunMuteIcon testRun="${testRun}"
                     test="${test}"
                     btScope="${btScope}" showNew="${newFailure && not shownNewReponsibility}"
                     ignoreMuteScope="${ignoreMuteScope}"
                     showMuteFromTestRun="false"
/>
<c:if test="${(empty flakyIconVisible or flakyIconVisible) and not empty test}">
  <bs:testFlakyIcon test="${test}" showNew="${newFailure && not shownNewReponsibility && not shownNewMute}"/>
</c:if>
</c:if><c:if test="${newFailure && not shownNewReponsibility && not shownNewMute && not shownNewFlacky}"><span class="icon icon16 bp test new" title="This is a new failed test"></span></c:if>
</span>