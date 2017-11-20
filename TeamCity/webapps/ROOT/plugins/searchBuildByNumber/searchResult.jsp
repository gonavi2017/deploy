<%@ include file="/include.jsp"
%><jsp:useBean id="bean" type="jetbrains.buildServer.serverSide.search.SearchBean" scope="request"
/><c:set var="popupMode" value="${bean.popupMode}"
/><c:set var="query" value="${bean.query}"
/><c:set var="byTime" value="${bean.byTime}"
/><c:set var="searchDebug" value="${bean.searchDebug}"
/><c:set var="searchTime" value="${bean.searchTime}"
/><c:set var="searchService" value="${bean.searchService}"
/><c:set var="byTime" value="${bean.byTime}"
/><c:set var="builds" value="${bean.builds}"
/><c:set var="result" value="${bean.searchResult}"
/><c:set var="enableSearchHighlightening" value="${bean.enableSearchHighlightening}"

/><c:if test="${popupMode}"><c:set var="divClass" value="popupMode popupMode${result.total}"/></c:if
><div id="searchResultsDiv" class="${divClass}">
  <div class="quickSearchResultsHeader">
    <c:if test="${not popupMode or bean.queueSize > 0}">
      <div class="inputDiv">
      <c:if test="${not popupMode}">
        <span class="search">
          <%@ include file="inputField.jspf" %>
        </span>
        <select name="searchByTime" id="searchByTime" onchange="BS.Search.go(false, $j('#searchField'));">
          <option value="false">Sort by relevance</option>
          <option value="true" <c:if test="${byTime}">selected</c:if>>Sort by time</option>
        </select>
      </c:if>
      <c:if test="${bean.queueSize > 0}">
        <div id="searchIndexUpdating"><span class="icon icon16 yellowTriangle"></span>Updating search index... (${bean.completionPercent}% ready)</div>
      </c:if>
      </div>
    </c:if>
    <div id="resultmap" class="resultsCount">
    <span title='Translated: ${result.query}'>
    <c:choose>
      <c:when test="${result.total == 0}">No builds found<%-- for <b>#${query}</b>--%></c:when>
      <c:when test="${result.total eq 1}">1 build found<%-- for <b>#${query}</b>--%></c:when>
      <c:otherwise>${result.total} builds found<%-- for <b>#${query}</b>--%></c:otherwise>
    </c:choose>
    </span>

    <c:if test="${result.total > 0}">
      (matches in
      <c:forEach items="${result.statistics}" var="field" varStatus="fieldI">
      <span class="domain">${result.fieldNameMap[field.key]}&nbsp;&mdash; ${field.value}<c:if test="${not fieldI.last}">,
        </c:if></span></c:forEach>) in ${searchTime}ms
    </c:if>
    <c:if test="${searchDebug}">
    <bs:popup_static controlId="searchInfo">
      <jsp:attribute name="content">
        <div class="searchInfo">
          <dl>
            <dt>Status
            <dd>Indexed: ${result.indexSize}
            <dd>Queued: ${bean.queueSize}
          </dl>
          <dl>
            <dt>Available fields
              <c:forEach items="${searchService.indexMap}" var="field">
            <dd><a title='Sample values: ${field.value}'>${field.key}</a></dd>
            </c:forEach>
          </dl>
        </div>
      </jsp:attribute>
    </bs:popup_static>
    </c:if>
    <span><bs:help file="Search"/></span>
  </div>
  </div>

  <c:if test="${not empty result.error}">
    <div class="searcherror">
        ${fn:escapeXml(result.error)}
    </div>
  </c:if>

  <c:if test="${not popupMode}">
    <script type="text/javascript">
      $j(function() {
        setTimeout(function() {
          $("searchField").focus();
        }, 20)
      });
    </script>
  </c:if>

  <c:if test="${not empty builds}">
    <div class="searchResultContainer">
    <table class="searchResult">
    <c:forEach items="${builds}" var="item" varStatus="itemI">
      <c:set var="build" value="${item}"/>
      <c:set var="explanation" value="${result.explanations[build.buildId]}"/>
      <%--@elvariable id="build" type="jetbrains.buildServer.serverSide.BuildEx"--%>
      <tr class="searchItem"
          data-zones="<c:forEach items="${explanation}" var="field">.${field} </c:forEach>"
          >
        <td class="searchBT">
          <span style="white-space: nowrap;">            
            <span class="agent"><bs:buildDataIcon buildData="${build}"/></span>
            <bs:buildTypeLinkFull buildType="${build.buildType}" popupMode="true"/>
          </span>
        </td>
        <td class="statusText">
          <c:set var="branch" value="${build.branch}"/>
          <c:if test="${not empty branch}">
            <span class="branch hasBranch ${branch.defaultBranch ? 'default' : ''}">
              <span class="branchName"><bs:trimBranch branch="${branch}"/></span>
            </span>&nbsp;
          </c:if>
          <span class="buildNumber"><bs:buildNumber buildData="${build}" withLink="true"/></span>&nbsp;
          <bs:resultsLink build="${build}" noPopup="false"><span class="status tests triggerer"><c:out value="${build.statusDescriptor.text}"/></span></bs:resultsLink>
        </td>
        <td class="artifacts">
          <c:if test="${build.artifactsExists}">
            <bs:_artifactsLink build="${build}">Artifacts</bs:_artifactsLink>
          </c:if>
          <c:if test="${not build.artifactsExists}">
            <span style="color: #888;">No artifacts</span>
          </c:if>
        </td>
        <td class="changes">
          <span class="changes files revision file_revision vcs committers"
              ><bs:changesLinkFull build="${build}" noUsername="true" highlightIfCommitter="${false}"/></span>
        </td>
        <td class="startDate right">
          <bs:date value="${build.startDate}"/></td>
      </tr>
      <tr class="secondLine searchItem">
        <td colspan="6" class="explanation">
          <div class="explanationDetails">
            <c:if test="${not empty build.buildComment}">
              Comment: <span class="comment">${build.buildComment.comment}</span>
            </c:if>
            <c:set var="buildLabels" value="${build.labels}"/>
            <c:if test="${not empty buildLabels}">
              Labels: <span class="labels">${buildLabels}</span>
            </c:if>
            <c:if test="${not empty build.tags}">
              Tags: <span class="tags">${build.tags}</span>
            </c:if>
            <c:if test="${build.finished and not empty build.pinComment}">
              Pin: <span class="pin_comment">${build.pinComment.comment}</span>
            </c:if>
            <c:if test="${build.pinned}">
              <bs:pinImg build="${build}"/>
            </c:if>
          </div>
          <div>
            <c:if test="${searchDebug}">[${result.scores[itemI.index]}]</c:if>
            Found in:
          <c:forEach items="${explanation}" var="field" varStatus="fieldI">
            ${result.fieldNameMap[field]}<c:if test="${not fieldI.last}">, </c:if>
          </c:forEach>
          </div>
        </td>
      </tr>
    </c:forEach>
    </table>
    </div>
  </c:if>

  <c:set var="query"><bs:forUrl val="${query}"/></c:set>
  <c:choose>
    <c:when test="${popupMode && result.total > 0}">
      <span class="viewAllResults">
        <a href="#" onclick="BS.Search.go(true, $j('#headerSearchField')); return false;">
          View results on a dedicated page (Shift-Enter) &raquo;
        </a>
      </span>
    </c:when>
    <c:when test="${not popupMode}">
      <c:set var="pager" value="${bean.pager}"/>
      <c:set var="pagerUrlPattern" value="searchResults.html?query=${query}&byTime=${byTime}&buildTypeId=${param['buildTypeId']}&page=[page]"/>
      <c:if test="${pager.totalRecords > 0}">
        <bs:pager place="bottom" urlPattern="${pagerUrlPattern}" pager="${pager}"/>
      </c:if>
    </c:when>
  </c:choose>
</div>
<c:if test="${enableSearchHighlightening}">
<script type="text/javascript">
  BS.Search.highlightResult('#searchResultsDiv .searchItem');
</script>
</c:if>
