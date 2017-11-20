<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%><%@
  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
  attribute name="agentPoolId" required="true" type="java.lang.Integer"%><%@
  attribute name="kind" required="false" type="java.lang.String"%><%@
  attribute name="forceState" required="false" type="java.lang.Boolean"%><%@
  attribute name="expanded" required="false" type="java.lang.Boolean"
  %><bs:chooseAgentPoolBlockState agentPoolId="${agentPoolId}" kind="${kind}" forceState="${forceState}" expanded="${expanded}"
  ><jsp:attribute name="ifExpanded"><c:set var="state">expanded</c:set></jsp:attribute
  ><jsp:attribute name="ifCollapsed"><c:set var="state">collapsed</c:set></jsp:attribute
  ></bs:chooseAgentPoolBlockState
  ><c:if test="${empty kind}"><c:set var="kind" value=""/></c:if
    ><span class="icon icon16 agentBlockHandle agentBlockHandle-${kind}${agentPoolId} handle handle_${state}" id="agentBlockHandle:${kind}${agentPoolId}" onclick="BS.AgentBlocks.toggleBlock('${kind}${agentPoolId}', true);"></span>