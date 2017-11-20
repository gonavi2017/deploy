<%@ tag import="com.intellij.util.text.DateFormatUtil"%><%@
  tag import="java.util.Date"%><%@
  attribute name="agent" required="true" rtexprvalue="true" type="jetbrains.buildServer.serverSide.SBuildAgent"
%>Last communication was <%=DateFormatUtil.formatBetweenDates(agent.getLastCommunicationTimestamp().getTime(), new Date().getTime())%>