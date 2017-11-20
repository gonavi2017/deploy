<%@ include file="include-internal.jsp" %>
<%@ taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %>
<jsp:useBean id="buildChain" type="jetbrains.buildServer.serverSide.dependency.BuildChain" scope="request"/>
<jsp:useBean id="failedTestsBean" type="jetbrains.buildServer.controllers.changes.FailedTestsBean" scope="request"/>
<c:url value="/viewChainProblems.html?chainId=${buildChain.id}" var="problemsUrl"/>
<bs:refreshable containerId="buildResults" pageUrl="${problemsUrl}">
<c:choose>
  <c:when test="${not failedTestsBean.hasFailedTests}">
    <div class="smallNote">
      There are no failed tests
    </div>
  </c:when>
  <c:otherwise>
    <c:if test="${failedTestsBean.hasNewFailedTests}">
      <c:set var="testsNum" value="${failedTestsBean.newTestsNumber}"/>
      <c:set var="btNum" value="${failedTestsBean.newAffectedBuildTypesNumber}"/>

      <c:set var="newTestsTitle">
        <span class="icon icon16 build-status-icon build-status-icon_error"></span> ${testsNum} new failed test<bs:s val="${testsNum}"/> in ${btNum} build configuration<bs:s val="${btNum}"/>
      </c:set>

      <bs:_collapsibleBlock title="${newTestsTitle}" id="buildNewFailedTests">
        <tt:_testGroupForChange testList="${failedTestsBean.newFailedTests}" defaultOption="bt" id="change_fail"/>
      </bs:_collapsibleBlock>

    </c:if>

    <c:if test="${failedTestsBean.otherTestsNumber > 0}">
      <c:set var="testsNum" value="${failedTestsBean.otherTestsNumber}"/>
      <c:set var="btNum" value="${failedTestsBean.otherAffectedBuildTypesNumber}"/>
      <c:set var="blockHeader">
        ${testsNum} test<bs:s val="${testsNum}"/> failing from previous builds
        in ${btNum} build configuration<bs:s val="${btNum}"/>
      </c:set>

      <bs:_collapsibleBlock title="${blockHeader}" id="oldTests">
        <tt:_testGroupForChange testList="${failedTestsBean.otherTests}" defaultOption="bt" id="change_other"/>
      </bs:_collapsibleBlock>
    </c:if>
  </c:otherwise>
</c:choose>
</bs:refreshable>
