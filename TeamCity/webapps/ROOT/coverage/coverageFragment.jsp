<%@ page import="jetbrains.buildServer.coverage.CoveragePageFragment" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" session="true"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="util" uri="/WEB-INF/functions/util" %>

<jsp:useBean id="coverageSummary" type="jetbrains.buildServer.coverage.CoverageSummary" scope="request"/>

<div id="coverageSummary">
  <p>
    Code coverage summary
    <c:if test="${not empty coverageSummary.coverageReportTabId}">
      &nbsp;&nbsp;&nbsp;&nbsp;<bs:_viewLog build="${coverageSummary.build}" tab="${coverageSummary.coverageReportTabId}">View full report &raquo;</bs:_viewLog>
    </c:if>
  </p>

  <table>
    <tr>
    <c:forEach items="${coverageSummary.availableStatTypes}" var="statType">
      <c:set var="statEntry" value="${coverageSummary.statistics[statType]}"/>
      <c:set var="val"><c:out value="${statEntry.percentString}"/></c:set>
    <td>
      <span class="label">${statType.displayName}</span>
      <span class="barBorder">${val}<span style="width:${statEntry.percent}%">${val}</span></span>
      <span class="absValues"><c:if test="${statEntry.covered >= 0}"><fmt:formatNumber value="${statEntry.covered}" groupingUsed="false"/>/${statEntry.total}</c:if></span>
    </td>
    </c:forEach>
    </tr>
    <c:if test="${not empty coverageSummary.prevBuild}">
      <tr>
      <c:forEach items="${coverageSummary.availableStatTypes}" var="statType">
      <c:set var="diff" value="${coverageSummary.statistics[statType].diff}"/>
      <c:set var="val"><c:out value="${diff.percentDiffString}"/></c:set>
      <td>
        <span class="label">Diff:</span>
        <span class="diffValue ${diff.percentDiff < 0 ? 'red' : (diff.percentDiff > 0 ? 'green' : '')}">${diff.percentDiff > 0 ? '+' : ''}${val}</span>
      </td>
      </c:forEach>
      </tr>
    </c:if>
  </table>
</div>
