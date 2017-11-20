<%@ tag import="jetbrains.buildServer.serverSide.util.FormatUtil"
%><%@ attribute name="source" required="true" type="java.lang.String"
%><%@ attribute name="key" required="true" type="java.lang.String"
%><%@ attribute name="replacementText" required="true" type="java.lang.String"
%><%=FormatUtil.format(source, key, replacementText)%>