<%@ page import="java.util.HashSet"
%><%@ page import="java.util.Set"
%>
<%@ page import="jetbrains.buildServer.serverSide.auth.Permission" %>
<%@ page import="jetbrains.buildServer.web.statistics.graph.DeclarativeCompositeValueType" %>
<%@ page import="jetbrains.buildServer.web.util.SessionUser" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="stats" tagdir="/WEB-INF/tags/graph"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="util" uri="/WEB-INF/functions/util"
%><%@ taglib prefix="auth" tagdir="/WEB-INF/tags/authz"
%><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"%>
<jsp:useBean id="customGraphs" scope="request" type="java.util.List<jetbrains.buildServer.web.statistics.graph.DeclarativeCompositeValueType>"/>
<%--@elvariable id="chartGroup" type="java.lang.String"--%>
<%--@elvariable id="project" type="jetbrains.buildServer.serverSide.SProject"--%>
<%--@elvariable id="buildType" type="jetbrains.buildServer.serverSide.SBuildType"--%>
<c:set value="${not empty buildType ? buildType.project.projectId : project.projectId}" var="currentProjectId"/>

<bs:linkScript>
  /js/bs/editCustomCharts.js
</bs:linkScript>

<%
  final Set<DeclarativeCompositeValueType> visibleCharts = new HashSet<DeclarativeCompositeValueType>();

  final jetbrains.buildServer.web.statistics.graph.BuildGraphHelper helper = (jetbrains.buildServer.web.statistics.graph.BuildGraphHelper)request.getAttribute("buildGraphHelper");
  if (helper != null) {
    for (final DeclarativeCompositeValueType customGraph : customGraphs) {
      if (customGraph.hasData(helper.createSettings(request, pageContext, customGraph.getProperties()))) {
        visibleCharts.add(customGraph);
      }
    }
  }

  pageContext.setAttribute("visibleCharts", visibleCharts);
%>

<c:set var="permissionGrantedForAnyProject"><%=SessionUser.getUser(request).isPermissionGrantedForAnyProject(Permission.EDIT_PROJECT)%></c:set>
<c:set var="authorizedInCurrent"><auth:authorize projectId="${currentProjectId}" allPermissions="EDIT_PROJECT">true</auth:authorize></c:set>
<c:forEach items="${customGraphs}" var="chart">
  <c:set var="authorized"><auth:authorize projectId="${chart.ownerProject.projectId}" allPermissions="EDIT_PROJECT">true</auth:authorize></c:set>
  <div id="${chart.key}CustomChart" class="customChart<c:if test="${authorized}"> editable</c:if>">
    <stats:buildGraph id="${chart.ownerProject.externalId}${chart.key}" valueType="${chart.key}" hideFilters="${chart.hideFilters}" projectExternalId="${chart.ownerProject.externalId}" valueTypeBean="${chart}"
                      defaultFilter="${chart.defaultFilter}" defaults="${chart.properties}" buildTypeExternalId="${buildType.externalId}"
                      additionalProperties="chartGroup">
      <jsp:attribute name="additionalActions">
        <c:if test="${authorized}">
          <a href="#" onclick="return false;" title="Edit chart" class="icon-pencil editChartToggle actionIcon noUnderline" data-chart-id='${chart.key}' data-chart-group='${chartGroup}' data-buildtype-id='${buildType.externalId}' data-project-id='${chart.ownerProject.externalId}'></a>
        </c:if>
        <c:if test="${not authorized and chart.ownerProject != project and permissionGrantedForAnyProject}">
          <a href="#" onclick="return false;" class="icon-info actionIcon noUnderline cannotEditIcon"></a>
          <script type="text/javascript">
            $j(function() {
              $j(".cannotEditIcon").on("click mouseover", function(e) {
                BS.Tooltip.showMessage(e.currentTarget, {}, "This chart is defined in the project you cannot edit: <c:out value="${chart.ownerProject.fullName}"/>");
                return false;
              }).on("mouseout", function() {BS.Tooltip.hidePopup();});
            });
          </script>
        </c:if>
      </jsp:attribute>
    </stats:buildGraph>
  </div>
</c:forEach>

<script type="text/javascript">
  $j(function() {
    $j(document).on("click", ".graphSettingsPopup .saveButtonsBlock .saveDefaults", function (e) {
      var $button = $j(e.currentTarget);
      var parents = $button.parents("form");
      if (parents.length > 0) {
        $j(parents[0]).append("<input type='hidden' name='_setYAxisDefaults' value='true'>");
        $button.siblings(".submitButton").click();
      }
      return false;
    });
  });
