<%@ page import="jetbrains.buildServer.controllers.interceptors.auth.impl.NTLMHttpConstants" %>
<%@ include file="/include-internal.jsp"%>
<%@ taglib prefix="prop" tagdir="/WEB-INF/tags/props"%>
<bs:smallNote>Depending on the client's web browser and operating system, this can either allow to log in without any prompts or pop up the browser credentials prompt.</bs:smallNote>
<br/>
<div><jsp:include page="/admin/allowCreatingNewUsersByLogin.jsp"/></div>
<br/>
<div>
  <label width="100%" for="<%=NTLMHttpConstants.ALLOW_PROTOCOLS_KEY%>">Allow protocols:</label><br/>
  <prop:textProperty style="width: 100%;" name="<%=NTLMHttpConstants.ALLOW_PROTOCOLS_KEY%>"/>
  <bs:smallNote>Specify the comma-separated list of HTTP authentication protocols to support. Possible options are <strong>NTLM</strong>, <strong>Negotiate</strong>, <strong>Kerberos</strong>. The default is <strong>NTLM</strong>.</bs:smallNote>
</div>
<br/>
<div>
  <label width="100%" for="<%=NTLMHttpConstants.FORCE_PROTOCOLS_KEY%>">Force protocols:</label><br/>
  <prop:textProperty style="width: 100%;" name="<%=NTLMHttpConstants.FORCE_PROTOCOLS_KEY%>"/>
  <bs:smallNote>Specify the comma-separated list of protocols to force authentication, i.e. to initiate NTLM HTTP authentication process instead of redirecting to the login page when a user is not authenticated). Possible options are <strong>NTLM</strong>, <strong>Negotiate</strong>, <strong>Kerberos</strong>. No protocol is forced by default.</bs:smallNote>
</div>