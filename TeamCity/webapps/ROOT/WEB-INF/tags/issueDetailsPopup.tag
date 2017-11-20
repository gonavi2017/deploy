<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    attribute name="issue" type="jetbrains.buildServer.issueTracker.IssueEx" required="true" %><%@
    attribute name="popupClass" type="java.lang.String" required="false" %><%@
    attribute name="priorityClass" type="java.lang.String" required="false" %><%@
    attribute name="severityClass" type="java.lang.String" required="false" %><%@
    attribute name="typeClass" type="java.lang.String" required="false" %><%@
    attribute name="stateClass" type="java.lang.String" required="false" %><%@
    attribute name="otherFields" fragment="true" required="false"
%><c:set var="issueData" value="${issue.issueDataOrNull}"

/><div class="issueDetailsPopup ${popupClass}">
  <table class="main">
    <tr class="${issueData.resolved ? 'resolved' : ''}">
      <td><c:out value="${issueData.id}"/></td>
      <td><c:out value="${issueData.summary}"/></td>
    </tr>
  </table>
  <table class="other">
    <tr>
      <c:if test="${not empty issueData.priority}">
        <td title="Priority" class="priority ${priorityClass}"><div><c:out value="${issueData.priority}"/></div></td>
      </c:if>
      <c:if test="${not empty issueData.severity}">
        <td title="Severity" class="severity ${severityClass}"><div><c:out value="${issueData.severity}"/></div></td>
      </c:if>
      <c:if test="${not empty issueData.type}">
        <td title="Type" class="type ${issueData.featureRequest ? 'feature' : ''} ${typeClass}"><c:out value="${issueData.type}"/></td>
      </c:if>
      <c:if test="${not empty issueData.state}">
        <td title="State" class="state ${stateClass}"><c:out value="${issueData.state}"/></td>
      </c:if>
      <jsp:invoke fragment="otherFields"/>
    </tr>
  </table>
</div>