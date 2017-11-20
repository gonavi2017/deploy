<%@ page import="jetbrains.buildServer.serverSide.TimePoint" %>
<%@
    include file="include-internal.jsp" %><%@
    taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags/tags" %><%@
    taglib prefix="q" tagdir="/WEB-INF/tags/queue"

%><jsp:useBean id="modification" type="jetbrains.buildServer.vcs.SVcsModification" scope="request"
/><jsp:useBean id="changeStatus" type="jetbrains.buildServer.vcs.ChangeStatus" scope="request"
/><jsp:useBean id="buildType" type="jetbrains.buildServer.serverSide.SBuildType" scope="request"
/><jsp:useBean id="currentUser" type="jetbrains.buildServer.users.User" scope="request"


/><c:set var="changeBtStatus" value="${changeStatus.buildTypesStatus[buildType]}" scope="request"
/><c:set var="firstBuild" value="${changeBtStatus.firstBuild}" scope="request"
/><c:set var="queuedBuilds" value="${changeBtStatus.queuedBuilds}"
/><c:set var="currentBuild" value="${changeBtStatus.currentBuild}" scope="request"
/><c:set var="neverInterval" value="<%= TimePoint.NEVER%>"

/><!-- To enable hide successful option: -->
<%--@elvariable id="hideSuccessfulProperty" type="java.lang.Boolean"--%>
<c:if test="${not empty param.show_all_builds}"><c:set var="disableHidingBuilds" value="true"/></c:if>
<c:if test="${empty hideSuccessfulProperty}"
  ><c:set var="hideSuccessfulProperty" value="${ufn:booleanPropertyValue(currentUser, 'changePage_hideSuccessful') and not disableHidingBuilds}"
/></c:if
><c:set var="no_display"><c:if test="${hideSuccessfulProperty and not changeBtStatus.failed}">style='display: none;'</c:if></c:set>
<c:set var="buildTypeColumnContent"><bs:responsibleIcon responsibility="${buildType.responsibilityInfo}"/><bs:buildTypeLinkFull buildType="${buildType}" projectText="${buildType.project.extendedName}"/></c:set>
<c:set var="trClass1" value="${firstBuild == null ? 'pendingBuild' : ''}"/>
<c:set var="row_id">viewModificationBuildType_${buildType.buildTypeId}_<bs:_csId changeStatus="${changeStatus}"/></c:set>
  <c:choose>
    <c:when test="${not empty firstBuild}">
      <c:choose>
        <c:when test="${not empty currentBuild && firstBuild!=currentBuild}">
          <%--two rows with first column (rowspan=2) shoud be shown--%>
          <tr id="${row_id}" ${no_display} class="buildTypeProblem ${trClass1} nosplit">
            <td class="buildTypeName" rowspan="2">
              <bs:responsibleIcon responsibility="${buildType.responsibilityInfo}"/>
              <bs:buildTypeLinkFull buildType="${buildType}" projectText="${buildType.project.extendedName}"/>
              <c:set var="nameAdded" value="true"/>
            </td>
            <td class="buildPrefix">First run:</td>
            <bs:buildRow build="${firstBuild}" showBuildNumber="true" showStatus="true" showChanges="true" showStartDate="true" showBranchName="true"/>
          </tr>
          <tr class="buildTypeProblem additional" ${no_display}>
              <td class="buildPrefix">Current:</td>
              <bs:buildRow build="${currentBuild}" showBuildNumber="true" showStatus="true" showChanges="true" showStartDate="true" showBranchName="true"/>
          </tr>
        </c:when>
        <c:when test="${not empty currentBuild && firstBuild==currentBuild}">
          <%--one row should be shown (with current)--%>
          <tr id="${row_id}" ${no_display}  class="buildTypeProblem ${trClass1}">
            <td class="buildTypeName">
              <bs:responsibleIcon responsibility="${buildType.responsibilityInfo}"/>
              <bs:buildTypeLinkFull buildType="${buildType}" projectText="${buildType.project.extendedName}"/>
              <c:set var="nameAdded" value="true"/>
            </td>
            <td class="buildPrefix">Current:</td>
            <bs:buildRow build="${currentBuild}" showBuildNumber="true" showStatus="true" showChanges="true" showStartDate="true" showBranchName="true"/>
          </tr>
        </c:when>
        <c:otherwise>
          <tr id="${row_id}" ${no_display} class="buildTypeProblem ${trClass1}">
            <td class="buildTypeName">
              <bs:responsibleIcon responsibility="${buildType.responsibilityInfo}"/>
              <bs:buildTypeLinkFull buildType="${buildType}" projectText="${buildType.project.extendedName}"/>
              <c:set var="nameAdded" value="true"/>
            </td>
            <td class="buildPrefix">First run:</td>
            <bs:buildRow build="${firstBuild}" showBuildNumber="true" showStatus="true" showChanges="true" showStartDate="true" showBranchName="true"/>
          </tr>
        </c:otherwise>
      </c:choose>
     </c:when>
     <c:when test="${not empty queuedBuilds}">
      <tr id="${row_id}" ${no_display} class="buildTypeProblem ${trClass1}">
        <c:forEach var="qBuild" items="${queuedBuilds}" varStatus="i">
          <td class="buildTypeName"><c:if test="${empty nameAdded}">${buildTypeColumnContent}</c:if></td>
          <td class="buildPrefix queued"><c:if test="${i.first}">Queued:</c:if></td>
          <bs:queuedBuild queuedBuild="${qBuild}" hideIcon="true" showNumber="true" estimateColspan="3" showBranches="true"/>
        </c:forEach>
      </tr>
    </c:when>
    <c:otherwise>
      <tr id="${row_id}" ${no_display} class="buildTypeProblem ${trClass1}">
          <td class="buildTypeName"><c:if test="${empty nameAdded}">${buildTypeColumnContent}</c:if></td>
          <td class="buildPrefix notTriggered">Not triggered</td>
          <td colspan="5">&nbsp;</td>
      </tr>
    </c:otherwise>
  </c:choose>
