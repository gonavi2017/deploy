<%@ include file="../include-internal.jsp" %>

<%--@elvariable id="buildPromotion" type="jetbrains.buildServer.serverSide.BuildPromotion"--%>

<c:set var="defaultBranch" value="${buildPromotion.branch.defaultBranch}"/>
<c:set var="buildType"  value="${buildPromotion.buildType}"/>

<et:subscribeOnBuildTypeEvents buildTypeId="${buildPromotion.buildTypeId}">
  <jsp:attribute name="eventNames">
    BUILD_CHANGES_LOADED
  </jsp:attribute>
  <jsp:attribute name="eventHandler">
    $("queuedBuildContainer") && $("queuedBuildContainer").refresh();
  </jsp:attribute>
</et:subscribeOnBuildTypeEvents>
<c:choose>
  <c:when test="${changesNotYetCollected}">
    Changes have not been collected yet
  </c:when>
  <c:otherwise>
    <%-- Build Revisions --%>
    <%--@elvariable id="depsRevisionsBean" type="jetbrains.buildServer.controllers.RevisionsBean"--%>
    <jsp:useBean id="changeLogBean" type="jetbrains.buildServer.controllers.buildType.tabs.ChangeLogBean" scope="request"/>
    <jsp:useBean id="revisionsBean" type="jetbrains.buildServer.controllers.RevisionsBean" scope="request"/>
    <c:set var="defaultBranch" value="${buildPromotion.branch.defaultBranch}"/>

    <c:if test="${not empty revisionsBean.revisions or (not empty depsRevisionsBean and not empty depsRevisionsBean.revisions)}">
      <div id="vcsInformation">
        <bs:refreshable containerId="buildLabels" pageUrl="${pageUrl}">
          <div class="clr"></div>
          <table class="plain changeRevisionsTable">
            <tr>
              <th class="vcsRoot">VCS Root</th>
              <th class="revision">Revision</th>
              <th class="label">Label</th>
            </tr>
            <c:forEach var="revision" items="${revisionsBean.revisions}">
              <tr>
                <td class="vcsRoot">
                  <c:if test="${revision.settingsRevision}">
                    <c:if test="${not revisionsBean.frozenSettings}">
                      <c:set var="notFixedSettingsRevision" value="true"/>
                      <div id="notFixedSettingsRevisionPopup" class="grayNote" style="display: none">
                        Revision of the build configuration settings on the moment of build start. Actual settings taken by the build can be different.
                        <bs:helpLink file="Storing+Project+Settings+in+Version+Control"><bs:helpIcon/></bs:helpLink>
                      </div>
                    </c:if>
                    <i class="tc-icon icon16 tc-icon_cog" title="TeamCity settings revision"></i>
                  </c:if>
                  <c:choose>
                    <c:when test="${notFixedSettingsRevision}">
                      <span class="notFixedSettingsRevision"
                            onmouseover="BS.Tooltip.showMessageFromContainer(this, {}, 'notFixedSettingsRevisionPopup')"
                            onmouseout="BS.Tooltip.hidePopup()">
                        <em>(<c:out value="${revision.root.vcsName}"/>)</em> <c:out value="${revision.root.name}"/>
                      </span>
                    </c:when>
                    <c:otherwise>
                      <em>(<c:out value="${revision.root.vcsName}"/>)</em> <c:out value="${revision.root.name}"/>
                    </c:otherwise>
                  </c:choose>
                  <span class="noteOnVcsRootInBuild">
                    <c:set var="vcsRoot" value="${revision.root}" scope="request"/>
                    <ext:includeJsp jspPath="/buildLog/buildChangesVcsDetails.jsp"/>
                  </span>
                </td>
                <c:set var="vcsBranch" value="${revision.repositoryVersion.vcsBranch}"/>
                <td class='revision <c:if test="${vcsBranch != null}">branch <c:if test="${defaultBranch}">default</c:if><c:if test="${not defaultBranch}">hasBranch</c:if></c:if>'>
                  <c:if test="${vcsBranch != null}">
                    <span class="branchName"><c:out value="${vcsBranch}"/></span>
                  </c:if>
                  <c:choose>
                    <c:when test="${notFixedSettingsRevision}">
                      <span class="revisionNum notFixedSettingsRevision"
                            onmouseover="BS.Tooltip.showMessageFromContainer(this, {}, 'notFixedSettingsRevisionPopup')"
                            onmouseout="BS.Tooltip.hidePopup()">
                        <c:out value="${revision.revisionDisplayName}"/>
                      </span>
                    </c:when>
                    <c:otherwise>
                      <span class="revisionNum"><c:out value="${revision.revisionDisplayName}"/></span>
                    </c:otherwise>
                  </c:choose>
                </td>
                <td class="label">
                  <c:set var="label" value="${revisionsBean.labels[revision.root.id]}"/>
                  <c:choose>
                    <c:when test="${label eq null}"><span class="commentText">none</span></c:when>
                    <c:when test="${label.successful}"><c:out value="${label.labelText}"/></c:when>
                    <c:when test="${label.failed}"><div class="error" style="margin-left: 0">Failed: <c:out value="${label.failureReason}"/></div></c:when>
                    <c:otherwise><span class="commentText">none (<c:out value="${label.statusText}"/>)</span></c:otherwise>
                  </c:choose>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${(not empty depsRevisionsBean) && (not empty depsRevisionsBean.revisions)}">
              <jsp:useBean id="depsRevisionsBean" type="jetbrains.buildServer.controllers.RevisionsBean" scope="request"/>
              <c:set var="buildType"  value="${buildPromotion.buildType}"/>
              <c:forEach var="revision" items="${depsRevisionsBean.revisions}">
                <tr>
                  <td class="vcsRoot">
                    <bs:snapDepChangeIcon title="This root is attached to snapshot dependency"/>
                    <em>(<c:out value="${revision.root.vcsName}"/>)</em> <c:out value="${revision.root.name}"/>
                  </td>
                  <c:set var="vcsBranch" value="${revision.repositoryVersion.vcsBranch}"/>
                  <td class='revision <c:if test="${vcsBranch != null}">branch <c:if test="${defaultBranch}">default</c:if><c:if test="${not defaultBranch}">hasBranch</c:if></c:if>'>
                    <c:if test="${vcsBranch != null}">
                      <span class="branchName"><c:out value="${vcsBranch}"/></span>
                    </c:if>
                    <span class="revisionNum"><c:out value="${revision.revisionDisplayName}"/></span>
                  </td>
                  <td class="label"></td>
                </tr>
              </c:forEach>
            </c:if>
          </table>
        </bs:refreshable>
      </div>
    </c:if>

    <!--=========================== CHANGES BLOCK =======-->
    <bs:changesList changeLog="${changeLogBean}"
                    url="${baseBuildUrl}&buildTypeId=${buildType.externalId}&tab=buildChangesDiv"
                    filterUpdateUrl="buildChangeLogTab.html?promoId=${buildPromotion.id}"
                    projectId="${buildPromotion.buildType.projectExternalId}"
                    hideBuildSelectors="true"
                    hideShowBuilds="true"
                    enableCollapsibleChanges="true"/>
  </c:otherwise>
</c:choose>
