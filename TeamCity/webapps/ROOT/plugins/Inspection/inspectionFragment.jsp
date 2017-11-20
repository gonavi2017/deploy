<%@ page contentType="text/html;charset=UTF-8" language="java" session="true"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %>
<c:if test="${not empty inspectionInfo}">
  <%--@elvariable id="inspectionInfo" type="jetbrains.buildServer.serverSide.impl.codeInspection.InspectionInfo"--%>
  <c:set var="stats" value="${inspectionInfo.statistics}"/>
  <c:choose>
    <c:when test="${inspectionInfo.build.buildStatus.successful || stats[0]>0}">
      <p>
        Total problems found: <strong>${stats[0]}</strong> (+${stats[1]} -${stats[2]}), errors: <strong style="color:red">${stats[3]}</strong> (+${stats[4]} -${stats[5]})
        <c:if test="${stats[0] > 0}">&nbsp;&nbsp;&nbsp;&nbsp;<bs:_viewLog build="${inspectionInfo.build}" tab="Inspection">View code inspection report &raquo;</bs:_viewLog></c:if>
      </p>
    </c:when>
    <c:otherwise>
      <p>Code Inspection: no data recorded.</p>
    </c:otherwise>
  </c:choose>
</c:if>
