<%@ tag import="jetbrains.buildServer.UserChangeStatus" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags"%><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    attribute name="changeStatus" required="true" type="jetbrains.buildServer.vcs.ChangeStatus"%>

<c:set var="failed" value="${changeStatus.failedCount}"/>
<c:set var="successsful" value="${changeStatus.successCount}"/>
<c:set var="total_conf" value="${fn:length(changeStatus.relatedConfigurations)}"/>
<c:choose>
  <c:when test="${failed > 0}"> failed in ${failed} build configuration<bs:s val="${failed}"/> </c:when>
  <c:when test="${changeStatus.successCount > 0}"> successful in ${successsful} of ${total_conf} build configuration<bs:s val="${total_conf}"/> </c:when>
  <c:when test="${changeStatus.pendingBuildsTypesNumber > 0}"> queued
  <c:if test="${successsful > 0}">(${successsful} of ${total_conf} successful)</c:if>
  </c:when>
  <c:when test="${changeStatus.runningBuildsNumber > 0}"> running, no failures yet </c:when>
</c:choose>
