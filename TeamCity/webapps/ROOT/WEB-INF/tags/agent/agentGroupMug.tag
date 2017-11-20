<%@ attribute name="idleAgentCount" required="true" type="java.lang.Integer"%>
<%@ attribute name="totalAgentCount" required="true" type="java.lang.Integer"%>
<div class="mug" style="margin-top: 0; margin-bottom: 3px; vertical-align: middle; float: left;">
  <%
    final int maxHeight = 16; // maximum height of the progress bar (see tabs.css)
    final int top = maxHeight * idleAgentCount / totalAgentCount;
  %>
  <div class="mugStuff" style="top: <%=top%>px; height: <%=maxHeight-top%>px;"></div>
</div>
