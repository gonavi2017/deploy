<%@ include file="/include-internal.jsp" %>
<%--@elvariable id="projectRow" type="java.util.List<jetbrains.buildServer.web.util.ProjectHierarchyTreeBean>"--%>
<%--@elvariable id="archivedRow" type="jetbrains.buildServer.serverSide.statistics.diskusage.DiskUsageProjectRow"--%>
<%--@elvariable id="totalArtifactsSize" type="int"--%>
<%--@elvariable id="totalLogsSize" type="int"--%>
<%--@elvariable id="totalSize" type="int"--%>
<%--@elvariable id="totalSizeRaw" type="java.lang.Long"--%>
<%--@elvariable id="buildTypes" type="java.util.Map<jetbrains.buildServer.serverSide.SBuildType, jetbrains.buildServer.serverSide.statistics.diskusage.DiskUsageRow>"--%>
<%--elvariable id="prows" type="java.util.Map<jetbrains.buildServer.serverSide.SProject, jetbrains.buildServer.serverSide.statistics.diskusage.DiskUsageProjectRow>"--%>
<bs:trimWhitespace>
  <c:set var="tableClass"><c:if test="${diskUsageForm.grouped}">grouped</c:if> diskUsageTable sortable dark borderBottom</c:set>
  <c:if test="${diskUsageForm.grouped}">
    <bs:projectHierarchy rootProjects="${projectRow}" linksToAdminPage="false" subprojectsPreceed="true" collapsible="true"
                         tablePostHeaderClass="total" tableFooterClass="archivedProject" showRootProjects="false" treeId="diskUsage"
                         tableClass="${tableClass}" tableBuildTypeClass="buildTypeData" customEmptyProjectMessage="No visible configurations">
      <jsp:attribute name="projectHTML">
        <%--@elvariable id="projectBean" type="jetbrains.buildServer.controllers.admin.diskUsage.DiskUsageController.ProjectRowBean"--%>
        <c:set var="pr" value="${projectBean.projectRow}"/>
        <%--@elvariable id="pr" type="jetbrains.buildServer.serverSide.statistics.diskusage.DiskUsageProjectRow"--%>
        <td class="middleCell subtotal size" <c:if test="${not pr.statisticResult.containsData}">title="Not scanned yet"</c:if>><strong>${pr.statisticResult.totalFormatted}</strong></td>
        <td class="middleCell iconcell"></td>
        <td class="middleCell subtotal percent" <c:if test="${not pr.statisticResult.containsData}">title="Not scanned yet"</c:if>><strong>${pr.statisticResult.containsData ? util:formatPercent(pr.statisticResult.total, totalSizeRaw) : "-"}</strong></td>
        <td class="middleCell subtotal size" <c:if test="${not pr.statisticResult.containsData}">title="Not scanned yet"</c:if>><strong>${pr.statisticResult.artifactsFormatted}</strong></td>
        <td class="middleCell subtotal size" <c:if test="${not pr.statisticResult.containsData}">title="Not scanned yet"</c:if>><strong>${pr.statisticResult.logsFormatted}</strong></td>
      </jsp:attribute>
      <jsp:attribute name="buildTypeHTML">
        <c:set var="pr" value="${projectBean.projectRow}"/>
        <%--@elvariable id="projectBean" type="jetbrains.buildServer.controllers.admin.diskUsage.DiskUsageController.ProjectRowBean"--%>
        <c:set var="bt" value="${pr.rowsMap[buildType]}"/>
        <%--@elvariable id="bt" type="jetbrains.buildServer.serverSide.statistics.diskusage.DiskUsageRow"--%>
        <td class="size" <c:if test="${bt.statisticResult.nonBuildsSize > 0}">title="Has non-builds files with size ${util:formatFileSize(bt.statisticResult.nonBuildsSize, 2)}" style="text-decoration: underline"</c:if> <c:if test="${not bt.calculated}">title="Not scanned yet"</c:if>>${bt.statisticResult.totalFormatted}</td>
        <td class="iconcell"><c:if test="${bt.buildsNumber > 0}"
          ><i class="tc-icon icon16 commentIcon" popup-data="${bt.buildType.externalId}"></i></c:if
        ></td>
        <td class="percent" <c:if test="${not bt.calculated}">title="Not scanned yet"</c:if>>${bt.calculated ? util:formatPercent(bt.statisticResult.total, pr.statisticResult.total) : "-"}</td>
        <td class="size" <c:if test="${not bt.calculated}">title="Not scanned yet"</c:if>>${bt.statisticResult.artifactsFormatted}</td>
        <td class="size" <c:if test="${not bt.calculated}">title="Not scanned yet"</c:if>>${bt.statisticResult.logsFormatted}</td>
      </jsp:attribute>
      <jsp:attribute name="tableHeader">
        <th class="sortable projectName groupable"><span id="CONFIGURATION">Project/Configuration Name</span></th>
        <th class="sortable groupable size"><span class="descDefault" id="TOTAL_SIZE">Size</span></th>
        <th class="iconcell"></th>
        <th class="percent"><span class="descDefault" id="a">%</span></th>
        <th class="sortable groupable size"><span class="descDefault" id="ARTIFACT_SIZE">Artifacts</span></th>
        <th class="sortable groupable size"><span class="descDefault" id="LOG_SIZE">Logs</span></th>
      </jsp:attribute>
      <jsp:attribute name="postHeader">
        <td>Total:</td>
        <td class="size">${totalSize}</td>
        <td class="iconcell"></td>
        <td class="size"></td>
        <td class="size">${totalArtifactsSize}</td>
        <td class="size">${totalLogsSize}</td>
      </jsp:attribute>
    </bs:projectHierarchy>
  </c:if>
  <c:if test="${not diskUsageForm.grouped}">
    <bs:projectHierarchy rootProjects="${projectRow}" linksToAdminPage="false" tablePostHeaderClass="total" tableFooterClass="archivedProject" treeId="diskUsage"
                         showRootProjects="false" tableClass="${tableClass}" tableBuildTypeClass="buildTypeData" _defaultBTNameColumn="false">
      <jsp:attribute name="projectHTML"></jsp:attribute>
      <jsp:attribute name="buildTypeHTML">
        <%--@elvariable id="projectBean" type="jetbrains.buildServer.controllers.admin.diskUsage.DiskUsageController.ProjectRowBean"--%>
        <c:set var="pr" value="${projectBean.projectRow}"/>
        <%--@elvariable id="pr" type="jetbrains.buildServer.serverSide.statistics.diskusage.DiskUsageProjectRow"--%>
        <c:set var="bt" value="${pr.rowsMap[buildType]}"/>
        <%--@elvariable id="bt" type="jetbrains.buildServer.serverSide.statistics.diskusage.DiskUsageRow"--%>
        <td ${not bt.calculated ? "class='nodata'" : ""}>
          <admin:editBuildTypeLink buildTypeId="${bt.buildType.externalId}"><c:out value="${bt.buildType.name}"/></admin:editBuildTypeLink>
        </td>
        <td class="groupedValue size" <c:if test="${not bt.calculated}">title="Not scanned yet"</c:if>>${bt.statisticResult.totalFormatted}</td>
        <td class="iconcell"><c:if test="${bt.buildsNumber > 0}"
          ><i class="tc-icon icon16 commentIcon" alt="" popup-data="${bt.buildType.externalId}"></i></c:if
        ></td>
        <td class="groupedValue size" <c:if test="${not bt.calculated}">title="Not scanned yet"</c:if>>${bt.calculated ? util:formatPercent(bt.statisticResult.total, totalSizeRaw) : "-"}</td>
        <td class="groupedValue size" <c:if test="${not bt.calculated}">title="Not scanned yet"</c:if>>${bt.statisticResult.artifactsFormatted}</td>
        <td class="groupedValue size" <c:if test="${not bt.calculated}">title="Not scanned yet"</c:if>>${bt.statisticResult.logsFormatted}</td>
      </jsp:attribute>
      <jsp:attribute name="tableHeader">
        <th class="sortable projectName"><span id="PROJECT">Project Name</span></th>
        <th class="sortable configurationName"><span id="CONFIGURATION">Configuration Name</span></th>
        <th class="sortable size"><span class="descDefault" id="TOTAL_SIZE">Size</span></th>
        <th class="iconcell"></th>
        <th class="percent"><span class="descDefault" id="a">%</span></th>
        <th class="sortable size"><span class="descDefault" id="ARTIFACT_SIZE">Artifacts</span></th>
        <th class="sortable size"><span class="descDefault" id="LOG_SIZE">Logs</span></th>
      </jsp:attribute>
      <jsp:attribute name="postHeader">
        <td colspan="2">Total:</td>
        <td class="size">${totalSize}</td>
        <td class="iconcell"></td>
        <td class="size"></td>
        <td class="size">${totalArtifactsSize}</td>
        <td class="size">${totalLogsSize}</td>
      </jsp:attribute>
      <jsp:attribute name="buildTypeNameHTML">
        <c:set var="pr" value="${projectBean.projectRow}"/>
        <c:set var="bt" value="${pr.rowsMap[buildType]}"/>
        <admin:editProjectLink projectId="${bt.project.externalId}">${bt.project.fullName}</admin:editProjectLink>
        <c:if test="${bt.project.archived}"> <span class="archivedProject">archived</span></c:if>
      </jsp:attribute>
    </bs:projectHierarchy>
  </c:if>
</bs:trimWhitespace>