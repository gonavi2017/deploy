<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ attribute name="issues" required="true" type="java.util.Collection<jetbrains.buildServer.issueTracker.IssueEx>"%>
<%@ attribute name="build" required="true" type="jetbrains.buildServer.serverSide.SBuild"%>

<table class="dark issues borderBottom" id="buildIssuesTable">
  <thead>
    <tr>
      <th style="width: 10%;">ID</th>
      <th style="width: 45%;">Summary</th>
      <th style="width: 10%;">Status</th>
      <th style="width: 35%;">Description</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="issue" items="${issues}">
      <c:set var="fetchStatus" value="${issue.fetchStatus}"/>
      <c:set var="rowClass">
        <c:choose>
          <c:when test="${fetchStatus.fetched}">
            <c:if test="${issue.fixedByRelatedModification}">class="fixed"</c:if>
          </c:when>
          <c:otherwise></c:otherwise>
        </c:choose>
      </c:set>
      <bs:trimWhitespace>
        <tr ${rowClass}>
          <td><a href="${issue.url}" title="Open in ${issue.provider.name}">${issue.id}</a></td>
          <td>
            <c:choose>
              <c:when test="${fetchStatus.fetched}">
                <c:out value="${issue.summary}"/>
              </c:when>
              <c:when test="${fetchStatus.failedToFetch}">
                <c:set var="errorMessage">
                  <c:choose>
                    <c:when test="${empty issue.fetchError}">Unable to retrieve issue details from issue-tracking system</c:when>
                    <c:otherwise>${issue.fetchError}</c:otherwise>
                  </c:choose>
                </c:set>
                <span class="err"><c:out value="<Error: ${errorMessage}>"/></span>
              </c:when>
              <c:otherwise>
                <span class="retrievingNote">Retrieving data...</span>
              </c:otherwise>
            </c:choose>
          </td>
          <td class="status">
            <c:if test="${fetchStatus.fetched}">
              <span <c:if test="${issue.fixedByRelatedModification}">title="The issue is resolved in this build" class="resolvedStatus" </c:if>>${issue.state}</span>
            </c:if>
          </td>
          <td>
            <c:choose>
              <c:when test="${not empty issue.relatedModification}">
                <c:set var="change" value="${issue.relatedModification}"/>
                Related change by
                <bs:popupControl
                    showPopupCommand="BS.FilesPopup.showPopup(event, {parameters: 'modId=${change.id}&personal=${change.personal}'});"
                    hidePopupCommand="BS.FilesPopup.hidePopup();"
                    stopHidingPopupCommand="BS.FilesPopup.stopHidingPopup();"
                    controlId="files:${change.id}">
                  <bs:modificationLink modification="${change}"><bs:changeCommitters modification="${change}"/></bs:modificationLink>
                </bs:popupControl>
              </c:when>
              <c:otherwise>
                <bs:buildLink build="${build}">Build comment</bs:buildLink>
                by <c:out value="${build.buildComment.user.descriptiveName}"/>
              </c:otherwise>
            </c:choose>
          </td>
        </tr>
      </bs:trimWhitespace>
    </c:forEach>
  </tbody>
</table>
