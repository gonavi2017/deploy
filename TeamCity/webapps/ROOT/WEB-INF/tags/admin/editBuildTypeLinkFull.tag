<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ attribute name="buildType" required="true" type="jetbrains.buildServer.serverSide.SBuildType"
%><%@ attribute name="cameFromUrl" type="java.lang.String"
%><%@ attribute name="contextProject" type="jetbrains.buildServer.serverSide.SProject"
%><%@ attribute name="step" type="java.lang.String"
%><admin:editProjectLinkFull project="${buildType.project}" withSeparatorInTheEnd="true" contextProject="${contextProject}"
/><admin:editBuildTypeLink buildTypeId="${buildType.externalId}" step="${step}" cameFromUrl="${cameFromUrl}"><c:out value="${buildType.name}"/></admin:editBuildTypeLink>