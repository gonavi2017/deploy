<%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@

    attribute name="vri" required="true" type="jetbrains.buildServer.vcs.VcsRootInstanceEx"
%>
<div class="vcsRootInstanceDetails" data-vriId="${vri.id}">

  Latest check for changes: <bs:date value="${vri.lastFinishChangesCollectingTime}" smart="2"/>
  (${fn:toLowerCase(vri.lastRequestor.description)})
  <br>
  Changes checking interval: <bs:printTime time="${vri.effectiveModificationCheckInterval}"/><c:if test="${not vri.pollingMode}">,
    the latest change was detected with a commit hook
  </c:if>

</div>