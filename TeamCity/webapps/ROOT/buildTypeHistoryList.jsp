<%@ include file="include-internal.jsp" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags/tags"
%><jsp:useBean id="buildType" type="jetbrains.buildServer.serverSide.SBuildType" scope="request"
/><jsp:useBean id="historyPager" type="jetbrains.buildServer.util.Pager" scope="request"
/><jsp:useBean id="historyForm" type="jetbrains.buildServer.controllers.buildType.tabs.HistorySearchBean" scope="request"
/><c:url var="history_url" value="/viewType.html?buildTypeId=${buildType.externalId}&tab=buildTypeHistoryList"/>
<%@ include file="_subscribeToCommonBuildTypeEvents.jspf"
%><et:subscribeOnBuildTypeEvents buildTypeId="${buildType.buildTypeId}">
    <jsp:attribute name="eventNames">
      BUILD_FINISHED
      BUILD_INTERRUPTED
    </jsp:attribute>
    <jsp:attribute name="eventHandler">
      BS.BuildType.updateView();
    </jsp:attribute>
</et:subscribeOnBuildTypeEvents>
<style type="text/css">
  #buildTypeHistoryList {
    margin-top: 10px;
  }
</style>

<div id="buildTypeHistoryList">
  <%--@elvariable id="pageUrl" type="java.util.String"--%>
  <bs:refreshable containerId="historyTable" pageUrl="${pageUrl}">
    <bs:messages key="recordNotFound"/>
    <div id="jumpToPopup" class="popupDiv quickLinksMenuPopup">
      <ul class="menuList">
        <l:li><a href="#" onclick="BS.JumpTo.jump('lastSuccessful'); return false">Latest successful build</a></l:li>
        <l:li><a href="#" onclick="BS.JumpTo.jump('lastPinned'); return false">Latest pinned build</a></l:li>
      </ul>
    </div>

    <c:set var="jumpedTo" value="${not empty jumpedTo ? jumpedTo : -1}"/>

    <form id="historyFilter" action="<c:url value='/viewType.html'/>" method="post" onsubmit="return BS.HistoryTable.doSearch()">
      <div class="actionBar">
        <table class="historyFilterTable">
          <tr>
            <td class="column1">
              <label for="agentName first">Filter by agent name:</label><forms:textField name="agentName" style="width: 15em;"
                                                                                         value="${historyForm.agentName}"/>
              <forms:filterButton/>
              <c:if test="${not empty historyForm.agentName}"><forms:resetFilter resetHandler="BS.HistoryTable.update('agentName=')"/></c:if>
              <script type="text/javascript">
                $('agentName').focus();
              </script>
            </td>
            <td class="column2">
              <div id="savingFilter">
                <forms:progressRing className="progressRingInline"/> Updating results...
              </div>
            </td>
            <td class="column3">
              <forms:checkbox name="showAllBuilds" checked="${historyForm.showAllBuilds}" onclick="BS.HistoryTable.doSearch()"/>
              <label for="showAllBuilds">Show canceled and failed to start builds</label>
              <span class="separator">|</span><bs:clickPopup showPopupCommand="BS.JumpTo.showPopupNearElement(this)"
                                                             controlId="jumpToControl">Jump to&hellip;</bs:clickPopup>
            </td>
          </tr>
          <tr>
            <td colspan="3">
              <tags:showBuildTypeTags buildType="${buildType}" historyForm="${historyForm}" label="Filter by tag:"/>
            </td>
          </tr>
        </table>
        <input type="hidden" name="tab" value="buildTypeHistoryList"/>
        <input type="hidden" name="buildTypeId" value="${buildType.externalId}"/>
        <input type="hidden" name="tag" value="${historyForm.tag}"/>
        <input type="hidden" name="privateTag" value="${historyForm.privateTag}"/>
      </div>
    </form>

    <%--@elvariable id="branchBean" type="jetbrains.buildServer.controllers.BranchBean"--%>
    <bs:historyTable historyRecords="${historyRecords}"
                     highlightRecord="${jumpedTo}"
                     buildType="${buildType}"
                     hasBranches="${branchBean.hasBranches}"
                     showTrivialColumnNames="${true}"/>

    <c:set var="pagerUrlPattern" value="viewType.html?buildTypeId=${buildType.externalId}&page=[page]&tab=buildTypeHistoryList"/>
    <c:if test="${not empty branchBean}">
      <c:set var="pagerUrlPattern" value="${pagerUrlPattern}&branch_${buildType.projectExternalId}=${branchBean.userBranchEscaped}"/>
    </c:if>
    <bs:pager place="bottom" urlPattern="${pagerUrlPattern}" pager="${historyPager}"/>
  </bs:refreshable>
</div>
<script type="text/javascript">
  BS.Branch.baseUrl = "${history_url}";
</script>
