<%@ tag import="jetbrains.buildServer.web.functions.BlockStateUtil" %><%@
    attribute name="blocksType" required="true" %><%@
    attribute name="collapsedByDefault" required="true" type="java.lang.Boolean" %><%@
    attribute name="id" required="true" %><%

  /**
   * DEPRECATED. Use ${util:blockHiddenCss} instead.
   */

  if (BlockStateUtil.isBlockHidden(request, blocksType, collapsedByDefault)) {
    out.write("<style>");
    out.write("#" + id + " {display: none;}");
    out.write("</style>");
  }
%>