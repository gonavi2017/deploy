<%--@elvariable id="buildGraphBean" type="jetbrains.buildServer.web.statistics.graph.BuildGraphBean"--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ attribute name="graphKey" required="true" %>
<c:set var="filter" value="${buildGraphBean.settings}"/>

<div class="averageFilter">
  <forms:checkbox
    id="@filter.average${graphKey}" name="@filter.average" value="${filter.average ? 'true' : 'false'}"
    checked="${filter.average}" className="chartFilter checkbox_unchecked_value"
    onclick="" attrs='data-default="${filter.defaults["@filter.average"]}" data-value="${filter.average ? "true" : "false"}"'
  /><label class="graphFilterAverage" for="@filter.average${graphKey}">Average</label>
</div>
