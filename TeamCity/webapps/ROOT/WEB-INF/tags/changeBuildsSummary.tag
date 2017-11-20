<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="l" tagdir="/WEB-INF/tags/layout" %><%@
    attribute name="changeStatus" required="true" type="jetbrains.buildServer.vcs.ChangeStatus" %><c:choose
  ><c:when test="${changeStatus.runningBuildsNumber == 0 && changeStatus.pendingBuildsTypesNumber == 0}"
    >all builds with this change have finished
  </c:when
  ><c:when test="${changeStatus.runningBuildsNumber == 0 && changeStatus.finishedBuildsNumber == 0}"
    >no builds with this change have started yet (${changeStatus.pendingBuildsTypesNumber} pending)
  </c:when
  ><c:otherwise>
    ${changeStatus.finishedBuildsNumber} finished, ${changeStatus.runningBuildsNumber} running,
    ${changeStatus.pendingBuildsTypesNumber} pending
    build<bs:s val="${changeStatus.pendingBuildsTypesNumber}"/></c:otherwise
></c:choose>