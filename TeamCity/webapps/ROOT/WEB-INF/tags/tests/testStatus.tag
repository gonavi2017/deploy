<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@
    attribute name="testRun" required="true" type="jetbrains.buildServer.serverSide.TestRunEx"

%><c:set var="status" value="${testRun.status}"
/><c:set var="testNameId" value="${testRun.test.testNameId}"
/><c:set var="buildData" value="${testRun.build}"
/><c:set var="muted" value="${testRun.muted}"/><c:choose
  ><c:when test="${status.successful}"><span class="success">OK</span><c:if test="${testRun.invocationCount > 1}"> <span class="invocationCount">(${testRun.invocationCount} runs)</span></c:if></c:when
  ><c:when test="${status == 'FAILURE' || status == 'ERROR' }"
    ><c:set var="linkText" value="${muted ? 'Muted failure' : 'Failure'}"
    /><c:choose
      ><c:when test="${not empty testNameId and not empty buildData}"
          ><tt:testStatusDetailsLink buildData="${buildData}"
                                     testNameId="${testNameId}"
                                     cssClass="${muted ? 'muted' : 'failure'}">${linkText}</tt:testStatusDetailsLink
      ></c:when
    ><c:otherwise><span class="failure">Failure</span></c:otherwise
    ></c:choose
  ><c:if test="${testRun.invocationCount > 1}"> <span class="invocationCount">(${testRun.failedInvocationCount} of ${testRun.invocationCount})</span></c:if></c:when
  ><c:when test="${status == 'UNKNOWN'}"><span style="color: ${status.htmlColor}">Ignored</span></c:when
  ><c:otherwise><span style="color: ${status.htmlColor}"><c:out value="${status}"/></span></c:otherwise
></c:choose>