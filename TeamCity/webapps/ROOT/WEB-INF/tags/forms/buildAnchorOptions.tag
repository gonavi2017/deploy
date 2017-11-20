<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
    %><%@ taglib tagdir="/WEB-INF/tags/props" prefix="props"
    %><%@ tag import="jetbrains.buildServer.artifacts.RevisionRules"
    %><%@ attribute name="withChainOption"
    %><%@ attribute name="selected" %>

<c:set var="lastSuccessful" value="<%=RevisionRules.LAST_SUCCESSFUL_NAME%>"/>
<c:set var="lastFinished" value="<%=RevisionRules.LAST_FINISHED_NAME%>"/>
<c:set var="sameChainOrLastFinished" value="<%=RevisionRules.LAST_FINISHED_SAME_CHAIN_NAME%>"/>
<c:set var="lastPinned" value="<%=RevisionRules.LAST_PINNED_NAME%>"/>

<c:set var="buildNumber" value="<%=RevisionRules.BUILD_NUMBER_NAME%>"/>
<c:set var="buildTag" value="<%=RevisionRules.BUILD_TAG_NAME%>"/>

<props:option value="${lastSuccessful}" selected="${selected == lastSuccessful}">Latest successful build</props:option>
<props:option value="${lastPinned}" selected="${selected == lastPinned}">Latest pinned build</props:option>
<props:option value="${lastFinished}" selected="${selected == lastFinished}">Latest finished build</props:option>
<c:if test="${withChainOption}">
  <props:option value="${sameChainOrLastFinished}" selected="${selected == sameChainOrLastFinished}">Build from the same chain</props:option>
</c:if>
<props:option value="${buildNumber}" selected="${selected == buildNumber}">Build with specified build number</props:option>
<props:option value="${buildTag}" selected="${selected == buildTag}">Latest finished build with specified tag</props:option>
