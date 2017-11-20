<%@ page import="jetbrains.buildServer.controllers.login.NTLMLoginController" %>
<%@ include file="/include-internal.jsp"%>
<c:set var="ntlmPath"><%=NTLMLoginController.LOGIN_PATH%></c:set>
<div><a href="<c:url value='${ntlmPath}'/>">Log in using Microsoft Windows domain</a></div>