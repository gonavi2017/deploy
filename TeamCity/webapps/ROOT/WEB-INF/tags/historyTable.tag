<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %><%@
    taglib prefix="tests" tagdir="/WEB-INF/tags/tests" %><%@
    taglib prefix="t" tagdir="/WEB-INF/tags/tags" %><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %><%@

    attribute name="historyRecords" required="true" rtexprvalue="true" type="java.util.Collection" %><%@
    attribute name="buildType" required="true" rtexprvalue="true" type="jetbrains.buildServer.serverSide.SBuildType" %><%@
    attribute name="highlightRecord" required="false" type="java.lang.Integer" %><%@
    attribute name="hasBranches" required="false" type="java.lang.Boolean" %><%@
    attribute name="showTrivialColumnNames" required="false" type="java.lang.Boolean"

%><c:url var="history_url" value="/viewType.html?buildTypeId=${buildType.externalId}&tab=buildTypeHistoryList"
/><c:if test="${empty historyRecords}">
  <p>No builds available</p>
</c:if

><c:if test="${not empty historyRecords}">
  <div class="clr"></div>

  <div class="successMessage" id="successMessage" style="display: none;">&nbsp;</div>
  <table class="testList historyList dark borderBottom">
    <thead>
      <tr>
        <c:choose>
          <c:when test="${showTrivialColumnNames and hasBranches}">
            <th class="branch hasBranch">Branch</th>
          </c:when>
          <c:otherwise>
            <th class="branch"></th>
          </c:otherwise>
        </c:choose>
        <th class="buildNumber">${showTrivialColumnNames ? '#' : ''}</th>
        <th>Results</th>
        <th>Artifacts</th>
        <th>Changes</th>
        <th class="sorted">Started</th>
        <th>Duration</th>
        <th>Agent</th>
        <th>Tags</th>
        <th class="autopin">&nbsp;</th>
        <th title="Pinned builds won't be removed from the history upon automatic history cleanup">${showTrivialColumnNames ? 'Pin' : ''}</th>
      </tr>
    </thead>
    <c:forEach var="entry" items="${historyRecords}" varStatus="recordStatus">
      <jsp:useBean id="entry" type="jetbrains.buildServer.serverSide.SFinishedBuild"/>

      <tr <c:if test="${not empty highlightRecord && recordStatus.count == highlightRecord + 1}">style="background-color: #FFFFCC;"</c:if>>
        <bs:buildRow build="${entry}" rowClass="${rowClass}"
                     showBranchName="true"
                     showBuildNumber="true"
                     showStatus="true"
                     showArtifacts="true"
                     showCompactArtifacts="true"
                     showChanges="true"
                     showStartDate="true"
                     showDuration="true"
                     showProgress="false"
                     showStop="false"
                     showAgent="true"
                     showPin="true"
                     showTags="true"
                     showUsedByOtherBuildsIcon="true"/>
      </tr>
    </c:forEach>
  </table>
  <bs:pinBuildDialog onBuildPage="${false}" buildType="${buildType}"/>
</c:if>
