<%@ tag import="java.util.Enumeration" %>
<%@ tag import="jetbrains.buildServer.web.util.WebUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ attribute name="graphKey" required="true" %>
<%@ attribute name="controllerUrl" required="false" %>
<%--<c:set var="buildGraphBean" value="${sessionScope[graphKey]}"/>--%>
<%--@elvariable id="buildGraphBean" type="jetbrains.buildServer.web.statistics.graph.BuildGraphBean"--%>
<%--<c:set var="agents" value="${buildGraphBean.availableAgents}"/>--%>
<c:set var="cols" value="1"/>
<%--<c:if test="${not empty agents and fn:length(agents)>1 }">--%>
<script type="text/javascript">
  BS.BuildGraph = BS.BuildGraph || {};
  BS.BuildGraph.setBoxes = function(key, val) {
    var boxes = document.forms[key+"Form"]['@filter.s'];
    if (boxes) {
      if (boxes.length) {
        for (var i = 0; i < boxes.length; i++) {
          boxes[i].checked = val;
          boxes[i].setAttribute("data-value", val);
        }
      }
      else boxes.checked = val;
    }
    return boxes;
  };
  (function(){
    BS.Chart.bindAgentFilterListener('${graphKey}');
  })();
</script>
<div class="agentsFilter" id="agentsFilter${graphKey}">

    <div>
      <strong><c:out value="${buildGraphBean.valueType.seriesGenericName}"/>s</strong>
      <a href="#" onclick="$j('#chartHolder${graphKey}').data('chart').setSerieEnabled(null, true); BS.BuildGraph.setBoxes('${graphKey}', true); return false;" class="all_none">All</a>
      <a href="#" onclick="$j('#chartHolder${graphKey}').data('chart').setSerieEnabled(null, false); BS.BuildGraph.setBoxes('${graphKey}', false); return false;" class="all_none">None</a>
    </div>
    <c:if test="${not empty agents}">
      <input type="hidden" name="@filter.pas" value="true"/>
    </c:if>
    <div class="agentsFilterInner" style="height: ${buildGraphBean.graphDescriptor.height-30}px;">
    <table class="agentsFilterTable">
      <tr style="display: none;" id="proto"><td>
        <label for="" class="name" id="">
        <forms:checkbox
            attrs="data-default='true' data-value='true'"
            id=""
            className="chartFilter agentCheckbox"
            name="agentFilterProto"
            value=""
            checked=""
            style="vertical-align:middle; margin:0; padding:0;"
            onclick=""/>
        <div class="color-bullet"></div></label>
      </td></tr>
    </table>
    </div>

</div>
