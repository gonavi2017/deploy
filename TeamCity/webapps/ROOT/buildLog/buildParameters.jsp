<%@include file="/include-internal.jsp"%>
<%@taglib prefix="auth" tagdir="/WEB-INF/tags/authz" %>

<bs:linkCSS>
  /css/buildGraph.css
  /css/buildLog/buildParameters.css
  /css/customCharts.css
</bs:linkCSS>
<bs:linkScript>
  /js/bs/editCustomCharts.js
  /js/bs/buildParameters.js
  /js/bs/chart.js
  /js/flot/jquery.flot.js
  /js/flot/excanvas.min.js
  /js/flot/jquery.flot.selection.min.js
  /js/flot/jquery.flot.time.min.js
</bs:linkScript>
<%--@elvariable id="valueProviders" type="java.util.Map<String,jetbrains.buildServer.serverSide.statistics.build.BuildValueTypeBase>"--%>
<%--@elvariable id="buildParameters" type="jetbrains.buildServer.controllers.viewLog.ActualBuildParametersBean"--%>
<%--@elvariable id="buildFinishParameters" type="jetbrains.buildServer.controllers.viewLog.ActualBuildParametersBean"--%>
<%--@elvariable id="shouldShowTOC" type="java.lang.Boolean"--%>
<%--@elvariable id="registeredCharts" type="java.util.List<jetbrains.buildServer.web.statistics.graph.DeclarativeCompositeValueType>"--%>

<c:set var="overriddenConfigParams" value="${buildParameters.overridenConfigParams}"/>
<c:set var="overriddenSysProps" value="${buildParameters.overriddenSystemProperties}"/>
<c:set var="overriddenEnvVars" value="${buildParameters.overriddenEnvVariables}"/>
<c:set var="overriddenDependencyParams" value="${buildParameters.overriddenDependencyParams}"/>

<jsp:useBean id="buildParametersTab" type="java.lang.String" scope="request"/>
<c:set var="isBuildParametersTab" value="${empty buildParametersTab or buildParametersTab eq 'parameters'}"/>
<c:if test="${shouldShowTOC}">
  <jsp:useBean id="buildData" type="jetbrains.buildServer.serverSide.SBuild" scope="request"/>
  <c:url value="/viewLog.html?buildId=${buildData.buildId}&tab=${tab}&buildTypeId=${buildData.buildTypeExternalId}" var="url"/>
  <div class="tableOfContents">
    <c:choose>
      <c:when test="${isBuildParametersTab}"><strong>Parameters</strong></c:when>
      <c:otherwise><bs:_viewLog tab="buildParameters" build="${buildData}">Parameters</bs:_viewLog></c:otherwise>
    </c:choose>
    <span class="separator">|</span>
    <c:choose>
      <c:when test="${buildParametersTab eq 'statistics'}"><strong>Reported statistic values</strong></c:when>
      <c:otherwise><bs:_viewLog tab="buildParameters" build="${buildData}" urlAddOn="&buildParametersTab=statistics">Reported statistic values</bs:_viewLog></c:otherwise>
    </c:choose>
  </div>
