<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="ext" tagdir="/WEB-INF/tags/ext" %><%@
    taglib prefix="changefn" uri="/WEB-INF/functions/change" %><%@
    attribute name="vcsChangeRow" required="true" type="jetbrains.buildServer.controllers.buildType.tabs.ChangeLogVcsChangeRow"%><%@
    attribute name="buildType" required="false" type="jetbrains.buildServer.BuildType" %><%@
    attribute name="checkoutRules" required="false" type="jetbrains.buildServer.vcs.CheckoutRules" %><%@
    attribute name="showFilesInRows" required="false" type="java.lang.Boolean" %><%@
    attribute name="showBuilds" required="false" type="java.lang.Boolean" %><%@
    attribute name="hideCommitter" required="false" type="java.lang.Boolean" %><%@
    attribute name="className" required="false" type="java.lang.String" %><%@
    attribute name="noBranchLink" required="false" type="java.lang.Boolean" %>
<c:set var="change" value="${vcsChangeRow.relatedVcsChange}"/>
<tr class="modification-row vcs-row ${className}" id="tr-mod-${change.id}">
  <td class="changeDescription">
    <c:set var="branchTags" value="${vcsChangeRow.branchTags}"/>
    <c:if test="${not empty branchTags}">
      <c:forEach var="branchTag" items="${branchTags}">
        <c:set var="branch" value="${branchTag.branch}"
        /><c:set var="clazz" value="${branch.defaultBranch ? 'branch default' : 'branch'} hasBranch"
        /><c:set var="trimmedBranch"><bs:trimBranch branch="${branch}"/></c:set
        ><span class="${clazz}"><bs:branchLink branch="${branch}" vcsChangeBranchTag="${branchTag}" noLink="${noBranchLink}">${trimmedBranch}</bs:branchLink></span>
      </c:forEach>
    </c:if>
    <bs:subrepoIcon modification="${vcsChangeRow.changeDescriptor.relatedVcsChange}"/>
    <c:choose>
      <c:when test="${fn:length(change.description) > 0}">
        <c:choose>
          <c:when test="${buildType != null}">
            <c:set var="resolverContext" value="${buildType}"/>
          </c:when>
          <c:when test="${vcsChangeRow.build != null}">
            <c:set var="resolverContext" value="${vcsChangeRow.build.buildPromotion}"/>
          </c:when>
        </c:choose>
        <bs:out value="${fn:trim(change.description)}" resolverContext="${resolverContext}"/>
      </c:when>
      <c:otherwise>No comment</c:otherwise>
    </c:choose>
  </td>
  <td class="userName">
    <c:if test="${empty hideCommitter or not hideCommitter}">
      <bs:changeCommitters modification="${change}"/>
    </c:if>
  </td>
  <td class="chainChangesIcon">
    <c:if test="${changefn:isSnapshotDependencyModification(vcsChangeRow.changeDescriptor)}">
      <bs:snapDepChangeLink snapDepLink="${changefn:getSnapDepLink(vcsChangeRow.changeDescriptor)}"/>
    </c:if>
  </td>
  <td class="changedFiles">
    <bs:changedFilesLink modification="${change}"
                         build="${vcsChangeRow.build}"
                         disableFileFiltering="${changefn:isSnapshotDependencyModification(vcsChangeRow.changeDescriptor)}"
                         disablePopup="false"
                         checkoutRules="${checkoutRules}"/>
  </td>
  <td class="vcsChange">
    <c:if test="${change.personal}">
      <span class="vcsChangeType"><bs:trimWhitespace><bs:changeType modification="${change}"/></bs:trimWhitespace>:</span>
    </c:if>

    <span class="vcsChangeNum" <bs:tooltipAttrs text="${change.personal ? change.personalChangeInfo.commitType.name : change.vcsRoot.name}<br>${change.displayVersion}"/>>
      <bs:shortRevision change="${change}"/>
    </span>
  </td>
  <td class="date">
    <bs:date value="${change.vcsDate}"/>
  </td>
  <td class="vcsChangeDetails">
    <c:set var="modification" scope="request" value="${change}"/>
    <ext:includeJsp jspPath="/vcsChangeDetails.jsp"/>
  </td>
</tr>
<c:if test="${showFilesInRows}">
  <c:choose>
    <c:when test="${not empty vcsChangeRow.build}">
      <bs:changeLogFilesRow modification="${change}" build="${vcsChangeRow.build}" disableFileFiltering="${changefn:isSnapshotDependencyModification(vcsChangeRow.changeDescriptor)}"/>
    </c:when>
    <c:otherwise>
      <bs:changeLogFilesRow modification="${change}" buildType="${buildType}" disableFileFiltering="${changefn:isSnapshotDependencyModification(vcsChangeRow.changeDescriptor)}"/>
    </c:otherwise>
  </c:choose>
</c:if>
