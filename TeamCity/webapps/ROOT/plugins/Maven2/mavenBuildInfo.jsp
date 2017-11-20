<%@include file="/include-internal.jsp"%>

<%--@elvariable id="build" type="jetbrains.buildServer.serverSide.SBuild"--%>
<%--@elvariable id="currentBuildInfoIndex" type="java.lang.Integer"--%>
<%--@elvariable id="availableIndexes" type="java.util.Collection<java.lang.Integer>"--%>
<%--@elvariable id="mavenBuildInfo" type="jetbrains.maven.build.MavenBuildInfo"--%>
<%--@elvariable id="errorMessage" type="java.lang.String"--%>

<script type="text/javascript">
function updateProjectDetails(projectId) {

  var url = '<c:url value="/maven/buildInfoProjectDetails.html?buildId=${build.buildId}&currentIndex=${currentBuildInfoIndex}&projectId="/>';
  if(projectId)
    url += encodeURIComponent(projectId);

  BS.ajaxUpdater($('projectDetails'), url, { method: 'get' });
}

</script>

<c:if test="${fn:length(availableIndexes) > 1}">
<table class="mavenBuildInfoIndexes"><tr>
<td class="header">Available reports:</td>
<c:set var="url" value="/viewLog.html?buildId=${build.buildId}&buildTypeId=${build.buildTypeId}&tab=mavenBuildInfo"/>
<c:forEach items="${availableIndexes}" var="index">
  <c:choose>
    <c:when test="${currentBuildInfoIndex == index}">
      <td class="cell selected"><c:out value="${index+1}"/></td>
    </c:when>
    <c:otherwise>
      <td class="cell unselected"><a href="<c:url value='${url}&currentIndex=${index}'/>"><c:out value="${index+1}"/></a></td>
    </c:otherwise>
  </c:choose>
</c:forEach>
</tr></table>
</c:if>

<c:if test="${not empty errorMessage}">
  <p><strong style="color:red"><c:out value="${errorMessage}"/></strong></p>
</c:if>

<c:if test="${(empty errorMessage) and (not build.finished) and (empty mavenBuildInfo)}">
<c:out value="Build is not finished yet"/>
</c:if>

<c:if test="${(empty errorMessage) and (build.finished) and (empty mavenBuildInfo)}">
<c:out value="Maven build information is not available"/>
</c:if>

<c:if test="${not empty mavenBuildInfo}">
<table id="mavenBuildInfoHead">
  <tr>
    <th class="col first">Built with Maven</th>
    <th class="col">General build information</th>
  </tr>

  <tr>
    <td class="col first">
      <table class="header-maven">
        <tr><td class="first">Version:</td><td><c:out value="${mavenBuildInfo.maven.version}"/></td></tr>
        <tr><td class="first">Build number:</td><td><c:out value="${mavenBuildInfo.maven.buildNumber}"/></td></tr>
        <tr><td class="first">Build timestamp:</td><td><bs:date value="${mavenBuildInfo.maven.timestamp}"/></td></tr>
      </table>
    </td>

    <td class="col">
      <table class="header-maven">
        <tr><td class="first">Start timestamp:</td><td><bs:date value="${mavenBuildInfo.startTimestamp}"/></td></tr>
        <tr><td class="first">Goals:</td><td><c:forEach items="${mavenBuildInfo.goals}" var="goal"><c:out value="${goal} "/></c:forEach></td></tr>
      </table>
    </td>
  </tr>
</table>

<div id="projectDetails" class="headerNote">
  <jsp:include page="mavenBuildInfoProjectDetails.jsp"/>
</div>

<%--
maybe in future we'll implement full support for anchor based navigation.
Currently it's dropped because of history back-forth navigation problems
--%>
<script type="text/javascript">
  (function() {
    var hash = window.location.hash;
    if (hash) {
      hash = hash.substring(1);
      updateProjectDetails(hash);
    }
  })();
</script>

</c:if>

