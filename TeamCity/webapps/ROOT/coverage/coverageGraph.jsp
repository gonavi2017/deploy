<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props"
%><%@ taglib prefix="stats" tagdir="/WEB-INF/tags/graph"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%--@elvariable id="coverageBuildTypes" type="java.util.List<SBuildType>"--%>
<c:if test="${not empty buildType}">
  <stats:buildGraph id="CodeCoverage${buildType.externalId}" isPredefined="${true}" valueType="CodeCoverage" hideFilters="averaged" defaultFilter="showFailed" buildType="${buildType}"/>
</c:if>
<c:forEach var="buildType" items="${coverageBuildTypes}">
  <stats:buildGraph id="CodeCoverage${buildType.externalId}" isPredefined="${true}" valueType="CodeCoverage" hideFilters="averaged" defaultFilter="showFailed" buildType="${buildType}"/>
</c:forEach>
