<%@ tag import="jetbrains.buildServer.util.PluralUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ attribute name="txt" fragment="false" required="true"
  %><%@ attribute name="val" fragment="false" type="java.lang.Integer" required="true"
  %><%= PluralUtil.toPluralSlashSeparated(txt, val)%>