<%@ page import="jetbrains.buildServer.web.openapi.PlaceId" %>
<%@ include file="include-internal.jsp" %>
<jsp:useBean id="currentUser" type="jetbrains.buildServer.users.User" scope="request"/>
<jsp:useBean id="currentTab" scope="request" type="java.lang.String"/>
<jsp:useBean id="myCustomTab" scope="request" type="jetbrains.buildServer.web.openapi.CustomTab"/>

<c:set var="currentTabCaption" value=" > ${myCustomTab.tabTitle}"/>

<bs:page>
<jsp:attribute name="page_title">Agents${currentTabCaption}</jsp:attribute>
<jsp:attribute name="quickLinks_include">
  <a class="quickLinksControlLink" href='#' onclick='BS.InstallAgentsPopup.showNearElement(this); return false'>Install Build Agents</a>
</jsp:attribute>
<jsp:attribute name="head_include">
  <bs:linkCSS>
    /css/progress.css
    /css/agents.css
    /css/installAgent.css
    /css/filePopup.css
  </bs:linkCSS>
  <bs:linkScript>
    /js/bs/runningBuilds.js
    /js/bs/testGroup.js

    /js/bs/blocks.js
    /js/bs/blockWithHandle.js

    /js/bs/agents.js
  </bs:linkScript>

  <script type="text/javascript">
    BS.Navigation.items = [
      {title: "Agents", selected:true}
    ];

    BS.topNavPane.setActiveCaption('agents');
  </script>
</jsp:attribute>

<jsp:attribute name="body_include">
  <%@ include file="agentsList.jsp" %>
</jsp:attribute>

</bs:page>

