<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ attribute name="grouped" required="true" type="java.lang.Boolean" %>
<c:if test="${grouped}">
  <div class="agentsToolbar">
    <bs:collapseExpand collapseAction="BS.AgentBlocks.collapseAll(); return false" expandAction="BS.AgentBlocks.expandAll(); return false"/>
  </div>
</c:if>