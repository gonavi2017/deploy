<%@ tag import="jetbrains.buildServer.web.util.WebUtil"%><%@
  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
  taglib prefix="util" uri="/WEB-INF/functions/util" %><%@
  taglib prefix="authz" tagdir="/WEB-INF/tags/authz"%><%@
  attribute name="agent" required="false" type="jetbrains.buildServer.serverSide.BuildAgentEx"%><%@
  attribute name="agentName" required="false" type="java.lang.String"%><%@
  attribute name="agentTypeId" required="false" type="java.lang.String"%><%@
  attribute name="agentType" required="false" type="jetbrains.buildServer.serverSide.agentTypes.SAgentType"%><%@
  attribute name="useDisplayName" required="false"%><%@
  attribute name="anchor" required="false"
  %><c:choose
    ><c:when test="${agentName == 'N/A' or not empty agent and agent.name == 'N/A'}">N/A</c:when
    ><c:when test="${not empty agent or not empty agentName or not empty agentType}"
      ><c:set var="name" value="${not empty agent ? agent.name : empty agentType ? agentName : not empty useDisplayName ? agentType.details.displayName : agentType.details.name}"
      /><jsp:doBody var="textInside"
      /><c:if test="${empty textInside}"><c:set var="textInside"><c:out value="${name}"/></c:set></c:if><authz:authorize anyPermission="VIEW_AGENT_DETAILS">
    <jsp:attribute name="ifAccessGranted"
        ><c:choose><c:when test="${not empty agent}"
          ><c:choose><c:when test="${(agent.id gt 0) or (agent.agentTypeId gt 0)}"
            ><a href="<c:url value='/agentDetails.html?id=${agent.id}&agentTypeId=${agent.agentTypeId}&realAgentName=${textInside}'/><c:if test="${anchor != null}">#${anchor}</c:if>"
                title="Click to view &quot;<c:out value="${name}"/>&quot; agent details">${textInside}</a
          ></c:when
          ><c:otherwise
          >${textInside}</c:otherwise
        ></c:choose></c:when
        ><c:when test="${not empty agentType}"
              ><a href="<c:url value='/agentDetails.html?agentTypeId=${agentType.agentTypeId}'/><c:if test="${anchor != null}">#${anchor}</c:if>" title="Click to view &quot;<c:out value="${agentType.details.longName}"/>&quot; agent type details">${textInside}</a></c:when
          ><c:otherwise
              ><c:set var="encodedName" value="<%=WebUtil.encode(agentName)%>"
             /><c:set var="url">/agentDetails.html?name=${encodedName}<c:if test="${not empty agentTypeId}">&agentTypeId=${agentTypeId}</c:if></c:set
             ><a href="<c:url value='${url}'/><c:if test="${anchor != null}">#${anchor}</c:if>" title="Click to view &quot;<c:out value="${name}"/>&quot; agent details">${textInside}</a></c:otherwise
        ></c:choose
    ></jsp:attribute
    ><jsp:attribute name="ifAccessDenied"><span class="non-link-agent-name">${textInside}</span></jsp:attribute
  ></authz:authorize
></c:when></c:choose>