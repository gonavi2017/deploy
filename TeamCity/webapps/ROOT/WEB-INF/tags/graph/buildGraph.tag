<%--@elvariable id="buildGraphBean" type="jetbrains.buildServer.web.statistics.graph.BuildGraphBean"--%>
<%@ tag import="java.util.Enumeration"
%><%@ tag import="jetbrains.buildServer.serverSide.TeamCityProperties"
%><%@ tag import="jetbrains.buildServer.serverSide.statistics.build.BuildChartSettings"
%><%@ tag import="jetbrains.buildServer.web.statistics.graph.BuildGraphBean"
%><%@ tag import="jetbrains.buildServer.web.statistics.graph.BuildGraphHelper"
%><%@ tag import="jetbrains.buildServer.web.statistics.graph.ChartExportPrinter"
%><%@ tag import="jetbrains.buildServer.web.util.WebUtil"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="stats" tagdir="/WEB-INF/tags/graph"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
%><%@ taglib prefix="util" uri="/WEB-INF/functions/util"
%><%@ attribute name="id" required="true" fragment="false" description="ID of this _tag_ - not chart"
%><%@ attribute name="valueTypeBean" required="false" fragment="false" type="jetbrains.buildServer.serverSide.statistics.ValueType"
%><%@ attribute name="valueType" required="true" fragment="false" description="ID of the 'chart' (it's not a chart actually) to show - div ID."
%><%@ attribute name="height" fragment="false" type="java.lang.Integer"
%><%@ attribute name="width" fragment="false" type="java.lang.Integer"
%><%@ attribute name="controllerUrl" fragment="false" required="false"
%><%@ attribute name="hideFilters" required="false" type="java.lang.String"
%><%@ attribute name="hideTitle" required="false" type="java.lang.Boolean"
%><%@ attribute name="isPredefined" required="false" type="java.lang.Boolean"
%><%@ attribute name="maxTitleLength" required="false" type="java.lang.Integer"
%><%@ attribute name="filtersHiddable" required="false" type="java.lang.Boolean"
%><%@ attribute name="additionalActions" required="false" fragment="true"
%><%@ attribute name="filtersHidden" required="false" type="java.lang.Boolean"
%><%@ attribute name="defaultFilter" required="false" type="java.lang.String"
%><%@ attribute name="additionalFilter" required="false" type="java.lang.String"
%><%@ attribute name="additionalProperties" required="false" type="java.lang.String"
%><%@ attribute name="defaults" required="false" type="java.util.Map"
%><%@ attribute name="hints" required="false" type="java.lang.String"
%><%@ attribute name="buildType" required="false" type="jetbrains.buildServer.serverSide.SBuildType"
%><%@ attribute name="projectExternalId" required="false" type="java.lang.String"
%><%@ attribute name="buildTypeExternalId" required="false" type="java.lang.String"
%><%@ tag body-content="empty" %>
<c:if test="${(empty param['_graphKey'] || param['_graphKey']==id)}">
<c:set var="id_nonescaped" value="${id}"/>
<c:set var="id" value="${util:forJSIdentifier(id)}"/>
<c:if test="${empty buildTypeId}">
  <c:if test="${not empty buildType}">
    <c:set var="buildTypeId" value="${buildType.externalId}" scope="page"/>
  </c:if>
  <c:if test="${not empty buildTypeExternalId and empty buildType}">
    <c:set var="buildTypeId" value="${buildTypeExternalId}" scope="page"/>
  </c:if>
</c:if>
<c:if test="${empty filtersHiddable or not filtersHiddable}"><c:set var="filtersHidden" value="false"/></c:if>
<c:if test="${empty maxTitleLength}"><c:set var="maxTitleLength" value="100"/></c:if>
<%
  final boolean val = TeamCityProperties.getBooleanOrTrue("teamcity.charts.useFlotCharts");
  final String force = request.getParameter("usejscharts") == null ? "" : request.getParameter("usejscharts");
  final boolean useSvgCharts = (val && !"false".equals(force)) || (!val && "true".equals(force));
  request.setAttribute("useFlotCharts", useSvgCharts);

  final BuildGraphHelper helper = (BuildGraphHelper)request.getAttribute("buildGraphHelper");
  if (helper == null) {
    return;
  }
  final BuildGraphBean buildGraphBean =
      valueTypeBean != null
      ? helper.createGraphBean(request, id, valueTypeBean, helper.createSettings(request, jspContext, defaults), session, defaults)
      : helper.createGraphBean(request, id, valueType, jspContext, session, defaults);
  if (buildGraphBean == null) {
    return;
  }

  request.setAttribute("buildGraphBean", buildGraphBean);

  if (useSvgCharts) {
    request.setAttribute("styles", buildGraphBean.getFlotStyles(hints));
  }

  if (request.getParameter("_graphKey") != null) {
    request.setAttribute("data", new ChartExportPrinter(buildGraphBean).json().getData());
  }
