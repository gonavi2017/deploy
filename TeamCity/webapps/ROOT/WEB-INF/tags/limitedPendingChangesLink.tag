<%@ tag import="jetbrains.buildServer.web.util.WebUtil" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@
    taglib prefix="util" uri="/WEB-INF/functions/util" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> <%@
    attribute name="buildType" fragment="false" required="true" type="jetbrains.buildServer.serverSide.BuildTypeEx" %><%@
    attribute name="pendingChanges" fragment="false" required="true" type="jetbrains.buildServer.serverSide.LimitedChangesCollection" %><%@
    attribute name="noLink" fragment="false" required="false" type="java.lang.Boolean" %><%@
    attribute name="showForAllBranches" fragment="false" required="false" type="java.lang.Boolean" %><%@
    attribute name="branch" fragment="false" required="false" type="jetbrains.buildServer.serverSide.BranchEx"%>
<c:choose>
  <c:when test="${pendingChanges.calculated}">
    <c:set var="changes" value="${pendingChanges.changes}"/>
    <bs:pendingChangesLink buildType="${buildType}"
                           pendingChanges="${changes}"
                           noLink="${noLink}"
                           showForAllBranches="${showForAllBranches}"
                           branch="${branch}">
      <c:choose>
        <c:when test="${pendingChanges.limitExceeded}">
          Pending (${pendingChanges.limit}+)
        </c:when>
        <c:otherwise>
          Pending (${fn:length(changes)})
        </c:otherwise>
      </c:choose>
    </bs:pendingChangesLink>
  </c:when>
  <c:otherwise>
    <c:set var="id" value="lazy_pendingChanges_${buildType.id}_${util:uniqueId()}"/>
    <c:set var="url"><bs:pendingChangesTabUrl buildType="${buildType}" branch="${branch}"/></c:set>
    <span id="${id}"></span>
    <script type="text/javascript">
      BS.BackgroundLoader.load($j('#${id}'),
                               'limitedPendingChangesLink.html',
                               {buildType: '${buildType.externalId}',
                                noLink: ${noLink ? 'true' : 'false'},
                                showForAllBranches: ${showForAllBranches ? 'true' : 'false'},
                                branch: '<%=branch != null ? WebUtil.encode(branch.getName()) : ""%>'});
    </script>
  </c:otherwise>
</c:choose>
