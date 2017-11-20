<%@ page import="jetbrains.buildServer.controllers.admin.projects.EditVcsRootsController" %>
<%@ include file="/include-internal.jsp"%>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="pageUrl" scope="request" type="java.lang.String"/>
<jsp:useBean id="cameFrom" scope="request" type="jetbrains.buildServer.web.util.CameFromSupport"/>
<jsp:useBean id="vcsRoot" scope="request" type="jetbrains.buildServer.vcs.VcsRoot"/>
<c:set var="pageTitle" scope="request">VCS Root: ${vcsRoot.name}</c:set>
<bs:page>
<jsp:attribute name="head_include">
  <bs:linkCSS>
    /css/admin/adminMain.css
    /css/admin/vcsSettings.css
  </bs:linkCSS>
  <bs:linkScript>
    /js/bs/editProject.js
    /js/bs/testConnection.js
  </bs:linkScript>
  <script type="text/javascript">
    BS.Navigation.items = [
        {title: "Administration", url: '<c:url value="/admin/admin.html"/>'},
        <forms:cameBackNav cameFromSupport="${cameFrom}"/>,
        {title: "${pageTitle}", selected:true}
    ];
  </script>
</jsp:attribute>

<jsp:attribute name="body_include">
  <div id="container" class="clearfix">

    <div class="editVcsRootPage">

      VCS plugin <strong><c:out value="${vcsRoot.vcsName}"/></strong> to which this VCS root belongs is not loaded or is not installed anymore. This VCS root cannot be edited, and no changes can be collected for it.
      Please remove this VCS root from your build configurations if you do not plan to use <strong><c:out value="${vcsRoot.vcsName}"/></strong> VCS plugin anymore.

    </div>
  </div>
</jsp:attribute>
</bs:page>
