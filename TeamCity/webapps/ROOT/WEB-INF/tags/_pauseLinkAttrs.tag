<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<%@attribute name="buildType" required="true" type="jetbrains.buildServer.serverSide.SBuildType"%>
<c:choose>
  <c:when test="${buildType.pauseComment != null && not empty buildType.pauseComment.comment}">
    <c:set var="tooltipText"><bs:pauseCommentText buildType="${buildType}" forTooltip="true"/></c:set>
    <bs:tooltipAttrs text="${tooltipText}"/>
  </c:when>
 <c:otherwise><jsp:doBody/></c:otherwise>
</c:choose>