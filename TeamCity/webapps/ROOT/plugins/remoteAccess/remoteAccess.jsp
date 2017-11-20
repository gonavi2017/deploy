<%@ include file="/include.jsp" %>
<jsp:useBean id="remoteAccessAddr" scope="request" type="java.lang.String"/>
<div><img src="<c:url value='${teamcityPluginResourcesPath}rdp_icon.gif'/>" height="16" width="16" border="0" data-no-retina> <a href="<c:url value="/remoteAccess/rdp.html?host=${remoteAccessAddr}"/>">Open Remote Desktop</a></div>
