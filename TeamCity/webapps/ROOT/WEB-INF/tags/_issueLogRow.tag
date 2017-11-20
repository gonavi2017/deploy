<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    attribute name="issue" required="true" type="jetbrains.buildServer.issueTracker.IssueEx" %><%@
    attribute name="details" required="true" fragment="true"

%><tr>
  <c:set var="fetchStatus" value="${issue.fetchStatus}"/>
  <td class="id"><a href="${issue.url}">${issue.id}</a></td>
  <td class="summary">
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
  <td class="state">
    <c:if test="${fetchStatus.fetched}">
      <c:out value="${issue.state}"/>
    </c:if>
  </td>
  <jsp:invoke fragment="details"/>
</tr>