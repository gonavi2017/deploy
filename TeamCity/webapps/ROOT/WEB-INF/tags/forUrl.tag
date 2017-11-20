<%@ tag import="jetbrains.buildServer.web.util.WebUtil" %><%@
  attribute name="val" required="true" type="java.lang.String" %><%=WebUtil.encode(val)%>