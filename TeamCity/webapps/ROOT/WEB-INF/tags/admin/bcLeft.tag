<%--@elvariable id="serverSummary" type="jetbrains.buildServer.web.openapi.ServerSummary"--%>
<%@
  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
  taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
  taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<bs:professionalFeature>
  <c:set var="bcLeft" value="${serverSummary.buildConfigurationsLeft}"/>
  <span class="commentText small"><c:choose>
    <c:when test="${bcLeft > 0}">(${bcLeft}</c:when>
    <c:otherwise>(none</c:otherwise>
  </c:choose> left)</span>
</bs:professionalFeature>
