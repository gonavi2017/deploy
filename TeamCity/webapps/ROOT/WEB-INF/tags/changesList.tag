<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"%>
<%@ attribute name="changeLog" required="true" type="jetbrains.buildServer.controllers.buildType.tabs.ChangeLogBean" %>
<%@ attribute name="url" required="true" type="java.lang.String" %>
<%@ attribute name="filterUpdateUrl" required="true" type="java.lang.String" %>
<%@ attribute name="projectId" required="false" type="java.lang.String" description="project external id" %>
<%@ attribute name="hideBuildSelectors" required="false"%>
<%@ attribute name="hideShowBuilds" required="false"%>
<%@ attribute name="enableCollapsibleChanges" required="false"%>
<%@ attribute name="showBuildTypeLink" required="false"%>

<%--@elvariable id="branchBean" type="jetbrains.buildServer.controllers.BranchBean"--%>
<c:if test="${not empty branchBean}">
  <c:set var="url" value="${url}&branch_${projectId}=${branchBean.userBranchEscaped}"/>
</c:if>
<c:url var="urlInternal" value="${url}"/>
<c:url var="filterUpdateUrlInternal" value="${filterUpdateUrl}"/>

<bs:linkCSS dynamic="${true}">
  /css/changeLog.css
  /css/changeLogGraph.css
</bs:linkCSS>

<c:if test="${hideShowBuilds}">
  <c:set target="${changeLog.filter}" property="showBuilds" value="false"/>
</c:if>

