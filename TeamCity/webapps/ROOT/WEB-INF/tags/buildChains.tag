<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="et" tagdir="/WEB-INF/tags/eventTracker" %>
<%@ taglib prefix="up" tagdir="/WEB-INF/tags/userProfile" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@attribute name="buildChainsBean" type="jetbrains.buildServer.controllers.graph.BuildChainsBean" required="true" %>
<%@attribute name="showFilter" type="java.lang.Boolean" required="false" %>
<%@attribute name="filterByAllBuildTypesPossible" type="java.lang.Boolean" required="false" %>
<%@attribute name="contextProject" type="jetbrains.buildServer.serverSide.SProject" required="false" %>
<jsp:useBean id="pageUrl" type="java.lang.String" scope="request"/>
<c:set var="buildChainsBean" value="${buildChainsBean}"/>
<c:set var="numChains" value="${buildChainsBean.numberOfChains}"/>
<c:set var="buildChains" value="${buildChainsBean.buildChains}"/>
<bs:linkCSS>
  /css/buildQueue.css
  /css/layeredGraph.css
  /css/buildChains.css
  /css/overviewTable.css
  /css/changeLog.css
  /css/buildLog/buildResultsDiv.css
</bs:linkCSS>
<bs:linkScript>
  /js/raphael-min.js
  /js/raphael.pieChart.js

  /js/bs/locationHash.js
  /js/bs/layeredGraph.js
  /js/bs/buildChains.js
  /js/bs/pieChartStatus.js
  /js/bs/blocksWithHeader.js
  /js/bs/runningBuilds.js
  /js/bs/changeLog.js
  /js/bs/changeLogGraph.js
  /js/bs/testDetails.js
  /js/bs/testGroup.js
  /js/bs/buildResultsDiv.js
</bs:linkScript>
<style type="text/css">
  .showMore {
    width: 100%;
    margin: 10px auto;
  }

  .showMore .btn {
    width: 15%;
    text-align: center;
    margin-left: 40%;
  }
</style>
<bs:refreshable containerId="allChains" pageUrl="${pageUrl}">

<c:if test="${showFilter != false}">
<script type="text/javascript">
  BS.BuildChainsFilter = OO.extend(BS.AbstractWebForm, {
    formElement: function() {
      return $('buildChainsFilter');
    },

    savingIndicator: function() {
      return $('buildChainsFilterProgress');
    },

    resetFilter: function() {
      $('selectedBuildTypeId').selectedIndex = 0;
      this.submitFilter();
    },

    submitFilter : function() {
      var that = this;
      this.setSaving(true);
      this.disable();
      BS.FormSaver.save(this, this.formElement().action, OO.extend(BS.SimpleListener, {
        onCompleteSave: function() {
          BS.reload(false);
        }
      }));

      return false;
    }
  });
</script>
<div>
  <form action="<c:url value='/buildChainsFilter.html'/>" id="buildChainsFilter" method="post" onsubmit="return false;">
    <div class="actionBar">
      <span class="nowrap">
        <label class="firstLabel" for="selectedBuildTypeId">Build chains:<bs:help file="Build+Chain"/></label>
        <forms:select name="selectedBuildTypeId" onchange="BS.BuildChainsFilter.submitFilter();" enableFilter="true" style="width: 30em">
          <forms:option value="">&lt;All build chains&gt;</forms:option>
          <c:forEach items="${buildChainsBean.availableTopBuildTypes}" var="bean">
            <forms:projectOptGroup project="${bean.project}" data="${bean.limitedDepth}" inplaceFiltered="true">
              <c:forEach var="buildType" items="${bean.buildTypes}"
                ><forms:option className="inplaceFiltered"
                               value="${buildType.buildTypeId}"
                               title="${buildType.fullName}"
                               data="${bean.limitedDepth + 1}"
                               selected="${buildChainsBean.selectedBuildTypeId == buildType.buildTypeId}"><c:out value="${buildType.name}"/></forms:option
                ></c:forEach>
            </forms:projectOptGroup>
          </c:forEach>
        </forms:select>
      </span>
      &nbsp;
      <span class="resetLink">
        <forms:resetFilter resetHandler="BS.BuildChainsFilter.resetFilter();" hidden="${empty buildChainsBean.selectedBuildTypeId}"/>
      </span>

      <forms:saving id="buildChainsFilterProgress" className="progressRingInline"/>

      <input type="hidden" name="buildChainsBeanId" value="${buildChainsBean.id}"/>
      <input type="hidden" name="buildChainsNum" value="${buildChainsBean.buildChainsNum}"/>
    </div>
  </form>
