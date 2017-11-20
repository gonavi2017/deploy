<%@ include file="../include-internal.jsp" %>
<jsp:useBean id="hasFixed" type="java.lang.Boolean" scope="request"/>
<jsp:useBean id="build" type="jetbrains.buildServer.serverSide.SBuild" scope="request"/>
<jsp:useBean id="issues" type="java.util.Collection" scope="request"/>

<c:choose>
  <c:when test="${not empty issues}">
    <p>
      The list of issues related to this build (i.e. mentioned in change's or build comments).
    </p>
    <%--@elvariable id="fetching" type="java.lang.Boolean"--%>
    <c:if test="${fetching}">
      <div class="icon_before icon16 attentionComment">
        Some of the issues are being retrieved from the issue-tracker system.
        Refresh the page to see the updates.
      </div>
    </c:if>
    <bs:buildIssuesTable issues="${issues}" build="${build}"/>
    <p>
      <c:if test="${hasFixed}">
        * An issue is considered <span class="resolvedStatus">resolved</span> in a build
        if the build includes the last change, in which the issue is mentioned.
      </c:if>
    </p>
  </c:when>
  <c:otherwise>
    <p>This build has no related issues.<bs:help file="Integrating+TeamCity+with+Issue+Tracker"/></p>
  </c:otherwise>
</c:choose>
