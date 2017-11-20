<%@include file="/include-internal.jsp" %>
<jsp:useBean id="messages" type="java.util.Collection<jetbrains.buildServer.notification.NotificationMessage>" scope="request"/>
<jsp:useBean id="buildStatus" type="jetbrains.buildServer.notification.BuildStatusMessage" scope="request"/>
<jsp:useBean id="pluginHome" type="java.lang.String" scope="request"/>
<jsp:useBean id="version" type="java.lang.String" scope="request"/>
<jsp:useBean id="nextUrl" type="java.lang.String" scope="request"/>
<jsp:useBean id="nextId" type="java.lang.String" scope="request"/>
<jsp:useBean id="refreshInterval" type="java.lang.Long" scope="request"/>
<bs:externalPage>
  <jsp:attribute name="head_include">
    <bs:linkScript>
     ${pluginHome}/js/extension.js
    </bs:linkScript>
  </jsp:attribute>
  <jsp:attribute name="body_include">
    <div>Notifier version: <div id="notifierVersion"></div></div>
    <div>Server version: <div id="serverVersion"><c:out value="${version}"/></div></div>

    <script type="text/javascript">
      Win32.Messages.refreshInterval = function() {
        return 1 + ${refreshInterval};
      };
      var UPD = Win32.Messages.updateState.bind(Win32.Messages);
      var M = Win32.Messages.notifyAction.bind(Win32.Messages);
    </script>

    <c:set var="nextUrlResolved"><c:url value="${nextUrl}"/></c:set>

    <bs:refreshable containerId="notification" pageUrl="${nextUrlResolved}">
  <script type="text/javascript">
    (function() {UPD(${nextId},"<bs:escapeForJs text="${version}"/>", ${buildStatus.status}, [<c:forEach var="n" items="${messages}"
         ><jsp:useBean id="n" type="jetbrains.buildServer.notification.NotificationMessage"
         />M(${n.eventType.eventId}, "<bs:escapeForJs text="${n.message}"/>", "<bs:escapeForJs text="${n.detailLink}"/>", ${n.personalBuild ? 'true' : 'false'}, ${n.time}, ${n.modificationCounter}),</c:forEach>]); })();
  </script>
    </bs:refreshable>

    <a href="#" onclick="BS.reload(); return false;">Refresh</a>
    <a href="#" onclick="Win32.Extension.closeMe(); return false;">Close</a>

    <a href="#" onclick="Win32.Extension.popupNotification(3, 'test popup', 'http://#', false, 10100102, 2); return false;">Test Popup</a>
    <a href="#" onclick="Win32.Extension.setBuildsStatus(2); return false;">Test Status</a>
  </jsp:attribute>
</bs:externalPage>
