<%@ tag import="jetbrains.buildServer.web.util.WebUtil"
  %><%@attribute name="text" required="true"
  %><%@attribute name="regex" required="true"
  %><%@attribute name="escape" required="false" type="java.lang.Boolean"
  %><%=WebUtil.makeBreakable(text, regex, escape == null ? true : escape)%>