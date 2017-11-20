<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@

    attribute name="title" required="true" type="java.lang.String" %><%@
    attribute name="tests" required="true" type="java.util.List"
    %><c:if test="${fn:length(tests) > 0}"
  ><c:if test="${not empty title}"
    ><div class="head">${title}</div>
  </c:if
  ><c:forEach items="${tests}" var="testBean"
    ><c:set var="testRun" value="${testBean.test}"
   /><jsp:useBean id="testRun" type="jetbrains.buildServer.serverSide.STestRun"/><c:set var="testText"
      ><bs:responsibleIcon responsibility="${testRun.test.responsibility}" test="${testRun.test}"
                           style="padding: 0; vertical-align: top; margin: 0; height: 16px; width: 16px; cursor: auto;"
      /> <tt:testName testBean="${testRun.test}" showPackage="true"/></c:set
    ><c:set var="elemId" value="test-${testRun.test.testNameId}_${testRun.test.projectId}"
    /><c:set var="clazz" value="testSpan"
    /><c:if test="${testRun.newFailure}"><c:set var="clazz" value="new ${clazz}"/></c:if
    ><span class="${clazz}">
      <forms:checkbox name="${elemId}" id="${elemId}" checked="${testBean.checked}"/>
      <label for="${elemId}">${testText}</label>
    </span>
  </c:forEach>
</c:if>