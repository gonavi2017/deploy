<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@attribute name="severity" type="jetbrains.buildServer.serverSide.healthStatus.ItemSeverity" required="true" %>
<%@attribute name="suggestion" type="java.lang.Boolean" required="false" %>
<c:choose>
  <c:when test="${severity.info and not suggestion}"><i class="itemSeverity tc-icon icon16 icon-info"></i></c:when>
  <c:when test="${severity.info and suggestion}"><i class="itemSeverity tc-icon icon16 icon-lightbulb"></i></c:when>
  <c:when test="${severity.warning}"><i class="itemSeverity tc-icon icon16 tc-icon_attention tc-icon_attention_yellow"></i></c:when>
  <c:when test="${severity.error}"><i class="itemSeverity tc-icon icon16 tc-icon_attention tc-icon_attention_red"></i></c:when>
</c:choose>
