<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout"%>
<%@ attribute name="grouped" required="true" type="java.lang.Boolean" %>
<c:if test="${grouped}">
  <script type="text/javascript">
    <l:blockState blocksType="agentPool"/>
    BS.AgentBlocks.restoreSavedBlocks();
  </script>
</c:if>