</c:if>
<c:if test="${isBuildParametersTab}">
<div class="buildParameters divsWithHeaders">
  <h2><a name="UserDefinedParameters"></a>User Defined Parameters</h2>
  <c:choose>
    <c:when test="${buildParameters.allParameters.parametersAvailable}">
      <c:set var="sectionNumber" value="${buildParameters.sectionNumber}"/>
      <c:set var="counter" value="0"/>
      <c:if test="${not (empty buildParameters.allParameters.configurationParameters and empty overriddenConfigParams)}">
        <c:set var="counter" value="${counter + 1}"/>
        <c:set var="divClass"><c:out value="${counter eq 1 ? 'first' : ''}"/> <c:out value="${counter eq sectionNumber ? ' last' : ''}"/></c:set>
        <div class="${divClass}" style="${(counter eq sectionNumber ? 'border-bottom: none;' : '')}">
          <h3><a name="UserDefinedParameters-ConfigurationParameters"></a>Configuration Parameters</h3>
          <bs:_buildParamsTable valueColumnTitle="Value passed to build" parameters="${buildParameters.allParameters.configurationParameters}" overriddenParameters="${overriddenConfigParams}"/>
        </div>
      </c:if>

      <c:if test="${not (empty buildParameters.allParameters.systemProperties and empty overriddenSysProps)}">
        <c:set var="counter" value="${counter + 1}"/>
        <c:set var="divClass"><c:out value="${counter eq 1 ? 'first' : ''}"/> <c:out value="${counter eq sectionNumber ? ' last' : ''}"/></c:set>
        <div class="${divClass}" style="${(counter eq sectionNumber ? 'border-bottom: none;' : '')}">
          <h3><a name="UserDefinedParameters-SystemProperties"></a>System properties</h3>
          <bs:_buildParamsTable valueColumnTitle="Value passed to build" parameters="${buildParameters.allParameters.systemProperties}" overriddenParameters="${overriddenSysProps}"/>
        </div>
      </c:if>

      <c:if test="${not (empty buildParameters.allParameters.environmentVariables and empty overriddenEnvVars)}">
        <c:set var="counter" value="${counter + 1}"/>
        <c:set var="divClass"><c:out value="${counter eq 1 ? 'first' : ''}"/> <c:out value="${counter eq sectionNumber ? ' last' : ''}"/></c:set>
        <div class="${divClass}" style="${(counter eq sectionNumber ? 'border-bottom: none;' : '')}">
          <h3><a name="UserDefinedParameters-EnvironmentVariables"></a>Environment variables</h3>
          <bs:_buildParamsTable valueColumnTitle="Value passed to build" parameters="${buildParameters.allParameters.environmentVariables}" overriddenParameters="${overriddenEnvVars}"/>
        </div>
      </c:if>

      <c:if test="${not (empty buildParameters.allParameters.dependencyParameters and empty overriddenDependencyParams)}">
        <c:set var="counter" value="${counter + 1}"/>
        <c:set var="divClass"><c:out value="${counter eq 1 ? 'first' : ''}"/> <c:out value="${counter eq sectionNumber ? ' last' : ''}"/></c:set>
        <div class="${divClass}" style="${(counter eq sectionNumber ? 'border-bottom: none;' : '')}">
          <h3><a name="UserDefinedParameters-DependencyParameters"></a>User defined parameters using dependency parameter names</h3>
          <bs:_buildParamsTable valueColumnTitle="Value passed to build" parameters="${buildParameters.allParameters.dependencyParameters}" overriddenParameters="${overriddenDependencyParams}"/>
        </div>
      </c:if>
    </c:when>
    <c:otherwise>
      <div class="last" style="border-bottom: none;">no parameters defined</div>
    </c:otherwise>
  </c:choose>
</div>


