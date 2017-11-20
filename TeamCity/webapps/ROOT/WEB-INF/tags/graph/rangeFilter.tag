<%--@elvariable id="buildGraphBean" type="jetbrains.buildServer.web.statistics.graph.BuildGraphBean"--%>
<%--@elvariable id="useSvgCharts" type="java.lang.Boolean"--%>
<%@ tag import="jetbrains.buildServer.serverSide.statistics.build.BuildChartSettings" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ attribute name="defaultRange" required="false" %>
<c:set var="RPN"><%=BuildChartSettings.FILTER_RANGE%></c:set>
<c:set var="rpv" value="${buildGraphBean.settings.rangeText}"/>
<c:set var="minimal" value="${buildGraphBean.settings.minimalRange}"/>
<%@ attribute name="graphKey" required="true" %>
<div id="rangeFilter${graphKey}" class="rangeFilter">
  Range
  <select name="${RPN}" onchange="this.form.onsubmit();">
    <option value="TODAY" <c:if test="${minimal > 1}">disabled title="no builds in this range"</c:if> <c:if test="${rpv=='TODAY'}">selected</c:if>>Today</option>
    <option value="WEEK" <c:if test="${minimal > 2}">disabled title="no builds in this range"</c:if> <c:if test="${rpv=='WEEK'}">selected</c:if>>Week</option>
    <option value="MONTH" <c:if test="${minimal > 3}">disabled</c:if> <c:if test="${empty rpv or rpv=='MONTH' or buildGraphBean.resetToDefaultRequest}">selected</c:if>>Month</option>
    <option value="QUARTER" <c:if test="${minimal > 4}">disabled</c:if> <c:if test="${rpv=='QUARTER'}">selected</c:if>>Quarter</option>
    <option value="YEAR" <c:if test="${minimal > 5}">disabled</c:if> <c:if test="${rpv=='YEAR'}">selected</c:if>>Year</option>
    <option value="ALL" <c:if test="${rpv=='ALL'}">selected</c:if>>All</option>
    <%--<option value="TEN" <c:if test="${rpv=='TEN'}">selected</c:if>>Nearest</option>--%>
    <c:if test="${useFlotCharts}"><option style="display: none;" disabled></option></c:if>
  </select>
</div>
