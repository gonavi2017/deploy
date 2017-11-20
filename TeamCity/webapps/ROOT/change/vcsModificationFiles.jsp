<%@ page import="jetbrains.buildServer.web.jsp.ChangeStatisticsPrinter" %>
<%@ page import="jetbrains.buildServer.web.openapi.PlaceId" %>
<%@ include file="/include-internal.jsp" %>
<jsp:useBean id="modification" scope="request" type="jetbrains.buildServer.vcs.SVcsModification"/>
<jsp:useBean id="buildTypeId" type="java.lang.String" scope="request"/>
<jsp:useBean id="changedFiles" type="java.util.List<jetbrains.buildServer.vcs.FilteredVcsChange>"
             scope="request"/>
<c:set var="statsText" value="<%= ChangeStatisticsPrinter.printFilesStatistics(changedFiles) %>"/>
<c:set var="modification" value="${filesTabModification}" scope="request"/>
<div class="changeHeader">
  <forms:saving id="changeBuildTypeProgress" className="progressRingInline" savingTitle="Filtering files according to checkout rules"/>
  Changed: ${statsText} in
  <forms:select name="buildTypeId" onchange="BS.buildTypeIdChanged(this);" id="buildTypeId_changed" enableFilter="true">
    <forms:option value="">&lt;All build configurations&gt;</forms:option>
    <c:forEach var="entry" items="${relatedConfigurations}">
      <c:set var="buildType" value="${entry}"/>
      <c:if test="${buildType.personal}"><c:set var="buildType" value="${buildType.sourceBuildType}"/></c:if>
      <c:set var="modId" value="${modification.id}"/>
      <forms:option value="buildTypeId=${buildType.externalId}&amp;filesTabModId=${modId}"
                    selected="${buildTypeId == buildType.externalId}">
        <c:out value="${buildType.fullName}"/>
      </forms:option>
    </c:forEach>
  </forms:select>
</div>
<div class="stamp stampMini">
  <dl class="changeExtensions">
    <ext:includeExtensions placeId="<%=PlaceId.CHANGE_DETAILS_BLOCK%>"/>
  </dl>
</div>
<div class="vcsModificationFilesList">
  <c:set var="buildType" value="${null}" scope="request"/>
  <bs:changedFiles changes="${changedFiles}" modification="${modification}"/>
</div>

<script type="text/javascript">
  if (BS.fixHeader) BS.fixHeader();
</script>