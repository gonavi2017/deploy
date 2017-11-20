<%@ tag import="jetbrains.buildServer.web.util.WebUtil" %><%@
  attribute name="text" required="true" type="java.lang.String" %><%@
  attribute name="removeLineFeeds" required="false" type="java.lang.Boolean" %><%@
  attribute name="forHTMLAttribute" required="false" type="java.lang.Boolean" %><%=WebUtil.escapeForJavaScript(text, removeLineFeeds != null && removeLineFeeds.booleanValue(), forHTMLAttribute != null && forHTMLAttribute.booleanValue())%>