<c:if test="${(not empty buildFinishParameters) and buildFinishParameters.allParameters.parametersAvailable}">
  <c:set var="sectionNumber" value="${buildFinishParameters.sectionNumber}"/>
  <c:set var="counter" value="0"/>
  <div class="buildParameters divsWithHeaders">
    <h2><a name="ActualParametersOnAgent"></a>Actual Parameters on Agent</h2>

    <c:if test="${not empty buildFinishParameters.allParameters.configurationParameters}">
      <c:set var="counter" value="${counter + 1}"/>
      <c:set var="divClass"><c:out value="${counter eq 1 ? 'first' : ''}"/> <c:out value="${counter eq sectionNumber ? ' last' : ''}"/></c:set>
      <div class="${divClass}" style="${(counter eq sectionNumber ? 'border-bottom: none;' : '')}">
        <h3><a name="ActualParametersOnAgent-ConfigurationParameters"></a>Configuration Parameters</h3>
        <bs:_buildParamsTable valueColumnTitle="Value used by the build" parameters="${buildFinishParameters.allParameters.configurationParameters}" overriddenParameters="${buildFinishParameters.overridenConfigParams}"/>
      </div>
    </c:if>

    <c:if test="${not empty buildFinishParameters.allParameters.systemProperties}">
      <c:set var="counter" value="${counter + 1}"/>
      <c:set var="divClass"><c:out value="${counter eq 1 ? 'first' : ''}"/> <c:out value="${counter eq sectionNumber ? ' last' : ''}"/></c:set>
      <div class="${divClass}" style="${(counter eq sectionNumber ? 'border-bottom: none;' : '')}">
        <h3><a name="ActualParametersOnAgent-SystemProperties"></a>System properties</h3>
        <bs:_buildParamsTable valueColumnTitle="Value used by the build" parameters="${buildFinishParameters.allParameters.systemProperties}" overriddenParameters="${buildFinishParameters.overriddenSystemProperties}"/>
      </div>
    </c:if>

    <c:if test="${not empty buildFinishParameters.allParameters.environmentVariables}">
      <c:set var="counter" value="${counter + 1}"/>
      <c:set var="divClass"><c:out value="${counter eq 1 ? 'first' : ''}"/> <c:out value="${counter eq sectionNumber ? ' last' : ''}"/></c:set>
      <div class="${divClass}" style="${(counter eq sectionNumber ? 'border-bottom: none;' : '')}">
        <h3><a name="ActualParametersOnAgent-EnvironmentVariables"></a>Environment variables</h3>
        <bs:_buildParamsTable valueColumnTitle="Value used by the build" parameters="${buildFinishParameters.allParameters.environmentVariables}" overriddenParameters="${buildFinishParameters.overriddenEnvVariables}"/>
      </div>
    </c:if>

    <c:if test="${not empty buildFinishParameters.allParameters.dependencyParameters}">
      <c:set var="counter" value="${counter + 1}"/>
      <c:set var="divClass"><c:out value="${counter eq 1 ? 'first' : ''}"/> <c:out value="${counter eq sectionNumber ? ' last' : ''}"/></c:set>
      <div class="${divClass}" style="${(counter eq sectionNumber ? 'border-bottom: none;' : '')}">
        <h3><a name="ActualParametersOnAgent-DependencyParameters"></a>Parameters from Dependencies</h3>
        <bs:_buildParamsTable valueColumnTitle="Value used by the build" parameters="${buildFinishParameters.allParameters.dependencyParameters}"  overriddenParameters="${buildFinishParameters.overriddenDependencyParams}"/>
      </div>
    </c:if>
  </div>
</c:if>
</c:if>

