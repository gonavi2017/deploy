<%@ include file="/include-internal.jsp" %>
<%@ taglib prefix="tt" tagdir="/WEB-INF/tags/tests"%>

<jsp:useBean id="changeStatus" type="jetbrains.buildServer.vcs.ChangeStatus" scope="request"/>
<jsp:useBean id="changeDetailsBean" type="jetbrains.buildServer.controllers.changes.ChangeDetails" scope="request"/>
<jsp:useBean id="sortedConfigurations" type="java.util.Collection<jetbrains.buildServer.serverSide.SBuildType>" scope="request"/>

<c:set var="key"><bs:_csId changeStatus="${changeStatus}"/></c:set>

<c:if test="${changeDetailsBean.problemsSectionNeeded}">
  <c:set var="problemText"><%@ include file="_changeProblemSummary.jspf" %></c:set>
</c:if>

<div class="expandedDetails">
<div class="expandedChange" id="expanded_view_${key}">

  <!-- Tabs: -->
  <div id="changeTabs_${key}" class="simpleTabs clearfix"></div>

  <%-- change problems --%>
  <c:if test="${changeDetailsBean.problemsSectionNeeded}">
      <div class="sectionContent" id="problems_${key}" style="display: none;">
        <div class="sectionTitle">${buildsText}</div>
        <%@ include file="_changeProblemBuildSection.jspf" %>

        <div class="sectionTitle">${testsText}</div>
        <%@ include file="_changeProblemTestSection.jspf" %>
      </div>
  </c:if>

  <%-- change builds --%>
  <div class="sectionContent" id="builds_${key}" style="display: none;">
      <c:if test="${not modification.personal}">
        <c:if test="${empty sortedConfigurations}">
          <div class="noBuilds">
             There are no builds${changeStatus.pendingBuildsTypesNumber > 0 ? " yet" : ""} with this change.
           </div>
        </c:if>
      </c:if>
      <c:set var="disableHidingBuilds" value="true" scope="request"/>

      <c:set var="hideSuccessful">${not changeStatus.change.personal and fn:length(sortedConfigurations) > 15}</c:set>
      <bs:_hideSuccessfulLine changeStatus="${changeStatus}" hideSuccessful="${hideSuccessful}"
                              jsBuildTypes="BS.changeTree.getNode('ct_node_${key}').changeBuildTypes"/>


      <table class="modificationBuilds">
      <c:forEach var="entry" items="${sortedConfigurations}" varStatus="pos">
        <c:if test="${not empty changeStatus.buildTypesStatus[entry]}">
          <c:set var="buildType" value="${entry}" scope="request"/>
          <c:set var="modification" value="${changeStatus.change}" scope="request"/>
          <ext:includeJsp jspPath="/viewModificationBuildType.jsp"/>
        </c:if>
      </c:forEach>
      </table>
      <div class="moreBlock">
        <bs:modificationLink modification="${modification}" tab="vcsModificationBuilds&show_all_builds=true">
          View all builds on the change page &raquo;
        </bs:modificationLink>
      </div>
  </div>

  <%-- change files --%>
  <c:if test="${changeDetailsBean.changedFilesCount > 0}">
      <div class="sectionContent" id="files_${key}" style="display: none;">
        <bs:changedFiles changes="${modificationFilesBean.changesToShow}"
                         modification="${modificationFilesBean.modification}"
                         openLinkInSameTab="${modificationFilesBean.openFileLinksInSameTab}"
                         highlightChange="${modificationFilesBean.highlightChange}"
            />
        <div class="moreBlock">
          <bs:modificationLink modification="${modification}" tab="vcsModificationFiles">
            View change details &raquo;
          </bs:modificationLink>
        </div>
      </div>
  </c:if>

</div>
</div>

<script>
  (function() {
    var switch_tab = function(tab) {
      $j("#expanded_view_${key}").find("div.sectionContent").each(function() {
        if (this.id == tab.getId()) {
          BS.Util.show(this);
        } else {
          BS.Util.hide(this);
        }
      });
    };

    var tabs = new TabbedPane();
    <c:if test="${changeDetailsBean.problemsSectionNeeded}">
      tabs.addTab('problems_${key}', { caption: 'Problems & <span class="first-letter">T</span>ests', onselect: switch_tab });
    </c:if>

    tabs.addTab('builds_${key}', { caption: '<span class="first-letter">B</span>uilds (${fn:length(sortedConfigurations)})', onselect: switch_tab });

    <c:if test="${changeDetailsBean.changedFilesCount > 0}">
      tabs.addTab('files_${key}', { caption: '<span class="first-letter">F</span>iles (${changeDetailsBean.changedFilesCount})', onselect: switch_tab });
    </c:if>

    var node = BS.changeTree.getNode('ct_node_${key}');
    node.setTabs(tabs, '${param.tab}');

    var buildTypes = {};
    <c:forEach var="buildType" items="${sortedConfigurations}">
      <jsp:useBean id="buildType" type="jetbrains.buildServer.serverSide.SBuildType"/>
      <c:set var="btStatus" value="${changeStatus.buildTypesStatus[buildType]}"/>
      <c:if test="${not empty btStatus}">
        buildTypes["${buildType.buildTypeId}"] = {id: "${buildType.buildTypeId}", failed: ${btStatus.failed}, successful: ${btStatus.successful}};
      </c:if>
    </c:forEach>

    // Each object in buildTypes map has properties id (buildTypeId, successful, failed)
    node.setBuildTypes(buildTypes);
    node.refreshHideSuccessful(${hideSuccessful});

  })();
</script>