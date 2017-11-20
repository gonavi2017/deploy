<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags"%><%@
    taglib prefix="l" tagdir="/WEB-INF/tags/layout"%><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz"%><%@
    taglib prefix="admin" tagdir="/WEB-INF/tags/admin"%><%@
    attribute name="buildType" required="true" type="jetbrains.buildServer.serverSide.SBuildType"%><%@
    attribute name="style" required="false"
%>
<c:if test="${buildType.paused}">
  <c:set var="title">
    <c:set var="pauseComment" value="${buildType.pauseComment}"/>
    <c:if test="${not empty pauseComment}">
      <c:set var="user">
        <c:if test="${not empty pauseComment.user}">
          &nbsp;by <c:out value="${pauseComment.user.descriptiveName}"/>
        </c:if>
      </c:set>
      <c:set var="date">
        <c:if test="${not empty pauseComment.timestamp}">&nbsp;<bs:date value="${pauseComment.timestamp}" smart="true" no_span="${true}"/></c:if>
      </c:set>
      <c:set var="comment">
        &nbsp;<bs:_commentText forTooltip="${true}" comment="${pauseComment}"/>
      </c:set>
      Build configuration was paused${user}${date}${comment}
    </c:if>
  </c:set>
  <span class="icon build-status-icon build-status-icon_paused" <bs:tooltipAttrs text="${title}" evalScripts="${true}"/>></span>
</c:if>



