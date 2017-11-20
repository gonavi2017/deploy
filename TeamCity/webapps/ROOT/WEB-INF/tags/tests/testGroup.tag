<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@
    attribute name="levelToSet" required="true" %><%@
    attribute name="testItems" required="true" type="java.util.List" %><%@
    attribute name="buildData" required="true" type="jetbrains.buildServer.serverSide.SBuild" %><%@
    attribute name="maxTestNameLength" type="java.lang.Integer" %><%@
    attribute name="flakyIconVisible" type="java.lang.Boolean"
              description="Whether flaky icon should be visible for flaky tests.
              The default is <code>true</code>. For regular (non-flaky) tests no
              icon is displayed, even if this attribute is <code>true</code>."
%><c:forEach items="${testItems}" var="testRun">
  <%--@elvariable id="testRun" type="jetbrains.buildServer.serverSide.STestRun"--%>
  <%--@elvariable id="tests" type="jetbrains.buildServer.controllers.viewLog.TestsTabData"--%>
  <tr>
    <td class="test-status"><c:if test="${testRun.newFailure}"><span class="icon icon16 bp test new" title="This is a new failed test" style="margin-left: -15px;"></span>&nbsp;</c:if><tt:testStatus testRun="${testRun}"/></td>
    <td class="nameT">
      <bs:responsibleIcon responsibility="${testRun.test.responsibility}"
                          test="${testRun.test}"
                          style="cursor: auto;"/>
      <bs:testRunMuteIcon testRun="${testRun}"
                          btScope="${testRun.build.buildType}"
                          ignoreMuteScope="false"
                          showMuteFromTestRun="false"/>
      <c:if test="${(empty flakyIconVisible or flakyIconVisible) and not empty testRun}">
        <bs:testFlakyIcon test="${testRun.test}"/>
      </c:if>
      <c:set var="group" value="${testRun.test.name.groupName}"/>
      <tt:classLink group="${group}">.</tt:classLink
      ><tt:testNameWithPopup testRun="${testRun}" showPackage="false" noClass="true" maxTestNameLength="${maxTestNameLength}"
                            hideResponsibileIcon="true"
                            link2Stacktrace="${testRun.status.failed}"
                            doNotHighlightMyInvestigation="true"/>
      <c:if test="${group.packageSet or group.suiteSet}">
        <span class="package">
          (<tt:suiteLink group="${group}" levelToSet="${levelToSet}"><c:if test="${group.packageSet}">:</c:if></tt:suiteLink><tt:packageLink group="${group}" levelToSet="${levelToSet}"/>)
        </span>
      </c:if>
    </td>
    <td class="duration"><tt:duration duration='${testRun.duration}'/>
      <c:choose>
        <c:when test="${empty tests.badStatsTestIds[testRun.test.testNameId]}">
          <a href="#" onclick="return false;" title="View test duration graph" id="trends${testRun.testRunId}"><i class="tc-icon icon16 tc-icon_graph" title="View trend"></i></a>
        </c:when>
        <c:otherwise>
          <span class="graphPlace"></span>
        </c:otherwise>
      </c:choose>
    </td>
    <td class="orderNum"><c:out value="${testRun.orderId}"/></td>
  </tr>
</c:forEach>
