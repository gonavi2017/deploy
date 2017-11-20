<%@ page import="jetbrains.buildServer.util.StringUtil" %>
<%@ include file="../include-internal.jsp" %>
<%@ taglib prefix="stats" tagdir="/WEB-INF/tags/graph" %>
<%
  final String valueType = request.getParameter("valueType");
  request.setAttribute("valueType", valueType);
  request.setAttribute("title", StringUtil.escapeHTML(valueType, true));
%>

<bs:dialog dialogId="chartDialog" title="${title}" closeCommand="BS.Hider.hideDiv('chartDialogPopup');"
           titleId='chartDialogTitle' dialogClass="buildParameters_chartPopup">
  <stats:buildGraph id="temp" valueType='${valueType}' valueTypeBean="${valueTypeBean}" height="150" width="500" additionalProperties="buildId"
                    defaultFilter="showFailed" controllerUrl="buildGraph.html" filtersHiddable="false" filtersHidden="true"/>
</bs:dialog>
<script type="text/javascript">
  new Draggable('chartDialogPopup', {
    starteffect: function () {},
    endeffect: function () {},
    handle: 'chartDialogTitle'
  });
</script>