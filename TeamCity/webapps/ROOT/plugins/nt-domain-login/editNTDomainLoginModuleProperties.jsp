<%@ page import="jetbrains.buildServer.serverSide.auth.settings.NTDomainConstants" %>
<%@ include file="/include-internal.jsp"%>
<%@ taglib prefix="prop" tagdir="/WEB-INF/tags/props"%>
<div><jsp:include page="/admin/allowCreatingNewUsersByLogin.jsp"/></div>
<br/>
<div>
  <label width="100%" for="<%=NTDomainConstants.DEFAULT_DOMAIN_PROPERTY_KEY%>">Default domain:</label><br/>
  <prop:textProperty style="width: 100%;" name="<%=NTDomainConstants.DEFAULT_DOMAIN_PROPERTY_KEY%>"/>
  <bs:smallNote>Default domain to be used if no domain is specified as part of the username.</bs:smallNote>
</div>