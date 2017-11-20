<%@ include file="/include.jsp" %>
<jsp:useBean id="pluginResourcesPath" type="java.lang.String" scope="request"/>
<jsp:useBean id="downloadUrl" type="java.lang.String" scope="request"/>

<style type="text/css">
p.idea {
background-image: url("<c:url value="${pluginResourcesPath}"/>img/idea_project.png");
background-repeat: no-repeat;
background-size: 16px;
}
@media only screen and (-webkit-min-device-pixel-ratio: 2), only screen and (min--moz-device-pixel-ratio: 2), only screen and (-o-min-device-pixel-ratio: 200 / 100), only screen and (min-device-pixel-ratio: 2), only screen and (min-resolution: 192dpi), only screen and (min-resolution: 2dppx) {
  p.idea {
  background-image: url("<c:url value="${pluginResourcesPath}"/>img/idea_project@2x.png");
  }
}
</style>
<p class="toolTitle idea">IntelliJ Platform Plugin<bs:help style="display:inline;" file="IntelliJ+Platform+Plugin"/></p>
<a showdiscardchangesmessage="false" title="Download plugin for IntelliJ Platform IDEs" href='<c:url value="${downloadUrl}"/>'>download</a>
