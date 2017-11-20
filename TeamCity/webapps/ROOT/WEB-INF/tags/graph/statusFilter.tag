<%@ tag import="java.util.Enumeration" %>
<%@ tag import="jetbrains.buildServer.web.util.WebUtil" %>
<%--@elvariable id="buildGraphBean" type="jetbrains.buildServer.web.statistics.graph.BuildGraphBean"--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ attribute name="graphKey" required="true" %>
<c:set var="filter" value="${buildGraphBean.settings}"/>

<div id="showFailed${graphKey}" class="statusFilter">
  <forms:checkbox
    id="@filter.status${graphKey}" name="@filter.status" value="${filter.status >= 4 ? 'ERROR' : 'WARNING'}"
    checked="${filter.status >= 4}" className="checkbox_unchecked_value"
    onclick="this.value = (this.value == 'ERROR' ? 'WARNING' : 'ERROR'); this.form.onsubmit();"
  /><label class="graphFilterStatus" for="@filter.status${graphKey}">Show failed</label>
</div>

