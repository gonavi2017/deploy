<%@ include file="/include-internal.jsp"%>
<jsp:useBean id="runBuildBean" type="jetbrains.buildServer.controllers.RunBuildBean" scope="request"/>
<jsp:useBean id="dependencies" type="jetbrains.buildServer.controllers.RunBuildDependencies" scope="request"/>

<c:if test="${dependencies.hasSnapshotDependencies or dependencies.hasArtifactDependencies}">
  <div id="dependencies-tab" style="display: none;" class="tabContent">
    <table class="runnerFormTable">
      <c:if test="${dependencies.hasSnapshotDependencies}">
      <tr>
        <td>
          <div>
            <a style="float: right" href="#" onclick="$j('#dependencies-tab select').each( function() { this.selectedIndex = 0; this._changedManually = null; BS.RunBuildDialog.highlightArtifactDep(this, ''); } );">Reset all</a>
            <c:set var="onclick">if (this.checked) { $j('#dependencies-tab select').each( function() { if (this.options[1].value == '__rebuild__') this.selectedIndex = 1; this._onchange(0); } ); }</c:set>
            <forms:checkbox name="rebuildDependencies"
                            onclick="${onclick}"/> <label for="rebuildDependencies">rebuild all snapshot dependencies transitively</label>
          </div>
        </td>
      </tr>
      </c:if>
      <tr>
        <td>
          <c:set value="${dependencies.rebuildDependenciesMap}" var="rebuildDepsMap"/>
          <c:set value="${dependencies.snapshotDependenciesWithoutArtifactDeps}" var="snapshotDepsWithoutArtifacts"/>
          <c:set value="${dependencies.artifactDependenciesSourceBuildTypes}" var="buildTypesMap"/>
          <c:set value="${dependencies.defaultArtifactDependencies}" var="artDeps"/>
          <c:set value="${dependencies.customArtifactDependenciesMap}" var="customDepsMap"/>
          <c:set value="${dependencies.lastBuilds}" var="lastBuilds"/>
          <table class="artifactBuildTypes" style="width: 100%">
            <c:forEach items="${artDeps}" var="artDep" varStatus="pos">
              <c:set var="elemName" value="artifactDependency:${artDep.sourceBuildTypeId}"/>
              <c:set var="elemId" value="${elemName}:${pos.index}"/>
              <tr <c:if test="${customDepsMap[artDep.sourceBuildTypeId] != null}">class="modifiedParam"</c:if>>
                <td style="width: 25%; vertical-align: top">
                  <c:set var="bt" value="${buildTypesMap[artDep.sourceBuildTypeId]}"/>
                  <label for="${elemId}"><c:choose>
                    <c:when test="${not empty bt}"><bs:buildTypeLinkFull buildType="${bt}"/></c:when>
                    <c:otherwise><em title="${not artDep.accessible ? 'You do not have enough permissions to access this configuration' : 'Build configuration does not exist'}">inaccessible build configuration</em></c:otherwise>
                  </c:choose></label>
                </td>
                <td style="padding-left: 0.5em; vertical-align: top">
                  <c:choose>
                    <c:when test="${not empty bt}">
                      <select name="${elemName}" id="${elemId}" style="width: 90%;" onchange="this._onchange(event || window.event);">
                        <forms:option value="">auto (<c:out value="${artDep.revisionRule.description}"/>)</forms:option>
                        <c:if test="${not empty rebuildDepsMap[artDep.sourceBuildTypeId]}">
                        <forms:option value="__rebuild__">rebuild</forms:option>
                        </c:if>
                        <c:forEach items="${lastBuilds[bt]}" var="build"
                          ><c:set var="startDate"><bs:date value="${build.startDate}" pattern="dd MMM yy HH:mm" no_span="true"/></c:set
                          ><c:set var="buildTags" value="${build.tags}"
                          /><c:set var="buildPinned" value="${build.pinned}"
                          /><c:set var="tagPinInfo" value=""
                          /><c:set var="branchName" value="${empty build.branch ? null : build.branch.displayName}"
                          /><c:if test="${buildPinned}"><c:set var="tagPinInfo" value="pinned"/></c:if
                          ><c:if test="${fn:length(buildTags) > 0}"
                            ><c:if test="${buildPinned}"><c:set var="tagPinInfo" value="pinned: "/></c:if
                            ><c:if test="${not buildPinned}"><c:set var="tagPinInfo" value="tags: "/></c:if
                            ><c:forEach var="tag" items="${buildTags}"
                              ><c:set var="tagPinInfo" value="${tagPinInfo} ${tag}"
                           /></c:forEach
                          ></c:if
                          ><c:if test="${not empty tagPinInfo}"><c:set var="tagPinInfo" value="(${tagPinInfo})"/></c:if
                          ><forms:option value="buildId:${build.buildId}" selected="${build == customDepsMap[artDep.sourceBuildTypeId]}"
                            ><bs:buildNumber buildData="${build}"/> <c:out value="${branchName}"/> (${startDate}) ${build.buildStatus.successful ? "" : "(failed)"} <c:out value="${tagPinInfo}"/>
                          </forms:option
                       ></c:forEach>
                      </select>
                      <script type="text/javascript">
                        $('${elemId}')._onchange = function(event) {
                          var that = this;
                          BS.RunBuildDialog.highlightArtifactDep(this, '');
                          if (event != 0) {
                            // manual change
                            this._changedManually = true;
                            $j('#dependencies-tab select').each(
                                function() {
                                  if (that != this && this.name.indexOf('artifactDependency:${artDep.sourceBuildTypeId}') != -1 && !this._changedManually)
                                    this.selectedIndex = that.selectedIndex; this._onchange(0);
                                }
                            );
                            <c:if test="${not empty rebuildDepsMap[artDep.sourceBuildTypeId]}">
                            if (this.selectedIndex != 1) $('rebuildDependencies').checked = false;
                            </c:if>
                          }
                        }.bind($('${elemId}'));
                      </script>
                    </c:when>
                    <c:otherwise>
                      auto (<c:out value="${artDep.revisionRule.description}"/>)
                      <input type="hidden" name="${elemName}" value=""/>
                    </c:otherwise>
                  </c:choose>
                  <bs:smallNote>
                  Artifacts paths:<br/>
                  <div style="margin-left: 1em;" class="mono"><bs:out value="${artDep.sourcePaths}"/></div>
                  </bs:smallNote>
                </td>
              </tr>
            </c:forEach>
            <c:forEach items="${snapshotDepsWithoutArtifacts}" var="bt" varStatus="pos">
            <tr>
              <td style="width: 25%; vertical-align: top">
                <bs:buildTypeLinkFull buildType="${bt}"/>
              </td>
              <td style="padding-left: 0.5em; vertical-align: top">
                <c:set var="elemName" value="snapshotDependency:${bt.buildTypeId}"/>
                <c:set var="elemId" value="${elemName}:${pos.index}"/>
                <select style="width: 90%;" name="${elemName}" id="${elemId}" onchange="this._onchange(event || window.event)">
                  <forms:option value="">auto</forms:option>
                  <forms:option value="__rebuild__">rebuild</forms:option>
                </select>
                <script type="text/javascript">
                  $('${elemId}')._onchange = function(event) {
                    BS.RunBuildDialog.highlightArtifactDep(this, '');
                    if (event != 0) {
                      if (this.selectedIndex != 1) $('rebuildDependencies').checked = false;
                    }
                  }.bind($('${elemId}'));
                </script>
                <bs:smallNote>snapshot dependency</bs:smallNote>
              </td>
            </tr>
            </c:forEach>
          </table>
        </td>
      </tr>
    </table>
  </div>
</c:if>