</div>
</c:if>

<div>
  <div class="pager-title">
    <c:choose>
      <c:when test="${numChains < buildChainsBean.defaultBuildChainsNum}">
        Found ${numChains} build chain<bs:s val="${numChains}"/>.
      </c:when>
      <c:otherwise>
        Showing ${numChains} most recent build chain<bs:s val="${numChains}"/>.
      </c:otherwise>
    </c:choose>
  </div>
  <div class="clr"></div>
</div>

<c:forEach var="buildChain" items="${buildChains}" varStatus="pos">
  <c:set var="serverSideExpand" value="${(param['chainId'] == buildChain.id and param['collapsed'] != 'true') or param['currentlyExpandedId'] == buildChain.id or param['currentlyExpandedId'] == buildChain.previousId}"/>
  <bs:_singleChainBlock buildChain="${buildChain}"
                        selectedBuildTypeId="${buildChainsBean.highlightedBuildTypeId}"
                        contextProject="${contextProject}"
                        serverSideExpand="${serverSideExpand}"
                        showHeader="true"/>
  <script type="text/javascript">
    if (!window._allChains) window._allChains = [];
    window._allChains['${buildChain.id}'] = [];
    <c:forEach items="${buildChain.allPromotions}" var="promo">window._allChains['${buildChain.id}'].push(${promo.id});</c:forEach>
  </script>
</c:forEach>

<c:forEach items="${buildChainsBean.buildTypesToWatch}" var="bt">
  <et:subscribeOnBuildTypeEvents buildTypeId="${bt.buildTypeId}">
    <jsp:attribute name="eventNames">
      BUILD_TYPE_ADDED_TO_QUEUE
    </jsp:attribute>
    <jsp:attribute name="eventHandler">
      BS.BuildChains.scheduleAllChainsRefresh(300);
    </jsp:attribute>
  </et:subscribeOnBuildTypeEvents>
</c:forEach>

<c:if test="${buildChainsBean.hasMoreData}">
<div class="showMore">
  <forms:button title="Load more build chains" onclick="var elem = $j('#buildChainsFilter')[0].buildChainsNum; elem.value = parseInt(elem.value, 10) + ${buildChainsBean.defaultBuildChainsNum}; BS.BuildChainsFilter.submitFilter(); return false">More</forms:button>
</div>
</c:if>
<script type="text/javascript">
  if ($j(".buildChainHeader td.branch.hasBranch").length > 0) {
    $j(".buildChainHeader td.branch").css("width", "10%");
  }

  var expandBlockId = BS.LocationHash.getHashParameter('expand');
  if ($j('.blockHeader.expanded')[0]) {
    // check hash parameter corresponds to expanded chain
    var expandedId = $j('.blockHeader.expanded').nextAll('div')[0].id;
    BS.LocationHash.setHashParameter('expand', expandedId);
  } else {
    if (!expandBlockId) {
      var firstBlock = $j('.buildChainBlock .buildChainGraph')[0];
      BS.BuildChains._showChain(firstBlock);
    } else {
      var chainId = expandBlockId.replace(/block_/, '');
      var prefix = chainId.substring(0, chainId.indexOf('-'));
      var promoIds = chainId.substring(chainId.indexOf('-')).split('_');

      var bestFoundChain = { elem: null, numMatchedPromos: -1 };
      $j('.buildChainBlock .buildChainGraph').each(function() {
        if ($j(this).data('chain-id') == chainId || $j(this).data('prev-chain-id') == chainId) {
          bestFoundChain.elem = $j(this)[0];
          return false;
        }

        if ($j(this).data('chain-id').startsWith(prefix)) {
          var chainPromoIds = window._allChains[$j(this).data('chain-id')];
          var numFound = 0;
          for (var i=0; i<promoIds.length; i++) {
            if (chainPromoIds.indexOf(parseInt(promoIds[i], 10)) != -1) {
              numFound++;
            }
          }

          if (bestFoundChain.numMatchedPromos < numFound) {
            bestFoundChain.elem = $j(this)[0];
            bestFoundChain.numMatchedPromos = numFound;
          }
        }

        return true;
      });

      if (bestFoundChain.elem) {
        BS.BuildChains._showChain(bestFoundChain.elem);
      }
    }
  }
</script>
</bs:refreshable>
