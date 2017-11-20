<%@ tag import="jetbrains.buildServer.artifacts.RevisionRules"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ attribute name="revisionRule" type="jetbrains.buildServer.artifacts.RevisionRule" required="true"
%><%@ attribute name="buildTypeId" type="java.lang.String" required="true"
%><c:set var="buildNumber" value="<%=RevisionRules.BUILD_NUMBER_NAME%>"
 /><c:choose><c:when test="${revisionRule.name == buildNumber}"
        ><bs:buildLink buildNumber="${revisionRule.revision}" buildTypeId="${buildTypeId}"
        ><c:out value="${revisionRule.description}"/></bs:buildLink></c:when
  ><c:otherwise
        ><bs:buildLink buildId="${revisionRule.name}" buildTypeId="${buildTypeId}"
        ><c:out value="${revisionRule.description}"
        /></bs:buildLink
  ></c:otherwise
></c:choose>