</script>

<auth:authorize projectId="${currentProjectId}" allPermissions="EDIT_PROJECT">
  <bs:editChartDialog keysDescriptions="${keysDescriptions}" currentProjectId="${currentProjectId}">
    <jsp:attribute name="additionalContent">
      <c:if test="${empty buildType and not empty managedProjects}">
        <div class="buildTypeChooser group">
          <span for="buildTypeChooser" class="title">Source Build Configuration</span>
          <forms:select name="buildTypeChooser" enableFilter="true" className="fullSize">
            <%--@elvariable id="managedProjects" type="java.util.List<jetbrains.buildServer.serverSide.SProject>"--%>
            <forms:option selected="false" value="" className="user-delete user-depth-0" disabled="true">-- Select Build Configuration --</forms:option>
            <c:forEach items="${managedProjects}" var="project" varStatus="status">
              <forms:projectOptGroup project="${project}" classes="user-depth-${fn:length(project.projectPath) - 1}">
                <c:forEach var="buildType" items="${project.ownBuildTypes}">
                  <forms:option value="${buildType.externalId}" title="${buildType.fullName}" className="user-depth-${fn:length(project.projectPath)}"><c:out value="${buildType.name}"/></forms:option>
                </c:forEach>
                <c:if test="${empty project.ownBuildTypes}"><forms:option selected="false" value="" className="user-delete" disabled="true">&nbsp;</forms:option></c:if>
              </forms:projectOptGroup>
            </c:forEach>
          </forms:select>
          <span style="display: none" class="spinner"><i class="icon-refresh icon-spin"></i></span>
          <bs:buildTypeLink classes="btLink" style="display: none" buildType="${buildType}" additionalUrlParams="&tab=buildTypeStatistics">see statistics tab</bs:buildTypeLink>
        </div>
      </c:if>
    </jsp:attribute>
  </bs:editChartDialog>
  <div class="addChartButtonHolder" style="display: none">
    <a class="btn editChartToggle" onclick="return false;" data-buildtype-id="${buildType.externalId}" data-project-id="${currentProjectId}" data-chart-group="${chartGroup}"><span class="icon_before icon16 addNew">Add new chart</span></a>
    <c:if test="${(not empty buildType or not empty managedProjects) and fn:length(visibleCharts) > 1}">
      <a class="btn reorderChartsButton" onclick="return false;" data-buildtype-id="${buildType.externalId}" data-project-id="${currentProjectId}" data-chart-group="${chartGroup}"><span class="reorder">Reorder</span></a>
      <c:url var="action" value="/admin/blabla.html"/>
      <bs:reorderDialog dialogId="reorderChartsDialog" dialogTitle="Charts">
        <jsp:attribute name="sortables">
          <c:forEach items="${customGraphs}" var="chart">
            <div data-is-visible="${util:contains(visibleCharts, chart)}" class="chart ${not util:contains(visibleCharts, chart) ? ' hidden' : ' draggable'}" id="ord_${chart.ownerProject.externalId}:${chart.key}"><c:out value="${chart.model.title}"/> <c:if test="${chart.ownerProject != project && chart.ownerProject != buildType.project}">(from <bs:projectLink project="${chart.ownerProject}"/>)</c:if></div>
          </c:forEach>
        </jsp:attribute>
      </bs:reorderDialog>
    </c:if>
  </div>
  <script type="text/javascript">
    $j(function () {
      var $targetContainer = $j(".GraphContainer:first");
      var $holder = $j(".addChartButtonHolder");
      if ($targetContainer.length > 0) {
        $targetContainer.before($holder);
      } else {
        $j("#mainContent").append($holder);
      }
      $holder.show();

      if (BS.CustomChart) {
        var popup = BS.CustomChart.initEditListeners('${currentProjectId}', '${chartGroup}');

        if (popup.getPopupElement().find("#buildTypeChooser").length > 0) {
          BS.CustomChart.initBuildTypeChooser(popup);
        } else {
          var initialized = false;
          $j(document).on("click", ".editChartToggle", function (e) {
            if (!initialized) {
              initialized = true;
              BS.CustomChart.updateValueTypes(popup, '${buildType.externalId}', true);
            }
          });
        }
      }
    });
  </script>
</auth:authorize>