<c:if test="${buildParametersTab eq 'statistics'}">
<bs:trimWhitespace>
<%--@elvariable id="buildMetricsSet" type="java.util.Set<java.lang.String>"--%>
<%--@elvariable id="previousMetrics" type="java.util.Map"--%>
<%--@elvariable id="valueProvidersData" type="java.util.List<jetbrains.buildServer.controllers.viewLog.BuildParametersTab.MetricDataBean>"--%>
<div class="buildParameters divsWithHeaders">
<c:choose>
  <c:when test="${not empty valueProvidersData}">
    <div style="display: none" class="successMessage">Your changes have been saved. <bs:buildTypeLink classes="btLink" style="display: none" buildType="${buildData.buildType}" additionalUrlParams="&tab=buildTypeStatistics">Click here to view the chart.</bs:buildTypeLink><a class="projectLink" style="display: none" href="<bs:projectUrl projectId="${buildData.projectExternalId}" tab="stats"/>">Click here to view the chart.</a></div>
    <h2><a name="ReportedStatisticValues"></a>Reported statistic values<bs:help file="Custom+Chart" anchor="DefaultStatisticsValuesProvidedbyTeamCity"/></h2>
      <auth:authorize allPermissions="EDIT_PROJECT" projectId="${buildData.projectId}"><th class="cbColumn"></th>
        <span style="margin: 0; display: block" class="smallNote">Select value types to create a new custom chart</span>
      </auth:authorize>
      <table class="runnerFormTable statisticsTable" style="width: 100%">
        <tr>
          <auth:authorize allPermissions="EDIT_PROJECT" projectId="${buildData.projectId}"><th class="cbColumn"></th></auth:authorize>
          <th class="paramName" style="width: initial">Statistic type</th>
          <th class="paramValue">Value reported by build</th>
        </tr>
        <c:forEach items="${valueProvidersData}" var="data" varStatus="it">
          <c:set var="escapedId"><c:out value="${data.key}"/></c:set>
          <tr>
            <auth:authorize allPermissions="EDIT_PROJECT" projectId="${buildData.projectId}">
              <c:set var="descriptionOrKey"><c:out value="${data.descriptionOrKey}"/></c:set>
              <c:set var="key">${escapedId}</c:set>
              <td class="cbColumn"><forms:checkbox className="valueTypeToggle" name="valueTypeToggle" id="addVT${escapedId}" attrs="data-vt-description='${descriptionOrKey}' data-vt-key='${key}'"/></td>
            </auth:authorize>
            <td class="paramName" title="${escapedId}"><label for="addVT${escapedId}">
              <c:choose>
                <c:when test="${empty data.description}"><i>${escapedId}</i></c:when>
                <c:otherwise><c:out value="${data.description}"/></c:otherwise>
              </c:choose>
            </label></td>
            <td><span id="${escapedId}" class="statistic_value">${data.value}</span>
              <a data-build-id="${buildData.buildId}" data-description="${descriptionOrKey}" data-key="${escapedId}" data-valuetype="${escapedId}" <c:if test="${not empty data.format}">data-format="${data.format}"</c:if> href="#" onclick="return false;" title="View chart" class="showChartLink tc-icon icon16 tc-icon_graph"></a></td>
          </tr>
        </c:forEach>
      </table>
    </div>

    <input type="hidden" data-build-type-id="${buildData.buildTypeExternalId}" id="buildTypeIdHolder"/>

    <auth:authorize allPermissions="EDIT_PROJECT" projectId="${buildData.projectId}">
      <%--@elvariable id="valueProviderDescriptions" type="java.util.List"--%>
      <bs:editChartDialog keysDescriptions="${valueProviderDescriptions}">
        <jsp:attribute name="additionalContent">
          <div class="projectChooser group"><span for="projectSelect" class="title">Target Project:</span>
            <forms:select name="chooseProject" enableFilter="true" id="projectSelect" className="fullSize">
              <%--@elvariable id="managedProjects" type="java.util.List<jetbrains.buildServer.serverSide.SProject>"--%>
              <c:forEach items="${managedProjects}" var="proj" varStatus="stat">
                <%--@elvariable id="proj" type="jetbrains.buildServer.serverSide.SProject"--%>
                <forms:option value="${proj.externalId}" selected="${stat.last}" className="user-depth-${fn:length(proj.projectPath) - 1}"><c:out value="${proj.name}"/></forms:option>
              </c:forEach>
            </forms:select>
            <div class="smallNote projectChartProjectChooserNote" style="display: none">Display the chart on Statistics tab of the selected project</div>
            <div class="smallNote configurationChartProjectChooserNote" style="display: none">Display the chart on Statistics tab of build configurations of the selected project and subprojects</div>
          </div>
        </jsp:attribute>
      </bs:editChartDialog>

      <forms:modified id="add-to-chart-docked">
        <div class="bulk-operations-toolbar fixedWidth">
          <span class="users-operations">
            <a href="#" class="btn addNewChart addToNewConfig btn_primary submitButton" onclick="return false;">Add build configuration chart...</a>
            <a href="#" class="btn addNewChart addToNewProject btn_primary submitButton" onclick="return false;">Add project chart...</a>
            <a href="#" class="btn" id="cancelAddToNew" onclick="return false;">Cancel</a>
          </span>
        </div>
      </forms:modified>
    </auth:authorize>

    <script>$j(function () {BS.BuildParameters.initHandlers("${buildData.projectExternalId}", "${buildData.buildTypeExternalId}");});</script>
  </c:when>
  <c:otherwise>
    No statistic values reported
  </c:otherwise>
</c:choose>
</bs:trimWhitespace>
</c:if>