<%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@

    attribute name="testCount" fragment="false" required="true" %><%@
    attribute name="id" fragment="false" required="false" type="java.lang.String" %><%@
    attribute name="maxTests2Show" required="true" type="java.lang.Integer" %><%@
    attribute name="buildData" fragment="false" required="true" type="jetbrains.buildServer.serverSide.SBuild" %><%@
    attribute name="testType" required="true"
%>

<c:if test="${maxTests2Show > 0 and testCount > maxTests2Show}">
  <div class="icon_before icon16 attentionComment">
    Too many ${testType} tests, showing ${maxTests2Show} tests only.
    <bs:_viewLog build="${buildData}" tab="buildResultsDiv" urlAddOn="&maxFailed=-1">Show all ${testCount} ${testType} tests &raquo;</bs:_viewLog>
  </div>
</c:if>
