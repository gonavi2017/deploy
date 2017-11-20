<%@ tag import="jetbrains.buildServer.serverSide.impl.cleanup.HistoryRetentionPolicy" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" 
    %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
    %><%@ attribute name="cleanupPolicies" required="true" type="java.util.Collection" 
    %><%@ attribute name="parentPolicies" required="true" type="java.util.Collection"
    %><%@ attribute name="useNormalForOther"
    %>
<c:set var="policies" value="${cleanupPolicies}"/>
<c:forEach items="${policies}" var="policy">
  <jsp:useBean id="policy" type="jetbrains.buildServer.serverSide.impl.cleanup.HistoryRetentionPolicy"/>
  <c:set var="text" ><c:out value="${policy.cleanupLevel.description} ${policy.description}"/></c:set>
  <div>
    <c:choose>
      <c:when test="<%= parentPolicies.contains(policy)%>">
        <span class="defaults">${text}</span>
      </c:when>
      <c:otherwise>${text}</c:otherwise>
    </c:choose>
  </div>
</c:forEach>
<c:set var="other">
  <c:if test="${fn:length(policies) == 0}"><div>Everything is kept forever</div></c:if>
  <c:if test="${fn:length(policies) > 0 && fn:length(policies) < fn:length(levels)}"><div>Other items are kept forever</div></c:if>
</c:set>
<c:if test="${useNormalForOther}">
  ${other}
</c:if>
<c:if test="${not useNormalForOther}">
  <span class="defaults">
      ${other}
  </span>
</c:if>

