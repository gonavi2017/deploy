<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="util" uri="/WEB-INF/functions/util" %><%@
    attribute name="buildTypeId" fragment="false" required="true" %><%@
    attribute name="branch" fragment="false" required="false" type="jetbrains.buildServer.serverSide.BranchEx" %><%@
    attribute name="style" fragment="false" required="false" %><%@
    attribute name="showInitially" required="false" type="java.lang.Boolean" %><%@
    attribute name="problemType" required="false" %><%@
    attribute name="problemSource" required="false" %><%@
    attribute name="maxWidth" required="false" %><%@
    attribute name="showHead" required="false"

%><c:set var="visibility" value="${(not empty showInitially && showInitially) ? '' : 'display:none'}"
/><c:set var="id" value="${util:uniqueId()}"
/><c:set var="maxWidth" value="${not empty maxWidth ? maxWidth : 60}"/><c:set var="showHead" value="${(empty showHead) ? true : showHead}"
/><c:set var="data"
  ><c:if test="${not empty branch and not branch.defaultBranch}">data-branch="<c:out value='${branch.name}'/>" data-build-type="${buildTypeId}"</c:if
></c:set
><span id="buildType:${id}:systemProblems" class="systemProblemsBar" style="${visibility};${style}" onclick="_tc_es(event)" ${data}>
  <span id="buildType:${id}:systemProblemsText" class="systemProblemsBarText" data-maxWidth="${maxWidth}">Configuration problems found</span><a
    title="View more information" href="#" class="systemProblemsBarLink" onclick="BS.SystemProblemsPopup.showDetails('${buildTypeId}', '${problemType}', '${problemSource}', ${showHead}, this); return false;">details &raquo;</a>
</span>
<script type="text/javascript">BS.SystemProblems.registerProblemId('${buildTypeId}', '${id}');</script>