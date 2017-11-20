<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><jsp:useBean id="agentsForm" scope="request" type="jetbrains.buildServer.controllers.agent.AgentListForm"
/><c:if test="${agentsForm.actuallyGroupByPools}"><th class="firstCell">&nbsp;</th></c:if>