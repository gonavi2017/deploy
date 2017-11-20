<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms"

%><jsp:useBean id="build" type="jetbrains.buildServer.serverSide.SBuild" scope="request"
/><jsp:useBean id="showAll" type="java.lang.Boolean" scope="request"/>
<%--
The artifacts tree can be very big to analyze it on page loading.
Hence most of the data in this JSP is loaded in separate AJAX requests.
Please be careful if you want to use a slow method here.
 --%>
<c:set var="urlPath">/repository/downloadAll/${build.buildTypeExternalId}/${build.buildId}:id/artifacts.zip${(showAll ? '?showAll=true' : '')}</c:set>
<c:url var="downloadUrl" value="${urlPath}"/>
<span id="downloadLinkSpan" style="display: none;"><a class="downloadLink tc-icon_before icon16 tc-icon_download" href="${downloadUrl}">Download all (.zip)</a></span>
<div id="artifactsTree"></div>
<div class="treeTotals">
  Total size:
  <span id="treeTotals">
    <i>Computing...</i>
  </span>

  <c:url var="url" value="/viewLog.html?buildId=${build.buildId}&tab=artifacts&buildTypeId=${build.buildTypeExternalId}&showAll=${not showAll}"/>
  <br/>
  <span id="hiddenArtifactsNote" style="color: #888; display: none;">
    <c:if test="${showAll}">
      Hidden artifacts from the .teamcity directory are displayed. <a href="${url}">Hide</a>
    </c:if>
    <c:if test="${not showAll}">
      There are also hidden artifacts. <a href="${url}">Show</a>
    </c:if>
  </span>
</div>

<script type="text/javascript">
  BS.LazyTree.treeUrl = window['base_uri'] + "/buildArtifacts.html?buildId=${build.buildId}&showAll=${showAll}";
  BS.LazyTree.options = {
    artifact: true,
    buildId: ${build.buildId}
  };
  BS.LazyTree.loadTree("artifactsTree");
  var detailsUrl = window['base_uri'] + "/buildArtifactsDetails.html?buildId=${build.buildId}&showAll=${showAll}";
  BS.BuildArtifacts.updateDetails(detailsUrl, 'treeTotals', 'downloadLinkSpan', 'hiddenArtifactsNote');
</script>
