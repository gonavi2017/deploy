<%@ page contentType="text/html;charset=UTF-8" language="java" session="true"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %>

<%--@elvariable id="duplicatesInfo" type="jetbrains.buildServer.serverSide.impl.codeDuplicates.DuplicatesInfo"--%>
<!-- ${duplicatesInfo.buildId} vs ${duplicatesInfo.prevBuildId} -->
<c:if test="${not empty duplicatesInfo}">
<c:set var="stats" value="${duplicatesInfo.statistics}"/>
<c:choose>
  <c:when test="${duplicatesInfo.build.buildStatus.successful || stats[0]>0}">
    <p>Duplicates found: <strong>${stats[0]}</strong> (+${stats[1]} -${stats[2]})
      &nbsp;&nbsp;&nbsp;&nbsp;<bs:_viewLog build="${duplicatesInfo.build}" tab="Duplicator">View duplicates &raquo;</bs:_viewLog>
    </p>
  </c:when>
  <c:otherwise>
    <p>Duplicates finder: no data recorded.</p>
  </c:otherwise>
</c:choose>
</c:if>