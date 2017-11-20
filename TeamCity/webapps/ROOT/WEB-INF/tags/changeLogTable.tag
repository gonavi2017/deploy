<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="ext" tagdir="/WEB-INF/tags/ext" %><%@
    taglib prefix="changefn" uri="/WEB-INF/functions/change" %><%@
    taglib prefix="l" tagdir="/WEB-INF/tags/layout" %><%@
    attribute name="changeLogBean" required="true" type="jetbrains.buildServer.controllers.buildType.tabs.ChangeLogBean" %><%@
    attribute name="buildType" required="false" type="jetbrains.buildServer.serverSide.SBuildType" %><%@
    attribute name="checkoutRules" required="false" type="jetbrains.buildServer.vcs.CheckoutRules" %><%@
    attribute name="changedFilesLinkDisabled" required="false" type="java.lang.Boolean" %><%@
    attribute name="showBuildTypeInBuilds" required="false" type="java.lang.Boolean" %><%@
    attribute name="showBranch" required="false" type="java.lang.Boolean" %><%@
    attribute name="noBranchLink" required="false" type="java.lang.Boolean" %>
<table class="changeLogTableInner">
<tr>
<c:if test="${!changeLogBean.showGraph}"><c:set var="graphStyle">style="display: none;"</c:set></c:if>
<td id="graphTd" class="graphTd graph-container" ${graphStyle}>
  <div id="graph" class="graph"></div>
</td>
  <td class="changeLogTd">
    <bs:changesTable>
      <c:set var="nearestBuildRow" value="${changeLogBean.topBuildRow}"/>
      <c:set var="prevRow" value="${null}"/>
      <c:forEach items="${changeLogBean.visibleRows}" var="row" varStatus="pos">
        <c:if test="${pos.first and changeLogBean.showBuilds and nearestBuildRow != row and not changeLogBean.isAddToSamePage}">
          <c:choose>
            <c:when test="${nearestBuildRow.build != null}">
              <bs:changeLogCaptionRow rowClass="modification-row-header continued">
                <bs:changeLogBuildRow build="${nearestBuildRow.build}"
                                      showBuildTypeInBuilds="${showBuildTypeInBuilds}"
                                      showBranch="${showBranch}"
                                      noBranchLink="${noBranchLink}"/>
              </bs:changeLogCaptionRow>
            </c:when>
            <c:otherwise>
              <bs:changeLogCaptionRow rowClass="modification-row-header">Pending changes</bs:changeLogCaptionRow>
            </c:otherwise>
          </c:choose>
        </c:if>
        <c:choose>
          <c:when test="${row.type == 'BUILD_ROW'}">
            <bs:changeLogCaptionRow rowClass="modification-row-header" rowId="tr-build-${row.build.buildId}">
              <bs:changeLogBuildRow build="${row.build}"
                                    showBuildTypeInBuilds="${showBuildTypeInBuilds}"
                                    showBranch="${showBranch}"
                                    noBranchLink="${noBranchLink}"/>
            </bs:changeLogCaptionRow>
            <c:set var="prevBuild" value="${row.build}"/>
          </c:when>
          <c:when test="${row.type == 'ART_DEPS_CHANGE_ROW'}">
            <tr class="modification-row">
              <td colspan="5" class="artifactDescriptionCaption icon_before icon16 blockHeader collapsed">Artifact dependency changes (${row.numberOfBuilds})</td>
              <td class="date"><bs:date value="${row.date}" no_smart_title="true"/></td>
              <td></td>
            </tr>
            <c:forEach items="${row.artifactDependencyChanges}" var="cd">
            <%--@elvariable id="sourceBuild" type="jetbrains.buildServer.serverSide.SBuild"--%>
            <c:set var="build" value="${row.build}"/>
            <c:set var="sourceBuild" value="${cd.associatedData['NEW_BUILD_ATTR']}"/>
            <c:set var="filesNum" value="${fn:length(build.downloadedArtifacts.artifacts[sourceBuild])}"/>
            <tr class="modification-row artifacts-row hidden">
              <td class="artifactDescription" colspan="7">
                <table class="artifactDescriptionTable">
                  <tr>
                    <td class="artifactDescriptionBuildType">
                      <bs:buildTypeLinkFull buildType="${sourceBuild.buildType}"/>
                    </td>
                    <bs:buildRow build="${sourceBuild}" showStatus="true" showBuildNumber="true"/>
                    <td class="changedFiles">
                      <bs:popupControl showPopupCommand="BS.DependentArtifactsPopup.showPopup(this, '${build.buildId}', '${sourceBuild.buildId}', 'downloadedFrom')"
                                       hidePopupCommand="BS.DependentArtifactsPopup.hidePopup()"
                                       stopHidingPopupCommand="BS.DependentArtifactsPopup.stopHidingPopup()"
                                       controlId="artifacts:${sourceBuild.buildId}">${filesNum} file<bs:s val="${filesNum}"/></bs:popupControl>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            </c:forEach>
          </c:when>
          <c:when test="${row.type == 'VCS_CHANGE_ROW'}">
            <bs:changeLogChangeRow vcsChangeRow="${row}"
                                   showFilesInRows="${changeLogBean.showFiles}"
                                   showBuilds="${changeLogBean.showBuilds}"
                                   noBranchLink="${noBranchLink}"
                                   checkoutRules="${checkoutRules}"/>
          </c:when>
        </c:choose>
        <c:set var="prevRow" value="${row}"/>
      </c:forEach>
    </bs:changesTable>
  </td>
</tr>
</table>
<script type="text/javascript">
  <c:if test="${changeLogBean.showFiles}">$j('#changesTable .changedFiles .toggle').hide();</c:if>
  <l:blockState blocksType="vcsRootGraph"/>
  BS.ChangeLogGraph.setGraphData(${changeLogBean.graph.json});
  BS.ChangeLogGraph.initGraph("#graph", "#showGraph", "#changesTable");
</script>
