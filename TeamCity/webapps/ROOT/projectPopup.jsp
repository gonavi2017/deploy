<%@ include file="include-internal.jsp"
%><jsp:useBean id="project" type="jetbrains.buildServer.serverSide.SProject" scope="request"
/><jsp:useBean id="branch" type="java.lang.String" scope="request"
/><jsp:useBean id="projectTabs" type="java.util.List" scope="request"
/><jsp:useBean id="withAdmin" type="java.lang.Boolean" scope="request"

/><c:set var="externalId" value="${project.externalId}"/>
<c:set var="branchParam" value=""
/><c:if test="${not empty branch}">
  <c:set var="branchParam">&branch_${externalId}=${branch}</c:set>
</c:if
><div class="summaryContainer">
  <ul class="menuList menuListGrouped">
    <c:forEach var="tab" items="${projectTabs}">
      <c:url value='/project.html?projectId=${externalId}&tab=${tab.tabId}${branchParam}' var="url"/>
      <li>
        <a href="${url}">${tab.tabTitle}</a>
      </li>
    </c:forEach>

    <c:if test="${withAdmin}">
      <li class="menuListSeparator"></li>
      <li>
        <admin:editProjectLink projectId="${externalId}">Edit Settings</admin:editProjectLink>
      </li>
    </c:if>
  </ul>
</div>