<%@taglib prefix="tags" tagdir="/WEB-INF/tags"
%><%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@taglib prefix="auth" tagdir="/WEB-INF/tags/authz"
%><%--@elvariable id="branch" type="jetbrains.buildServer.serverSide.Branch"--%>
<%--@elvariable id="showBranch" type="java.lang.Boolean"--%>
<%--@elvariable id="build" type="jetbrains.buildServer.serverSide.SBuild"--%>
<%--@elvariable id="buildType" type="jetbrains.buildServer.serverSide.SBuildType"--%>
<c:choose>
  <c:when test="${not accessDenied}">
    <div>Build: <tags:buildLink build="${build}">#${build.buildNumber} <tags:buildDataIcon buildData="${build}"/></tags:buildLink><c:out value="${build.statusDescriptor.text}"/></div>
    <c:if test="${showBuildType}">
      <div>Configuration: <tags:buildTypeLink buildType="${buildType}"/></div>
    </c:if>
    <div>Started: <tags:formatDate value="${build.startDate}"/></div>
    <c:if test="${showBranch}">
      <div>Branch: <span class="branch hasBranch"><tags:branchLink branch="${branch}"/></span></div>
    </c:if>
  </c:when>
  <c:otherwise>
    You do not have enough permissions to see this build details
  </c:otherwise>
</c:choose>