%>
<c:if test="${not empty buildGraphBean && buildGraphBean.available}">
<c:set var="yAxisMin"><%=buildGraphBean.getAttribute(BuildChartSettings.AXIS_Y_MIN) != null ? buildGraphBean.getAttribute(BuildChartSettings.AXIS_Y_MIN) : ""%></c:set>
<c:set var="yAxisMax"><%=buildGraphBean.getAttribute(BuildChartSettings.AXIS_Y_MAX) != null ? buildGraphBean.getAttribute(BuildChartSettings.AXIS_Y_MAX) : ""%></c:set>
<c:set var="saved">
  <%
    Enumeration names = request.getParameterNames();
    while (names.hasMoreElements()) {
      String name = (String)names.nextElement();
      if (name.startsWith("_") || name.startsWith("@")) continue;
      String[] values = request.getParameterValues(name);
      //for (String value : values) {
  %><input type="hidden" name="<%=WebUtil.escapeXml(name)%>" value="<%=WebUtil.escapeXml(values[0])%>"/><%
    //}
  }
%>
</c:set>

<bs:linkCSS>
  /css/FontAwesome/css/font-awesome.css
</bs:linkCSS>
<bs:linkScript>
  /js/bs/chart.js
</bs:linkScript>
<c:if test="${useFlotCharts}">
  <bs:linkScript>
    /js/flot/jquery.flot.js
    /js/flot/excanvas.min.js
    /js/flot/jquery.flot.selection.min.js
    /js/flot/jquery.flot.time.min.js
  </bs:linkScript>
