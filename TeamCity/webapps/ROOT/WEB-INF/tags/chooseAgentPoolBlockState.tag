<%@ tag import="jetbrains.buildServer.web.functions.BlockStateUtil"%><%@
  tag import="com.intellij.util.ArrayUtil"%><%@
  attribute name="agentPoolId" required="true" type="java.lang.Integer"%><%@
  attribute name="kind" required="false" type="java.lang.String"%><%@
  attribute name="forceState" required="false" type="java.lang.Boolean"%><%@
  attribute name="expanded" required="false" type="java.lang.Boolean"%><%@
  attribute name="ifExpanded" fragment="true"%><%@
  attribute name="ifCollapsed" fragment="true"
  %><%
  final boolean collapsed;
  if (forceState != null && forceState) {
    collapsed = !expanded;
  }
  else {
    final String[] collapsedPoolIds = BlockStateUtil.getBlockState(request, "agentPool").split(":");
    String key = (kind == null? "" : kind) + String.valueOf(agentPoolId);
    collapsed = ArrayUtil.contains(key, collapsedPoolIds);
  }

  if (collapsed) {
    if (ifCollapsed != null) {
      %><jsp:invoke fragment="ifCollapsed"/><%
    }
  }
  else if (ifExpanded != null) {
    %><jsp:invoke fragment="ifExpanded"/><%
  }
%>