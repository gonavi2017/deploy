<%@ page import="jetbrains.buildServer.issueTracker.youtrack.YouTrackIssueFetcher" %><%@
    include file="/include.jsp"

%><jsp:useBean id="issue" scope="request" type="jetbrains.buildServer.issueTracker.IssueEx"
/><c:set var="issueData" value="${issue.issueDataOrNull}"
/><c:set var="fields" value="${issueData.allFields}"
/><c:set var="fixVersionField"><%=YouTrackIssueFetcher.FIXED_VERSION_FIELD%></c:set
><c:set var="priorityValueField"><%=YouTrackIssueFetcher.PRIORITY_VALUE_FIELD%></c:set

><bs:issueDetailsPopup issue="${issue}"
                       popupClass="yt"
                       priorityClass="p${fields[priorityValueField]}">
  <jsp:attribute name="otherFields">
    <c:set var="fixVersion" value="${fields[fixVersionField]}"/>
      <c:if test="${not empty fixVersion}">
        <td title="Fix versions"><c:out value="${fixVersion}"/></td>
      </c:if>
  </jsp:attribute>
</bs:issueDetailsPopup>