<div id="changeLog" class="logTable">
  <c:set var="changeLogPager" value="${changeLog.pager}"/>
  <c:set var="pagerUrlPattern" value="${urlInternal}&page=[page]"/>
  <c:set var="hideFilter" value="${changeLog.numberOfChanges lt 10 and changeLog.filter.emptyFilter}"/>

  <form action="${filterUpdateUrlInternal}" method="post" id="changeLogFilter" class="changeLogFilter" onsubmit="return BS.ChangeLog.submitFilter();">
    <div class="actionBar" style="${hideFilter ? 'display: none' : ''}">
      <span class="actionBarRight">
        <bs:resultsPerPage pager="${changeLogPager}" onchange="BS.ChangeLog.submitFilter();"/>
      </span>

      <span class="nowrap">
        <label for="userDropDown" class="first">Show changes by:</label>
        <bs:changeLogUserFilter changeLogBean="${changeLog}"/>
      </span>

      <forms:filterButton/>
      <span class="resetLink">
        <forms:resetFilter resetHandler="BS.ChangeLog.resetFilter();"
                           hidden="${empty changeLog.userId and not changeLog.hasAdvancedOptions}"/>
      </span>

      <c:if test="${not changeLog.hasAdvancedOptions}">
        <a href="#" class="actionBarAdvancedToggle" onclick="return BS.ChangeLog.toggleAdvanced(this);">Advanced search</a>
      </c:if>
      <forms:saving className="progressRingInline"/>

      <div class="actionBarAdvanced<c:if test="${not changeLog.hasAdvancedOptions}"> hidden</c:if>" id="advanced-fields">
        <c:if test="${not hideBuildSelectors}">
          <div>
            <span class="nowrap">
              <label for="from" class="first">from:</label>
              <forms:textField name="from" className="actionInput short" value="${changeLog.from}" defaultText="<build #>"/>
            </span>

            <span class="nowrap">
              <label for="to">to:</label>
              <forms:textField name="to" className="actionInput short" value="${changeLog.to}" defaultText="<build #>"/>
            </span>
          </div>
        </c:if>

        <div>
          <span class="nowrap">
            <label for="comment" class="first">containing comment:</label>
            <forms:textField name="comment" className="actionInput" value="${changeLog.comment}" defaultText=""/>
          </span>
        </div>

        <div>
          <span class="nowrap">
            <label for="path" class="first">containing path:</label>
            <forms:textField name="path" className="actionInput" value="${changeLog.path}" defaultText=""/>
          </span>
        </div>

        <div>
          <span class="nowrap">
            <label for="path" class="first">revision:</label>
            <forms:textField name="revision" className="actionInput" value="${changeLog.revision}" defaultText=""/>
          </span>
        </div>
      </div>
    </div>

    <bs:refreshable containerId="changeLogTable" pageUrl="${urlInternal}">
      <c:choose>
        <c:when test="${not changeLog.fromPositionFound and not changeLog.toPositionFound}">
          <div class="error" style="margin-left: 0">
            Builds with build number <strong><c:out value='${changeLog.from}'/></strong> and <strong><c:out value='${changeLog.to}'/></strong> do not exist.
          </div>
        </c:when>
        <c:when test="${not changeLog.fromPositionFound or not changeLog.toPositionFound}">
          <div class="error" style="margin-left: 0">
          <c:if test="${not changeLog.fromPositionFound}">Build with build number <strong><c:out value='${changeLog.from}'/></strong> does not exist.</c:if>
          <c:if test="${not changeLog.toPositionFound}">Build with build number <strong><c:out value='${changeLog.to}'/></strong> does not exist.</c:if>
          </div>
        </c:when>
      </c:choose>
      <p class="resultsTitle">
        <c:if test="${changeLog.hasChanges}">
          <c:if test="${changeLog.showPermalink}">
            <span class="changeLogPermalink">
              <bs:changeLogLink baseUrl="${urlInternal}" from="${changeLog.from}" to="${changeLog.to}"
                                userId="${changeLog.userId}" path="${changeLog.path}" changesLimit="${changeLog.filter.changesLimit}"
                                showBuilds="${changeLog.showBuilds}" revision="${changeLog.revision}" comment="${changeLog.comment}">Permalink</bs:changeLogLink>
            </span>
          </c:if>
          <span class="changeLogToggle">
            <forms:checkbox name="showGraph" checked="${changeLog.showGraph}" onclick="BS.ChangeLog.toggleGraph()" disabled="${not empty changeLog.path}"/>
            <label for="showGraph">Show graph <bs:help file="Working+with+Build+Results#WorkingwithBuildResults-ChangesGraph"/></label>
          </span>
          <c:if test="${not hideShowBuilds}">
            <span class="changeLogToggle">
              <bs:changeLogShowBuildsCheckBox changeLogBean="${changeLog}"/>
            </span>
          </c:if>
          <span class="changeLogToggle">
            <forms:checkbox name="showFiles" checked="${changeLog.showFiles}" onclick="BS.ChangeLog.submitFilter(this)"/>
            <label for="showFiles">Show files</label>
          </span>
          <input type="hidden" name="buildsActiveDays" id="buildsActiveDays" value="${changeLog.filter.buildsActiveDays}"/>
        </c:if>
      </p>

      <script>BS.ChangeLog.disable();</script>

      <c:choose>
        <c:when test="${fn:length(changeLog.visibleRows) > 0}">
          <c:set var="foundDescr">
            Found <span id="changes-num-found">${changeLog.numberOfChanges}</span> change<bs:s val="${changeLog.numberOfChanges}"/><c:choose
              ><c:when test="${changeLog.notAllResultsShown}"> in first <span class="changes-total">${(changeLog.filter.changesLimit) * changeLog.bigPageSize}</c:when
              ><c:when test="${changeLog.filter.buildsActiveDays > 0}"> from builds finished during the last <strong>${changeLog.filter.buildsActiveDays}</strong> active days, <a href="#" onclick="$('buildsActiveDays').value = -1; BS.ChangeLog.submitFilter($('changeLogFilter'));">show all</a></c:when
              ></c:choose></span>
          </c:set>

          <bs:pager place="title" urlPattern="${pagerUrlPattern}" pager="${changeLogPager}" pagerDesc="${foundDescr}"/>
        </c:when>
        <c:when test="${changeLog.hasChanges}">
          <div class="pager pager-title">
            Found <span id="changes-num-found">${changeLog.numberOfChanges}</span> change<bs:s val="${changeLog.numberOfChanges}"/><c:choose
              ><c:when test="${changeLog.notAllResultsShown}"> in first <span class="changes-total">${(changeLog.filter.changesLimit) * changeLog.bigPageSize}</c:when
              ><c:when test="${changeLog.filter.buildsActiveDays > 0}"> from builds finished during the last <strong>${changeLog.filter.buildsActiveDays}</strong> active days, <a href="#" onclick="$('buildsActiveDays').value = -1; BS.ChangeLog.submitFilter($('changeLogFilter'));">search in all changes</a></c:when
              ></c:choose></span>
          </div>
        </c:when>
        <c:otherwise>
          <div class="pager pager-title">
            There are no changes found.
          </div>
        </c:otherwise>
      </c:choose>

      <c:if test="${fn:length(changeLog.visibleRows) > 0}">
        <bs:changeLogTable changeLogBean="${changeLog}" showBranch="${changeLog.showBranch}" showBuildTypeInBuilds="${showBuildTypeLink}" noBranchLink="${empty branchBean or not branchBean.hasBranches}"/>
      </c:if>

      <c:if test="${changeLog.notAllResultsShown and changeLogPager.lastPage}">
        <p class="resultsTitle">
          Searched through <strong class="changes-total">${(changeLog.filter.changesLimit) * changeLog.bigPageSize}</strong> changes.
          <script type="text/javascript">BS.ChangeLog.currentPage = 1;</script>
          <a id="search-more" href="#" onclick="BS.ChangeLog.showNextBigPage('${urlInternal}'); return false;">Search in next ${changeLog.bigPageSize}</a>
          <forms:saving id="progress" className="progressRingInline"/>
        </p>
      </c:if>

      <c:if test="${fn:length(changeLog.visibleRows) > 0 and changeLogPager.totalRecords > 0}">
        <bs:pager place="bottom" urlPattern="${pagerUrlPattern}" pager="${changeLogPager}"/>
      </c:if>

      <script type="text/javascript">
        BS.ChangeLog.enableFilter();
        BS.ChangeLog.initChangeLogTable("#changesTable");

        <c:if test="${changeLog.showGraph}">
        BS.ChangeLogGraph.redrawGraph();
        </c:if>
      </script>
    </bs:refreshable>
  </form>
  <br/>
</div>
<script type="text/javascript">
  BS.Branch.baseUrl = "${urlInternal}";
</script>
