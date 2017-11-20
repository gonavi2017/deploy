<%@ include file="/include-internal.jsp" %>

<c:set var="firstFailedInBuild" value="${not empty loadedTestRun ? loadedTestRun.firstFailed : null}"/>
<c:set var="currentIsFFI" value="${not empty loadedTestRun and (empty firstFailedInBuild or firstFailedInBuild == build)}"/>
<c:set var="hasAnotherFFI" value="${not empty loadedTestRun and not empty firstFailedInBuild and not currentIsFFI}"/>

<c:if test="${not empty loadedTestRun && not empty loadedTestRun.fixedIn}">
  <tr data-buildId="${loadedTestRun.fixedIn.buildId}">
    <td class="selector">&nbsp;</td>
    <td class="header">Already fixed in:<bs:help file="Already Fixed In"/></td>
    <c:set var="_currBuild" value="${loadedTestRun.fixedIn}"/>
    <%@ include file="_relatedBuildTDs.jspf" %>
  </tr>
</c:if>

<c:set var="currTestId" value="${empty loadedTestRun ? testId : loadedTestRun.testRunId}"/>

<tr class="selectedBuild" data-buildId="${build.buildId}" data-testId="${currTestId}"
    data-invocationCount="${not empty loadedTestRun ? loadedTestRun.invocationCount : 0}"
    data-failedInvocationCount="${not empty loadedTestRun ? loadedTestRun.failedInvocationCount : 0}"
    >
  <td class="selector">
    <c:if test="${hasAnotherFFI}">
      <input type='radio' name='currentSelector_${build.buildId}_${currTestId}' checked="true"/>
    </c:if>
  </td>
  <td class="header">
    <c:if test="${currentIsFFI}">
      First failure:<bs:help file="First Failure"/>
    </c:if>
    <c:if test="${not currentIsFFI}">
      Current failure:
    </c:if>
  </td>
  <c:set var="_currBuild" value="${build}"/>
  <%@ include file="_relatedBuildTDs.jspf" %>
</tr>

<c:choose>
  <c:when test="${empty loadedTestRun}">
    <tr>
      <td class="selector">&nbsp;</td>
      <td class="header">First failure:<bs:help file="First Failure"/></td>
      <td colspan="4"><em>Calculating ...</em></td>
    </tr>
  </c:when>
  <c:when test="${hasAnotherFFI}">
    <tr data-buildId="${firstFailedInBuild.buildId}" data-testId="${ffiTestRun.testRunId}"
        data-invocationCount="${ffiTestRun.invocationCount}"
        data-failedInvocationCount="${ffiTestRun.failedInvocationCount}">
      <td class="selector"><input type='radio' name='currentSelector_${build.buildId}_${currTestId}'/></td>
      <td class="header">First failure:<bs:help file="First Failure"/></td>
      <c:set var="_currBuild" value="${firstFailedInBuild}"/>
      <%@ include file="_relatedBuildTDs.jspf" %>
    </tr>
  </c:when>
</c:choose>

