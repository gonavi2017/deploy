<%@ tag import="jetbrains.buildServer.web.util.WebUtil" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    attribute name="buildType" fragment="false" required="true" type="jetbrains.buildServer.serverSide.BuildTypeEx" %><%@
    attribute name="branch" fragment="false" required="false" type="jetbrains.buildServer.serverSide.BranchEx"

%><c:choose
><c:when test="${empty branch}"
    ><c:url value='/viewType.html?buildTypeId=${buildType.externalId}&tab=pendingChangesDiv'/></c:when
><c:otherwise
    ><c:url value='/viewType.html?buildTypeId=${buildType.externalId}&tab=pendingChangesDiv'/>&branch_${buildType.projectExternalId}=<%=WebUtil.encode(branch.getName())%></c:otherwise
></c:choose>
