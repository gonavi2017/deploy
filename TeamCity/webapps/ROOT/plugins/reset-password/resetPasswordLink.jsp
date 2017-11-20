<%@ page import="jetbrains.buildServer.resetPassword.ForgotPasswordController" %>
<%@ include file="/include-internal.jsp"%>
<c:set var="link"><%=ForgotPasswordController.URL_PATH%></c:set>
<span><a href="<c:url value="${link}"/>">Reset password</a></span>