</c:if>
<c:set var="settings" value="${buildGraphBean.settings}"/>
<div id="${id}Container" class="GraphContainer" data-project-id="${settings.projectId}" data-buildtype-id="${settings.buildTypeId}">
  <script type="text/javascript">
    (function() {
      <c:if test="${useFlotCharts}">
      var id = "${id}";
      var chartFiltersState = {
        buildTypeId: '${settings.buildTypeId}' || null,
        projectId: '${settings.projectId}' || '${projectExternalId}' || null,
        buildId: '${buildGraphBean.attrs['buildId'][0]}' || null,
        "@f_range": '${settings.rangeText}',
        "@filter.status": '${settings.statusText}',
        "@filter.average": '${settings.average}' || null,
        "@filter.s": [<c:forEach var="filter" items="${settings.filterS}" varStatus="s">'${filter}'<c:if test="${not s.last}">,</c:if></c:forEach>],
        "@filter.pas": [<c:forEach var="filter" items="${settings.filterPas}" varStatus="s">'${filter}'<c:if test="${not s.last}">,</c:if></c:forEach>],
        "@filter.personal": '${settings.hidePersonal}',
        flotChart: "true",
        <c:if test="${not empty additionalProperties}">
        <c:forEach var="key" items="${fn:split(additionalProperties, ',')}" varStatus="s">"${key}": '${buildGraphBean.attrs[key][0]}',</c:forEach>
        </c:if>
        <c:if test="${showBranches}">
        showBranches: true,
        <c:if test="${not empty branchName}">branchName: '${branchName}',</c:if>
        <c:if test="${not empty allBranches}">allBranches: '${allBranches}',</c:if>
        </c:if>
        _graphKey: 'g',
        valueType: '${util:urlEscape(valueType)}',
        id: id,
        showBuildType: ${empty buildGraphBean.attrs['buildType'][0]}
      };

      var $chartHolder = $j("div[id='" + id + "Container']");
      $chartHolder.data("filters", chartFiltersState);
      </c:if>

      if (typeof BS.Chart === 'undefined') {<%--
                this case serves for popup chart case on testInfo page where it's impossible to include js libraries
                with standard bs:linkScript tag --%>
        var selector = "#${id}Container";
        $j(selector).append(<c:if test="${useFlotCharts}">"<script type='text/javascript' src='js/flot/jquery.flot.js'/>"
                               + "<script type='text/javascript' src='js/flot/jquery.flot.time.min.js'/>"
                               + "<script type='text/javascript' src='js/flot/jquery.flot.selection.min.js'/>"
                               + "<script type='text/javascript' src='js/flot/excanvas.min.js'/>"
                               + </c:if>"<script type='text/javascript' src='js/bs/chart.js'/>");
      }
    })();
    <c:if test="${not useFlotCharts}">
    BS.BuildGraph = BS.BuildGraph || {};

    BS.BuildGraph.showTip${id} = function(event, element) {
      BS.Tooltip.hidePopup();
      var tip = element.getAttribute("tip");
      var href = element.getAttribute("href");
      if (href) {
        tip = tip.replace('$LINK', href);
      }
      BS.Tooltip.showMessageAtCursor(event, {shift:{x:0}}, tip);
    };

    BS.BuildGraph.hideTip${id} = function() {
      BS.Tooltip.hidePopup();
    };

    BS.BuildGraph.attachHandlers${id} = function(k) {
      if (! document.getElementById("Map" + k)) return false;
      $("Map" + k).on("mouseover", "area", BS.BuildGraph.showTip${id});
      $("Map" + k).on("mouseout", "area", BS.BuildGraph.hideTip${id});
      return true;
    };</c:if>
  </script>

  <bs:refreshable containerId="${id}Container_i" pageUrl="${controllerUrl}">
    <c:set var="guid" value="${buildGraphBean.guid}"/>
    <form id="${id}Form" onsubmit="BS.Chart.applyFilter('${id}', '${id_nonescaped}', '${controllerUrl}');">
      <input type="hidden" name="_graphKey" value="${id_nonescaped}"/>
      <input type="hidden" name="_guid" value="${guid}"/>

      <c:set var="descriptor" value="${buildGraphBean.graphDescriptor}"/>
      <c:set var="showYAxisConfig" value="${(not fn:containsIgnoreCase(hideFilters, 'yAxisType') or not fn:containsIgnoreCase(hideFilters, 'forceZero')) and not fn:containsIgnoreCase(hideFilters, 'all')}"/>

      <c:url var="GETRequestLink" value="">
        <c:param name="buildTypeId" value="${settings.buildTypeId}"/>
        <c:if test="${not empty settings.projectId}">
          <c:param name="projectId" value="${settings.projectId}"/>
        </c:if>
        <c:if test="${not empty buildGraphBean.attrs['buildId']}">
          <c:param name="buildId" value="${buildGraphBean.attrs['buildId'][0]}"/>
        </c:if>
        <c:param name="@f_range" value="${settings.rangeText}"/>
        <c:param name="@filter.status" value="${settings.statusText}"/>
        <c:if test="${settings.average}">
          <c:param name="@filter.average" value="${settings.average}"/>
        </c:if>
        <c:if test="${settings.average}">
          <c:param name="@filter.personal" value="${settings.hidePersonal}"/>
        </c:if>
        <c:if test="${not empty settings.filterS}">
          <c:forEach var="filter" items="${settings.filterS}">
            <c:param name="@filter.s" value="${filter}"/>
          </c:forEach>
        </c:if>
        <c:if test="${not empty settings.filterPas}">
          <c:forEach var="filter" items="${settings.filterPas}">
            <c:param name="@filter.pas" value="${filter}"/>
          </c:forEach>
        </c:if>
        <c:if test="${not empty additionalProperties}">
          <c:forEach var="key" items="${fn:split(additionalProperties, ',')}">
            <c:param name="${key}" value="${buildGraphBean.attrs[key][0]}"/>
          </c:forEach>
        </c:if>
        <c:if test="${showBranches}">
          <c:param name="showBranches" value="true"/>
          <c:if test="${not empty branchName}"><c:param name="branchName" value="${branchName}"/></c:if>
          <c:if test="${not empty allBranches}"><c:param name="allBranches" value="${allBranches}"/></c:if>
        </c:if>
        <c:param name="_graphKey" value="g"/>
        <c:param name="valueType" value="${valueType}"/>
        <c:param name="id" value="${id}"/>
      </c:url>

      <table>
        <tr class="graphHeader" id="${id}TT">
          <td>
            <%--header--%>
            <c:if test="${not hideTitle}">
              <div class="graphName">
                <span id="${id}TitlePopup" class="headerContainer">
                  <bs:trimWithTooltip maxlength="${maxTitleLength}" trimCenter="true">${buildGraphBean.title}</bs:trimWithTooltip>
                </span>
              </div>
            </c:if>
          </td>
          <td>
            <div class="agentsListHelp iconsHolder actionsHolder">
              <jsp:invoke fragment="additionalActions"/>
              <a title="Download data as CSV" id="${id}ChartLink" class="downloadChartLink actionIcon icon-download-alt noUnderline" style="display: none" href="<c:url value="exportchart.html${GETRequestLink}"><c:param name="type" value="text"/></c:url>"></a>
              <bs:helpLink file="Statistic Charts" anchor="${isPredefined ? valueType : 'CustomCharts'}"/>
            </div>
          </td>
        </tr>
        <tr>
          <td class="graphContainer">
              <%--Y Axis Config href--%>
            <span class="graphConfigLink">
              <c:if test="${showYAxisConfig}">
                <a href="#" title="Configure chart axes" onclick="$j('#${id}PopupW').data('chartConfigPopup').show(this); return false;" class="noUnderline"><i class="icon-cog"></i></a>
                <span class="resetLink"><a class="yAxisResetLink" href="#" title="Reset to defaults" style="${buildGraphBean.hasNonDefaultYAxisConfig ? '' : 'display: none'}" onclick="BS.Chart.resetYAxis('${id}'); return false;">reset</a></span>
              </c:if>
            </span>
              <%--Y Axis config--%>
            <c:if test="${showYAxisConfig}">
              <l:popupWithTitle id="${id}PopupW" title="Y-Axis Settings"><%@ include file="chartSettings.jsp" %></l:popupWithTitle>
            </c:if>

              <%-- image graph --%>
            <c:if test="${not useFlotCharts}">
              <%--${buildGraphBean.graphInfo.imageMap}--%>
              <img id="${id}Chart" usemap="#Map${guid}" src="<c:url value="chart.png${GETRequestLink}">
                      <c:if test="${not empty yAxisMin}">
                        <c:param name="axis.y.min" value="${yAxisMin}"/>
                      </c:if>
                      <c:if test="${not empty yAxisMax}">
                        <c:param name="axis.y.max" value="${yAxisMax}"/>
                      </c:if>
                      <c:param name="width" value="${descriptor.width}"/>
                      <c:param name="height" value="${descriptor.height}"/>
                      <c:if test="${not empty descriptor.YAxisType}">
                        <c:param name="axis.y.type" value="${descriptor.YAxisType}"/>
                      </c:if>
                      <c:param name="axis.y.zero" value="${descriptor.forceZero}"/>
                      <c:param name="hints" value="${hints}"/>
                    </c:url>" alt="${descriptor.title}" width="${descriptor.width}" height="${descriptor.height}"/>
            </c:if>

              <%-- flot chart holder --%>
            <c:if test="${useFlotCharts}">
              <input type="hidden" name="flotChart" value="true"/>
              <div class="chartHolder" id="chartHolder${id}" style="min-width: ${descriptor.width}px; width: 100%; height: ${descriptor.height}px;"></div>
            </c:if>
          </td>

            <%-- filters --%>
          <c:if test="${not fn:contains(hideFilters, 'all') }">
            <td class="agentsList" id="${id}">
              <c:if test="${filtersHiddable}"><a link="#" class="showLink" style="display: ${filtersHidden ? 'block' : 'none'};"
                 onclick="BS.Chart.showFilters('${id}');"></a></c:if>
              <div class="posRel" ${filtersHidden ? 'style="display: none"' : ''}>
                <c:if test="${filtersHiddable}"><a link="#" class="hideLink" style="display: ${filtersHidden ? 'none' : 'inline'};"
                   onclick="BS.Chart.hideFilters('${id}');"></a></c:if>
                <div class="agentsListHelp">
                  <a class="resetLink" href="#" title="Reset to defaults" style="display:${buildGraphBean.hasNonDefaultFilters ? 'inline' : 'none'};" onclick="BS.Chart.reset('${id}'); return false;" data-nondefaults="${buildGraphBean.hasNonDefaultFilters ? 1 : 0}" data-server-nondefaults="${buildGraphBean.hasNonDefaultFilters ? 1 : 0}">reset filter</a>
                </div>
                <span style="display: ${not fn:contains(hideFilters, 'series') ? 'inline' : 'none'}">
                  <stats:agentsFilter graphKey="${id}" controllerUrl="${controllerUrl}"/>
                  </span>
                <div>
                <span style="display: ${not fn:contains(hideFilters, 'averaged') ? 'inline' : 'none'}">
                  <stats:averageFilter graphKey="${id}"/>
                </span>
                  <div class="personalBuildFilter" data-id="${id}" data-state="${settings.hidePersonal}" style="display: none;">
                    <forms:checkbox name="@filter.showPersonal${id}" className="chartFilter"
                                    attrs='data-default="${!settings.defaults["@filter.personal"]}" data-value="${!settings.hidePersonal}"' value="${!settings.hidePersonal}"
                                    checked="${!settings.hidePersonal}"/><label
                      for="@filter.showPersonal${id}"> Show personal</label>
                      <%--<a href="#" onclick="return false;" class="icon icon16 buildDataIcon build-status-icon ${settings.hidePersonal ? 'build-status-icon_personal' : 'build-status-icon_my'}"></a> Personal--%>
                  </div>
                <c:if test="${not fn:contains(hideFilters, 'showFailed') }">
                  <stats:statusFilter graphKey="${id}"/>
                </c:if>
                <c:if test="${not fn:contains(hideFilters, 'range') }">
                  <stats:rangeFilter graphKey="${id}" defaultRange="${buildGraphBean.attrs['range'][0]}"/>
                </c:if>
                <c:if test="${not empty additionalFilter}">
                  <jsp:include page="${additionalFilter}">
                    <jsp:param name="graphKey" value="${id}"/>
                  </jsp:include>
                </c:if>
                </div>
              </div>
            </td>
          </c:if>
          <c:if test="${fn:contains(hideFilters, 'all')}">
            <td style="width: 0"></td>
          </c:if>

        </tr>
      </table>
      ${saved}
    </form>

    <script type="text/javascript">
      (function() {
        var id = "${id}";
        var styles = [${styles}];
        var $chartHolder = $j("div[id='" + id + "Container']");
        var chartFiltersState = $chartHolder.data("filters");

        var showBranches = chartFiltersState.showBranches;
        var showBuildType = chartFiltersState.showBuildType;

        <c:if test="${empty data and useFlotCharts}">
          BS.Chart.chartsStyles[id] = styles;
          BS.Chart.loadedCharts.push(chartFiltersState);
        </c:if>
        $j(function() {
          var type = ${descriptor.YAxisType eq 'logarithmic' ? '"logarithmic"' : '"default"'};
          var forceZero = ${descriptor.forceZero eq 'true'};
          var yMin = '<bs:escapeForJs text="${yAxisMin}"/>';
          var yMax = '<bs:escapeForJs text="${yAxisMax}"/>';
          var yType = ${not fn:contains(hideFilters, 'yAxisType')};
          var hideForceZero = ${not fn:contains(hideFilters, 'forceZero')};
          var hideRange = ${not fn:contains(hideFilters, 'yAxisRange')};
          var nonDefault = ${buildGraphBean.hasNonDefaultYAxisConfig};

          new BS.Chart.ConfigureChartPopup(id, type, forceZero, yMin, yMax, yType, hideForceZero, hideRange, hideRange, nonDefault).attachTo($j("#" + id + "PopupW"));

          <c:if test="${useFlotCharts}">
            var json = ${not empty data ? data : 'null'};
            BS.Chart.showChart(id, json, styles, showBranches, showBuildType,
                               {
                                 BSChart: {
                                   average: {
                                     enabled: ($j("input[id='@filter.average" + id + "']").attr("value") + "").toLowerCase() === 'true',
                                     groupBy: $j("div[id='rangeFilter" + id + "']").find("option:selected").val().toLowerCase()
                                   },
                                   hidePersonal: !$j("input[id='@filter.showPersonal" + id + "']").data("value")
                                 }
                               }, '${settings.projectId}' || '${projectExternalId}' || null, "${buildTypeExternalId}" || '${settings.buildTypeId}' || null
            );
            BS.Chart.doBulkRequestForData();
          </c:if>
        });
      })();
      <c:if test="${not useFlotCharts}">
      new BS.Overflower($("${id}TT")).installTooltip();
      BS.BuildGraph.tryAttach${id} = setInterval(function() {
      if (BS.BuildGraph.attachHandlers${id}("${guid}")) clearInterval(BS.BuildGraph.tryAttach${id});
      }, 100);
      </c:if>
    </script>

  </bs:refreshable>
</div>

</c:if>
</c:if>