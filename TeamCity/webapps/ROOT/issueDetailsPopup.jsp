<%@ include file="/include-internal.jsp" %>
<%--@elvariable id="issueDetailsPopupUrl" type="java.lang.String"--%>
<jsp:useBean id="issue" scope="request" type="jetbrains.buildServer.issueTracker.IssueEx"/>
<c:choose>
  <c:when test="${not empty issueDetailsPopupUrl}">
    <jsp:include page="${issueDetailsPopupUrl}"/>
  </c:when>
  <c:otherwise>
    <bs:issueDetailsPopup issue="${issue}"/>
  </c:otherwise>
</c:choose>

