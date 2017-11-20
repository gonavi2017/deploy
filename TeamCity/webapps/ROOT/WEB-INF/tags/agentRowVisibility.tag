<%@ taglib prefix="util" uri="/WEB-INF/functions/util"%><%@
  taglib prefix="bs" tagdir="/WEB-INF/tags"%><%@
  attribute name="agentPoolId" required="true" type="java.lang.Integer"
  %><bs:chooseAgentPoolBlockState agentPoolId="${agentPoolId}"><jsp:attribute name="ifCollapsed">display: none;</jsp:attribute></bs:chooseAgentPoolBlockState>