<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn" uri="/WEB-INF/functions/user" %>
<%@ taglib prefix="util" uri="/WEB-INF/functions/util"%>
<%@attribute name="buildChain" required="true" type="jetbrains.buildServer.serverSide.dependency.BuildChain" %>
<%@attribute name="serverSideExpand" required="false" type="java.lang.Boolean" %>
<%@attribute name="selectedBuildTypeId" required="false" type="java.lang.String" %>
<%@attribute name="contextProject" required="false" type="jetbrains.buildServer.serverSide.SProject" %>
<%@attribute name="showHeader" required="false" type="java.lang.Boolean" %>

<c:set var="topBuildTypes" value="${buildChain.topBuildTypes}"/>
<c:set var="topBuildPromotions" value="${buildChain.topBuildPromotions}"/>
<c:set var="chainId" value="${not empty param['chainId']? param['chainId'] : buildChain.id}"/>
<c:set var="blockId" value="block_${chainId}"/>
<c:set var="contextProjectUrlExt" value=""/>
<c:if test="${not empty contextProject}">
  <c:set var="contextProjectUrlExt" value="&contextProjectId=${contextProject.externalId}"/>
</c:if>
<c:set value='/viewChain.html?chainId=${chainId}&selectedBuildTypeId=${selectedBuildTypeId}${contextProjectUrlExt}' var="relativeViewChainUrl"/>
<c:url value='${relativeViewChainUrl}' var="viewChainUrl"/>

<bs:refreshable containerId="chainRefresh_${buildChain.id}" pageUrl="${pageUrl}&chainId=${buildChain.id}">
<div class="buildChainBlock">
  <c:set var="currentPromotion" value="${buildChain.allPromotionsMap[selectedBuildTypeId]}"/>
  <c:if test="${empty currentPromotion}">
    <c:set var="currentPromotion" value="${buildChain.latestTopPromotion}"/>
  </c:if>

  <c:if test="${not empty currentPromotion and showHeader}">
  <div class="icon_before icon16 blockHeader ${serverSideExpand ? 'expanded' : 'collapsed'}" onclick="BS.BuildChains.toggleChainBlock(this, '${blockId}')">
    <table class="buildChainHeader" border="0">
        <c:set var="triggered" value="${not empty currentPromotion}"/>
        <c:set var="buildType" value="${currentPromotion.buildType}"/>
        <c:set var="build" value="${not empty currentPromotion ? currentPromotion.associatedBuild : null}"/>
        <c:set var="queuedBuild" value="${not empty currentPromotion ? currentPromotion.queuedBuild : null}"/>
        <c:set var="branch" value="${not empty currentPromotion ? currentPromotion.branch : null}"/>

        <tr class="chainBuildInfo">
          <td class="chainStatus" id="status_${chainId}"><!-- pie chart --></td>
          <td class="buildConfName ${not triggered ? 'notTriggered' : ''}" ${not triggered ? 'colspan="4"' : ''}><bs:buildTypeLinkFull buildType="${buildType}" contextProject="${contextProject}"/></td>
          <c:choose>
            <c:when test="${not empty build}">
              <td class="branch ${not empty branch ? 'hasBranch' : ''} ${not empty branch and branch.defaultBranch ? 'default' : ''}">
                <c:if test="${not empty branch}">
                  <bs:branchLink branch="${branch}" build="${build}"><c:out value="${branch.displayName}"/></bs:branchLink>
                </c:if>
              </td>
              <td class="lastBuildNumber">
                <bs:buildNumber buildData="${build}"/>
              </td>
              <td class="chainStatusText">
                <bs:buildDataIcon buildData="${build}"/>
                <bs:resultsLink build="${build}"><c:out value="${build.statusDescriptor.text}"/></bs:resultsLink>
              </td>
              <td class="chainStartTime">Started: <bs:date value="${build.startDate}"/></td>
            </c:when>
            <c:when test="${not empty queuedBuild}">
              <td class="branch ${not empty branch ? 'hasBranch' : ''} ${not empty branch and branch.defaultBranch ? 'default' : ''}">
                <c:if test="${not empty branch}">
                  <bs:branchLink branch="${branch}" buildPromotion="${queuedBuild.buildPromotion}"><c:out value="${branch.displayName}"/></bs:branchLink>
                </c:if>
              </td>
              <td class="lastBuildNumber"></td>
              <td class="chainStatusText">
                <bs:queuedBuildIcon queuedBuild="${queuedBuild}"/>
                <bs:_viewQueued queuedBuild="${queuedBuild}">waiting in queue</bs:_viewQueued>
              </td>
              <td class="chainStartTime">Triggered: <bs:date value="${queuedBuild.whenQueued}"/></td>
            </c:when>
            <c:otherwise>
              <td class="chainStartTime">Not triggered</td>
            </c:otherwise>
          </c:choose>
          <td class="openChainInNewWindow">
            <a href="${viewChainUrl}" target="_blank" onclick="BS.stopPropagation(event);" title="Open build chain in a new window"><i class="tc-icon icon16 tc-icon_build-chain"></i></a>
          </td>
        </tr>
    </table>
  </div>
  </c:if>
  <c:choose>
    <c:when test="${not serverSideExpand}">
      <div id="${blockId}" data-url="${viewChainUrl}&embedded=true" data-chain-id="${buildChain.id}" data-prev-chain-id="${buildChain.previousId}" class="buildChainGraph"></div>
    </c:when>
    <c:otherwise>
      <div id="${blockId}" data-url="${viewChainUrl}&embedded=true" data-chain-id="${buildChain.id}" data-prev-chain-id="${buildChain.previousId}" class="buildChainGraph"><jsp:include page="${relativeViewChainUrl}&embedded=true"/></div>
    </c:otherwise>
  </c:choose>

  <script type="text/javascript">
    BS.PieStatus.drawPlaceholder($('status_${chainId}'));

    if ($j(".buildChainHeader td.branch.hasBranch").length > 0) {
      $j(".buildChainHeader td.branch").css("width", "10%");
    }

    <c:if test="${showHeader}">
    window.setTimeout(function() {
      BS.ajaxRequest('<c:url value="/buildChainStatusChart.html"/>', {
        parameters: "chainId=${chainId}",
        onComplete: function(response) {
          response.responseText.evalScripts();
        }
      });
    }, 200);
    </c:if>
  </script>
</div>
</bs:refreshable>