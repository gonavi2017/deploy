<%@ page import="jetbrains.buildServer.web.openapi.PlaceId" %>
<%@ include file="/include.jsp"%><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags"%><%@
    taglib prefix="ext" tagdir="/WEB-INF/tags/ext"
%><bs:messages key="buildNotFound"

/><c:if test="${not empty artifactsInfo}"
> <jsp:useBean id="artifactsInfo" type="jetbrains.buildServer.serverSide.artifacts.BuildArtifacts" scope="request"
  /><jsp:useBean id="buildId" type="java.lang.String" scope="request"
  /><c:set var="id" value="buildArtifacts_${buildId}"

/><div id="${id}"></div>
<script type="text/javascript">
  BS.LazyTree.treeUrl = window['base_uri'] + "/buildArtifacts.html?buildId=${buildId}";
  BS.LazyTree.ignoreHashes = true;
  BS.LazyTree.options = {
    artifact: true,
    buildId: ${buildId}
  };
  BS.LazyTree.loadTree('${id}');
  BS.ArtifactsPopup.updatePopup();
</script>
<ext:includeExtensions placeId="<%=PlaceId.BUILD_ARTIFACTS_POPUP_FRAGMENT%>"/>
</c:if>