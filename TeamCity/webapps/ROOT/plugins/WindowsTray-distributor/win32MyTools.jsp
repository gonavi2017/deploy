<%@ include file="/include-internal.jsp" %>
<jsp:useBean id="win32DownloadUrl" type="java.lang.String"  scope="request"/>
<jsp:useBean id="win32IconUrl" type="java.lang.String"  scope="request"/>

<style type="text/css">
  p.toolTitle.winTray {
    background-image: url("<c:url value="${win32IconUrl}"/>");
    background-repeat: no-repeat;
    background-size: 17px;
  }
</style>
<p class="toolTitle winTray">
  Windows Tray Notifier <bs:help style="display:inline;" file="Windows+Tray+Notifier"/>
</p>
<a showdiscardchangesmessage="false" title="Download Windows Tray Notifier" href="<c:url value='${win32DownloadUrl}'/>">download</a>

