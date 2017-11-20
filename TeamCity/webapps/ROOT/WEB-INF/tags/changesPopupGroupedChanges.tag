<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
    %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
    %><%@ taglib prefix="changefn" uri="/WEB-INF/functions/change"
    %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
    %><%@ taglib prefix="user" uri="/WEB-INF/functions/user" %>
<%@attribute name="changes" type="jetbrains.buildServer.controllers.changes.ChangesBean" required="true" %>
<c:choose>
  <c:when test="${changes.buildPromotion != null}">
    <c:set var="resolverContext" value="${changes.buildPromotion}"/>
  </c:when>
  <c:otherwise>
    <c:set var="resolverContext" value="${changes.ownerBuildType}"/>
  </c:otherwise>
</c:choose>
<c:forEach items="${changes.changes}" var="userChanges">
  <c:set var="only1change" value="${fn:length(changes.modifications) == 1}"/>
  <c:set var="artifactChangesHeaderStyle" value="artifactsChangeHeader icon_before icon16 blockHeader ${only1change ? 'expanded' : 'collapsed'}"/>
  <c:set var="artifactChange" value="${changefn:isArtifactDependencyModification(userChanges.changes[0])}"/>
  <div class="userChanges">
    <div class="userChangesHeader ${userChanges.hightlightChanges ? 'highlightChanges' : ''}
              ${artifactChange ? artifactChangesHeaderStyle : ''}">
      <c:forEach items="${userChanges.committers}" var="committer" varStatus="pos">
        <c:choose>
          <c:when test="${fn:length(committer.vcsUsername) > 0}">
            <c:set var="tooltip">
              VCS username: <c:out value="${committer.vcsUsername}"/><br/>
              TeamCity user:
              <c:if test="${empty committer.user}">
                unknown
                <c:if test="${not artifactChange and not user:isGuestUser(currentUser)}">
                  <a title="Add this vcs username to my profile" href="javascript:;" onclick="BS.VcsUsername.addVcsNameFromModification(${userChanges.changes[0].relatedVcsChange.id});">it's me!</a>
                </c:if>
              </c:if>
              <c:if test="${not empty committer.user}"><c:out value="${committer.user.extendedName}"/></c:if>
            </c:set>
            <span <bs:tooltipAttrs text="${tooltip}"/> ><c:out value="${committer.extendedName}"/></span><c:if test="${not pos.last}">, </c:if>
          </c:when>
          <c:otherwise>
            <c:out value="${committer.name}"/>
          </c:otherwise>
        </c:choose>
      </c:forEach>
    </div>
    <c:forEach items="${userChanges.changes}" var="change">
      <c:choose>
        <c:when test="${changefn:isArtifactDependencyModification(change)}">
          <c:forEach items="${change.associatedData['CHANGED_DEPENDENCIES_ATTR']}" var="artChange">
            <div class="userChange artifactChange ${only1change ? '' : 'hidden'}">
              <c:set var="sourceBuild" value="${artChange.associatedData['NEW_BUILD_ATTR']}"/>
              <div class="userChangeFiles">
                <c:set var="filesNum" value="${fn:length(changes.build.downloadedArtifacts.artifacts[sourceBuild])}"/>
                <bs:popupControl showPopupCommand="BS.DependentArtifactsPopup.showPopup(this, ${changes.build.buildId}, ${sourceBuild.buildId}, 'downloadedFrom')"
                                 hidePopupCommand="BS.DependentArtifactsPopup.hidePopup()"
                                 stopHidingPopupCommand="BS.DependentArtifactsPopup.stopHidingPopup()"
                                 controlId="artifacts:${sourceBuild.buildId}">${filesNum} file<bs:s val="${filesNum}"/></bs:popupControl>
              </div>
              <div class="userChangeComment artifactComment">
                <table class="artifactCommentTable">
                  <tr>
                    <td class="artifactCommentBuildType"><bs:buildTypeLinkFull buildType="${sourceBuild.buildType}"/></td>
                    <bs:buildRow build="${sourceBuild}" showBuildNumber="true" showStatus="true"/>
                  </tr>
                </table>
              </div>
            </div>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <div class="userChange">
            <div class="userChangeFiles">
              <c:choose>
                <c:when test="${not empty changes.build}">
                  <bs:changedFilesLink modification="${change.relatedVcsChange}" build="${changes.build}"/>
                </c:when>
                <c:otherwise>
                  <bs:changedFilesLink modification="${change.relatedVcsChange}" buildType="${changes.ownerBuildType}"/>
                </c:otherwise>
              </c:choose>
            </div>
          <c:if test="${changefn:isSnapshotDependencyModification(change)}">
              <div class="dependencyRelationIcon">
                <bs:snapDepChangeLink snapDepLink="${changefn:getSnapDepLink(change)}"/>
              </div>
            </c:if>
            <div class="userChangeComment">
              <bs:subrepoIcon modification="${change.relatedVcsChange}"/>
              <c:if test="${userChanges.personalChanges[change.relatedVcsChange.id] != null}"><bs:personalChangesIcon1 mod="${change.relatedVcsChange}"/></c:if>
              <c:if test="${not change.relatedVcsChange.personal and changes.containsVcsRootsOfDifferentTypes}"><em>(<c:out value="${change.relatedVcsChange.vcsRoot.vcsDisplayName}"/>)</em></c:if>
              <c:set var="description" value="${fn:trim(change.description)}"/>
              <c:choose>
                <c:when test="${fn:length(description) > 0}">
                  <c:choose>
                    <c:when test="${changes.buildPromotion != null}">
                      <bs:out value="${description}" resolverContext="${changes.buildPromotion}"/>
                    </c:when>
                    <c:otherwise>
                      <bs:out value="${description}" resolverContext="${changes.ownerBuildType}"/>
                    </c:otherwise>
                  </c:choose>
                </c:when>
                <c:otherwise>No comment</c:otherwise>
              </c:choose>
            </div>
          </div>
        </c:otherwise>
      </c:choose>
    </c:forEach>
  </div>
</c:forEach>