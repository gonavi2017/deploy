<%@ page contentType="text/html;charset=UTF-8" language="java" session="true"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@taglib prefix="stats" tagdir="/WEB-INF/tags/graph"
  %><%@taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%--@elvariable id="DuplicatorBuildTypes" type="java.util.List<SBuildType>"--%>
<c:if test="${not empty buildType}">
  <stats:buildGraph id="DuplicatorStats${buildType.externalId}" isPredefined="${true}" valueType="DuplicatorStats" hideFilters="series" buildType="${buildType}"/>
</c:if>
<c:forEach var="buildType" items="${DuplicatorBuildTypes}">
  <stats:buildGraph id="DuplicatorStats${buildType.externalId}" isPredefined="${true}" valueType="DuplicatorStats" hideFilters="series" buildType="${buildType}"/>
</c:forEach>
